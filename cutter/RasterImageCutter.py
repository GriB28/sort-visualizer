import cv2
import numpy as np
from sys import argv

#imagename = argv[1]
imagename = 'rick.jpg'
#array_size = int(argv[2])
array_size = 240

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
        if np.sum(stripe[y, :] == 255) > stripe_width/2:
            stripe[y, :] = 255
        else:
            stripe[y, :] = 0

reconstructed = np.hstack(vertical_stripes)

cv2.imwrite('sliced.png', reconstructed)
