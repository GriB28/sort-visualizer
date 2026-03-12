#!/bin/bash

Y='\033[0;33m'
G='\033[0;32m'
C='\033[0;36m'
E='\033[0m'
err="\033[0;31m[!]${E} "

commands=("exit" "help" "reset" "render" "generate" "sort" "main" "compress")
exit=()
help=("--page <uint>[def. all]")
reset=("--cmake <bool>[def. true]" "--venv <bool>[def. true]" "--temp <bool>[def. true]")
render=("--fps <uit>" "--source_file <string>" "--sort_file <string>" "--image_file <string>" "--width <uint>[def. 1920]" "--height <uint>[def. 1080]" "--name <string>[def. 'default']")
generate=("--name <string>" "--length <uint>")
sort=("--input <string>" "--output <string>")
main=("--name <string>" "--video_length <uint>" "--array_length <uint>" "--video_width <uint>[def. 1920]" "--video_height <uint>[def. 1080]")
compress=("--input <string>" "--output <string>")


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
