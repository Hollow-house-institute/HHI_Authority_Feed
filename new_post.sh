#!/data/data/com.termux/files/usr/bin/bash

read -p "Platform (devto/linkedin/reddit): " platform
read -p "Date (YYYY-MM-DD): " date
read -p "Slug: " slug

dir="posts/$platform/$date"
file="$dir/$slug.md"

mkdir -p "$dir"

# base content
cp posts/_TEMPLATE.md "$file"

# platform-specific footer handling
if [ "$platform" = "reddit" ]; then
  # remove full footer for reddit
  sed -i '/## Footer/,$d' "$file"
elif [ "$platform" = "linkedin" ]; then
  # compress footer for linkedin
  sed -i '/## Footer/,$d' "$file"
  cat <<EOL >> "$file"

Time turns behavior into infrastructure.  
Behavior is the most honest data there is.

Canonical Source:
https://github.com/hhidatasettechs-oss/Hollow_House_Standards_Library
EOL
fi

nano "$file"
