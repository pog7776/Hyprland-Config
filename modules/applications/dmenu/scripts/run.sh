#!/bin/bash

dmenu_command=(dmenu -i -l 10 -p "Run: ")

#query="$( echo "" | dmenu -p "Run: " <&- )" 
query="$(compgen -c | sort -u | "${dmenu_command[@]}" )"

if [ -n "${query}" ]; then
  app="$(echo "$query" | cut -d " " -f1)"
  kitty --detach --app-id "$app" "$query"
fi
