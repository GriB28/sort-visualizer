#!/bin/bash

E='\033[0m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
GREY='\e[90m'
err="\033[0;31m[!]${E} "


function help() {
    read -rp "$GREYНомер страницы (по умолчанию: все): " page
    if [ "$page" -eq "" ]; then
        ./shell/routers/help.sh
    else
        ./shell/routers/help.sh --page "$page"
    fi
}

function main() {
    read -rp "$CYANРазмер массива для сортировки (количество элементов): " array_length
    read -rp "$CYANДлина видео (в секундах): " video_length
    read -rp "$CYANНазвание сортировки: " name

    ./shell/routers/main --array_length "$array_length" --video_length "$video_length" --name "$name"
}

function reset() {
    cmake=-1
    while [ $cmake -eq -1 ]; do
        read -rp "$GREYСбросить настройки CMake? (y/n, по умолчанию 'y') " cmake
        case $cmake in
            y|Y)
                cmake=true
                ;;
            n|N)
                cmake=false
                ;;
            *)
                echo -e "$errВведённое значение не может быть распознано"
                cmake=-1
                ;;
        esac
    done

    venv=-1
    while [ $venv -eq -1 ]; do
        read -rp "$GREYСбросить настройки Python VENV? (y/n, по умолчанию 'y') " venv
        case $venv in
            y|Y)
                venv=true
                ;;
            n|N)
                venv=false
                ;;
            *)
                echo -e "$errВведённое значение не может быть распознано"
                venv=-1
                ;;
        esac
    done

    temp=-1
    while [ $temp -eq -1 ]; do
        read -rp "$GREYОчистить временные файлы? (y/n, по умолчанию 'y') " temp
        case $temp in
            y|Y)
                temp=true
                ;;
            n|N)
                temp=false
                ;;
            *)
                echo -e "$errВведённое значение не может быть распознано"
                temp=-1
                ;;
        esac
    done

    ./shell/routers/reset.sh --cmake $cmake --venv $venv --temp $temp
}

function generate() {
    read -rp "$CYANНазвание сортировки: " name
    read -rp "$CYANРазмер массива для сортировки: " length

    ./shell/routers/generate.sh --name "$name" --length "$length"
}

function sort() {
    read -rp "$CYANФайл с конфигурацией: " input
    read -rp "$CYANИмя выходного файла: " output

    ./shell/routers/sort.sh --input "$input" --output "$output"
}

function render() {
    read -rp "$CYANФайл с конфигурацией: " file
    read -rp "$CYANКоличество кадров в секунду: " fps

    read -rp "$GREYГоризонтальный размер видео (по умолчанию: 1920): " width
    if [ "$width" -eq "" ]; then
        width=1920
    fi

    read -rp "$GREYВертикальный размер видео (по умолчанию: 1080): " height
    if [ "$height" -eq "" ]; then
        height=1080
    fi

    ./shell/routers/render.sh --file "$file" --fps "$fps" --width "$width" --height "$height"
}


while true; do
    read -rp "$GREEN>>> " command
    case $command in
        exit)
            break
            ;;
        help)
            help
            ;;
        main)
            main
            ;;
        reset)
            reset
            ;;
        generate)
            generate
            ;;
        sort)
            sort
            ;;
        render)
            render
            ;;
        *)
            echo -e "$errКоманда не распознана!"
            ;;
    esac
done

echo -e "$YELLOW\sort_visualizer, 2026$E"
echo -e "$GREY\https:://github.com/GriB28/sort_visualizer$E"
exit
