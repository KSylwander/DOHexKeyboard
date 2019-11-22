#!/bin/bash
# This script will build and assemble the iOS SDK.
# Run this script from the git root directory.

cleanup() {
  rm -rf docs
  rm -rf Build
}

# Error function that is called if something goes wrong.
error_occured() {
  local parent_lineno="$1"
  local message="$2"
  local code="${3:-1}"
  if [[ -n "$message" ]] ; then
    echo "Error on or near line ${parent_lineno}: ${message}\nExiting with status"
  else
    echo "Error on or near line ${parent_lineno}\nExiting with status"
  fi
  cleanup
  exit "${code}"
}

usage() {
  cat <<EOF
Usage: $0 [options]

-h    This help description.
-c    Code Sign the release.
-e    The environment for which the product is built. Takes an argument: STAGE or PROD
-r    Run unit tests (These are executed with a DebugSTAGE configuration)
-v    Specify the version of this release. Takes an argument.

Example:
  ./buildscripts/build_release.sh -e PROD -r -v 2.0

EOF
}

archive_xcode_project() {
  # Change to target directory where the xcode project is located
  flags=()

  if [[ $CODE_SIGN_RELEASE == YES ]]; then
    flags+=( CODE_SIGNING_REQUIRED=YES )
  else
    flags+=( CODE_SIGN_IDENTITY="" )
    flags+=( CODE_SIGNING_REQUIRED=NO )
  fi

  echo "Building for Environment: $ENVIRONMENT"
  if [[ $ENVIRONMENT == "STAGE" ]]; then
    CONFIGURATION=ReleaseSTAGE
  elif [[ $ENVIRONMENT == "PROD" ]]; then
    CONFIGURATION=ReleasePROD
  else
    echo "Building for unsupported environment: $ENVIRONMENT"
    usage
    error_occured ${LINENO} "Unsupported Environment"
  fi

  # Build for iOS. 
  # SKIP_INSTALL is to install frameworks into the archive.
  xcodebuild archive \
            ${flags[0]} ${flags[1]} \
            -scheme BlippitKit \
            -configuration $CONFIGURATION \
            -sdk iphoneos \
            -archivePath "$BUILD_DIR/$ARCHIVE_NAME_IOS" \
            SKIP_INSTALL=NO \
            || error_occured ${LINENO} "Build failed"

  # Build for iOS Simulator.
  xcodebuild archive \
            ${flags[0]} ${flags[1]} \
            -scheme BlippitKit \
            -configuration $CONFIGURATION \
            -sdk iphonesimulator \
            -archivePath "$BUILD_DIR/$ARCHIVE_NAME_IOS_SIMULATOR" \
            SKIP_INSTALL=NO \
            || error_occured ${LINENO} "Build failed"
}

run_unit_test() {
  if [[ $RUN_UNIT_TEST == YES ]]; then
    xcodebuild clean test -project BlippitKit.xcodeproj -configuration DebugSTAGE -scheme BlippitKit -destination 'platform=iOS Simulator,name=iPhone 11' || error_occured ${LINENO} "Unit tests failed!"
  else
    echo "Skipping Unit Tests"
  fi
}

run_carthage() {
  if [[ $ENVIRONMENT == "STAGE" ]]; then
    carthage bootstrap --configuration ReleaseSTAGE --platform ios
  elif [[ $ENVIRONMENT == "PROD" ]]; then
    carthage bootstrap --configuration ReleasePROD --platform ios
  else
    echo "Building for unsupported environment: $ENVIRONMENT"
    usage
    error_occured ${LINENO} "Unsupported Environment"
  fi
}

create_documentation() {

	jazzy \
  		--clean \
  		--author Crunchfish Proximity \
  		--author_url https://blippit.com/developer \
  		--module-version $RELEASE_VERSION \
  		--xcodebuild-arguments -scheme,BlippitKit,-configuration,Release \
  		--module BlippitKit \
  		--output docs || error_occured ${LINENO} "Could not produce documentation!"  
}

assemble_sdk() {

  # Create xcframework containing iOS and iOS Simulator frameworks
  xcodebuild -create-xcframework \
             -framework $BUILD_DIR/$ARCHIVE_NAME_IOS.xcarchive/$ARCHIVE_FRAMEWORK_LOCATION \
             -framework $BUILD_DIR/$ARCHIVE_NAME_IOS_SIMULATOR.xcarchive/$ARCHIVE_FRAMEWORK_LOCATION \
             -output $BUILD_DIR/$FRAMEWORK_NAME

  mkdir -p $RELEASE_FOLDER $SDK_FOLDER $DOCUMENTATION_FOLDER

  cp -R "$BUILD_DIR/$FRAMEWORK_NAME" $SDK_FOLDER

  # Documentation
  cp -R docs $DOCUMENTATION_FOLDER

  zip -r $RELEASE_ZIP_NAME $RELEASE_FOLDER
  rm -r $RELEASE_FOLDER

  # Move the SDK to the artifacts folder
  mkdir -p artifacts
  mv $RELEASE_ZIP_NAME artifacts/

  # Copy archives 
  pushd $BUILD_DIR > /dev/null
  zip -r "$ARCHIVE_NAME_IOS.xcarchive.zip" "$ARCHIVE_NAME_IOS.xcarchive"
  zip -r "$ARCHIVE_NAME_IOS_SIMULATOR.xcarchive.zip" "$ARCHIVE_NAME_IOS_SIMULATOR.xcarchive"
  popd > /dev/null

  mv "$BUILD_DIR/$ARCHIVE_NAME_IOS.xcarchive.zip" artifacts/
  mv "$BUILD_DIR/$ARCHIVE_NAME_IOS_SIMULATOR.xcarchive.zip" artifacts/
}

# ------------------------------------------------------
#
# Start of script flow
#
# ------------------------------------------------------

# Parse any command line argument
while getopts "che:rv:" opt; do
  case $opt in
    c)
      CODE_SIGN_RELEASE=YES
      ;;
    h)
      usage
      exit
      ;;
    e)
      ENVIRONMENT=$OPTARG
      ;;
    r)
      RUN_UNIT_TEST=YES
      ;;
    v)
      RELEASE_VERSION=$OPTARG
      ;;
    \?)
      error_occured ${LINENO} "Invalid option: -$OPTARG" 2
      ;;
  esac
done

# Script variables
RELEASE_ZIP_NAME="BlippitKit-$RELEASE_VERSION-iOS.zip"
RELEASE_FOLDER="BlippitKit-$RELEASE_VERSION"
DOCUMENTATION_FOLDER="$RELEASE_FOLDER/Documentation"
SDK_FOLDER="$RELEASE_FOLDER/SDK"

BUILD_DIR="build"
ARCHIVE_NAME_IOS="BlippitKit-iOS-$RELEASE_VERSION"
ARCHIVE_NAME_IOS_SIMULATOR="BlippitKit-iOS-Simulator-$RELEASE_VERSION"
ARCHIVE_FRAMEWORK_LOCATION="Products/Frameworks/BlippitKit.framework"

FRAMEWORK_FOLDER="Build/Frameworks"
FRAMEWORK_NAME="BlippitKit.xcframework"

# Source the common_functions.sh files to have access to common functions.
. buildscripts/common_functions.sh

#
# Check if all commands and tools are available.
# jazzy: https://github.com/realm/jazzy
#
commands_exist xcodebuild jazzy carthage || error_occured ${LINENO} "Missing needed commands"

#
# Carthage
#
echo "Carthage setup..."
run_carthage 

#
# Run Unit tests
#
echo "Run Unit tests..."
run_unit_test

#
# Create documentation
#
echo "Generating Documentation..."
create_documentation

#
# Archive BlippitKit project
#
echo "Archiving BlippitKit..."
archive_xcode_project

#
# Assemble the SDK
#
echo "Assembling SDK..."
assemble_sdk
cleanup

echo "SDK Built and Assembled successfully"

