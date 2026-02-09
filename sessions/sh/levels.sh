#!/bin/bash

# Script to create directory structure for Level 1 and Level 2
# Run this in the root directory (where sessions/ will be created)

# Create shared folders
mkdir -p sessions/css
touch sessions/css/index.css  # Placeholder for CSS

mkdir -p sessions/js
touch sessions/js/index.js    # Placeholder for JS

# Create Level 1: sessions/html/session[0-8].html
mkdir -p sessions/html
for i in {0..8}; do
  touch sessions/html/session${i}.html
done

# Create Level 2: sessions/level2/session[1-8]/sub[1-8].html
mkdir -p sessions/level2
for session in {1..8}; do
  mkdir -p sessions/level2/session${session}
  for sub in {1..8}; do
    touch sessions/level2/session${session}/sub${sub}.html
  done
done

echo "Directory structure created successfully!"