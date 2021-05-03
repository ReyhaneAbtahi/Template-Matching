# Template-Matching
Image processing template matching project

In this project we have a function named Find (Find.m file) that get an image and calculate the sum of digits appeared in that with positive sign for red digits and negative sign for blue ones.

for testing the accuracy of function we have a set of images (test) with different level of salt and peppers noise. in main.m file i use median filter with 3*3 kernel to remove noise and Find function to calculate sum of digits. the result of summation is written at the buttom of images and save in answer directory
(the true answer appeare in name of test images)
