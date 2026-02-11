import cv2
import numpy as np

width = 1000
height = 500
framerate = 60
file_path = 'quick.txt'
array_size = 200
arr = np.array([141, 122, 147, 98, 83, 14, 60, 36, 85, 194, 95, 92, 108, 72, 114, 131, 21, 20, 12, 52, 61, 127, 2, 117, 157, 64, 94, 184, 4, 149, 119, 17, 154, 96, 28, 139, 41, 67, 82, 109, 195, 15, 45, 132, 42, 180, 87, 35, 110, 33, 179, 189, 24, 9, 63, 156, 10, 54, 175, 182, 62, 77, 143, 58, 65, 81, 37, 171, 185, 31, 48, 148, 53, 16, 56, 173, 78, 186, 103, 136, 152, 18, 183, 49, 73, 124, 102, 155, 163, 11, 59, 126, 116, 145, 91, 47, 146, 55, 38, 51, 104, 137, 164, 138, 8, 113, 112, 177, 6, 44, 174, 29, 199, 19, 105, 46, 167, 160, 159, 192, 181, 188, 74, 101, 107, 76, 120, 187, 27, 198, 69, 111, 161, 68, 168, 39, 135, 142, 66, 128, 23, 26, 123, 151, 190, 140, 79, 150, 25, 200, 1, 22, 99, 86, 170, 133, 125, 50, 134, 88, 121, 43, 5, 57, 75, 176, 169, 7, 191, 40, 71, 30, 118, 89, 130, 197, 193, 84, 93, 97, 158, 34, 165, 80, 90, 70, 100, 129, 106, 172, 144, 162, 178, 32, 166, 3, 13, 196, 153, 115])

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
            if line.strip() != 's':
                a, b = line.split()
                #print(a,b)
                #print(arr)
                draw_frame(video, True, int(a), int(b))
            else:
                print("swap")
                arr[int(a)], arr[int(b)] = arr[int(b)], arr[int(a)]
                #print(arr)
                draw_frame(video, True, int(a), int(b))
        draw_frame(video, False)
except FileNotFoundError:
    print(f"Error: The file '{file_path}' was not found.")
except Exception as e:
    print(f"An error occurred: {e}")

video.release()