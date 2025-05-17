#!/bin/bash

# Unmount an SSHFS target

echo "" > ~/sshfs/open_sessions.tmp

function umount_sshfs {
  dir="$1"
  [ -z "$dir" ] && return

  grep --invert-match "$dir" ~/sshfs/open_sessions > ~/sshfs/open_sessions.tmp
  diskutil umount force "$dir"
  code=$?
  if [ $code -eq 0 ]; then
    mv ~/sshfs/open_sessions.tmp ~/sshfs/open_sessions
  else
    echo "Could not unmount $dir"
  fi
}

dir="$1"
if [ -z "$dir" ] || [ "$dir" == "-all" ]; then
  cat ~/sshfs/open_sessions |
  while read dir; do
    umount_sshfs $dir
  done
else
  umount_sshfs $dir
fi
