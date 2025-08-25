#!/bin/bash

dmenu_path | dmenu -l 10 -p "Run:" "$@" | ${SHELL:-"/bin/sh"} &
