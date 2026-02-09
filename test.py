import cv2
import numpy as np

# Create video writer
fourcc = cv2.VideoWriter_fourcc(*'mp4v')
video = cv2.VideoWriter('output.mp4', fourcc, 20.0, (1000, 500))
x = 10
for frame_num in range(100):
    # Create frame
    frame = np.zeros((500, 1000, 3), dtype=np.uint8)
    frame.fill(0)

    # Draw something that changes each frame
    cv2.putText(frame, "hello-world-sort 0 comparisons, 0 swaps", (10,24), cv2.FONT_HERSHEY_SIMPLEX, 1, (255,255,255), 1)
    for i in range(100):

        cv2.rectangle(frame, (i * 10, 450), (i * 10 + 8, 450 - i * 4), (255, 255, 255), -1)
    cv2.rectangle(frame, (frame_num * 10, 450), (frame_num * 10 + 8, 450 - frame_num * 4), (0, 255, 0), -1)

    video.write(frame)

video.release()