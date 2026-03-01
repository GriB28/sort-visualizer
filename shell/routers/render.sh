#!/bin/bash

G='\e[90m'
E='\033[0m'
R='\033[0;31m'
err="${R}[!]${E} "


function do_render() {  # 1 -- video width; 2 -- video height; 3 -- video length
    fps=$((10000 / "$3"))  # needs tests

    echo -e "$GЗапущен рендер видео с параметрами:"
    echo -e "$G> WIDTH  = $1"
    echo -e "$G> HEIGHT = $2"
    echo -e "$G> FPS    = $fps"

    python3 test.py "$1" "$2" "$fps"

    echo -e "$GГотово!"
}

length=0
width=1920
height=1080
while [ "$#" -gt 1 ]; do
    case "$1" in
        --length)
            if [[ $2 =~ ^[0-9]+$ ]]; then
                length="$2"
            else
                echo -e "$errАргумент ключа length не может быть распознан!"
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
    esac
    shift
done

if [ "$length" -eq 0 ]; then
    echo -e "$errПараметр по ключу length не был передан в роутер!"
else
    do_render "$width" "$height" "$length"
fi
