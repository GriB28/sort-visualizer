#!/bin/bash

Y='\033[0;33m'
G='\033[0;32m'
C='\033[0;36m'
E='\033[0m'
R='\033[0;31m'
err="${R}[!]${E} "

commands=("help" "build" "clear")
help=("--page <uint>")
build=("--cmake <bool>" "--venv <bool>")
clear=("--hard <bool>")


function print() {  # 1 -- номер страницы для просмотра (0 = все)
    counter=0

    for command in "${commands[@]}"; do
        ((counter++))

        if [ $counter -eq "$1" ] || [ "$1" -eq 0 ]; then
            echo -e "$G  ${counter}. $C$command$E"

            declare -n list=$command
            for keyword in "${list[@]}"; do
                echo -e "        $C${keyword}$E"
            done
        fi
    done
}


if [ "$#" -eq 0 ]; then
    echo -e "$YСтраница помощи\n$G> Список доступных команд:$E"
    print 0
else
    breaker=0
    while [ "$#" -gt 1 ]; do
        if [ "$1" == "--page" ]; then
            if [[ $2 =~ ^[0-9]+$ ]]; then
                breaker=$2
            else
                breaker=-1
                echo -e "$errАргумент не может быть распознан!"
            fi
            break
        fi
        shift
    done

    if [ "$breaker" -ne -1 ]; then
        print "$breaker"
    fi
fi
