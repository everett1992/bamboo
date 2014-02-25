#!/bin/bash

debug() { echo $@; }
error() { echo $script_name: $@ 1>&2; }

script_name=$(basename $0)

lsym='-{'
rsym='}-'
valid_chars='\w'

# Global vars
first_name="Caleb"
last_name="Everett"
full_name="$first_name $last_name"

# Auto vars
scaffold="$1"
project_name="$2"
project_path="$PWD/"

# TODO: create system and user scaffold folders.
scaffolds_dir=~/workspace/bamboo/scaffolds

echo "scaffold_dir: $scaffolds_dir"
echo "scaffold:     $scaffold"
echo "project_name: $project_name"
echo "project_path: $project_path"

if [ -d "$scaffolds_dir/$scaffold" ]; then
  debug "Found scaffold $scaffold in $scaffolds_dir"
else
  error "Couldn't find scaffold $scaffold in $scaffolds_dir"
  exit 1
fi
