#!/bin/bash
# This script will build and assemble the iOS SDK.
# Run this script from the git root directory.

cleanup() {
  rm -rf Docs/output
  rm -rf Build
}

# Error function that is called if something goes wrong.
error_occured() {
  local parent_lineno="$1"
  local message="$2"
  local code="${3:-1}"
  if [[ -n "$message" ]] ; then
    echo -e "Error on or near line ${parent_lineno}: ${message}\nExiting with status"
  else
    echo -e "Error on or near line ${parent_lineno}\nExiting with status"
  fi
  cleanup
  exit "${code}"
}

usage() {
  cat <<EOF
Usage: $0 [options]

-h    This help description.
-s    Code Sign the release.
-c    The configuration for which the product is built. Takes an argument: Debug or Release
-t    Run unit tests (These are executed with a Debug configuration)
-v    Specify the version of this release. Takes an argument.
-p    Package and assemble the SDK (archive, generate documentation and assembles SDK)
-d    Do not run Carthage setup

Example:
  ./scripts/build.sh -v 1.0.0 -c Release -t -p -s

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

  echo "Building for configuration: $CONFIGURATION"

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
    xcodebuild clean test -project BlippitKit.xcodeproj -configuration Debug -scheme BlippitKit -destination 'platform=iOS Simulator,name=iPhone 11' || error_occured ${LINENO} "Unit tests failed!"
  else
    echo "Skipping Unit Tests"
  fi
}

run_carthage() {
  if [[ $RUN_CARTHAGE == NO ]]; then
    echo "Skipping Carthage setup"
    return
  fi

  echo "Setting up dependencies for configuration: $CONFIGURATION"
  carthage bootstrap --configuration $CONFIGURATION --platform iOS
}

create_documentation() {
  jazzy \
    --config .jazzy.json \
    --module-version $RELEASE_VERSION || error_occured ${LINENO} "Could not produce documentation!"  
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
  pushd Docs/output
  cp -R . ../../$DOCUMENTATION_FOLDER
  popd

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
while getopts "shc:ptv:d" opt; do
  case $opt in
    s)
      CODE_SIGN_RELEASE=YES
      ;;
    h)
      usage
      exit
      ;;
    c)
      # Convert option to title case (e.g. DEBUG -> Debug)
      CONFIGURATION=`awk '{print toupper($1)tolower($2)}' <<< "${OPTARG:0:1} ${OPTARG:1}"`
      if [[ "$CONFIGURATION" != "Debug" ]] && [[ "$CONFIGURATION" != "Release" ]]; then
        echo "Building for unsupported configuration: $CONFIGURATION"
        usage
        error_occured ${LINENO} "Unsupported configuration"
      fi
      ;;
    p)
      PACKAGE_SDK=YES
      ;;
    t)
      RUN_UNIT_TEST=YES
      ;;
    v)
      RELEASE_VERSION=$OPTARG
      ;;
    d)
      RUN_CARTHAGE=NO
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
. scripts/common_functions.sh

#
# Check if all commands and tools are available.
#
commands_exist xcodebuild carthage || error_occured ${LINENO} "Missing needed commands"

#
# Carthage
#
echo "Running Carthage setup..."
run_carthage 

#
# Run Unit tests
#
echo "Run Unit tests..."
run_unit_test

if [[ $PACKAGE_SDK == YES ]]; then

  # jazzy: https://github.com/realm/jazzy
  commands_exist jazzy || error_occured ${LINENO} "Missing needed commands"

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

  echo "SDK Built and Assembled successfully"    
else
  echo "Skipping package and assemble SDK."
fi

cleanup
