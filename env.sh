#!/bin/bash

# Get directory
pushd . > '/dev/null';
SCRIPT_PATH="${BASH_SOURCE[0]:-$0}";
export CMD_UTIL_HOME=$(realpath $(dirname "${BASH_SOURCE[0]}"))
echo "Sourcing cmd-util from $CMD_UTIL_HOME"

# Source tools
source ${CMD_UTIL_HOME}/bash/tools.sh
export PATH="${PATH}:${CMD_UTIL_HOME}/bin:${CMD_UTIL_HOME}/bash"
alias wd='${CMD_UTIL_HOME}/bash/wd.sh'
alias cwd='cd $(${CMD_UTIL_HOME}/bash/wd.sh echo)'
alias pushwd='pushd $(${CMD_UTIL_HOME}/bash/wd.sh echo)'
alias bjob='${CMD_UTIL_HOME}/bash/bjob.sh'
alias ntee='${CMD_UTIL_HOME}/bash/named_tee.sh'
alias help='less ${CMD_UTIL_HOME}/bash/bash.txt'

# Optionally source prompt modification
[ ! -z "$CMD_UTIL_PROMPT" ] && source ${CMD_UTIL_HOME}/bash/prompt.sh
