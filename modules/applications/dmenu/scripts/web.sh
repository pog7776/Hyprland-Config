#!/bin/bash

query="$( echo "" | dmenu -p "Search: " <&- )" 
[ -n "${query}" ] && firefox https://www.google.com/search?q="${query}" &
