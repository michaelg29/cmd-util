#!/bin/bash

id=$1
now=`date "+%Y_%m_%d-%H_%M_%S"`
host=${HOST:=${HOSTNAME}}
out_file=${USER}-${host}-${now}-${id}.txt

tee $out_file

echo "Written log to $out_file"

