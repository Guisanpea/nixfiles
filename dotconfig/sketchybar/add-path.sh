#!/bin/bash
export PATH="/opt/homebrew/bin:$PATH"

# Directory to search for .sh files
SEARCH_DIR="."

# Path to add
NEW_PATH='export PATH="/opt/homebrew/bin:$PATH"'

# Find all .sh files in the directory and subdirectories
# and add NEW_PATH on the second line
find "$SEARCH_DIR" -type f -name "*.sh" -exec sed -i '' "1 a\\
$NEW_PATH
" {} \;

echo "Path added to all .sh files in $SEARCH_DIR and its subdirectories"

