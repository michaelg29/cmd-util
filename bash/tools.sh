#!/bin/bash

# silent
function silent {
  eval "$*" &> /dev/null
  return $?
}
export function silent

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

# recursive remove
function rmr {
  pattern=$1
  shift
  find . -name "$pattern" |
  while read file; do
    rm -f $* "$file"
  done
}
export function rmr
