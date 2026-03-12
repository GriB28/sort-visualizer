#!/bin/bash
# 1 -- video width; 2 -- video height; 3 -- video length; 4 -- source file path; 5 -- sort log file path

G='\e[90m'
E='\033[0m'
err="\033[0;31m[!]${E} "

script="test.py"

if [ -f "$script" ]; then
    echo -e "$GЗапущен рендер видео с параметрами:$E"
    echo -e "$G> WIDTH  = $1$E"
    echo -e "$G> HEIGHT = $2$E"
    echo -e "$G> FPS    = $3$E"
    echo -e "$G> SOURCE = $4$E"
    echo -e "$G> SORT   = $5$E"
    echo -e "$G> NAME   = $6$E"
    echo -e "$G> IMAGE  = $7$E"

    source ./.venv/bin/activate
    python3 $script "$1" "$2" "$3" "$4" "$5" "$6" "$7"
    deactivate

    echo -e "$GГотово!$E"
else
    echo -e "$errНе найден файл генерации ($script)$E"
fi
