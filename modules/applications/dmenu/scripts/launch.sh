#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

python3 $parent_path/dmenu-launch/dmenu_launch.py --apps
