.data
# test input
# asize : dimensions of the frame [i, j] and window [k, l]
#         i: number of rows,  j: number of cols
#         k: number of rows,  l: number of cols  
# frame : frame data with i*j number of pixel values
# window: search window with k*l number of pixel values
#
# $v0 is for row / $v1 is for column

# test 0 For the 16X16 frame size and 4X4 window size
# The result should be 0, 2
asize0:  .word    4,  4,  2, 2    #i, j, k, l 

frame0:  .word    0,  0,  1,  2, 
         .word    0,  0,  3,  4
         .word    0,  0,  0,  0
         .word    0,  0,  0,  0, 
window0: .word    1,  2, 
         .word    3,  4, 

# test 1
# result = 1, 1
asize7:  .word    3,  3,  2, 1    # Frame 3x3, Window 2x1

frame7:  .word    0,  1,  2
         .word    3,  4,  5
         .word    6,  7,  8
         
window7: .word    4
         .word    7

# test 2
# result = 2, 0
asize8:  .word    4,  2,  1, 2    # Frame 4x2, Window 1x2

frame8:  .word    5,  6
         .word    7,  8
         .word    9,  10
         .word    11, 12
         
window8: .word    9, 10

# test 3
# result = 1, 1
asize9:  .word    5,  5,  3, 2    # Frame 5x5, Window 3x2

frame9:  .word    0,  0,  0,  0,  0
         .word    0,  1,  2,  0,  0
         .word    0,  3,  4,  0,  0
         .word    0,  5,  6,  0,  0
         .word    0,  0,  0,  0,  0
         
window9: .word    1,  2
         .word    3,  4
         .word    5,  6

# test 4
# result = 3, 3
asize22: .word    6,  6,  3,  3    # Frame 6x6, Window 3x3

frame22: .word    1,  2,  3,  4,  5,  6
          .word    7,  8,  9, 10, 11, 12
          .word   13, 14, 15, 16, 17, 18
          .word   19, 20, 21, 22, 23, 24
          .word   25, 26, 27, 28, 29, 30
          .word   31, 32, 33, 34, 35, 36
          
window22: .word   22, 23, 24
           .word   28, 29, 30
           .word   34, 35, 36