import cv2
import numpy as np

width = 1000
height = 500
framerate = 10
file_path = 'bubble.txt'
array_size = 8
arr = np.array([4, 3, 6, 5, 7, 2, 0, 1])

def draw_rectangle(frame, index, value, color):
    x = int(width/array_size*index)
    y = int(height/array_size*(value+1))
    dx = int(width/array_size - 2)
    cv2.rectangle(frame, (x, height), (x + dx, height - y), color, -1)

def draw_frame(video, highlight = True, index1 = None, index2 = None):
    frame = np.zeros((height, width, 3), dtype=np.uint8)
    frame.fill(0)
    #cv2.putText(frame, "hello-world-sort 0 comparisons, 0 swaps",
                #(10, 24), cv2.FONT_HERSHEY_SIMPLEX, 1,
                #(255, 255, 255), 1)
    for i in range(array_size):
        draw_rectangle(frame, i, arr[i], (255, 255, 255))
    if highlight:
        if arr[index1] > arr[index2]:
            draw_rectangle(frame, index1, arr[index1], (0, 0, 255))
            draw_rectangle(frame, index2, arr[index2], (0, 0, 255))
        else:
            draw_rectangle(frame, index1, arr[index1], (0, 255, 0))
            draw_rectangle(frame, index2, arr[index2], (0, 255, 0))
    video.write(frame)

# Create video writer
fourcc = cv2.VideoWriter_fourcc(*'mp4v')
video = cv2.VideoWriter('output.mp4', fourcc, framerate, (width, height))

try:
    with open(file_path, 'r') as file:
        for line in file:
            if line.strip() != 'swap':
                a, b = line.split()
                print(a,b)
                print(arr)
                draw_frame(video, True, int(a), int(b))
            else:
                print("swap")
                arr[int(a)], arr[int(b)] = arr[int(b)], arr[int(a)]
                print(arr)
                draw_frame(video, True, int(a), int(b))
        draw_frame(video, False)
except FileNotFoundError:
    print(f"Error: The file '{file_path}' was not found.")
except Exception as e:
    print(f"An error occurred: {e}")

video.release()