import cv2
import numpy as np
import os
from sys import argv

width = int(argv[1])
height = int(argv[2])
framerate = int(argv[3])
source = argv[4]
log = argv[5]
algorithm_name = argv[6]

image_path = None
vector_heights_array = list()
image_render_flag = int(argv[7])  #  0 -- default;  1 -- vector;  2 -- raster
if len(argv) > 8:
    if image_render_flag == 1:
        with open(f"arrays/{algorithm_name}.csv") as heights_file:
            vector_heights_array = list(map(float, heights_file.read().strip().split('\n')))
    elif image_render_flag == 2:
        image_path = argv[8]
else:
    image_render_flag = 0

output_name = f'videos/output_{algorithm_name}.mp4'


def draw_rectangle(frame, index, value, color, array_size, max_val):
    bar_width = width / array_size
    if image_render_flag == 0:
        bar_height = int(value / max_val * height)
    elif image_render_flag == 1:
        bar_height = int(vector_heights_array[value - 1] * height)
    else:
        bar_height = 0
    x = int(index * bar_width)
    cv2.rectangle(frame, (x, height), (x + int(bar_width), height - bar_height), color, -1)

def draw_frame(video, arr, text, highlight=False, idx1=None, idx2=None):
    frame = np.zeros((height, width, 3), dtype=np.uint8)
    array_size = len(arr)
    max_val = max(arr) if array_size > 0 else 1

    (text_width, text_height), baseline = cv2.getTextSize(text, cv2.FONT_HERSHEY_SIMPLEX, 0.7, 2)
    cv2.putText(frame, text, (0, text_height), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (255, 255, 255))
    for i in range(array_size):
        draw_rectangle(frame, i, arr[i], (255, 255, 255), array_size, max_val)

    if highlight and idx1 is not None and idx2 is not None:
        if idx1 < array_size and idx2 < array_size:
            color = (0, 0, 255) if arr[idx1] > arr[idx2] else (0, 255, 0)
            draw_rectangle(frame, idx1, arr[idx1], color, array_size, max_val)
            draw_rectangle(frame, idx2, arr[idx2], color, array_size, max_val)

    video.write(frame)

def draw_frame_image(video, arr, text, image):
    stripe_width = int(width / len(arr))
    vertical_stripes = []
    for x in range(0, width, stripe_width):
        stripe = image[:, x:x + stripe_width]  # slice columns x to x+stripe_width
        vertical_stripes.append(stripe)
    vertical_stripes = [vertical_stripes[arr[i] - 1] for i in range(len(arr))]
    frame = np.hstack(vertical_stripes)
    (text_width, text_height), baseline = cv2.getTextSize(text, cv2.FONT_HERSHEY_SIMPLEX, 0.7, 2)
    cv2.putText(frame, text, (0, text_height), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (255, 255, 255))
    video.write(frame)


def run_visualization():
    if not os.path.exists('videos'):
        os.makedirs('videos')

    if not os.path.exists(source) or not os.path.exists(log):
        print(f"Skipping: files missing")
        exit()

    with open(source, 'r') as f:
        first_line = f.readline().strip()
        arr = [int(x) for x in first_line.split()]

    image = None
    if image_path:
        image = cv2.imread(image_path)
        image = cv2.resize(image, (width, height))

    fourcc = cv2.VideoWriter_fourcc(*'mp4v')
    video = cv2.VideoWriter(output_name, fourcc, framerate, (width, height))

    print(f"Visualisation started with {len(arr)} elements...")
    try:
        with open(log, 'r') as f:
            a, b = 0, 0
            swaps = 0
            compares = 0
            lines = f.readlines()
            total_length = len(lines)
            counter = 0
            for line in lines:
                line = line.strip()
                if not line:
                    continue
                text = f"{algorithm_name} sort with {len(arr)} elements, swaps:{swaps}, compares:{compares}"
                if line == 's':
                    if a < len(arr) and b < len(arr):
                        arr[a], arr[b] = arr[b], arr[a]
                        if image_path is not None:
                            draw_frame_image(video, arr, text, image)
                        else:
                            draw_frame(video, arr, text, True, a, b)
                    swaps += 1
                else:
                    parts = line.split()
                    if len(parts) == 2:
                        a, b = int(parts[0]), int(parts[1])
                        if image_path is not None:
                            draw_frame_image(video, arr, text, image)
                        else:
                            draw_frame(video, arr, text, True, a, b)
                        compares += 1
                counter += 1
                print(f"{counter * 100 / total_length:.2f}%", end='\b\r')
            print("100%")

        for _ in range(framerate):
            if image_path is not None:
                draw_frame_image(video, arr, text, image)
            else:
                draw_frame(video, arr, text, False)

        print(f"Finished {algorithm_name}! Result saved in {output_name}")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        video.release()

if __name__ == "__main__":
    run_visualization()