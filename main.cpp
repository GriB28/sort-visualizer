#include <iostream>

#include "utils/colors.h"
#include "utils/utils.h"

using std::cout;


int main(const int argc, char* argv[]) {
    cout << colors::MAGENTA << "Sort Visualizer\n"
    << colors::LIGHT_BLUE << "[CPP Core]\n"
    << colors::RESET;

    if (argc < 2) {
        std::cerr << "Not enough arguments!\n";
        return 1;
    }

    Utils utils(argv);

    cout << colors::YELLOW << "> Executing a sort algorithm...\n" << colors::RESET;
    const unsigned short executing_result = utils.do_sorting();

    cout << colors::LIGHT_YELLOW << "> Finished with exit code " << executing_result << "!\n" << colors::RESET
    << (executing_result == 0 ? colors::GREEN : colors::RED) << utils.info() << colors::RESET << '\n';

    return executing_result;
}
