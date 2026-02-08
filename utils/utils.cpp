#include "utils.h"

#include <fstream>
#include "../sorts/sorts.h"

using std::ifstream;
using std::getline;


Utils::Utils(char** console_args) {
    /* ожидаемые параметры: путь к входному файлу, путь к выходному файлу (для создания)
     * входной файл:
     * * входной массив
     * * имя сортировки (bubble, insertion, selection, merge, quick, heap)
     * выходной файл:
     * * последовательность изменений
     */

    input_file_name = string(console_args[1]);
    output_file_name = string(console_args[2]);

    if (const char first = input_file_name.front(), last = input_file_name.back();
        (first == '"' && last == '"') || (first == '\'' && last == '\''))
        input_file_name = input_file_name.substr(1, input_file_name.size() - 2);

    if (const char first = output_file_name.front(), last = output_file_name.back();
        (first == '"' && last == '"') || (first == '\'' && last == '\''))
        output_file_name = output_file_name.substr(1, output_file_name.size() - 2);

    output = new ofstream;
    output->open(output_file_name);

    ifstream input(input_file_name);
    getline(input, input_list);
    getline(input, sort_name);
    input.close();

    check_for_input();
}

Utils::~Utils() {
    output->close();
    delete output;
}

bool Utils::check_for_input() {
    checking_state = true;
    if (sort_name != "bubble" && sort_name != "insertion" && sort_name != "selection" &&
        sort_name != "merge" && sort_name != "heap" && sort_name != "quick")
        checking_state = false;
    return checking_state;
}

string Utils::info() const {
    if (success_flag)
        return "Executed a(n) '" + sort_name + "' sorting algorithm.\n"
        + "Results are stored in '" + output_file_name + "'.";
    return "Failed to execute a(n) '" + sort_name + "' sorting algorithm.\n"
    + "It is currently unsupported.";
}

bool Utils::do_sorting() {
    if (!checking_state) {
        success_flag = false;
        return false;
    }

    if (sort_name == "bubble") {

    }
    else if (sort_name == "insertion") {

    }
    else if (sort_name == "selection") {

    }
    else if (sort_name == "merge") {

    }
    else if (sort_name == "heap") {

    }
    else { // quick

    }

    success_flag = true;
    return true;
}
