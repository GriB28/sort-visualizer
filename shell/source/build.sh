#!/bin/bash

S='\e[90m[build] '
E='\033[0m'
ok=true


echo -e "$SПроизводим проверку пресетов...$E\n"

if ! [ -d ".venv" ]; then
    ok=false
    echo -e "$SЛокальная конфигурация интерпретатора Python не найдена, производим установку...$E"

    echo -e "$S> настройка venv... (1/2)$E"
    python3 -m venv ./.venv > /dev/null

    echo -e "$S> установка библиотек... (2/2)$E"
    source ./.venv/bin/activate
    python3 -m pip install -r .req > /dev/null
    deactivate
fi


if ! [ -d "cmake-build" ]; then
    ok=false
    echo -e "$SКонфигурация CMake не найдена, производим установку...$E"
    mkdir cmake-build
    cmake -S . -B cmake-build
fi


if $ok; then
    echo -e "$SНеобходимые компоненты уже установлены"
else
    echo -e "$SВсё готово к использованию!"
fi
