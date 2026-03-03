#!/bin/bash

err="\033[0;31m[!]\033[0m "


input=""
output=""
while [ "$#" -gt 1 ]; do
    case "$1" in
        --input)
            if [[ $2 =~ ^.+\.txt$ ]]; then
                input="$2"
            else
                echo -e "$errАргумент ключа input не может быть распознан!"
            fi
            shift
            ;;
        --output)
            if [[ $2 =~ ^.+\.txt$ ]]; then
                output="$2"
            else
                echo -e "$errАргумент ключа output не может быть распознан!"
            fi
            shift
            ;;
    esac
    shift
done

if [ "$input" -eq "" ] || [ "$output" -eq "" ]; then
    echo -e "$errНеобходимые параметры не были переданы в роутер!"
else
    ./shell/source/sort.sh "$input" "$output"
fi
