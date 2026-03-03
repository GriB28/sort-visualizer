#!/bin/bash

G='\e[90m'
err="\033[0;31m[!]\033[0m "


video_length=0
array_length=0
name=""
video_width=1920
video_height=1080
while [ "$#" -gt 1 ]; do
    case "$1" in
        --video_length)
            if [[ $2 =~ ^[0-9]+$ ]]; then
                video_length="$2"
            else
                echo -e "$errАргумент ключа video_length не может быть распознан!"
            fi
            shift
            ;;
        --array_length)
            if [[ $2 =~ ^[0-9]+$ ]]; then
                array_length="$2"
            else
                echo -e "$errАргумент ключа array_length не может быть распознан!"
            fi
            shift
            ;;
        --video_width)
            if [[ $2 =~ ^[0-9]+$ ]]; then
                video_width="$2"
            else
                echo -e "$errАргумент ключа video_width не может быть распознан!"
            fi
            shift
            ;;
        --video_height)
            if [[ $2 =~ ^[0-9]+$ ]]; then
                video_height="$2"
            else
                echo -e "$errАргумент ключа video_height не может быть распознан!"
            fi
            shift
            ;;
        --name)
            if [[ $2 =~ ^(bubble|heap|merge|selection|insertion|quick)$ ]]; then
                name="$2"
            else
                echo -e "$errАргумент ключа name не может быть распознан!"
            fi
            shift
            ;;
    esac
    shift
done

if [ "$video_length" -eq 0 ] || [ "$array_length" -eq 0 ] || [ -z "$name" ]; then
    echo -e "$errНеобходимые параметры не были переданы в роутер!"
else
    echo -e "$GПодготовка к генерации видео..."
    fps=$(("$array_length" * 100 / "$video_length"))  # needs tests

    ./shell/routers/generate.sh --name "$name" --length "$array_length"
    ./shell/routers/sort.sh --input "arrays/input_$name.txt" --output "arrays/output_$name.txt"
    ./shell/routers/render.sh --fps $fps --file "arrays/output_$name.txt" --width "$video_width" --height "$video_height"
fi
