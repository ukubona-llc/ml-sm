#!/bin/bash

# ===============================
# LLM PROJECT SNAPSHOT TOOL
# ===============================

TARGET_DIR="${1:-.}"
DEPTH=3
MAX_LINES=200          # Max lines per file
OUTPUT_FILE="llm_snapshot.log"

EXCLUDES=".git|node_modules|__pycache__|.venv|env|dist|build"

TEXT_EXT="md|txt|py|js|ts|html|css|json|yaml|yml|sh|csv|sql|toml|ini"

# ===============================
# Validate
# ===============================

if [ ! -d "$TARGET_DIR" ]; then
  echo "❌ Directory not found: $TARGET_DIR"
  exit 1
fi

# ===============================
# Start Log
# ===============================

exec > "$OUTPUT_FILE"

echo "=========================================="
echo "📦 LLM PROJECT SNAPSHOT"
echo "=========================================="
echo "Directory: $TARGET_DIR"
echo "Generated: $(date)"
echo "=========================================="
echo

# ===============================
# Counts
# ===============================

TOTAL_FILES=$(find "$TARGET_DIR" -type f | wc -l)
TOTAL_DIRS=$(find "$TARGET_DIR" -type d | wc -l)

echo "## 📊 SUMMARY"
echo "Files   : $TOTAL_FILES"
echo "Folders : $TOTAL_DIRS"
echo

# ===============================
# File Type Stats
# ===============================

echo "## 🧾 FILE TYPES"

for ext in md py js html css json sh csv sql yaml yml txt; do
  COUNT=$(find "$TARGET_DIR" -type f -iname "*.$ext" | wc -l)
  printf "%-8s : %4d\n" ".$ext" "$COUNT"
done

echo

# ===============================
# Directory Tree
# ===============================

echo "## 🌳 DIRECTORY TREE (Depth $DEPTH)"
echo

echo "$TARGET_DIR"

find "$TARGET_DIR" -mindepth 1 -maxdepth $DEPTH \
  | grep -Ev "$EXCLUDES" \
  | sed "s|$TARGET_DIR/||" \
  | sort \
  | awk -F/ '
{
  indent=""
  for(i=1;i<NF;i++) indent=indent "│   "
  print indent "├── " $NF
}'

echo
echo "=========================================="
echo

# ===============================
# File Contents
# ===============================

echo "## 📄 FILE CONTENTS"
echo

find "$TARGET_DIR" -type f \
  | grep -Ev "$EXCLUDES" \
  | grep -Ei "\.($TEXT_EXT)$" \
  | sort \
  | while read -r file; do

    echo "------------------------------------------"
    echo "📄 FILE: $file"
    echo "------------------------------------------"

    LINES=$(wc -l < "$file")

    echo "Lines: $LINES"
    echo

    if [ "$LINES" -le "$MAX_LINES" ]; then
        cat "$file"
    else
        echo "⚠️ Truncated (showing first $MAX_LINES lines)"
        echo
        head -n "$MAX_LINES" "$file"
        echo
        echo "... [TRUNCATED] ..."
    fi

    echo
    echo
done

# ===============================
# Footer
# ===============================

echo "=========================================="
echo "✅ SNAPSHOT COMPLETE"
echo "=========================================="
echo "Paste this file into your LLM:"
echo "👉 $OUTPUT_FILE"
