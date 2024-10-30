# Function to delete original images
delete_originals() {
    echo "Deleting original images..."
    for ext in jpg jpeg png heic HEIC; do
        find images -type f -iname "*.${ext}" -delete
    done
}

delete_originals

echo "Non WEBP formatted images removed"
