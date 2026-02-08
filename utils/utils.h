#ifndef UTILS_H
#define UTILS_H

#include <fstream>
#include <string>
using std::string;
using std::ofstream;


class Utils {
public:
    explicit Utils(char** console_args);
    ~Utils();

    bool check_for_input();
    [[nodiscard]] string info() const;

    string start_sorting();
private:
    string input_file_name, output_file_name;
    string input_list, sort_name;
    bool checking_state = true;
    ofstream* output;
};

#endif