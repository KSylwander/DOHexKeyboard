#!/bin/sh

# This script is meant to be sourced, not run.

# Checks if a command exists in the current environment.
# \param $1 The command to check for.
# \return 0 if the command exists, 1 otherwise.
command_exists() {
  type "$1" > /dev/null 2> /dev/null
}

# Checks if a variable is set.
# \param $1 The name of the variable to check.
# \return 0 if the variable is set, 1 otherwise.
variable_is_set() {
  eval value="\$$1"; export value
  [ -n "$value" ]
}

# Checks that all given commands exists, printing error messages for all missing
# commands.
# \param $@ A list of commands to check.
# \return 0 if all commands exists, 1 otherwise.
commands_exist() {
  _result=0
  for my_command in $@
  do
    if command_exists $my_command
    then :
    else
      echo "Could not find needed command \"$my_command\" in your path!" >&2
      _result=1
    fi
  done
  return ${_result}
}

# Checks that all given variables are set, printing error messages for any that
# is not. As opposed to the built-in construct ${variable:?}, this gives a
# script the possibility to report all missing variables before exiting, instead
# of just reporting the first missing variable encountered.
# \param $@ A list of names of variables to check.
# \return 0 if all variables are set, 1 otherwise.
variables_are_set() {
  _result=0
  for my_variable in $@
  do
    if variable_is_set $my_variable
    then :
    else
      echo "Variable $my_variable is not set!" >&2
      _result=1
    fi
  done
  return ${_result}
}

# Augments the path with the given arguments unless the arguments are already in
# the path and prints the resulting path.
# \param $@ The new directories to add to the path.
# \return 0
augment_path_with() {
  _result="$PATH"
  for extra_path in "$@"
  do
    if echo "${_result}" | grep "\<$extra_path\>"
    then :
    else
      _result="$extra_path:${_result}"
    fi
  done
  echo "${_result}"
}

# Creates a given directory unless it already exists.
# \param $1 The directory to create.
# \return 0 if the directory was created or it already exists, 1 otherwise.
create_directory() {
if [ ! -d "$1" ]
then
  if [ -f "$1" ]
  then
    echo "Failed making sure $1 is a directory!" >&2
    return 1
  fi

  mkdir "$1"
fi
return 0
}

# Exits the shell using return code 1 after optionally printing an error message.
# \param $1 The error message to print. Optional.
die() {
  [ -n "$1" ] && echo "$1" >&2
  exit 1
}
