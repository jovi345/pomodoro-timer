#!/bin/bash

declare -A pomo_options
pomo_options["study"]="20"
pomo_options["work"]="20"
pomo_options["break"]="7"

if [ -n "$1" -a -n "${pomo_options["$1"]}" ]; then
  val=$1
  [ "$1" = "study" -o "$1" = "work" ] && echo "${val^} session in progress..." | lolcat
  timer "${pomo_options["$val"]}"m
  notify-send "${val^} session is done!" -i ~/Pictures/icon/thumbs-up.png
else 
  echo "Option is not available yet"
fi