#!/bin/bash

G='\e[90m'
E='\033[0m'
err="\033[0;31m[!]${E} "

script="bin/sort_visualizer"

if [ -f "$script" ]; then
    echo -e "\n$Gобработка: $1...$E"
    sleep 1
    ./$script "$1" "$2"
    echo -e "$GЗавершено!$E"
else
    echo -e "$errНе найден файл бинарника по пути: $script$E"
    echo -e " > Воспользуйтесь командой \`reset\`, чтобы сбросить скомпилированный бинарник и/или окружение Python"
    exit 1
fi