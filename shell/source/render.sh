#!/bin/bash
# 1 -- video width; 2 -- video height; 3 -- video length; 4 -- file path

G='\e[90m'
E='\033[0m'
err="\033[0;31m[!]${E} "

script="test.py"

if [ -f "$script" ]; then
    echo -e "$GЗапущен рендер видео с параметрами:$E"
    echo -e "$G> WIDTH  = $1$E"
    echo -e "$G> HEIGHT = $2$E"
    echo -e "$G> FPS    = $3$E"
    echo -e "$G> FILE   = $4$E"

    python3 $script "$1" "$2" "$3" "$4"

    echo -e "$GГотово!$E"
else
    echo -e "$errНе найден файл генерации ($script)$E"
fi
