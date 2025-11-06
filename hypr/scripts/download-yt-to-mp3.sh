#!/bin/bash

# Script to download audio from a user-provided URL using yt-dlp and convert it to MP3.

set -euo pipefail

OUTPUT_DIR="$HOME/Music"
mkdir -p "$OUTPUT_DIR"

echo "🎵 yt-dlp Interactive MP3 Downloader"
echo "-------------------------------------"

# Prompt the user for the URL
read -p "Please enter the video URL: " VIDEO_URL

# Check if the user entered anything
if [ -z "$VIDEO_URL" ]; then
    echo "Error: No URL provided. Exiting."
    exit 1
fi

echo "---"
echo "Starting download and conversion for URL: $VIDEO_URL"
echo "---"

# Execute the yt-dlp command inside a conditional so the script can continue
# to the final prompt even if yt-dlp fails (set -e is enabled).
if yt-dlp \
    --extract-audio \
    --audio-format mp3 \
    --embed-thumbnail \
    --output "$OUTPUT_DIR/%(title)s.%(ext)s" \
    "$VIDEO_URL"; then
    echo "---"
    echo "✅ Download and conversion completed successfully!"
    rc=0
else
    echo "---"
    echo "❌ An error occurred during the download or conversion."
    rc=1
fi

# Wait for user to press Enter so they can inspect the terminal output before it closes
echo
read -r -p "Press Enter to close this window..." _ || true

exit $rc