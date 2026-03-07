#!/bin/bash

E='\033[0m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
GREY='\e[90m'
err="\033[0;31m[!]${E} "


function help() {
    echo -e "$GREY"
    read -rp "Номер страницы (по умолчанию: все): " page
    echo -e "$E"
    if [ -z "$page" ]; then
        ./shell/routers/help.sh
    else
        ./shell/routers/help.sh --page "$page"
    fi
}

function main() {
    echo -e "$CYAN"
    read -rp "Размер массива для сортировки (количество элементов): " array_length
    echo -e "$CYAN"
    read -rp "Длина видео (в секундах): " video_length
    echo -e "$CYAN"
    read -rp "Название сортировки: " name
    echo -e "$E"

    ./shell/routers/main.sh --array_length "$array_length" --video_length "$video_length" --name "$name"
}

function reset() {
    cmake="-1"
    while [ "$cmake" = "-1" ]; do
        echo -e "$GREY"
        read -rp "Сбросить настройки CMake? (y/n, по умолчанию 'y') " cmake
        case $cmake in
            y|Y|"")
                cmake=true
                ;;
            n|N)
                cmake=false
                ;;
            *)
                echo -e "$errВведённое значение не может быть распознано"
                cmake="-1"
                ;;
        esac
    done

    venv="-1"
    while [ "$venv" = "-1" ]; do
        echo -e "$GREY"
        read -rp "Сбросить настройки Python VENV? (y/n, по умолчанию 'y') " venv
        case $venv in
            y|Y|"")
                venv=true
                ;;
            n|N)
                venv=false
                ;;
            *)
                echo -e "$errВведённое значение не может быть распознано"
                venv="-1"
                ;;
        esac
    done

    temp="-1"
    while [ "$temp" = "-1" ]; do
        echo -e "$GREY"
        read -rp "Очистить временные файлы? (y/n, по умолчанию 'y') " temp
        case $temp in
            y|Y|"")
                temp=true
                ;;
            n|N)
                temp=false
                ;;
            *)
                echo -e "$errВведённое значение не может быть распознано"
                temp="-1"
                ;;
        esac
    done

    echo -e "$E"

    ./shell/routers/reset.sh --cmake "$cmake" --venv "$venv" --temp "$temp"
}

function generate() {
    echo -e "$CYAN"
    read -rp "Название сортировки: " name
    echo -e "$CYAN"
    read -rp "Размер массива для сортировки: " length
    echo -e "$E"

    ./shell/routers/generate.sh --name "$name" --length "$length"
}

function sort() {
    echo -e "$CYAN"
    read -rp "Файл с конфигурацией: " input
    echo -e "$CYAN"
    read -rp "Имя выходного файла: " output
    echo -e "$E"

    ./shell/routers/sort.sh --input "$input" --output "$output"
}

function render() {
    echo -e "$CYAN"
    read -rp "Файл с конфигурацией: " file
    echo -e "$CYAN"
    read -rp "Количество кадров в секунду: " fps

    echo -e "$GREY"
    read -rp "Горизонтальный размер видео (по умолчанию: 1920): " width
    if [ -z "$width" ]; then
        width=1920
    fi

    echo -e "$GREY"
    read -rp "Вертикальный размер видео (по умолчанию: 1080): " height
    if [ -z "$height" ]; then
        height=1080
    fi

    echo -e "$E"

    ./shell/routers/render.sh --file "$file" --fps "$fps" --width "$width" --height "$height"
}

echo -e "$YELLOW
 ____             _    __     ___                 _ _
/ ___|  ___  _ __| |_  \\ \\   / (_)___ _   _  __ _| (_)_______ _ __
\___ \\ / _ \\| '__| __|  \\ \\ / /| / __| | | |/ _\` | | |_  / _ \\ '__|
 ___) | (_) | |  | |_    \\ V / | \\__ \\ |_| | (_| | | |/ /  __/ |
|____/ \\___/|_|   \\__|    \\_/  |_|___/\\__,_|\\__,_|_|_/___\\___|_|
\n$E"


breaker=false
while ! $breaker; do
    echo -e "\n$GREEN"
    read -rp ">>> " command
    case "$command" in
        exit)
            breaker=true
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

echo -e "$YELLOW    sort_visualizer, 2026$E"
echo -e "$GREY    https://github.com/GriB28/sort_visualizer$E"
exit
