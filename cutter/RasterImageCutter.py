import cv2
import numpy as np
from sys import argv

#imagename = argv[1]
imagename = 'rick.jpg'
#array_size = int(argv[2])
array_size = 240
outputname = "anim.mp4"
framerate = 600

# Read image as grayscale
img = cv2.imread(imagename, cv2.IMREAD_GRAYSCALE)

# If image is not strictly binary, apply threshold
_, binary = cv2.threshold(img, 127, 255, cv2.THRESH_BINARY)

height, width = binary.shape
stripe_width = int(width / array_size)
vertical_stripes = []

for x in range(0, width, stripe_width):
    stripe = binary[:, x:x+stripe_width]    # slice columns x to x+stripe_width
    vertical_stripes.append(stripe)

for stripe in vertical_stripes:
    for y in range(0, height):
        if np.sum(stripe[y, :] == 255) > stripe_width/2-3:
            stripe[y, :] = 255
        else:
            stripe[y, :] = 0

reconstructed = np.hstack(vertical_stripes)

cv2.imwrite('slicedrick.png', reconstructed)

fourcc = cv2.VideoWriter_fourcc(*'mp4v')
video = cv2.VideoWriter(outputname, fourcc, framerate, (width, height))

def check(i, j, stripe):
    if stripe[i, :] == stripe[j, :]:
        return 0
    else:
        if stripe[i, :] < stripe[j, :]:
            return 1
        else:
            return -1
def swap(i, j, stripe):
    if check(i, j, stripe) == 1:
        tmp = stripe[i, :]
        stripe[i, :] = stripe[j, :]
        stripe[j, :] = tmp
def sort_cycles(stripe):
    n = height
    swapped = False
    for i in range(n - 1):
        if stripe[i, 1] == 255 and stripe[i+1, 1] == 0:
            stripe[i, :], stripe[i+1, :] = stripe[i+1, 1], stripe[i, 1]
            swapped = True
    #print(swapped)
    return swapped


sorted_flags = [False] * array_size     # track which arrays are already sorted
iteration = 0
while not all(sorted_flags):
    iteration += 1
    print(f"iteration {iteration}")
    any_swaps_this_iter = False

    for i, stripe in enumerate(vertical_stripes):
        #print(iteration, i)
        if not sorted_flags[i]:
            swapped = sort_cycles(stripe)
            if not swapped:
                sorted_flags[i] = True  # this array is now sorted
            else:
                any_swaps_this_iter = True
    #print(sorted_flags)
    # If no array made a swap in this iteration, all are sorted – stop early
    if not any_swaps_this_iter:
        break
    if iteration % 10 == 0:
        frame = np.hstack(vertical_stripes)
        video.write(cv2.cvtColor(frame, cv2.COLOR_GRAY2BGR))
        print("write")

video.release()


