#!/bin/bash
# 1 -- video width; 2 -- video height; 3 -- video length

G='\e[90m'
E='\033[0m'

fps=$((10000 / "$3"))  # needs tests

echo -e "$GЗапущен рендер видео с параметрами:$E"
echo -e "$G> WIDTH  = $1$E"
echo -e "$G> HEIGHT = $2$E"
echo -e "$G> FPS    = $fps$E"

python3 test.py "$1" "$2" "$fps"

echo -e "$GГотово!$E"
