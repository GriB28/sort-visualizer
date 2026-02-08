#ifndef COLORS_H
#define COLORS_H

#include <string>
using std::string;

namespace colors { // ANSI-codes
    inline string RESET   = "\u001b[0m";

    inline string RED     = "\u001b[31m";
    inline string GREEN   = "\u001b[32m";
    inline string YELLOW  = "\u001b[33m";
    inline string BLUE    = "\u001b[34m";
    inline string MAGENTA = "\u001b[35m";
    inline string CYAN    = "\u001b[36m";
    inline string WHITE   = "\u001b[37m";

    inline string LIGHT_RED     = "\u001b[31;1m";
    inline string LIGHT_GREEN   = "\u001b[32;1m";
    inline string LIGHT_YELLOW  = "\u001b[33;1m";
    inline string LIGHT_BLUE    = "\u001b[34;1m";
    inline string LIGHT_MAGENTA = "\u001b[35;1m";
    inline string LIGHT_CYAN    = "\u001b[36;1m";
    inline string LIGHT_WHITE   = "\u001b[37;1m";
}

#endif