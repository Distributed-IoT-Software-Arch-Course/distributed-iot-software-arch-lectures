#!/bin/bash

# Get the script directory (works even if script is in scripts/ folder)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Get the project root (parent directory of script location)
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "📚 Pandoc Document Converter"
echo "=============================="
echo ""

#=============================================================================
# PHASE 1: INPUT CONFIGURATION
#=============================================================================
echo "🔹 PHASE 1: Input Configuration"
echo "─────────────────────────────────"
echo ""

# Ask for the input directory (containing the markdown file and potentially images)
echo "📂 ➤ Enter the input directory path (containing the markdown file and related assets like images):"
echo "💡 Examples:"
echo "   📁 ../Lectures/1-CPS-Introduction (lecture folder with images)"
echo "   📁 ../ (project root directory)"
echo "   📁 /absolute/path/to/input/directory"
echo ""
echo -n "📂 Input directory: "
read -e input_dir

# Convert relative path to absolute path if needed
if [[ "$input_dir" == /* ]]; then
  # Already absolute path
  input_dir_abs="$input_dir"
else
  # Relative path, convert to absolute
  input_dir_abs="$(cd "$input_dir" 2>/dev/null && pwd)"
  if [ ! -d "$input_dir_abs" ]; then
    # If the above fails, try relative to current directory
    input_dir_abs="$(pwd)/$input_dir"
  fi
fi

# Validate input directory exists
if [ ! -d "$input_dir_abs" ]; then
  echo "❌ Input directory '$input_dir_abs' does not exist."
  exit 1
fi

echo "✅ Input directory found: $input_dir_abs"
echo ""

# Ask for the markdown filename (within the input directory)
echo "📄 ➤ Enter the markdown filename (within the input directory):"
echo "📋 Available .md files in directory:"
ls -la "$input_dir_abs"/*.md 2>/dev/null | awk '{print "   📝 " $9}' || echo "   ⚠️  (No .md files found)"
echo ""
echo "💡 Examples:"
echo "   📝 1_cps_introduction.md"
echo "   📝 lecture2.md"
echo "   📝 README.md"
echo ""
echo -n "📄 Markdown filename: "
read -e input_filename

# Validate input file exists
input_file_abs="$input_dir_abs/$input_filename"
if [ ! -f "$input_file_abs" ]; then
  echo "❌ Input file '$input_file_abs' does not exist."
  exit 1
fi

echo "✅ Input file found: $input_file_abs"
echo ""

#=============================================================================
# PHASE 2: OUTPUT FORMAT SELECTION
#=============================================================================
echo "🔹 PHASE 2: Output Format Selection"
echo "─────────────────────────────────────"
echo ""

# Ask for the output format
echo "🎯 ➤ Choose the output format:"
echo "   📕 pdf  - Portable Document Format (best for printing and professional documents)"
echo "   📘 epub - Electronic Publication (best for e-readers and mobile devices)" 
echo "   🌐 html - Web page format (best for online viewing)"
echo ""
echo -n "🎯 Output format [pdf/epub/html]: "
read format

# Validate format
if [[ "$format" != "pdf" && "$format" != "epub" && "$format" != "html" ]]; then
  echo "❌ Unsupported format. Choose pdf, epub, or html."
  exit 1
fi

# Ask for author and title if format is EPUB
if [ "$format" = "epub" ]; then
  echo ""
  echo "📚 ➤ EPUB Metadata Configuration (optional):"
  echo "   ℹ️  EPUB files can include author and title metadata"
  echo ""
  echo "💡 Examples:"
  echo "   👤 Prof. Marco Picone"
  echo "   👤 University of Modena and Reggio Emilia"
  echo ""
  echo -n "👤 Author name (leave empty to skip): "
  read -e author
  
  echo ""
  echo "💡 Examples:"
  echo "   📖 Distributed IoT Software Architectures - Lecture 1"
  echo "   📖 CPS Introduction"
  echo ""
  echo -n "📖 Title (leave empty to skip): "
  read -e title
fi

echo ""

#=============================================================================
# PHASE 3: OUTPUT CONFIGURATION
#=============================================================================
echo "🔹 PHASE 3: Output Configuration"
echo "──────────────────────────────────"
echo ""

# Ask for the output directory
echo "📂 ➤ Enter the output directory path (will be created if it doesn't exist):"
echo "💡 Examples:"
echo "   📁 ../pdf (PDF files in project root)"
echo "   📁 ../ePub (EPUB files in project root)"
echo "   📁 ../output (general output folder)"
echo "   📁 /absolute/path/to/output"
echo ""
echo -n "📂 Output directory: "
read -e output_dir

# Convert relative path to absolute path if needed
if [[ "$output_dir" == /* ]]; then
  # Already absolute path
  output_dir_abs="$output_dir"
else
  # Relative path, convert to absolute
  output_dir_abs="$(cd "$(dirname "$output_dir")" 2>/dev/null && pwd)/$(basename "$output_dir")"
  if [ ! -d "$(dirname "$output_dir_abs")" ]; then
    # If the above fails, try relative to current directory
    output_dir_abs="$(pwd)/$output_dir"
  fi
fi

# Ask for the output filename (without extension)
echo ""
echo "📝 ➤ Enter the output filename (without extension):"
echo "💡 Examples:"
echo "   📄 1_cps_introduction (will become 1_cps_introduction.pdf)"
echo "   📄 lecture1_notes (will become lecture1_notes.epub)"
echo "   📄 my_document (will become my_document.html)"
echo ""
echo -n "📝 Output filename: "
read -e output_name

# Set default if empty
if [ -z "$output_name" ]; then
  output_name="output"
  echo "ℹ️  Using default filename: $output_name"
fi

# Create output directory if it doesn't exist
if [ ! -d "$output_dir_abs" ]; then
  echo "📁 Creating output directory: $output_dir_abs"
  mkdir -p "$output_dir_abs"
  if [ $? -ne 0 ]; then
    echo "❌ Failed to create output directory: $output_dir_abs"
    exit 1
  fi
else
  echo "✅ Output directory exists: $output_dir_abs"
fi

# Construct the full output filename
output_file="$output_name.$format"
output_path="$output_dir_abs/$output_file"

echo ""

#=============================================================================
# PHASE 4: CONFIGURATION SUMMARY & PROCESSING
#=============================================================================
echo "� PHASE 4: Configuration Summary & Processing"
echo "────────────────────────────────────────────────"
echo ""
echo "�🔧 Configuration Summary:"
echo "=========================="
echo "📄 Input file:      $input_file_abs"
echo "🎯 Output format:   $format"
echo "📁 Output location: $output_path"
if [ "$format" = "epub" ] && [ ! -z "$author" ]; then
  echo "👤 Author:          $author"
fi
if [ "$format" = "epub" ] && [ ! -z "$title" ]; then
  echo "📖 Title:           $title"
fi
echo ""

# Set engine/options depending on format
case $format in
  pdf)
    engine_args=("--template" "eisvogel" "--standalone" "--pdf-engine=xelatex")
    format_emoji="📕"
    ;;
  epub)
    engine_args=("-t" "epub")
    format_emoji="📘"
    # Add metadata if provided
    if [ ! -z "$author" ]; then
      engine_args+=("--metadata" "author=$author")
    fi
    if [ ! -z "$title" ]; then
      engine_args+=("--metadata" "title=$title")
    fi
    ;;
  html)
    engine_args=("--standalone" "-t" "html5")
    format_emoji="🌐"
    ;;
esac

echo "🔄 Converting to $format_emoji $format format..."
echo "📁 Mounting input directory: $input_dir_abs -> /input"
echo "📁 Mounting output directory: $output_dir_abs -> /output"
echo "📄 Processing file: $input_filename"
echo "⏳ Please wait..."
echo ""

# Run Pandoc inside Docker
# Mount the entire input directory (including images and assets) and output directory using absolute paths
# Set working directory to /input so relative paths work correctly
docker run --rm \
  -v "$input_dir_abs:/input" \
  -v "$output_dir_abs:/output" \
  -w /input \
  -u $(id -u):$(id -g) \
  pandoc/extra:3.7 \
  "$input_filename" \
  "${engine_args[@]}" \
  -o "/output/$output_file"

# Capture the exit code of the docker command
status=$?

echo ""
#=============================================================================
# PHASE 5: RESULTS & COMPLETION
#=============================================================================
echo "🔹 PHASE 5: Results & Completion"
echo "──────────────────────────────────"
echo ""

# Check if the conversion was successful
if [ $status -eq 0 ]; then
  echo "✅ Conversion successful!"
  echo "🎉 Output saved as: $output_path"
  echo "📊 File size: $(du -h "$output_path" 2>/dev/null | cut -f1 || echo "Unknown")"
  echo ""
  echo "🚀 Next steps:"
  echo "   📖 Open the file to review the output"
  echo "   📤 Share or distribute as needed"
  echo "   🔄 Run the script again for additional conversions"
else
  echo "❌ Conversion failed!"
  echo "🔍 Please check your Markdown file and template."
  echo ""
  echo "💡 Common issues:"
  echo "   🖼️  Missing images or broken image paths"
  echo "   📝 Invalid markdown syntax"
  echo "   🛠️  Template compatibility issues"
  echo "   🐳 Docker daemon not running"
  echo ""
  echo "🔄 Try running the script again with corrected inputs"
fi
