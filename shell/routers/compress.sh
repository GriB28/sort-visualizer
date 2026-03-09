#!/bin/bash

err="\033[0;31m[!]\033[0m "


input=""
output=""
while [ "$#" -gt 1 ]; do
    case "$1" in
        --input)
            if [ -f "$2" ]; then
                input="$2"
            else
                echo -e "$errАргумент ключа input не может быть распознан!"
            fi
            shift
            ;;
        --output)
            if [ -f "$2" ]; then
                output="$2"
            else
                echo -e "$errАргумент ключа output не может быть распознан!"
            fi
            shift
            ;;
    esac
    shift
done

if [ -z "$input" ] || [ -z "$output" ]; then
    echo -e "$errНеобходимые параметры не были переданы в роутер!"
else
    ffmpeg -i "$input" -filter:v "framerate=fps=60:interp_start=0:interp_end=0:scene=0" "$output"
fi
