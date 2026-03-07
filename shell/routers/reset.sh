#!/bin/bash

err="\033[0;31m[!]\033[0m "


cmake=true
venv=true
temp=true
while [ "$#" -gt 1 ]; do
    case "$1" in
        --cmake)
            if [ "$2" = "false" ]; then
                cmake=false
            else
                if [ "$2" = "true" ]; then
                    cmake=true
                else
                    echo -e "$errАргумент ключа CMake не может быть распознан! Значение по умолчанию: true"
                fi
            fi
            shift
            ;;
        --venv)
            if [ "$2" = "false" ]; then
                venv=false
            else
                if [ "$2" = "true" ]; then
                    venv=true
                else
                    echo -e "$errАргумент ключа Python VENV не может быть распознан! Значение по умолчанию: true"
                fi
            fi
            shift
            ;;
        --temp)
            if [ "$2" = "false" ]; then
                temp=false
            else
                if [ "$2" = "true" ]; then
                    temp=true
                else
                    echo -e "$errАргумент ключа TEMP не может быть распознан! Значение по умолчанию: true"
                fi
            fi
            shift
            ;;
    esac
    shift
done

./shell/source/reset.sh "$cmake" "$venv" "$temp"
