import cv2
import numpy as np

%load images
y_pred = cv2.imread('Img1.bmp')
y_true = cv2.imread('Img2.bmp') 

%Dice similarity function
def dice(pred, true, k = 1):
    intersection = np.sum(pred[true==k]) * 2.0
    dice = intersection / (np.sum(pred) + np.sum(true))
    return dice

dice_score = dice(y_pred, y_true, k = 255) %255 in my case, can be 1 
print ("Dice Similarity: {}".format(dice_score))