#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Ensure the script is run from the root directory
if [ ! -d "images" ]; then
    echo "Please run this script from the root directory of the repository."
    exit 1
fi

# Function to convert images to WEBP format
convert_to_webp() {
    echo "Converting images to WEBP format..."
    
    # You only need each extension once, because `-iname` in 'find' ignores case.
    for ext in jpg jpeg png heic; do
        find images -type f -iname "*.${ext}" -exec bash -c '
            input="$1"
            output="${input%.*}.webp"
            echo "Converting $input to $output"
            mkdir -p "$(dirname "$output")"

            lowercase_input=$(echo "$input" | tr "[:upper:]" "[:lower:]")
            # Use a case statement or test for .heic
            case "$lowercase_input" in
                *.heic)
                    magick "$input" -quality 85 "$output"
                    ;;
                *)
                    cwebp -q 85 -mt "$input" -o "$output"
                    ;;
            esac
        ' bash {} \;
    done
}

# Function to generate resized images
generate_resized_images() {
    echo "Generating resized images..."
    # For reasonable images (2000px width)
    find images -type f -iname "*.webp" -exec sh -c '
        input="$1"
        output="reasonable-images/${input#images/}"
        if [ -f "$output" ]; then
            echo "Skipping $output, already exists."
            exit 0
        fi
        echo "Creating reasonable image $output"
        mkdir -p "$(dirname "$output")"
        cwebp -q 85 -mt -resize 2000 0 "$input" -o "$output"
    ' sh {} \;

    # For thumbnails (1100px width)
    find images -type f -iname "*.webp" -exec sh -c '
        input="$1"
        output="thumbnails/${input#images/}"
        if [ -f "$output" ]; then
            echo "Skipping $output, already exists."
            exit 0
        fi
        echo "Creating thumbnail $output"
        mkdir -p "$(dirname "$output")"
        cwebp -q 85 -mt -resize 1100 0 "$input" -o "$output"
    ' sh {} \;
}

# Main execution
convert_to_webp
generate_resized_images

echo "Image processing complete."
