#!/bin/bash

# ------------------------------------------------------------------------
# Name: sep.sh
#
# Author: Paul Nadolny
# Date:   2019-Jul-28
#
# Purpose: Print one (or more) lines of characters
# to visually separate the output from different commands.
# This helps to make things more readable when you
# scroll back to review things.
#
# Usage: With no command line arguments, it just prints a line of dashes
# With a number from 1 to 9, it prints a row of 1 to 9 boxes with an X.
# With any other character(s), it prints a line of that character(s).
#
# Copyright (c) 2019 Paul Nadolny
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
# ------------------------------------------------------------------------


# ------------------------------------------------------------------------
# Constants
# ------------------------------------------------------------------------


VERSION="1.0"
SEPARATOR_DEFAULT="-"  # Default separator
WIDTH=75               # Default width of a row to print
MARGIN_RIGHT=5         # Do not print the full terminal width
MAX_BOXES=9            # How many boxes you can choose to print
INTEGER_RE='^[0-9]+$'  # A regular expression to validate an integer
PROGNAME=$(basename $0)

# Exit codes
EXIT_SUCCESS=0
EXIT_FAILURE=1

# Big boxes
# +---+---+
# |\ /|\ /|
# | 2 | 2 |
# |/ \|/ \|
# +---+---+
LINES=5
SEP[1]="+---"
SEP[2]="|\\ /"
SEP[3]="| X "
SEP[4]="|/ \\"
SEP[5]="+---"
END[1]="+"
END[2]="|"
END[3]="|"
END[4]="|"
END[5]="+"


# ------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------


# ------------------------------------------------------------------------
Usage() {
  # Note: cannot combine options, and cannot have multiple options
  echo "Usage: ${PROGNAME} [ --box <n> | --help | --sep <s> | --version ]"
  echo "  -b, --box <n>  Print <n> big boxes (<n> in [1,9])"
  echo "  -h, -?, --help Print this usage message"
  echo "  -s, --sep <s>  Print repeated separator character(s) <s>"
  echo "  -v, --version  Print the version"
  echo "  if no argument, print a separator line of dashes"
  return 0
}


# ------------------------------------------------------------------------
Version() {
  echo "${PROGNAME} Version: ${VERSION}"
  return 0
}


# ------------------------------------------------------------------------
# Requires one argument: the number of boxes
PrintBoxes() {
  typeset -i boxes_requested=$1
  # Print separator boxes
  SEP[3]="${SEP[3]/X/${boxes_requested}}" # Replace the X with the boxes number
                                          # even if we print fewer boxes
  (( boxes_fit = (WIDTH-1) / ${#SEP[1]} ))
  (( boxes_to_print = boxes_requested < boxes_fit ? boxes_requested : boxes_fit ))
  [[ ${boxes_to_print} -lt 1 ]] && {
    return 0
  }

  for line in $(seq 1 ${LINES})
  do
    for i in $(seq 1 ${boxes_to_print})
    do
      echo -n "${SEP[${line}]}"
    done
    echo "${END[${line}]}"
  done
  return 0
}


# ------------------------------------------------------------------------
# Requires one argument: the separator character(s)
PrintLine() {
  separator="$1"
  # Print a line of specified separator characters, no wider than WIDTH
  size=${#separator}
  if [[ ${size} -gt ${WIDTH} ]]
  then
    # It's larger than the allowed width, so abbreviate it
    echo "${separator:0:${WIDTH}}"
  else
    (( group_count = WIDTH / size ))
    for i in $(seq 1 ${group_count})
    do
      echo -n "${separator}"
    done
    echo
  fi
  return 0
}


# ------------------------------------------------------------------------
ErrorThenExit() {
  echo "${PROGNAME}: ERROR: $1"
  exit ${EXIT_FAILURE}
}


# ------------------------------------------------------------------------
# Main code
# ------------------------------------------------------------------------

separator="${SEPARATOR_DEFAULT}"
action_separator=0
action_boxes=0
action_help=0
action_version=0

# Set the maximum width of the separator line
columns=$(tput cols)
[[ $? -ne 0 ]] && {
  ErrorThenExit "could not get terminal columns"
}
(( WIDTH = columns - MARGIN_RIGHT ))
[[ ${WIDTH} -lt 1 ]] && {
  exit ${EXIT_SUCCESS}
}

# Process command line arguments
# Note: Since both long and short options are supported,
#       let's not use getopt(s)
# Note: Probably need to rework this into a loop to support adding future
#       optional arguments, like --width or --margin
#       or to support multiple arguments

if [[ $# -eq 0 ]]
then
  # No args - print a line of default separator characters
  action_separator=1

elif [[ $# -gt 2 ]]
then
  ErrorThenExit "too many arguments"

else
  if [[ "$1" == "-h" || "$1" == "--help" ||  "$1" == "-?" ]]
  then
    action_help=1

  elif [[ "$1" == "-v" || "$1" == "--version" ]]
  then
    action_version=1

  elif [[ "$1" == "-b" || "$1" == "--box" ]]
  then
    if [[ $# -eq 1 ]]
    then
      ErrorThenExit "missing argument to $1"
    elif [[ $2 =~ $INTEGER_RE ]]  # Do we have an integer?
    then
      typeset -i box_count=10#$2  # strip any leading zeroes
      if [[ ${box_count} -lt 1 || ${box_count} -gt ${MAX_BOXES} ]]
      then
        ErrorThenExit "argument must be in the range [1,${MAX_BOXES}]"
      fi
      # Print big boxes
      action_boxes=1
    else
      ErrorThenExit "expected a positive integer: $2"
    fi

  elif [[ "$1" == "-s" || "$1" == "--sep" ]]
  then
    if [[ $# -eq 1 ]]
    then
      ErrorThenExit "missing argument to $1"
    fi
    # Print a line of specified separator characters
    action_separator=1
    separator="$2"

  else
    ErrorThenExit "invalid argument: $1"
  fi
fi

# Perform the requested action

[[ action_help -eq 1 ]] && {
  Usage
}
[[ action_version -eq 1 ]] && {
  Version
}
[[ action_separator -eq 1 ]] && {
  PrintLine "${separator}"
}
[[ action_boxes -eq 1 ]] && {
  PrintBoxes ${box_count}
}

exit ${EXIT_SUCCESS}
