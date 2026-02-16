#!/bin/bash

NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
GREY='\e[90m'


echo -e "Запускаю сборщик визуализатора сортировок..."
echo -e "$CYANПодготавливаю проект к запуску...$NC\n"

sleep 2

if ! [ -d ".venv" ]; then
    echo -e "$YELLOWНастраиваю виртуальное окружение, это займёт некоторое время...$NC"
    python3 -m venv ./.venv
    source ./.venv/bin/activate
    echo -e "> $YELLOWУстанавливаю библиотеки$NC"
    python3 -m pip install opencv-python numpy
else
    source ./.venv/bin/activate
fi

echo "Начинаю собирать проект С++"

sleep 2

if ! [ -d "cmake-build" ]; then
    echo -e "$YELLOWНастраиваю CMake, это займёт некоторое время...$NC"
    mkdir cmake-build
    cmake -S . -B cmake-build
fi

cmake --build cmake-build
echo -e "$GREENСборка завершена!$NC\n\n"

echo -e "$YELLOWГенерирую случайные входные массивы...$NC\n"
mkdir -p ./arrays

sleep 2

if [ -f "generate.py" ]; then
    python3 generate.py
else
    echo -e "[!] $REDНе найден файл генерации (generate.py)$NC"
    exit 1
fi

echo -e "$YELLOWЗапускаю сортировки!$NC"
sleep 2
algos=("bubble" "heap" "merge" "selection" "insertion" "quick")

way="./bin/sort_visualizer"

for algo in "${algos[@]}"; do
    input_file="./arrays/input_${algo}.txt"
    log_file="${algo}.txt"
    
    if [ -f "$way" ]; then
        echo -e "\n$GREYОбработка: ${algo}...$NC"
        sleep 1
        $way "$input_file" "$log_file"
    else
        echo "[!] $RED Не найден файл бинарника по пути: $way$NC"
        echo " >  $RED Попробуйте запустить скрипт сборщика повторно либо собрать проект вручную$NC"
        exit 1
    fi
done

echo -e "\n\n\n$CYANНачинаю генерировать видео$NC"
sleep 2
if [ -f "test.py" ]; then
    python3 test.py
else
    echo -e "[!] $REDНе найден файл test.py$NC"
    exit 1
fi

echo -e "\n\nНажмите ENTER, чтобы удалить временные файлы выйти из программы"
read

echo -e "$YELLOWОчищаю временные файлы, логи и папки с массивами$NC"
sleep 1
rm -rf ./arrays
for algo in "${algos[@]}"; do
    rm -f "${algo}.txt"
done

echo -e "> $GREENГотово!$NC"

deactivate
exit