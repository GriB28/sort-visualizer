import cv2
import numpy as np
import os

width = 1000
height = 500
framerate = 60

algos = ['bubble', 'heap', 'merge', 'selection', 'insertion', 'quick']

def draw_rectangle(frame, index, value, color, array_size, max_val):
    bar_width = width // array_size
    bar_height = int((value / max_val) * (height - 50))
    x = index * bar_width
    cv2.rectangle(frame, (x, height), (x + bar_width - 2, height - bar_height), color, -1)

def draw_frame(video, arr, highlight=False, idx1=None, idx2=None):
    frame = np.zeros((height, width, 3), dtype=np.uint8)
    array_size = len(arr)
    max_val = max(arr) if array_size > 0 else 1

    for i in range(array_size):
        draw_rectangle(frame, i, arr[i], (255, 255, 255), array_size, max_val)

    if highlight and idx1 is not None and idx2 is not None:
        if idx1 < array_size and idx2 < array_size:
            color = (0, 0, 255) if arr[idx1] > arr[idx2] else (0, 255, 0)
            draw_rectangle(frame, idx1, arr[idx1], color, array_size, max_val)
            draw_rectangle(frame, idx2, arr[idx2], color, array_size, max_val)

    video.write(frame)

def run_visualization():
    if not os.path.exists('videos'):
        os.makedirs('videos')

    for algo in algos:
        current_input = f'./arrays/input_{algo}.txt'
        current_log = f'{algo}.txt'
        output_name = f'videos/output_{algo}.mp4'

        if not os.path.exists(current_input) or not os.path.exists(current_log):
            print(f"Skipping {algo}: files missing")
            continue

        with open(current_input, 'r') as f:
            first_line = f.readline().strip()
            arr = [int(x) for x in first_line.split()]

        fourcc = cv2.VideoWriter_fourcc(*'mp4v')
        video = cv2.VideoWriter(output_name, fourcc, framerate, (width, height))

        print(f"Visualisation started for {algo}, with {len(arr)} elements...")

        try:
            with open(current_log, 'r') as f:
                a, b = 0, 0
                for line in f:
                    line = line.strip()
                    if not line:
                        continue

                    if line == 's':
                        if a < len(arr) and b < len(arr):
                            arr[a], arr[b] = arr[b], arr[a]
                            draw_frame(video, arr, True, a, b)
                    else:
                        parts = line.split()
                        if len(parts) == 2:
                            a, b = int(parts[0]), int(parts[1])
                            draw_frame(video, arr, True, a, b)

            for _ in range(framerate):
                draw_frame(video, arr, False)

            print(f"Finished {algo}! Result saved in {output_name}")
        except Exception as e:
            print(f"Error in {algo}: {e}")
        finally:
            video.release()

if __name__ == "__main__":
    run_visualization()