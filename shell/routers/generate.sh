#!/bin/bash

err="\033[0;31m[!]\033[0m "


name=""
length=0
while [ "$#" -gt 1 ]; do
    case "$1" in
        --name)
            if [[ $2 =~ ^(bubble|heap|merge|selection|insertion|quick)$ ]]; then
                name="$2"
            else
                echo -e "$errАргумент ключа name не может быть распознан!"
            fi
            shift
            ;;
        --length)
            if [[ $2 =~ ^[0-9]+$ ]]; then
                length="$2"
            else
                echo -e "$errАргумент ключа length не может быть распознан!"
            fi
            shift
            ;;
    esac
    shift
done

if [ "$name" -eq "" ] || [ "$length" -eq 0 ]; then
    echo -e "$errНеобходимые параметры не были переданы в роутер!"
else
    ./shell/source/generate.sh "$name" "$length"
fi
