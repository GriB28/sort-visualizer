#!/bin/bash

err="\033[0;31m[!]\033[0m "


fps=0
sort_file=""
source_file=""
image_file=""
name="default"
width=1920
height=1080
while [ "$#" -gt 1 ]; do
    case "$1" in
        --fps)
            if [[ $2 =~ ^[0-9]+$ ]]; then
                fps="$2"
            else
                echo -e "$errАргумент ключа fps не может быть распознан!"
            fi
            shift
            ;;
        --sort_file)
            if [ -f "$2" ]; then
                sort_file=$2
            else
                echo -e "$errАргумент ключа sort_file не может быть найден на диске!"
            fi
            shift
            ;;
        --source_file)
            if [ -f "$2" ]; then
                source_file=$2
            else
                echo -e "$errАргумент ключа source_file не может быть найден на диске!"
            fi
            shift
            ;;
        --image_file)
            if [ -f "$2" ]; then
                image_file=$2
            else
                echo -e "$errАргумент ключа image_file не может быть найден на диске!"
            fi
            shift
            ;;
        --width)
            if [[ $2 =~ ^[0-9]+$ ]]; then
                width="$2"
            else
                echo -e "$errАргумент ключа width не может быть распознан!"
            fi
            shift
            ;;
        --height)
            if [[ $2 =~ ^[0-9]+$ ]]; then
                height="$2"
            else
                echo -e "$errАргумент ключа height не может быть распознан!"
            fi
            shift
            ;;
        --name)
            name="$2"
            shift
            ;;
    esac
    shift
done

if [ "$fps" -eq 0 ] || [ -z "$sort_file" ] || [ -z "$source_file" ]; then
    echo -e "$errНеобходимые параметры не были переданы в роутер!"
else
    case "$image_file" in
        "")
            image_file=0
            ;;
        *.csv)
            image_mode=1
            ;;
        *.jpg)
            image_mode=2
            ;;
    esac

    ./shell/source/render.sh "$width" "$height" "$fps" "$source_file" "$sort_file" "$name" "$image_mode" "$image_file"
fi
