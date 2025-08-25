#!/bin/bash

echo -e "poweroff\nreboot\nsuspend" | dmenu | xargs systemctl
