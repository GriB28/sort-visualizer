#!/bin/bash

Y='\033[0;33m'
G='\033[0;32m'
C='\033[0;36m'
E='\033[0m'
R='\033[0;31m'
err="${R}[!]${E} "

commands=("help" "build" "reset")
help=("--page <uint>")
build=("--cmake <bool>[def. true]" "--venv <bool>[def. true]")
reset=("--hard <bool>")


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

page=0
while [ "$#" -gt 1 ]; do
    if [ "$1" == "--page" ]; then
        if [[ $2 =~ ^[0-9]+$ ]]; then
            page=$2
        else
            page=-1
            echo -e "$errАргумент не может быть распознан!"
        fi
        break
    fi
    shift
done

if [ "$page" -ne -1 ]; then
    if [ "$page" -eq 0 ]; then
        echo -e "$YСтраница помощи\n$G> Список доступных команд:$E"
    fi
    print "$page"
fi
