#!/bin/bash

E='\033[0m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
GREY='\e[90m'
err="\033[0;31m[!]${E} "

package_list=("python3" "g++" "cmake" "ffmpeg")


function check_packages() {
    ok=0
    for pkg in "${package_list[@]}"; do
        if command -v "$pkg" >/dev/null 2>&1; then
            ((ok++))
        fi
    done
    if [ $ok -lt ${#package_list[@]} ]; then
        echo -e "$errВ системе отсутствуют необходимые пакеты!"
        exit 1
    fi
}

function help_() {
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
    echo -e "$GREY"
    read -rp "Путь к файлу изображения/csv (по умолчанию: none): " image_path
    if [ -z "$name" ]; then
        image_path=""
    fi
    echo -e "$E"

    if [ -z "$image_path" ]; then
        ./shell/routers/main.sh --array_length "$array_length" --video_length "$video_length" --name "$name"
    else
        ./shell/routers/main.sh --array_length "$array_length" --video_length "$video_length" --name "$name" --image_path "$image_path"
    fi
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
    read -rp "Файл с конфигурацией генератора: " source_file
    echo -e "$CYAN"
    read -rp "Файл с логом сортировщика: " sort_file
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
    echo -e "$GREY"
    read -rp "Имя сортировки для отображения (по умолчанию: default): " name
    if [ -z "$name" ]; then
        name="default"
    fi
    echo -e "$GREY"
    read -rp "Путь к файлу изображения/csv (по умолчанию: none): " image_file
    if [ -z "$name" ]; then
        image_file=""
    fi

    echo -e "$E"

    if [ -z "$image_file" ]; then
        ./shell/routers/render.sh --source_file "$source_file" --sort_file "$sort_file" --fps "$fps" --width "$width" --height "$height" --name "$name"
    else
        ./shell/routers/render.sh --source_file "$source_file" --sort_file "$sort_file" --fps "$fps" --width "$width" --height "$height" --name "$name" --image_file "$image_file"
    fi
}

function compress() {
    echo -e "$CYAN"
    read -rp "Входной файл: " input_file
    echo -e "$CYAN"
    read -rp "Выходной файл: " output_file

    echo -e "$E"

    ./shell/routers/compress.sh --input "$input_file" --output "$output_file"
}

echo -e "$YELLOW
 ____             _    __     ___                 _ _
/ ___|  ___  _ __| |_  \\ \\   / (_)___ _   _  __ _| (_)_______ _ __
\___ \\ / _ \\| '__| __|  \\ \\ / /| / __| | | |/ _\` | | |_  / _ \\ '__|
 ___) | (_) | |  | |_    \\ V / | \\__ \\ |_| | (_| | | |/ /  __/ |
|____/ \\___/|_|   \\__|    \\_/  |_|___/\\__,_|\\__,_|_|_/___\\___|_|
\n$E"

check_packages

breaker=false
while ! $breaker; do
    echo -e "\n$GREEN"
    read -rp ">>> " command
    case "$command" in
        exit)
            breaker=true
            ;;
        help)
            help_
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
        compress)
            compress
            ;;
        *)
            echo -e "$errКоманда не распознана!"
            ;;
    esac
done

echo -e "$YELLOW    sort_visualizer, 2026$E"
echo -e "$GREY    https://github.com/GriB28/sort_visualizer$E"
exit
