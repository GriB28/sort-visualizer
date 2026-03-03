#!/bin/bash

G='\e[90m'
E='\033[0m'
need_rebuild=false

if $1; then
    echo -e "$GСбрасываем конфигурацию CMake...$E"
    rm -rf ./cmake-build
    need_rebuild=true
fi
if $2; then
    echo -e "$GСбрасываем конфигурацию Python VENV...$E"
    rm -rf ./.venv
    need_rebuild=true
fi
if $3; then
    echo -e "$GОчищаем временные файлы...$E"
    ./shell/source/clear.sh
fi

if $need_rebuild; then
    ./shell/source/build.sh
fi
