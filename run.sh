#!/bin/bash

NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
GREY='\e[90m'

algos=("bubble" "heap" "merge" "selection" "insertion" "quick")

start_binary() {  # 1 -- sort_name; 2 -- way
    input_file="./arrays/input_$1.txt"
    log_file="$1.txt"

    if [ -f "$2" ]; then
        echo -e "\n$GREYОбработка: $1...$NC"
        sleep 1
        "$2" "$input_file" "$log_file"
    else
        echo -e "[!] $RED Не найден файл бинарника по пути: $2$NC"
        echo -e " >  $RED Попробуйте запустить скрипт сборщика повторно либо собрать проект вручную$NC"
        exit 1
    fi
}


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

echo -e "$YELLOWОжидаю параметры для генерации входных массивов:$NC\n"
mkdir -p ./arrays

read -rp ">>> Введите размер массива для сортировки: " length
read -rp ">>> Введите название сортировки для расчёта или \`all\` для всех: " algorithm

correct_algo_name=false
for item in "${algos[@]}"; do
    if [[ "$item" == "$algorithm" ]]; then
        correct_algo_name=true
        break
    fi
done
if [ "$correct_algo_name" = false ] && [ "$algorithm" != "all" ]; then
    echo "Фигню написал, делаю all!"
    algorithm="all"
fi

if [ -f "generate.py" ]; then
    python3 generate.py $length $algorithm
else
    echo -e "[!] $REDНе найден файл генерации (generate.py)$NC"
    exit 1
fi

echo -e "$YELLOWЗапускаю сортировки!$NC"
sleep 2

way="./bin/sort_visualizer"

if [ "$algorithm" == "all" ]; then
    for algo in "${algos[@]}"; do
        start_binary $algo $way
    done
else
    start_binary $algorithm $way
fi

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