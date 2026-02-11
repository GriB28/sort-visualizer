#include "utils.h"

#include <fstream>
#include <iostream>

using std::ifstream;
using std::getline;
using std::stoi;
using std::cerr;
using std::runtime_error;


Utils::Utils(char** console_args) {
    /* ожидаемые параметры: путь к входному файлу, путь к выходному файлу (для создания)
     * входной файл:
     * * входной массив
     * * имя сортировки (bubble, insertion, selection, merge, quick, heap)
     * выходной файл:
     * * последовательность изменений
     */

    list = nullptr;
    length = 0;

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
    if (!output->is_open()) {
        cerr << "Failed to open output file '" << output_file_name << "'.\n";
        throw runtime_error("Failed to open output file.");
    }

    sorter = new Sorts(output);

    ifstream input(input_file_name);
    getline(input, input_list);
    getline(input, sort_name);
    input.close();

    parse_input();
    check_for_input();
}

Utils::~Utils() {
    output->close();
    delete output;
    delete sorter;

    delete[] list;
}

void Utils::parse_input() {
    length = 0;
    string buffer;

    for (const char c : input_list) {
        if (c == ' ' && !buffer.empty()) {
            add_value(stoi(buffer));
            buffer.clear();
        }
        else if ('0' <= c && c <= '9' || c == '-') {
            buffer += c;
        }
    }
    if (!buffer.empty())
        add_value(stoi(buffer));
}
void Utils::add_value(const int value) {
    const auto list_copy = new int[++length];
    for (size_t i = 0; i < length - 1; i++)
        list_copy[i] = list[i];
    list_copy[length - 1] = value;

    delete[] list;
    list = list_copy;
}

bool Utils::check_for_input() {
    checking_state = true;
    if (sort_name != "bubble" && sort_name != "insertion" && sort_name != "selection" &&
        sort_name != "merge" && sort_name != "heap" && sort_name != "quick")
        checking_state = false;
    return checking_state;
}

string Utils::info() const {
    if (last_code == 0)
        return "Executed a(n) '" + sort_name + "' sorting algorithm.\n"
        + "Results are stored in '" + output_file_name + "'.";
    if (last_code == 1)
        return "Failed to execute a(n) '" + sort_name + "' sorting algorithm.\n"
        + "It is currently unsupported.";
    return "Failed to start executing a sorting algorithm.\nThe list of values was not provided.";
}

void Utils::change_list(int** new_list) {
    list = *new_list;
}

unsigned short Utils::do_sorting() {
    if (!checking_state) {
        last_code = 1;
        return 1;
    }
    if (list == nullptr) {
        last_code = 2;
        return 2;
    }

    sorter->load_list(&list, length);

    if (sort_name == "bubble")
        sorter->bubble();
    else if (sort_name == "insertion")
        sorter->insertion();
    else if (sort_name == "selection")
        sorter->selection();
    else if (sort_name == "merge")
        sorter->merge();
    else if (sort_name == "heap")
        sorter->heap();
    else // quick
        sorter->quick();

    last_code = 0;
    return 0;
}
