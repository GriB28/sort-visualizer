<div align="center" style="text-align: center;">

# [Sort Visualizer](https://github.com/GriB28/sort-visualizer)
## Консольное приложение для визуализации работы алгоритмов сортировки

</div><br><br>


### ✅ Использование
<img src="/.readme/3.webp" width=70 align="left" style="float: left; margin-right: 8px;" alt="Main menu commands">

Основные команды главного меню.

- [Сборщик](./run.sh) создаст виртуальное окружение venv, установит необходимые python-модули и скомпилирует проект самостоятельно (см. раздел Запуск и Конфигурация). Нужно следовать инструкциям в самом сборщике.
- После запуска программы и успешной компиляции необходимо ввести размер массива чисел для сортировки, а также тип сортировки (`bubble`, `insertion`, `quick`, `selection`, `heap`, `merge`) либо `all` для выбора всех типов
- После выполнения программы необходимо на соответствующем шаге нажать **ENTER** чтобы очистить все временные файлы
- Сгенерированные видеоролики с визуализациями сортировок сохраняются в папку `videos`
- Готово! Сборщик можно закрывать

<br>



#
### ☑️ Запуск и конфигурация
<img src="/.readme/1.webp" width=70 align="left" style="float: left; margin-right: 8px;" alt="Launch and configuration">

Инструкции по установке и настройке.

Приложение адаптировано под ОС Windows и Linux.

- Windows 10+ (WSL) и Linux:

  * (!) Для запуска программы на ОС Windows необходимо заранее установить Windows Subsystem for Linux (WSL)

  * Установка необходимых пакетов: `sudo apt install g++`(если не установлен), `sudo apt install python3`(если не установлен), `sudo apt install cmake`, `sudo apt install dos2unix`, `sudo apt install python3-venv`

  * Перед запуском сборщика [`run.sh`](./run.sh) необходимо конвертировать его в формат Unix: `dos2unix run.sh`

  * Запуск приложения: `./run.sh`



#
### ⚙️ Компиляция бинарного файла сортировщика
<img src="/.readme/2.webp" width=70 align="left" style="float: left; margin-right: 8px;" alt="Self-compiling a binary file">

В конфигурационном файле [`CMakeLists.txt`](./CMakeLists.txt) содержится скрипт CMake3.28 для компиляции
необходимого бинарного файла. Дополнительных действий делать не нужно.

<br><br>


#
## Создатели
[@GriB28](https://github.com/GriB28),
[@EichhorniaCrassipes](https://github.com/EichhorniaCrassipes),
[@ArsenyKenunen](https://github.com/ArsenyKenunen)

[![Contributors](https://contrib.rocks/image?repo=GriB28%2Fsort-visualizer)](https://github.com/GriB28/sort-visualizer/graphs/contributors)

ФАКТ МФТИ, 2026
