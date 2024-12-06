#
# ECE369
# 

########################################################################################################################
### data
########################################################################################################################
.data
# test input
# asize : dimensions of the frame [i, j] and window [k, l]
#         i: number of rows,  j: number of cols
#         k: number of rows,  l: number of cols  
# frame : frame data with i*j number of pixel values
# window: search window with k*l number of pixel values
#
# $v0 is for row / $v1 is for column

# test 1 For the 16X16 frame size and a 8X4 window size
# The result should be 3, 2
asize1:  .word    16, 16, 8, 4    #i, j, k, l
frame1:  .word    7, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
         .word    7, 8, 8, 8, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 
         .word    7, 8, 8, 8, 2, 8, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 
         .word    7, 8, 8, 8, 8, 8, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 
         .word    0, 4, 8, 8, 8, 8, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 
         .word    0, 5, 8, 8, 8, 8, 30, 35, 40, 45, 50, 55, 60, 65, 70,  75, 
         .word    0, 6, 8, 8, 8, 8, 36, 42, 48, 54, 60, 66, 72, 78, 84, 90, 
         .word    0, 4, 8, 8, 8, 8, 42, 49, 56, 63, 70, 77, 84, 91, 98, 105, 
         .word    0, 1, 8, 8, 8, 8, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120, 
         .word    0, 1, 8, 8, 8, 8, 54, 63, 72, 81, 90, 99, 108, 117, 126, 135, 
         .word    0, 10, 8, 8, 8, 8, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 
         .word    0, 11, 22, 33, 44, 55, 66, 77, 88, 99, 110, 121, 132, 143, 154, 165, 
         .word    9, 9, 9, 9, 48, 60, 72, 84, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    9, 9, 9, 9, 52, 65, 78, 91, 104, 114, 130, 143, 1, 2, 3, 4, 
         .word    9, 9, 9, 9, 56, 70, 84, 98, 112, 126, 140, 154, 2, 3, 4, 5, 
         .word    9, 9, 9, 9, 60, 75, 90, 105, 120, 135, 150, 165, 3, 4, 5, 6 
window1: .word    8, 8, 8, 8, 
         .word    8, 8, 8, 8, 
         .word    8, 8, 8, 8, 
         .word    8, 8, 8, 8, 
         .word    8, 8, 8, 8, 
         .word    8, 8, 8, 8, 
         .word    8, 8, 8, 8, 
         .word    8, 8, 8, 8 

# test 2 For the 32X32 frame and a 8X16 window size
# The result should be 16, 0
asize2:  .word    32, 32, 8, 16    #i, j, k, l
frame2:  .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8
         
window2: .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         
# test 3 For the 16X16 frame and a 4X8 window size
# The result should be 12, 0
asize3:  .word    16, 16, 4, 8    #i, j, k, l
frame3:  .word    9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 6, 7, 7, 7, 
         .word    9, 7, 7, 7, 7, 5, 6, 7, 8, 9, 10, 11, 6, 7, 7, 7, 
         .word    9, 7, 7, 7, 7, 3, 12, 14, 16, 18, 20, 6, 6, 7, 7, 7, 
         .word    9, 7, 7, 7, 7, 4, 18, 21, 24, 27, 30, 33, 6, 7, 7, 7, 
         .word    0, 7, 7, 7, 7, 5, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 
         .word    0, 5, 3, 4, 5, 6, 30, 35, 40, 45, 50, 55, 60, 65, 70,  75, 
         .word    0, 6, 12, 18, 24, 30, 36, 42, 48, 54, 60, 66, 72, 78, 84, 90, 
         .word    0, 4, 14, 21, 28, 35, 42, 49, 56, 63, 70, 77, 84, 91, 98, 105, 
         .word    0, 8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120, 
         .word    0, 9, 18, 27, 36, 45, 54, 63, 72, 81, 90, 99, 108, 117, 126, 135, 
         .word    0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 
         .word    0, 11, 22, 33, 44, 55, 66, 77, 88, 99, 110, 121, 132, 143, 154, 165, 
         .word    9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3
         
window3: .word    9, 9, 9, 9, 9, 9, 9, 9, 
         .word    9, 9, 9, 9, 9, 9, 9, 9, 
         .word    9, 9, 9, 9, 9, 9, 9, 9, 
         .word    9, 9, 9, 9, 9, 9, 9, 9
     
# test 4 For the 16X16 frame and a 8X8 window size
# The result should be 8, 3
asize4: .word    16, 16, 8, 8    #i, j, k, l
frame4: .word    9, 19, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    9, 91, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    9, 9, 19, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    9, 9, 91, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    91, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    9, 19, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    9, 91, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    1, 2, 3, 9, 9, 19, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 
         .word    1, 2, 3, 9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 
         .word    1, 2, 3, 9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 
         .word    1, 2, 3, 9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 
         .word    1, 2, 3, 9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 
         .word    1, 2, 3, 9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 
         .word    1, 2, 3, 9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 
         .word    1, 2, 3, 9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 
         .word    1, 2, 3, 9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0
                  
window4:   .word    9, 9, 9, 9, 9, 9, 9, 9, 
            .word    9, 9, 9, 9, 9, 9, 9, 9, 
            .word    9, 9, 9, 9, 9, 9, 9, 9, 
            .word    9, 9, 9, 9, 9, 9, 9, 9, 
            .word    9, 9, 9, 9, 9, 9, 9, 9, 
            .word    9, 9, 9, 9, 9, 9, 9, 9, 
            .word    9, 9, 9, 9, 9, 9, 9, 9, 
            .word    9, 9, 9, 9, 9, 9, 9, 9
   
# test 5 For the 32X32 frame and a 4X4 window size
# The result should be 5, 16 since its the first of multiple repeating occurrences
asize5: .word    32, 32, 4, 4    #i, j, k, l
frame5: .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
                  
window5:   .word    10, 10, 10, 10, 
            .word    10, 10, 10, 10, 
            .word    10, 10, 10, 10, 
            .word    10, 10, 10, 10

newline: .asciiz     "\n" 

########################################################################################################################
### main
########################################################################################################################

.text

.globl main

main: 
    addi    $sp, $sp, -4    # Make space on stack
    sw      $ra, 0($sp)     # Save return address
         
    # Start test 1 
    ############################################################
    la      $a0, asize1     # 1st parameter: address of asize1[0]
    la      $a1, frame1     # 2nd parameter: address of frame1[0]
    la      $a2, window1    # 3rd parameter: address of window1[0] 
   
    jal     vbsme           # call function
  # jal     print_result    # print results to console
    
    ############################################################
    # End of test 1   
 
    # Start test 2 
    ############################################################
    la      $a0, asize2     # 1st parameter: address of asize2[0]
    la      $a1, frame2     # 2nd parameter: address of frame2[0]
    la      $a2, window2    # 3rd parameter: address of window2[0] 
   
    jal     vbsme           # call function
  # jal     print_result    # print results to console
    ############################################################
    # End of test 2   
                        
    # Start test 3
    ############################################################
    la      $a0, asize3     # 1st parameter: address of asize3[0]
    la      $a1, frame3     # 2nd parameter: address of frame3[0]
    la      $a2, window3    # 3rd parameter: address of window3[0] 

    jal     vbsme           # call function
  # jal     print_result    # print results to console 
    ############################################################
    # End of test 3       
      
    # Start test 4 
    ############################################################
    la      $a0, asize4     # 1st parameter: address of asize4[0]
    la      $a1, frame4     # 2nd parameter: address of frame4[0]
    la      $a2, window4    # 3rd parameter: address of window4[0] 

    jal     vbsme           # call function
  # jal     print_result    # print results to console
    ############################################################
    # End of test 4   
    
    # Start test 5
    ############################################################
    la      $a0, asize5     # 1st parameter: address of asize5[0]
    la      $a1, frame5     # 2nd parameter: address of frame5[0]
    la      $a2, window5    # 3rd parameter: address of window5[0] 

    jal     vbsme           # call function
 #  jal     print_result    # print results to console
    ############################################################
    # End of test 5

    lw      $ra, 0($sp)         # Restore return address
    addi    $sp, $sp, 4         # Restore stack pointer
    j       end_program         # Return

end_program:                    # remain in infinite loop
	j end_program
################### Print Result ####################################
#print_result:
    # Printing $v0
    # add     $a0, $v0, $zero     # Load $v0 for printing
    # li      $v0, 1              # Load the system call numbers
    # syscall
   
    # Print newline.
    # la      $a0, newline          # Load value for printing
    # li      $v0, 4                # Load the system call numbers
    # syscall
   
    # Printing $v1
    # add     $a0, $v1, $zero      # Load $v1 for printing
    # li      $v0, 1                # Load the system call numbers
    # syscall

    # Print newline.
    # la      $a0, newline          # Load value for printing
    # li      $v0, 4                # Load the system call numbers
    # syscall
   
    # Print newline.
    # la      $a0, newline          # Load value for printing
    # li      $v0, 4                # Load the system call numbers
    # syscall
   
    # jr      $ra                   #function return

#####################################################################
### vbsme
#####################################################################

vbsme:
    andi $t9, $t9, 0                           # reset t9

    addi    $v0, $zero, 0                      # reset $v0 and $V1
    addi    $v1, $zero, 0


    lw $t0, 0($a0)                      # dimension 1 frame height
    lw $t1, 4($a0)                      # dimension 2 frame width

    lw $t2, 8($a0)                      # dimension 3 window height
    lw $t3, 12($a0)                     # dimension 4 window width

    addi $t4, $zero, 0                  # set top boundary
    addi $t5, $zero, 0                  # set left boundary
    
    sub $t6, $t1, $t3                   # set right boundary
    #addi $t6, $t6, 1
    
    sub $t7, $t0, $t2                   # set bottom boundary
    #addi $t7, $t7, -1

    # li $t8, 1                         # initialize while loop

    addi $s0, $zero, 0                  # set current row to 0,  "i"
    addi $s1, $zero, 0                  # set current column to 0 "j"

    addi $s2, $zero, 0                  # k
    addi $s3, $zero, 0                  # l

    addi $s4, $zero, 0                  # set current SAD
    addi $s5, $zero, 32767              # set minimum SAD

    addi $s6, $zero, 1                  #s6 = 1, for branch comparisons

    addi $sp, $sp, -4                   # add space one element to stack
    sw $ra, 0($sp)                      # store ra in first stack element

    add $s0, $t5, $zero                 # i = left boundary (0)
    add $s1, $t4, $zero                 # j = top boundary  (0)

    while:
        slt $t9, $t6, $t5      
        beq $t9, $s6, exit              # exit if left boundary > right boundary
        #beq $t5, $t6, exit

        #bgt $t4, $t7, exit              # exit if top boundary > bottom boundary
        #beq $t4, $t7, exit
        
        ###########################
        # LEFT TO RIGHT
        ###########################

        loop_lr:
                slt $t8, $t6, $s0       # exit if i > right boundary
                beq $t8, $s6, exit_lr  

                addi $s4, $zero, 0               # SAD = 0

                addi $s3, $zero, 0               # l = 0
                j loop_l1

        compare_lr:
                slt $t8 , $s4, $s5      # branch if sumABS < minABS  
                beq $t8, $s6, newABS_lr
                
        iter_lr:
                addi $s0, $s0, 1        # i++
                j loop_lr               # loop for left to right movement

        newABS_lr:
                addi $v0, $s1, 0           # coordinates[0] = j;
                addi $v1, $s0, 0           # coordinates[1] = i;

                addi $s5, $s4, 0           # minABS = sumABS

                j iter_lr

        loop_l1:
                slt $t8, $s3, $t2       # branch when l >= window height
                beq $t8, $zero, compare_lr 

                addi $s2, $zero, 0               # k = 0

                j loop_k1 
        iter_l1:
                addi $s3, $s3, 1        # l++
                j loop_l1
                
        loop_k1:
                slt $t8, $s2, $t3       # branch when k >= window width
                beq $t8, $zero, iter_l1  

                jal absolute

                addi $s2, $s2, 1        # k++

                j loop_k1
    
        exit_lr:
                addi $t4, $t4, 1        # top boundary += 1

                addi $s0, $t6, 0        # i = right boundary
                #addi $s1, $t4, 0        # j = top boundary

                # slt $t8, $t5, $t1     # left boundary < frame width
                # bne $t8, 1, loop_tb   # if left boundary >= frame width then go past if statment
                # beq $s6, $zero, loop_tb # if second run = 1
                


        ###########################
        # TOP TO BOTTOM
        ###########################

         
        loop_tb:
                slt $t8, $t7, $s1       # exit if j > bottom boundary
                beq $t8, $s6, exit_tb

                addi $s4, $zero, 0               # SAD = 0
                addi $s3, $zero, 0               # l = 0

                j loop_l2               # loop for top to bottom movement

        compare_tb:
                slt $t8 , $s4, $s5      # branch if sumABS < minABS
                beq $t8, $s6, newABS_tb
        
        iter_tb:
                addi $s1, $s1, 1        # j++
                j loop_tb

        newABS_tb:
                addi $v0, $s1, 0           # coordinates[0] = j;
                addi $v1, $s0, 0           # coordinates[1] = i;

                addi $s5, $s4, 0           # minABS = sumABS

                j iter_tb 
        
        loop_l2:
                slt $t8, $s3, $t2       # branch when l >= window height
                beq $t8, $zero, compare_tb

                addi $s2, $zero, 0               # k = 0

                j loop_k2

        iter_l2:
                addi $s3, $s3, 1        # l++
                j loop_l2
        
        loop_k2:
                slt $t8, $s2, $t3       # branch when k >= window width
                beq $t8, $zero, iter_l2

                jal absolute

                addi $s2, $s2, 1        # k++

                j loop_k2

        exit_tb:
                addi $t6, $t6, -1       # right boundary -= 1

                addi $s1, $t7, 0        # j = bottom boundary
                #addi $s0, $t6, 0        # i = right boundary
        

        ###########################
        # RIGHT TO LEFT
        ###########################

            
        loop_rl:
                slt $t8, $s0, $t5       # exit if i < left boundary
                beq $t8, $s6, exit_rl  

                addi $s4, $zero, 0               # SAD = 0
                addi $s3, $zero, 0               # l = 0

                j loop_l3

        compare_rl:
                slt $t8 , $s4, $s5      # branch if sumABS < minABS
                beq $t8, $s6, newABS_rl

        iter_rl:
                addi $s0, $s0, -1       # i--
                j loop_rl               

        newABS_rl:
                addi $v0, $s1, 0           # coordinates[0] = j;
                addi $v1, $s0, 0           # coordinates[1] = i;

                addi $s5, $s4, 0           # minABS = sumABS

                j iter_rl

        loop_l3:
                slt $t8, $s3, $t2       # branch when l >= window height
                beq $t8, $zero, compare_rl 

                addi $s2, $zero, 0               # k = 0
                j loop_k3

        iter_l3:
                addi $s3, $s3, 1        # l++
                j loop_l3
        
        loop_k3:
                slt $t8, $s2, $t3       # branch when k >= window width
                beq $t8, $zero, iter_l3 

                jal absolute

                addi $s2, $s2, 1        # k++

                j loop_k3

        exit_rl:
                addi $t7, $t7, -1       # Bottom Boundary -= 1

                addi $s0, $t5, 0           # i = leftBoundary
                #addi $s1, $t7, 0           # j = bottom boundary

        
        ###########################
        # BOTTOM TO TOP
        ###########################

            
        loop_bt:
                slt $t8, $s1, $t4       # exit if j < top boundary
                beq $t8, $s6, exit_bt   

                addi $s4, $zero, 0               # SAD = 0
                addi $s3, $zero, 0               # l = 0

                j loop_l4               # jump to l loop

        compare_bt:
                slt $t8 , $s4, $s5      # branch if sumABS < minABS  
                beq $t8, $s6, newABS_bt

        iter_bt:
                addi $s1, $s1, -1       # --j
                j loop_bt

        newABS_bt:
                addi $v0, $s1, 0           # coordinates[0] = j;
                addi $v1, $s0, 0           # coordinates[1] = i;

                addi $s5, $s4, 0           # minABS = sumABS
                
                j iter_bt

        loop_l4:
                slt $t8, $s3, $t2       # branch when l >= window height
                beq $t8, $zero, compare_bt

                addi $s2, $zero, 0               # k = 0

                j loop_k4

        iter_l4:
                addi $s3, $s3, 1        # l++
                j loop_l4
        
        loop_k4:
                slt $t8, $s2, $t3       # branch when k >= window width
                beq $t8, $zero, iter_l4

                jal absolute
                
                addi $s2, $s2, 1        # k++
                j loop_k4

        exit_bt:
                addi $t5, $t5, 1        # left boundary += 1

                addi $s0, $t4, 0        # j = top boundary
                #addi $s0, $t5, 0       # i = left boundary

                # li $s6, 1             # secondrun = 1

        j while

        exit:
            lw $ra, 0($sp)              #reset return address with ra when vbsme is called
            addi $sp, $sp, 4            #reset stack pointer to bottom
            
            jr $ra                      #jump to return

        absolute:                       # need to maintain framewidth = t1, window width = $t3, i = s0, j = s1, k = s2, l = s3
            addi $sp, $sp, -12
            sw $t0, 8($sp)
            sw $t2, 4($sp)
            sw $t4, 0($sp)

            add $t0, $a1, $zero             # t0 = &frame[]

            #sll $t2, $s0, 2                # make i word readable
            #add $t0, $t0, $t2              # t0 = &frame[i]

            add $t2, $s1, $s3               # t2 = (l + j)
            mul $t2, $t1, $t2               # t2 = (l + j) * framewidth
            add $t2, $t2, $s2               # t2 = (l + j) * framewidth) + k
            add $t2, $t2, $s0               # t2 = i + ((l + j) * framewidth) + k

            sll $t2, $t2, 2                 # make t2 word readable
            add $t0, $t0, $t2               # t0 = &frame[i + ((l + j) * framewidth) + k]

            lw $t4, 0($t0)                  # t4 = frame[i + ((l + j) * framewidth) + k]

            add $t0, $a2, $zero             # t0 = &window[]
            mul $t2, $s3, $t3               # t2 = (l * windowWidth)
            add $t2, $t2, $s2               # t2 = (l * windowWidth) + k

            sll $t2, $t2, 2                 # make t2 word readable
            add $t0, $t0, $t2               # t0 = &window[(l * windowWidth) + k]

            lw $t2, 0($t0)                  # t2 = window[(l * windowWidth) + k]

            sub $t0, $t4, $t2               # difference between t4 and t2
            slt $t2, $t0, $zero             # check if (t4 - t2) < 0
            bne $t2, $zero, sign_change             # jump to sign change

        sum:    
            add $s4, $s4, $t0               # add to absolute sum
            lw $t4, 0($sp)
            lw $t2, 4($sp)
            lw $t0, 8($sp)
            addi $sp, $sp, 12
            jr $ra

        sign_change:
            addi $t2, $zero, -1 
            mul $t0, $t0, $t2               # change negative to positive
            j sum
