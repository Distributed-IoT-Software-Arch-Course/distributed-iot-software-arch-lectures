#!/bin/bash

# Ask for the project subdirectory (relative to current folder, leave empty for current folder)
echo "Enter the project subdirectory (relative to current folder, leave empty for current folder):"
read -e subdir  # -e enables readline for tab-completion

# If subdir is empty, set it to the current folder
if [ -z "$subdir" ]; then
  subdir="."
fi

# Build the full path to the folder
folder="$(pwd)/$subdir"

# Ask for the Markdown file name (with tab-completion)
echo "Enter the Markdown file name (must be inside $folder):"
read -e filename

# Ask for the output PDF name (optional)
echo "Enter the output PDF name (default: output.pdf):"
read -e output

# If output is empty, set default
if [ -z "$output" ]; then
  output="output.pdf"
fi

# Run Pandoc inside Docker with Eisvogel template
docker run --rm \
  -v "$folder:/data" \
  -u $(id -u):$(id -g) \
  pandoc/extra:3.7 \
  "$filename" \
  --template eisvogel \
  --standalone \
  --pdf-engine=xelatex \
  -o "$output"

# Capture the exit code of the docker command
status=$?

# Check if the conversion was successful
if [ $status -eq 0 ]; then
  echo "✅ Conversion complete! PDF saved as $folder/$output"
else
  echo "❌ Conversion failed! Please check your Markdown file and template."
fi
