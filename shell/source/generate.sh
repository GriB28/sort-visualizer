#!/bin/bash

G='\e[90m'
E='\033[0m'
err="\033[0;31m[!]${E} "

script="generate.py"


if [ -f "$script" ]; then
    python3 $script "$2" "$1"
    echo -e "$GЗавершено!$E"
else
    echo -e "$errНе найден файл генерации ($script)$E"
fi
