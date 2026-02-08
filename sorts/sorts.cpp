#include "sorts.h"


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
}


void Sorts::bubble() const {
    for (size_t i = 0; i < length - 1; i++) {
        bool breaker = true;
        for (size_t j = 0; j < length - i - 1; j++) {
            if (list[j] > list[j + 1]) {
                breaker = false;
                const int t = list[j + 1];
                list[j + 1] = list[j];
                list[j] = t;

                save_snapshot();
            }
        }
        if (breaker) break;
    }
}

void Sorts::insertion() const {
    for (size_t i = 1; i < length; i++) {
        const int current_value = list[i];
        size_t j = i;
        while (j > 0 && list[j - 1] > current_value) {
            list[j] = list[j - 1];
            j--;
        }
        list[j] = current_value;

        save_snapshot();
    }
}

void Sorts::selection() const {
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

        save_snapshot();
    }
}

void Sorts::do_merge(const size_t &left, const size_t &middle, const size_t &right) const {
    const size_t left_length = middle - left + 1, right_length = right - middle;
    const auto left_sublist = new int[left_length], right_sublist = new int[right_length];

    for (size_t i = 0; i < left_length; i++)
        left_sublist[i] = list[left + i];
    for (size_t i = 0; i < right_length; i++)
        right_sublist[i] = list[middle + 1 + i];

    size_t i = 0, j = 0, k = left;

    while (i < left_length && j < right_length) {
        if (left_sublist[i] <= right_sublist[j]) list[k++] = left_sublist[i++];
        else list[k++] = right_sublist[j++];

        save_snapshot();
    }

    while (i < left_length) {
        list[k++] = left_sublist[i++];

        save_snapshot();
    }
    while (j < right_length) {
        list[k++] = right_sublist[j++];

        save_snapshot();
    }

    delete[] left_sublist;
    delete[] right_sublist;
}
void Sorts::merge(const size_t &left, const size_t &right) {
    if (left < right) {
        const size_t middle = left + (right - left) / 2;

        merge(left, middle);
        merge(middle + 1, right);

        do_merge(left, middle, right);
    }
}
void Sorts::merge() { merge(0, length - 1); }

void Sorts::quick(const size_t &low, const size_t &high) {
    if (low < high) {
        const int pivot = list[(low + high) / 2];
        size_t i = low - 1;
        size_t j = high + 1;

        while (true) {
            do { i++; } while (list[i] < pivot);
            do { j--; } while (list[j] > pivot);

            if (i >= j) break;

            const int t = list[j];
            list[j] = list[i];
            list[i] = t;

            save_snapshot();
        }

        quick(low, j);
        quick(j + 1, high);
    }
}
void Sorts::quick() { quick(0, length - 1); }

void Sorts::do_heap(const size_t &len, const size_t &index) {
    size_t max = index;
    const size_t left = 2 * index + 1;
    const size_t right = 2 * index + 2;

    if (left < len && list[left] > list[max])
        max = left;
    if (right < len && list[right] > list[max])
        max = right;

    if (max != index) {
        const int t = list[index];
        list[index] = list[max];
        list[max] = t;

        save_snapshot();

        do_heap(len, max);
    }
}
void Sorts::heap() {
    for (size_t i = length / 2; i > 0; i--)
        do_heap(length, i - 1);

    for (size_t i = length - 1; i > 0; i--) {
        const int t = list[0];
        list[0] = list[i];
        list[i] = t;

        save_snapshot();

        do_heap(i, 0);
    }
}
