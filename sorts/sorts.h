#ifndef SORTS_H
#define SORTS_H

#include <cstddef>
#include <fstream>
using std::size_t;
using std::ofstream;


class Sorts {
public:
    explicit Sorts(ofstream* link);
    ~Sorts() = default;

    void load_list(int** array, const size_t &array_length);

    void bubble() const;
    void insertion() const;
    void selection() const;

    void merge();
    void merge(const size_t &left, const size_t &right);

    void quick();
    void quick(const size_t &low, const size_t &high);

    void heap();
private:
    int* list;
    size_t length;

    void do_merge(const size_t &left, const size_t &middle, const size_t &right) const;
    void do_heap(const size_t &len, const size_t &index);

    void save_snapshot() const;
    void save_check(size_t index_1, size_t index_2) const;
    void save_swap() const;

    ofstream* link;
};

#endif