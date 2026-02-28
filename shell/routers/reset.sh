#!/bin/bash

G='\e[90m'
E='\033[0m'
R='\033[0;31m'
err="${R}[!]${E} "


function do_reset() {  # 1 -- удалить (?) CMake; 2 -- удалить (?) venv; 3 -- удалить (?) временные файлы
    if $1; then
        echo -e "$GСбрасываем конфигурацию CMake..."
        rm -rf ./cmake-build
    fi
    if $2; then
        echo -e "$GСбрасываем конфигурацию Python VENV..."
        rm -rf ./.venv
    fi
    if $3; then
        echo -e "$GОчищаем временные файлы..."
        ./shell/clear.sh
    fi
}

cmake=true
venv=true
temp=true
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
        "--temp" )
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

do_reset $cmake $venv $temp
