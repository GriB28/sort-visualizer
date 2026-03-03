#!/bin/bash

err="\033[0;31m[!]\033[0m "


cmake=true
venv=true
temp=true
while [ "$#" -gt 1 ]; do
    case "$1" in
        --cmake)
            if [ "$2" = "false" ] || [ "$2" -eq 0 ]; then
                cmake=false
            else
                echo -e "$errАргумент ключа CMake не может быть распознан! Значение по умолчанию: true"
            fi
            shift
            ;;
        --venv)
            if [ "$2" = "false" ] || [ "$2" -eq 0 ]; then
                venv=false
            else
                echo -e "$errАргумент ключа Python VENV не может быть распознан! Значение по умолчанию: true"
            fi
            shift
            ;;
        --temp)
            if [ "$2" = "false" ] || [ "$2" -eq 0 ]; then
                temp=false
            else
                echo -e "$errАргумент ключа TEMP не может быть распознан! Значение по умолчанию: true"
            fi
            shift
            ;;
    esac
    shift
done

./shell/source/reset.sh $cmake $venv $temp
