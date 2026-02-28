#!/bin/bash

G='\e[90m'
E='\033[0m'
R='\033[0;31m'
err="${R}[!]${E} "


function do_reset() {  # 1 -- удалить (?) CMake; 2 -- удалить (?) venv
    if $1; then
        echo -e "$GСбрасываем конфигурацию CMake..."
        rm -rf ./cmake-build
    fi
    if $2; then
        echo -e "$GСбрасываем конфигурацию Python VENV..."
        rm -rf ./.venv
    fi
}

cmake=true
venv=true
while [ "$#" -gt 1 ]; do
    case "$1" in
        "--cmake" )
            if [ "$2" = "false" ] || [ "$2" -eq 0 ]; then
                cmake=false
            else
                echo -e "$errАргумент ключа CMake не может быть распознан! Значение по умолчанию: true"
            fi
            shift
            ;;
        "--venv" )
            if [ "$2" = "false" ] || [ "$2" -eq 0 ]; then
                venv=false
            else
                echo -e "$errАргумент ключа Python VENV не может быть распознан! Значение по умолчанию: true"
            fi
            shift
            ;;
    esac
    shift
done

do_reset $cmake $venv
