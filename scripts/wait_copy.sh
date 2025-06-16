#!/bin/bash

TARGET_DIR="$1"
SOURCE_FILE="$2"

if [[ -z "$TARGET_DIR" || -z "$SOURCE_FILE" ]]; then
    echo "usage: $0 /path/to/target_dir /path/to/source_file [copy delay secs]"
    exit 1
fi

echo -n "waiting for directory: $TARGET_DIR"

SECONDS_WAITED=0

# Wait for directory to exist, showing live counter
while [ ! -d "$TARGET_DIR" ]; do
    printf "\rwaiting for directory: %s [%ds]" "$TARGET_DIR" "$SECONDS_WAITED"
    sleep 1
    ((SECONDS_WAITED++))
done

printf "\rdirectory found. copying file...\n"

# Optional delay before copying
if [[ -n "$3" && "$3" =~ ^[0-9]+$ ]]; then
    echo "sleeping for $3 seconds before copying..."
    sleep "$3"
fi

cp "$SOURCE_FILE" "$TARGET_DIR"

echo "file copied to $TARGET_DIR"
