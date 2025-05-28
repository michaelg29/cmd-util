#!/bin/bash
# Copy these into your .bashrc file

# cmd-util scripts
CMD_UTIL_HOME="${HOME}/bin/cmd-util"
alias wd='${CMD_UTIL_HOME}/bash/wd.sh'
alias cwd='cd $(${CMD_UTIL_HOME}/bash/wd.sh echo)'
alias pushwd='pushd $(${CMD_UTIL_HOME}/bash/wd.sh echo)'
alias bjob='${CMD_UTIL_HOME}/bash/bjob.sh'
