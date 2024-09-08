#!/bin/bash

declare -A pomo_options
pomo_options["study"]="9999"
pomo_options["work"]="9999"
pomo_options["break"]="7"

# Change this target_directory according to your liking
  target_directory=~/Documents/Workspace/bash/project-iseng/pomodoro-timer

generate_link(){
  # Check whether the file already existed
  # If existed, then no need to run the genereate_link function
  if [ ! -f "$target_directory/song-link.txt" ]; then
    # Change this yt channel link to your favorite one
    yt-dlp --flat-playlist --get-id "https://www.youtube.com/@chillpillsstudio/videos" >> $target_directory/song-link.txt
  fi
}

generate_random_number(){
  data_length=$(wc -l < $target_directory/song-link.txt)
  random_number=$(($RANDOM % $data_length))
  echo $random_number
}

if [ -n "$1" -a -n "${pomo_options["$1"]}" ]; then
  generate_link
  val=$1

  random_line=$(generate_random_number)
  if [ "$1" = "study" -o "$1" = "work" ]; then
    link="$(sed -n "${random_line}p" "$target_directory/song-link.txt")"
    full_url="https://www.youtube.com/watch?v=${link}" 
    echo $full_url

    echo "${val^} session in progress..." | lolcat
    yt-dlp -f bestaudio -o - $full_url 2>/dev/null | mpv - 
    notify-send "${val^} session is done!" -i ~/Pictures/icon/thumbs-up.png
  elif [ "$1" = "break" ]; then
    echo "Coffee break :)" | lolcat
    timer "${pomo_options["$val"]}"m
  fi

else 
  echo "Option is not available yet"
fi
