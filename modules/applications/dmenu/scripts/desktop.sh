#!/bin/bash

# This script creates a dmenu application launcher similar to rofi's drun mode.
# It finds all .desktop files, extracts their names, and launches the selected one.

# Define the directories to search for .desktop files.
# We use the XDG_DATA_DIRS environment variable for robustness,
# but also explicitly add the user's local applications directory.
DESKTOP_DIRS="/usr/share/applications/ ~/.local/share/applications/"

# Generate a list of applications to display in dmenu.
# The list is formatted as "AppName | /path/to/app.desktop"
# This allows dmenu to display only the name, while retaining the full path.
app_list=$(
  # Find all .desktop files in the defined directories
  find $DESKTOP_DIRS -type f -name "*.desktop" 2>/dev/null | \
  while IFS= read -r desktop_file; do
    # Use grep to find the line starting with "Name=" in the file
    # `cut` then extracts just the value after the "="
    name=$(grep -m 1 "^Name=" "$desktop_file" | cut -d'=' -f2-)

    # Check if a name was found and the file is executable
    if [ -n "$name" ] && grep -q '^Exec=' "$desktop_file"; then
      # Print the app name and the full path, separated by a pipe
      echo "${name}" # | ${desktop_file}"
    fi
  done | \
  # Sort the list alphabetically and remove duplicates for a clean display
  sort -u
)

# Pipe the formatted list to dmenu and store the user's choice.
# `-l 10` sets the number of lines, and `-p` sets the prompt.
# We then use `cut` to extract only the file path from the selected line.
choice=$(echo "$app_list" | dmenu -i -l 10 -p "Run app:" | cut -d'|' -f2-)

# Check if a choice was made and launch the application using gio.
if [ -n "$choice" ]; then
  # `gio launch` is the most reliable way to execute a .desktop file.
  # The `&` runs the process in the background, so dmenu closes immediately.
  gio launch "$choice" &
fi
