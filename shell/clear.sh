#!/bin/bash

S='\e[90m\[clear\]'
E='\033[0m'

algorithms=("bubble" "heap" "merge" "selection" "insertion" "quick")


echo -e "$SОчищаю временные файлы и папки$E"
rm -rf ./arrays
echo -e "$S> директория 'arrays' удалена"
for alg_name in "${algorithms[@]}"; do
    rm -f "${alg_name}.txt"
    echo -e "$S> файл '${alg_name}' удалён"
done
