#!/bin/bash

echo "Запускаю сборщик визуализатора сортировок..."
echo "Устанавливаю необходимые зависимости"

sleep 2

pip3 install opencv-python numpy --break-system-packages

echo "Начинаю собирать проект С++"

sleep 2

rm -rf build
mkdir -p build
cd build

if cmake ..; then
    if make; then
        echo "Сборка завершена!"
    fi
fi
cd ..

echo "Генерирую случайные входные массивы..."
mkdir -p ./arrays

sleep 2

if [ -f "generate.py" ]; then
    python3 generate.py
else
    echo "Не найден файл генерации (generate.py)"
    exit 1
fi

echo "Запускаю сортировки!"
sleep 2
algos=("bubble" "heap" "merge" "selection" "insertion" "quick")

way="./bin/sort_visualizer"

for algo in "${algos[@]}"; do
    input_file="./arrays/input_${algo}.txt"
    log_file="${algo}.txt"
    
    if [ -f "$way" ]; then
        echo "Обработка: ${algo}..."
        sleep 1
        $way "$input_file" "$log_file"
    else
        echo "Не найден файл бинарника по пути: $way"
        echo "Попробуйте запустить скрипт сборщика повторно либо собрать проект вручную"
        exit 1
    fi
done

echo "Начинаю генерировать видео"
sleep 2
if [ -f "test.py" ]; then
    python3 test.py
else
    echo "Не найден файл test.py"
    exit 1
fi

echo "Очищаю временные файлы, логи и папки с массивами"
sleep 1
rm -rf ./arrays
for algo in "${algos[@]}"; do
    rm -f "${algo}.txt"
done

echo "Готово!"
