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


mkdir -p "$TARGET/Images" "$TARGET/Documents" "$TARGET/Videos" "$TARGET/Archives" "$TARGET/Code" "$TARGET/Other"


for file in "$TARGET"/*; do
    [ -f "$file" ] || continue  
    filename=$(basename "$file")

    
    [ "$filename" = "$(basename "$0")" ] && continue

    extension="${filename##*.}"

    case "$extension" in
        png|jpg|jpeg|gif)
            mv "$file" "$TARGET/Images/"
            echo "Moved $filename → Images"
            ;;
        pdf|docx|txt)
            mv "$file" "$TARGET/Documents/"
            echo "Moved $filename → Documents"
            ;;
        mp4|mov)
            mv "$file" "$TARGET/Videos/"
            echo "Moved $filename → Videos"
            ;;
        zip|rar)
            mv "$file" "$TARGET/Archives/"
            echo "Moved $filename → Archives"
            ;;
        py|js|html|css)
            mv "$file" "$TARGET/Code/"
            echo "Moved $filename → Code"
            ;;
        *)
            mv "$file" "$TARGET/Other/"
            echo "Moved $filename → Other"
            ;;
    esac
done

echo "Organization complete!"
