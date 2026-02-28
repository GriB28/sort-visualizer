#!/bin/bash

Y='\033[0;33m'
G='\033[0;32m'
C='\033[0;36m'
E='\033[0m'


commands=("help" "build" "clear")
help=("--page <uint>")
build=("--cmake <bool>" "--venv <bool>")
clear=("--hard <bool>")

echo -e "$YСтраница помощи\n$G> Список доступных команд:$E"

for command in "${commands[@]}"; do
    echo -e "$G  > $C$command$E"
    declare -n list=$command
    for keyword in "${list[@]}"; do
        echo -e "      $C${keyword}$E"
    done
done
