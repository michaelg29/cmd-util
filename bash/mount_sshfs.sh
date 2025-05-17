#!/bin/bash

# Mount an SSHFS target

function mount_sshfs {
  echo "args are $@"

  dst=`eval "echo $1"`
  shift
  echo "dst is $dst"
  startdir="${dst##*:}"
  dst="${dst%%:*}"

  if [ -z "$startdir" ]; then
    startdir="/"
  fi
  user=$USER
  grp=`id -g`
  dir="${HOME}/sshfs/${dst}"

  # construct options
  opts="-o allow_other -o cache=yes"
  if [ -f ~/.ssh/id_rsa ]; then
    opts="$opts -o IdentityFile=~/.ssh/id_rsa"
  fi

  # make directory
  if [ ! -d $dir ]; then
    echo "Creating directory $dir"
    mkdir -p $dir
  fi

  echo "Destination: $dst"
  echo "Start directory: $startdir"
  echo "Mount directory: $dir"
  echo "Options: $opts"

  # open connection
  sshfs $opts $dst:$startdir "$dir" && echo "$dir" >> ~/sshfs/open_sessions

}

dir="$1"
if [ -z "$dir" ] || [ "$dir" == "-all" ]; then
  cat ~/sshfs/init_sessions |
  while read dir; do
    mount_sshfs $dir
  done
elif [[ $dir =~ -re=* ]]; then
  re="${dir##-re=}"
  grep "$re" ~/sshfs/init_sessions |
  while read dir; do
    mount_sshfs $dir
  done
else
  mount_sshfs $dir
fi

