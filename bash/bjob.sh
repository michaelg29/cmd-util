#!/bin/bash

# Execute and log background jobs

id=$1
now=`date "+%Y-%m-%d_%H-%M-%S"`
out_file=out_${now}_${id}.txt
echo "Writing log to $out_file"
shift
BJOB_IN_FILE=${BJOB_IN_FILE:=./bjob.in}
if [[ -f "$BJOB_IN_FILE" ]] && [[ -z "$BJOB_NO_INPUT" ]]; then
  eval "$* < $BJOB_IN_FILE &> $out_file" &
  procid=$!
else
  eval "$* &> $out_file" &
  procid=$!
fi
disown
if [ ! -z "$BJOB_JOB_LOG" ]; then
  if [ ! -f "$BJOB_JOB_LOG" ]; then
    echo "Time,Job ID,Process ID,User,Working directory,Log file,Run command,Comments" > $BJOB_JOB_LOG
  fi
  echo "$now,$id,$procid,$USER,`pwd`,$out_file,$*,$BJOB_COMMENTS" >> $BJOB_JOB_LOG
fi
