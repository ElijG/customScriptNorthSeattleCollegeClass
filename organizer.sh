#!/bin/bash

echo "----Desktop/File Organizer (from current directory)----"

# Infinite loop to reprompt until a valid directory is given
while true; do
    read -p "Enter a folder to organize (leave empty for current directory): " INPUT

    if [ -z "$INPUT" ]; then
        TARGET="$PWD" 
    else
        TARGET="$PWD/$INPUT"  
    fi

  
    if [ -d "$TARGET" ]; then
        echo "Organizing directory: $TARGET"
        break
    else
        echo "Directory '$TARGET' does not exist. Please try again."
    fi
done


mkdir -p "$TARGET/images" "$TARGET/documents" "$TARGET/videoaudio" "$TARGET/archives" "$TARGET/code" "$TARGET/other"


for file in "$TARGET"/*; do
    [ -f "$file" ] || continue  
    filename=$(basename "$file")

    
    [ "$filename" = "$(basename "$0")" ] && continue

    extension="${filename##*.}"

    case "$extension" in
        png|jpg|jpeg|gif)
            mv "$file" "$TARGET/images/"
            echo "Moved $filename → images"
            ;;
        pdf|docx|txt)
            mv "$file" "$TARGET/documents/"
            echo "Moved $filename → documents"
            ;;
        mp4|mov|mp3|.wav)
            mv "$file" "$TARGET/videoaudio/"
            echo "Moved $filename → videoaudio"
            ;;
        zip|rar)
            mv "$file" "$TARGET/archives/"
            echo "Moved $filename → archives"
            ;;
        py|js|html|css|sh)
            mv "$file" "$TARGET/code/"
            echo "Moved $filename → code"
            ;;
        *)
            mv "$file" "$TARGET/other/"
            echo "Moved $filename → other"
            ;;
    esac
done

echo "Organization complete!"
