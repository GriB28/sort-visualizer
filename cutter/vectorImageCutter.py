import math
from sys import argv
import matplotlib.pyplot as plt

import numpy as np

imagename = argv[1]
array_size = int(argv[2])

arr =  np.arange(1, 1, 1/array_size)

def sinpi(x):
    return math.sin(np.pi * x)

with open(imagename, "w") as f:
    if imagename == "bubble":
        for i in arr:
            f.write(f"{sinpi(i):.3f},")
    #later another images will be added
#test hernya, potom udalu
testarray = np.loadtxt('bubble.csv', delimiter=',', dtype=float)
plt.plot(arr, testarray)
#end of test herni