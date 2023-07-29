#!/bin/bash

# path from argument
directory="$1"

# Change to the specified directory
cd "$directory" || { echo "Directory not found."; exit 1; }

# Loop through each file in the directory
for file in *; do
  # Check if the file is a regular file (not a directory or a symbolic link)
  if [[ -f "$file" ]]; then
    # the filename is "[number][dot] [espace] [filename] [extension]" take the filename
    filename=$(echo "$file" | sed -E 's/^[0-9]+\. (.*)\..*$/\1/')
    #
    echo "$filename"
    lowercase_filename=$(echo "$filename" | tr '[:upper:]' '[:lower:]')
    #echo "$lowercase_filename"
    # Create the aliases content to prepend
    aliases_content="---
aliases: $filename, $lowercase_filename
---
"

    # add the content to the start of the file
    echo "$aliases_content" | cat - "$file" > temp && mv temp "$file"
  fi
done

echo "Aliases prepended to files in the directory."

