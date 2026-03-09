#!/bin/bash

G='\e[90m'
E='\033[0m'
err="\033[0;31m[!]${E} "


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
                echo -e "$GВыходной файл с таким именем уже существует. Программа спросит разрешение на перезапись."
            fi
            output="$2"
            shift
            ;;
    esac
    shift
done

if [ -z "$input" ] || [ -z "$output" ]; then
    echo -e "$errНеобходимые параметры не были переданы в роутер!"
else
    if [ "$input" = "$output" ]; then
        echo -e "$GПараметр input не может быть равен параметру output!$E"
    else
        ffmpeg -i "$input" -filter:v "framerate=fps=60:interp_start=0:interp_end=0:scene=0" "$output"
    fi
fi
