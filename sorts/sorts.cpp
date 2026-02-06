#include "sorts.h"


void sorts::bubble(int* list, const size_t &length) {
    for (size_t i = 0; i < length - 1; i++) {
        bool breaker = true;
        for (size_t j = 0; j < length - i - 1; j++) {
            if (list[j] > list[j + 1]) {
                breaker = false;
                const int t = list[j + 1];
                list[j + 1] = list[j];
                list[j] = t;
            }
        }
        if (breaker) break;
    }
}

void sorts::insertion(int* list, const size_t &length) {
    for (size_t i = 1; i < length; i++) {
        const int current_value = list[i];
        size_t j = i;
        while (j > 0 && list[j - 1] > current_value) {
            list[j] = list[j - 1];
            j--;
        }
        list[j] = current_value;
    }
}

void sorts::selection(int* list, const size_t &length) {
    for (size_t i = 0; i < length; i++) {
        int local_min = list[i];
        for (size_t j = i + 1; j < length; j++) {
            if (local_min > list[j]) {
                const int t = list[j];
                list[j] = local_min;
                local_min = t;
            }
        }
        list[i] = local_min;
    }
}
