#ifndef SORTS_H
#define SORTS_H

#include <cstddef>
using std::size_t;

namespace sorts {
    void bubble(int* list, const size_t &length);
    void insertion(int* list, const size_t &length);
    void selection(int* list, const size_t &length);


    void merge(int* list, const size_t &length);
    void merge(int* list, const size_t &left, const size_t &right);
    void do_merge(int* list, const size_t &left, const size_t &middle, const size_t &right);

    void quick(int* list, const size_t &length);
    void quick(int* list, const size_t &low, const size_t &high);

    void heap(int* list, const size_t &length);
    void do_heap(int* list, const size_t &length, const size_t &index);
}

#endif