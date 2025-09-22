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

# Ask for the output format
echo "Choose the output format (pdf, epub, html):"
read format

# Validate format
if [[ "$format" != "pdf" && "$format" != "epub" && "$format" != "html" ]]; then
  echo "❌ Unsupported format. Choose pdf, epub, or html."
  exit 1
fi

# Ask for author and title if format is EPUB
if [ "$format" = "epub" ]; then
  echo "Enter the author name for the EPUB (leave empty to skip):"
  read -e author
  
  echo "Enter the title for the EPUB (leave empty to skip):"
  read -e title
fi

# Ask for the base name of the output file (without extension)
echo "Enter the base name of the output file (extension will be added automatically):"
read -e output_base

# Set default if empty
if [ -z "$output_base" ]; then
  output_base="output"
fi

# Construct the full output filename
output="$output_base.$format"

# Set engine/options depending on format
case $format in
  pdf)
    engine="--template eisvogel --standalone --pdf-engine=xelatex"
    ;;
  epub)
    engine="-t epub"
    # Add metadata if provided
    if [ ! -z "$author" ]; then
      engine="$engine --metadata author=\"$author\""
    fi
    if [ ! -z "$title" ]; then
      engine="$engine --metadata title=\"$title\""
    fi
    ;;
  html)
    engine="--standalone -t html5"
    ;;
esac

# Run Pandoc inside Docker
docker run --rm \
  -v "$folder:/data" \
  -u $(id -u):$(id -g) \
  pandoc/extra:3.7 \
  "$filename" \
  $engine \
  -o "$output"

# Capture the exit code of the docker command
status=$?

# Check if the conversion was successful
if [ $status -eq 0 ]; then
  echo "✅ Conversion complete! Output saved as $folder/$output"
else
  echo "❌ Conversion failed! Please check your Markdown file and template."
fi
