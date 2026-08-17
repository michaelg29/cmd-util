#!/bin/bash

# aliases
alias mux='tmux new-session -A -s'
alias pinfo='ps -Flww -p'
alias rgrep='grep -Rns --color=auto'
alias regrep='egrep -Rns --color=auto'
alias find='find -L'

# silent
function silent {
  eval "$*" &> /dev/null
  return $?
}
export function silent

# split string
function split {
  delim="$2"
  [ -z "$delim" ] && delim=" "
  IFS="$delim" read -ra VALS <<< "$1"
  for v in "${VALS[@]}"; do
    echo $v
  done
}
export function split

# calculate
function calc(){ awk "BEGIN{ print $* }" ;}
export function calc

# conversions
function dec2hex(){ printf "%x\n" $1; }
export function dec2hex
function hex2dec(){ printf "%d\n" 0x$1; }
export function hex2dec
function bin2dec(){ echo "$((2#$1))"; }
export function bin2dec

# breakpoint
alias debug='__debug_cmd__="echo IN DEBUG MODE"; while [ "$__debug_cmd__" != "exit" ]; do eval $__debug_cmd__; echo -n "> "; read __debug_cmd__; done'

# Print the $1-th word of the input lines
function word {
    eval "awk '{print \$$1}'"
}
export function word

# Recursive remove
function rmr {
  pattern=$2
  find $1 -name "$pattern" |
  while read file; do
    rm -f $* "$file"
  done
}
export function rmr

# Trim white spacing in markdown notes
function trim_mds {
  dir=$1
  make -C ${CMD_UTIL_HOME}/src trim_md_list_spacing
  find $dir -name "*.md" |
  while read file; do
    echo "Trimming $file"
    ${CMD_UTIL_HOME}/bin/trim_md_list_spacing $file
  done
}
export function trim_mds

# Perform grep in a set of files
function findgrep {
    [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] && \
        echo "Usage: GREP=<grep_cmd> findgrep <dir> <file_pattern> <grep_pattern>" && \
        return 1

    GREP=${GREP:="grep"}
    echo "Using grep $GREP ($(whereis $GREP))"
    find $1 -name "$2" | while read f; do
        echo "==$f";
        $GREP --color=auto -Rns "$3" $f;
    done
}
export function findgrep

# Scan through a tarball
function zless {
    zcat $1 | less -N
}
export function zless

function scps {
    [ -z "$1" ] && echo

    scp_src_format=$1
    shift
    scp_dst_format=$1
    shift

    echo "$scp_src_format -> $scp_dst_format"

    while [ ! -z "$1" ]; do
        echo "ID is $1"

        src=$(printf "$scp_src_format" $1)
        dst=$(printf "$scp_dst_format" $1)
        scp $src $dst

        shift
    done
}
export function scps
