import random
import os

SIZE = int(input(">>> Введите размер массива для сортировки: "))
FOLDER = "arrays"

current_algo = input(">>> Введите название сортировки для расчёта или `all` для всех: ").strip().lower()
algos = ["quick", "bubble", "selection", "insertion", "heap", "merge"]

if current_algo not in algos and current_algo != 'all':
    print("Фигню написал, делаю all!")
    current_algo = 'all'

if not os.path.exists(FOLDER):
    os.makedirs(FOLDER)

arr = random.sample(range(1, SIZE + 1), SIZE)
arr_str = " ".join(map(str, arr))

if current_algo == 'all':
    algos_req = algos
else:
    algos_req = [current_algo]

for algo in algos_req:
    file_path = os.path.join(FOLDER, f'input_{algo}.txt')

    with open(file_path, 'w') as f:
        f.write(arr_str + "\n")
        f.write(algo + "\n")

#print(f"all txt input files saved to '{FOLDER}'")
#print(f"size of each array: {SIZE}")