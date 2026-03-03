#!/bin/bash

err="\033[0;31m[!]\033[0m "


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
    ./shell/source/render.sh "$width" "$height" "$length"
fi
