import random
import os

SIZE = 25
FOLDER = "arrays"

algos = ["quick", "bubble", "selection", "insertion", "heap", "merge"]

if not os.path.exists(FOLDER):
    os.makedirs(FOLDER)

arr = random.sample(range(1, 201), SIZE)
arr_str = " ".join(map(str, arr))

for algo in algos:
    file_path = os.path.join(FOLDER, f'input_{algo}.txt')

    with open(file_path, 'w') as f:
        f.write(arr_str + "\n")
        f.write(algo + "\n")

#print(f"all txt input files saved to '{FOLDER}'")
#print(f"size of each array: {SIZE}")