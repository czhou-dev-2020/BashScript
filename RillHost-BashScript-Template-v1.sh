#!/bin/bash
# ==============================================================================
# RillHost-BashScript-Template.sh
# ==============================================================================
# START OF HEADER
# ==============================================================================
# Description:
#
#   Use this template as the beginning of a new program. Place a short 
#   description of the script here.  
#
# ==============================================================================
# Script Usage:
#
# SYNOPSIS
#   ${SCRIPT_NAME} [-hv] [-o[file]] args ...
#
# DESCRIPTION
#   This is a script template
#   to start any good shell script.
#
# OPTIONS
#   -o [file], --output=[file]    Set log file (default=/dev/null)
#                                  use DEFAULT keyword to autoname file
#                                  The default value is /dev/null.
#   -t, --timelog                 Add timestamp to log ("+%y/%m/%d@%H:%M:%S")
#   -x, --ignorelock              Ignore if lock file exists
#   -h, --help                    Print this help
#   -v, --version                 Print script information
#
# ==============================================================================
# Change History:
#
#   Date    | Author                | Version | Remark
#   2021.03 | Crane Zhou            | 0.1     | Initial  
#
# ==============================================================================
# License & CopyRight(C):
# 
#   This project is released under the terms of the BSD license.
#   See LICENSE for more information or see:
#   https://opensource.org/licenses/BSD-3-Clause.
# 
# ==============================================================================
# END OF HEADER
# ==============================================================================

RILLHOST_BASHSCRIPT_VERSION=0.1.0
RILLHOST_BASHSCRIPT_SUBJECT=some-unique-id
RILLHOST_BASHSCRIPT_SYNOPSIS="$(basename $0) [-vh] [-o[file]] args ..."
#RILLHOST_BASHSCRIPT_USAGE="Usage: command -ihv args"
#RILLHOST_BASHSCRIPT_SCRIPT_NAME="$(basename $0)"

# ------------------
# Options Processing
# ------------------
print_usage () {
#    echo "to be continued ..."
    echo $RILLHOST_BASHSCRIPT_SYNOPSIS

    echo "DESCRIPTION"
    echo "  This is a script template"
    echo "  to start any good shell script."

    echo "OPTIONS"
    echo "   -o [file], --output=[file]    Set log file (default=/dev/null)"
    echo "                                  use DEFAULT keyword to autoname file"
    echo "                                  The default value is /dev/null."
    echo '   -t, --timelog                 Add timestamp to log ("+%y/%m/%d@%H:%M:%S")"'
    echo "   -x, --ignorelock              Ignore if lock file exists"
    echo "   -h, --help                    Print this help"
    echo "   -v, --version                 Print script information"

#    exit 1;
}

#if [ $# == 0 ] ; then
#    print_usage
#    exit 1;
#fi

#parse_opts () {
optstring=":i:vh"
while getopts ${optstring} optname;
  do
    case "$optname" in
      "v")
        echo "Version $RILLHOST_BASHSCRIPT_VERSION"
        exit 0;
        ;;
      "h")
        print_usage
        exit 0;
        ;;
      "?")
        echo "Unknown option $OPTARG"
        exit 0;
        ;;
      ":")
        echo "No argument value for option $OPTARG"
        exit 0;
        ;;
      "i")
        echo "-i argument: $OPTARG"
        ;;
      *)
        echo "Unknown error while processing options"
        exit 0;
        ;;
    esac
  done
#}

# ------------------
# main routine  
# ------------------
#parse_opts

print_hello () {
  echo Hello $1
}

print_bash_version () {
  echo "Bash version: ${BASH_VERSION}"
}

main() {
  echo "hello world!"

  print_hello $USER
  print_bash_version
   
}

main "$@"
