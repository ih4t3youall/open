#!/bin/bash

filename=$(basename -- "$1")
extension="${filename##*.}"
filename="${filename%.*}"

# Function to open a file using the default application associated with its extension
open_file() {
    xdg-open "$1" >/dev/null 2>&1
}

# Array of supported file types and their corresponding default applications
declare -A file_types=(
    ["odt"]="libreoffice"
    ["docx"]="libreoffice"
    ["doc"]="libreoffice"
    ["ods"]="libreoffice"
    ["csv"]="libreoffice"
    ["txt"]="featherpad"
    ["java"]="featherpad"
    ["feature"]="featherpad"
    ["jpg"]="feh"
    ["jpeg"]="feh"
    ["png"]="feh"
    ["bmp"]="feh"
    ["3gp"]="vlc"
    ["asf"]="vlc"
    ["avi"]="vlc"
    ["flv"]="vlc"
    ["mkv"]="vlc"
    ["midi"]="vlc"
    ["mp4"]="vlc"
    # Add more file types and applications as needed
)

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
    return 1
fi

if [ -d "$1" ]; then
    echo "$1 is a directory"
    xdg-open "$1" >/dev/null 2>&1
    return
fi

if [ "$1" = "." ]; then
    xdg-open . >/dev/null 2>&1
    return
fi

if [ "$extension" = "sh" ]; then
    chmod +x "$1"
    "./$1"
    return
fi

if [ "$extension" = "py" ]; then
    python3 "$1"
    return
fi

if [ "$extension" = "pdf" ]; then
    open_file "$1"
    return
fi

# Check if the file extension is supported and open the file using the associated application
if [ "${file_types[$extension]+_}" ]; then
    "${file_types[$extension]}" "$1"
    return
fi

# If the file is a text file, open it in Vim
file -b --mime-encoding "$1" | grep -q "charset=us-ascii" && open_file "$1" || vim "$1"

