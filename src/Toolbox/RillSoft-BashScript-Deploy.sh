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
#   2021.08 | Crane Zhou            | 0.2     | Options Process added
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

RILLHOST_BASHSCRIPT_PROJECT="RillHost_BashScript_Template"

RILLHOST_BASHSCRIPT_VERSION=0.2.0
RILLHOST_BASHSCRIPT_SUBJECT=some-unique-id
RILLHOST_BASHSCRIPT_SYNOPSIS="$(basename $0) [-vhxst] [-o[file]] args ..."
#RILLHOST_BASHSCRIPT_USAGE="Usage: command -ihv args"
#RILLHOST_BASHSCRIPT_SCRIPT_NAME="$(basename $0)"
RILLHOST_BASHSCRIPT_OUTPUTFILE=$RILLHOST_BASHSCRIPT_PROJECT$"-"

g_TimeLog_Enable=false
g_SlientMode_Enable=false

# ------------------
# Options Processing
# ------------------
print_usage () {
    echo $RILLHOST_BASHSCRIPT_SYNOPSIS

    echo "DESCRIPTION"
    echo "  This is a script template"
    echo "  to start any good shell script."

    echo "OPTIONS"
    echo "   -o [file], --output=[file]    Set log file (default=/dev/null)"
    echo "                                  use DEFAULT keyword to autoname file"
    echo "                                  The default value is /dev/null."
    echo "   -s, --silent                  Silent mode, No message output on console"
    echo "   -x, --ignorelock              Ignore if lock file exists"    
    echo '   -t, --timelog                 Add timestamp to log ("+%y/%m/%d@%H:%M:%S")"'
    echo "   -h, --help                    Print this help"
    echo "   -v, --version                 Print script information"

#    exit 1;
}

#if [ $# == 0 ] ; then
#    print_usage
#    exit 1;
#fi

#      ":")
#        echo "No argument value for option $OPTARG"
#        exit 0;
#        ;;
#      "i")
#        echo "-i argument: $OPTARG"
#        exit 0;
#        ;;

parse_opts () {

local OPTARG
local OPTIND optname

optstring=":vhxsto:"
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
      "x")
        lock_file
#        exit 0;
        ;;
      "s")
        setup_silentmode true
#        exit 0;
        ;;
      "t")
        setup_timelog true
#        exit 0;
        ;;
      "o")
        print_outputfile $OPTARG
        exit 0;
        ;;
      "?")
        echo "Unknown option $OPTARG"
        exit 0;
        ;;
      *)
        echo "Unknown error while processing options"
        exit 0;
        ;;
    esac
  done
}

parse_opt () {

  echo "parse_opt()"
  echo "$@"

#  optstring=":i:vh"
#  getopts ${optstring} optname;
#  echo $optname

#  echo $OPTIONS
#  echo $OPTARG
}

print_timelog()
{
  local strlogText
  strlogText=$(basename $0)$'\t('$(date -d today "+%Y/%m/%d %H:%M")$')'  
# Print the time log head text
  s=$(printf "%-50s" "=")
  if [ $2 == false ]; then
    echo $strlogText
    echo "${s// /=}"
  fi
  echo $strlogText >> $1
  echo "${s// /=}" >> $1

# Print the time log body text
  strlogText="Test Text (with Time Log)"
  
  if [ $g_TimeLog_Enable == true ]; then
    strlogText=$(date -d today "+%Y/%m/%d %H:%M:%S")$'\t'$strlogText
  else
    strlogText="Test Text (with No Time Log)"
  fi
  for i in $(seq 1 2 10);
  
  do
    if [ $2 == false ]; then
      echo $strlogText
    fi
    echo $strlogText >> $1
    sleep 0.1
  done

# Print the time log foot text
# Not yet
}

setup_silentmode()
{
  g_SlientMode_Enable=$1

  if [ $g_SlientMode_Enable == true ]; then
    echo "SilentMode Enabled"
  else
    echo "SilentMode Disabled"
  fi
}

setup_timelog()
{
  g_TimeLog_Enable=$1

  if [ $g_TimeLog_Enable == true ]; then
    echo "TimeLog Enabled"
  else
    echo "TimeLog Disabled"
  fi
}

print_outputfile()
{
#  if [ $# == 0 ]; then
#    strOutputFileName="/dev/null"
#    echo "Set log file (default=/dev/null)"
#  fi  

  if [ $1 == "DEFAULT" ]; then
    strOutputFileName=${RILLHOST_BASHSCRIPT_OUTPUTFILE}$(date -d today "+%Y-%m-%d.log")
  else
    strOutputFileName=$1
  fi

  echo "Printing in output file ... " $strOutputFileName
  print_timelog $strOutputFileName $g_SlientMode_Enable
}

lock_file()
{
#  echo "lock file function"
  LOCKFILE=/tmp/$(basename $0)
  if [ -f "$LOCKFILE" ]
  then 
    echo "The script file($basename $0) had been locked, and you can't run it again!"
    echo "Please remove the locked file handle($LOCKFILE) manually." 
    exit 1
  else 
    echo "The script file($basename $0) is now in locking status !"
    touch $LOCKFILE
  fi
}

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

  echo $(basename $0) ", You are welcome! ;-P" 
  
  parse_opts "$@"
#  parse_opt "$@"

}

main "$@"
