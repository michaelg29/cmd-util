#!/bin/bash

# Select project working directories

exe="$1"
dir="$2"
wds_file=${WDS_FILE:="$3"}

# only print directory to stdout if storing in a variable
{

[ -z "$exe" ] && exe="echo"
[ -z "$wds_file" ] && wds_file="${HOME}/bin/wds.txt"

echo "exe is $exe dir is $dir wds_file is $wds_file"

COL_CYAN='\033[0;96m'
COL_NORMAL='\033[0;39m'

normal=$(tput sgr0; echo -e $COL_NORMAL)
def=$(tput bold; echo -e $COL_CYAN)

if [ -f "$wds_file" ]; then

  names=()
  opts=()

  while read line; do
      names+=($(eval "echo \"${line%% *}\""))
      opts+=($(eval "echo \"${line##* }\""))
  done < "$wds_file"

  # option display
  if [ -z "$dir" ]; then
    echo "=== Directories ==="
    echo ""
    i=0
    for name in "${names[@]}"; do
      echo "  [$name] - ${opts[$i]}"
      ((i++))
    done
    read -p "  Plase select your target destination ${def}[.]${normal}: " dir

    dir=(${dir:-.})

    # find selection
    i=0
    for name in "${names[@]}"; do
      [[ "$name" == "${dir[0]}" ]] && break
      ((i++))
    done
    dir="${opts[$i]}${dir[1]}"
  fi

else

  dir=${dir:-$(pwd)}

fi

# only print directory to stdout if storing in a variable
} 1>&2

# open
${exe} ${dir}
