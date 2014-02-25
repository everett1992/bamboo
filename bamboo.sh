#!/bin/bash

#:: Define some helpfull functions

debug() { echo $@; }
error() { echo $script_name: $@ 1>&2; }

#:: Get command line arguments, and setup scripts from the shell state.

script_name=$(basename $0)
scaffold="$1"
project_name="$2"
project_path="$PWD"
scaffolds_dir=~/workspace/bamboo/scaffolds

# bamboo placeholders are surrouned by _{ and }_
# and must be made of only word charecters
lsym='_{'
rsym='}_'
valid_chars='\w'


#:: Setup bamboo placeholder replacement values

declare -A replacements

# Global replacements
replacements=(
  ["first_name"]="Caleb"
  ["last_name"]="Everett"

  ["scaffold"]="$scaffold"
  ["project_name"]="$project_name"
  ["project_path"]="$project_path"

  ["scaffolds_dir"]="$scaffolds_dir"
)
replacements["full_name"]="${replacements["first_name"]} ${replacements["last_name"]}"


print_replacements() {
  for placeholder in "${!replacements[@]}"; do
    replacemnet="${replacements["$placeholder"]}"
    echo "$placeholder:	$replacemnet"
  done | column -t -s '	'
}


#:: Check that scaffold exists

if [ -d "$scaffolds_dir/$scaffold" ]; then
  debug "Found scaffold $scaffold in $scaffolds_dir"
else
  error "Couldn't find scaffold $scaffold in $scaffolds_dir"
  exit 1
fi


#:: Begin replacing placeholders with values.

# I'd like to pass the dictionary of replacements to
# this as a function, but I don't know how to in bash
build_sed() {
  sed_expressions=""

  for placeholder in "${!replacements[@]}"; do
    # escape any charecters that might give sed trouble
    trouble_chars="\/"
    replacement="$(echo "${replacements["$placeholder"]}" | sed -s "s/\([$trouble_chars]\)/\\\\\1/g" -)"
    sed_expressions+="s/${lsym}${placeholder}${rsym}/${replacement}/g; "
  done

  echo "$sed_expressions"
}

# List of all scaffold subfiles, filenames are relative to the scaffold's dir.
files=$(cd $scaffolds_dir/$scaffold; find -mindepth 1)

sed_s="$(build_sed)"

for file in $files; do
  sed -s "$sed_s" "$scaffolds_dir/$scaffold/$file"
done
