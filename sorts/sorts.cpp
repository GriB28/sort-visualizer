#include <algorithm>

#include "sorts.h"

#include <iostream>

using std::min;
using std::max;


Sorts::Sorts(ofstream* link) {
    this->link = link;
    list = nullptr;
    length = 0;
}

void Sorts::load_list(int** array, const size_t &array_length) {
    list = *array;
    length = array_length;
}

void Sorts::save_snapshot() const {
    for (size_t i = 0; i < length; i++)
        *link << list[i] << ' ';
    *link << '\n';
}
void Sorts::save_check(const size_t index_1, const size_t index_2) const {
    *link << min(index_1, index_2) << ' ' << max(index_1, index_2) << '\n';
}
void Sorts::save_swap() const {
    *link << "s\n";
}


void Sorts::bubble() const {
    for (size_t i = 0; i < length - 1; i++) {
        bool breaker = true;
        for (size_t j = 0; j < length - i - 1; j++) {

            save_check(j, j+1);

            if (list[j] > list[j + 1]) {
                breaker = false;
                const int t = list[j + 1];
                list[j + 1] = list[j];
                list[j] = t;

                save_swap();
            }
        }
        if (breaker) break;
    }
}

void Sorts::insertion() const {
    for (size_t i = 1; i < length; i++) {
        const int current_value = list[i];
        size_t j = i;

        save_check(i, j - 1);

        while (j > 0) {
            save_check(j, j - 1);

            if (list[j - 1] > current_value) {
                list[j] = list[j - 1];
                j--;

                save_swap();
            }
            else break;
        }
        list[j] = current_value;
    }
}

void Sorts::selection() const {
    for (size_t i = 0; i < length - 1; i++) {
        size_t local_min_index = i;

        for (size_t j = i + 1; j < length; j++) {
            save_check(local_min_index, j);

            if (list[j] < list[local_min_index])
                local_min_index = j;
        }

        if (local_min_index != i) {
            save_check(i, local_min_index);

            const int t = list[i];
            list[i] = list[local_min_index];
            list[local_min_index] = t;

            save_swap();
        }
    }
}

void Sorts::do_merge(const size_t &left, size_t middle, const size_t &right) const {
    size_t i = left;
    size_t j = middle + 1;

    while (i <= middle && j <= right) {
        save_check(i, j);

        if (list[i] <= list[j])
            i++;
        else {
            size_t index = j;

            while (index > i) {
                save_check(index - 1, index);

                const int t = list[index];
                list[index] = list[index - 1];
                list[index - 1] = t;

                save_swap();
                index--;
            }

            i++;
            j++;
            middle++;
        }
    }
}
void Sorts::merge() const {
    for (size_t current_size = 1; current_size < length; current_size *= 2)
        for (size_t left = 0; left < length - 1; left += 2 * current_size) {
            const size_t middle = std::min(left + current_size - 1, length - 1),
                         right = std::min(left + 2 * current_size - 1, length - 1);
            if (middle < right)
                do_merge(left, middle, right);
        }
}

void Sorts::do_quick(const size_t &low, const size_t &high) {
    if (low < high) {
        const int pivot = list[(low + high) / 2];
        size_t i = low - 1;
        size_t j = high + 1;

        while (true) {
            do {
                i++;
                save_check(i, (low + high) / 2);
            } while (list[i] < pivot);
            do {
                j--;
                save_check(j, (low + high) / 2);
            } while (list[j] > pivot);

            if (i >= j) break;

            save_check(i, j);
            save_swap();

            const int t = list[j];
            list[j] = list[i];
            list[i] = t;
        }

        do_quick(low, j);
        do_quick(j + 1, high);
    }
}
void Sorts::quick() { do_quick(0, length - 1); }

void Sorts::do_heap(const size_t &len, const size_t &index) {
    size_t max = index;
    const size_t left = 2 * index + 1;
    const size_t right = 2 * index + 2;

    if (left < len && list[left] > list[max]) {

        save_check(max, left);

        max = left;
    }
    if (right < len && list[right] > list[max]) {

        save_check(max, right);

        max = right;
    }

    save_check(index, max);

    if (max != index) {
        const int t = list[index];
        list[index] = list[max];
        list[max] = t;

        save_swap();

        do_heap(len, max);
    }
}
void Sorts::heap() {
    for (size_t i = length / 2; i > 0; i--)
        do_heap(length, i - 1);

    for (size_t i = length - 1; i > 0; i--) {
        save_check(0, i);
        save_swap();

        const int t = list[0];
        list[0] = list[i];
        list[i] = t;

        do_heap(i, 0);
    }
}
