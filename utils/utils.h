#ifndef UTILS_H
#define UTILS_H

#include <fstream>
#include <string>

#include "../sorts/sorts.h"

using std::string;
using std::ofstream;


class Utils {
public:
    explicit Utils(char** console_args);
    ~Utils();

    bool check_for_input();
    [[nodiscard]] string info() const;

    unsigned short do_sorting();

    void change_list(int** new_list);
private:
    Sorts* sorter;

    string input_file_name, output_file_name;
    string input_list, sort_name;
    ofstream* output;

    bool checking_state = false;
    unsigned short last_code = -1;

    int* list;
    size_t length;

    void parse_input();
    void add_value(int value);
};

#endif