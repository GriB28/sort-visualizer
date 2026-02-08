<div align="center" style="text-align: center;">

# [Sort Visualizer](https://github.com/GriB28/sort-visualizer)
## Консольное приложение для визуализации работы алгоритмов сортировки

</div><br><br>


### ✅ Использование
<img src="/.readme/3.webp" width=70 align="left" style="float: left; margin-right: 8px;" alt="Main menu commands">

Основные команды главного меню.

<br>

- help

  * выводит справку

- input <\[list\[int]]>

  * сохраняет список чисел для расчётов (указываются целые числа через пробел)
  
- render <\[str]>

  * запускает процесс расчётов и последующего рендера видео сортировки (указывается название сортировки)



#
### ☑️ Запуск и конфигурация
<img src="/.readme/1.webp" width=70 align="left" style="float: left; margin-right: 8px;" alt="Launch and configuration">

Инструкции по установке и настройке.

Приложение адаптировано под ОС Windows и Linux.

- Windows 10+:

  * Установка необходимых библиотек: `python -m pip install -r requirements.txt`

  * Запуск приложения: `python main.py`


- Linux:

  * Создание виртуального окружения: `python3 -m venv ./.venv`

  * И его активация: `source ./.venv/bin/activate`

  * Установка необходимых библиотек: `python3 -m pip install -r requirements.txt`

  * Запуск приложения: `python3 main.py`



#
### ⚙️ Компиляция бинарного файла сортировщика
<img src="/.readme/2.webp" width=70 align="left" style="float: left; margin-right: 8px;" alt="Self-compiling a binary file">

В конфигурационном файле [`CMakeLists.txt`](./CMakeLists.txt) содержится скрипт CMake4.0 для компиляции
необходимого бинарного файла. Дополнительных действий делать не нужно.

<br><br>


#
## Создатели
[@GriB28](https://github.com/GriB28),
[@EichhorniaCrassipes](https://github.com/EichhorniaCrassipes),
[@ArsenyKenunen](https://github.com/ArsenyKenunen)

[![Contributors](https://contrib.rocks/image?repo=GriB28%2Fsort-visualizer)](https://github.com/GriB28/sort-visualizer/graphs/contributors)

ФАКТ МФТИ, 2026
