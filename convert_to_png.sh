#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Ensure the script is run from the root directory
if [ ! -d "images" ]; then
    echo "Please run this script from the root directory of the repository."
    exit 1
fi

# Create pngs directory if it doesn't exist
mkdir -p pngs

# Function to convert webp images to PNG format
convert_to_png() {
    echo "Converting webp images to PNG format..."
    
    find images -type f -name "*.webp" -exec bash -c '
        input="$1"
        relative_path="${input#images/}"
        output_dir="pngs/$(dirname "$relative_path")"
        output_file="$output_dir/$(basename "${input%.webp}").png"
        
        mkdir -p "$output_dir"
        
        echo "Converting $input to $output_file"
        dwebp "$input" -o "$output_file"
    ' bash {} \;
}

# Main execution
convert_to_png

echo "PNG conversion complete. Images stored in pngs/ directory."