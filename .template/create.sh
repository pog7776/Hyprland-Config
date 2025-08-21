#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

directory="./$1"
name=$(basename $directory)
pretty_name="${name^}"

echo $directory
echo $name
echo $pretty_name

loader_name="\$loaderName = $pretty_name"

load_file="$directory/load.conf"
settings_file="$directory/settings.conf"

mkdir $directory

echo $loader_name >> $load_file
cat $parent_path/load.conf >> $load_file

cp $parent_path/settings.conf $settings_file 
