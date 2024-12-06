# The updated version, 11/30/2022
.data
DATA:   .word 4, 8, 16, 24, 184, 220, 260, 316
#indices      0  4   8  12   16   20   24   28

.text
.globl main

    # Load values
main:
	## this line is for MIPS Helper:
	
	addi $a0, $zero, 0 
	# this line is for Qtspim:
	#la $a0, DATA 
	##
    addi    $s0, $zero, -4 # 0xFFFC
    addi    $s1, $zero, -4 # 0xFFFC
    addi    $s2, $zero, -4 # 0xFFFC
    addi    $s4, $zero, -4 # 0xFFFC


    # read after lw on rs Case 1
    lw      $s2, 4($a0)   # $s2 = 8 # 0x8
    add     $s3, $s2, $s1 # s3 = 4 # 0x4

    # Flush pipeline
    nop
    nop
    nop
    nop
    nop

    # read after lw on rt  Case 2
    lw      $s2, 8($a0)   # $s2 = 0x10
    add     $s3, $s1, $s2 # $s3 = 0xC

    # Flush pipeline
    nop
    nop
    nop
    nop
    nop

    # read after lw on rs  Case 3
    lw      $s2, 12($a0)  # $s2 = 0x18
    add     $s5, $s1, $s4 # $s5 = 0xFFF8
    add     $s3, $s2, $s1 # $s3 = 0x14
	
    # Flush pipeline
    nop
    nop
    nop
    nop
    nop

    # read after lw on rt  Case 4
    lw      $s2, 0($a0)   # $s2 = 0x4
    add     $s5, $s4, $s1 # $s5 = 0xFFF8
    add     $s3, $s1, $s2 # $s3 = 0x0

    # Flush pipeline
    nop
    nop
    nop
    nop
    nop

    # bne after lw Case 5
    addi    $s3, $zero, 10  # s3 = 0xA
	addi    $s6, $zero, 10  # s6 = 0xA
    lw      $s3, 16($a0) # $s3 = 0xB8
    bne     $s3, $s6, branch1  # it will jump to ? checks s3 value and jumps to jump1 not to beq like bne with 9

    addi    $s1, $zero, -1 # flag
	
    nop
    nop	
	nop

branch1:

	# Load values
	addi $s7, $zero, 11  # s7= 0xB
	addi $t0, $zero, 12  # t0=0xC
	addi $t1, $zero, 13  # t1=0xD
	addi $t2, $zero, 14  # t2= 0xE
	addi $t3, $zero, 15  # t3=0xF



# Case 6 - lw MEM Stage Dependency 
    lw      $t3, 24($a0) # $t3 = 260 --> 0x104
    add     $t1, $s7, $s7  # Independent t1 = 0x16
    bne     $t0, $t3, branch2  # 
	
    addi    $s1, $zero, -1

    nop
    nop	
	nop	
	
branch2:
	addi     $t3, $zero, 12  # t3 = 0xC
	
	nop                 #
	nop                 #
	nop                 #
	nop                 #
	nop                 #

# Case 7 - lw WB Stage Dependency, Case 7
    lw      $t0, 24($a0)   # t0 = 260 --> 0x104
    add     $t1, $s6, $s6  # Independent (t1 = 0x14)
    add     $t2, $s7, $s7  # Independent t2 = 0x16
    bne     $t0, $t3 ,branch3 # depedency 
    addi    $s1, $zero, -1 # flag
	
    nop
    nop	
	nop	
	
branch3:
	addi    $s1, $zero, 1 # $s1 = 0x1

	nop                 #
	nop                 #
	nop                 #
	nop                 #
	nop                 #

	# Case 8 - rs EX - MEM Stage Dependency
	add $t1, $s6, $s7   # $t1 = 0x15
	sub $t2, $t1, $s6   # $t2 = 0xB

	nop                 #
	nop                 #
	nop                 #
	nop                 #
	nop                 #

	# Case 9 - rt EX - MEM Stage Dependency
	add $t1, $s6, $zero # $t1 = 0xA
	sub $t2, $s7, $t1   # $t2 = 0x1

	nop                 #
	nop                 #
	nop                 #
	nop                 #
	nop                 #

	# Case 10 - rs EX - WB Stage Dependency
	add $t1, $s6, $s7   # $t1 = 0x15
	addi $t0, $zero, 5  # Independent $t0 = 0x5
	sub $t2, $t1, $s6   # $t2 = 0xB

    # Flush pipeline
    nop
    nop
    nop
    nop
    nop
	
	addi $t4, $zero, 10  # t4 = 0xA
	addi $t5, $zero, 11  # t5 = 0xB
	addi $t6, $zero, 12  # t6 = 0xC
	addi $t7, $zero, 13  # t7 = 0xD
	addi $t8, $zero, 14 # t8 = 0xE
	addi $t9, $zero, 15  # t9 = 0xF

	
	# Case 11 on rt
	add $t9, $t5, $zero     # t9 = 0xB
	andi $t7, $t5, 9        # indep 0x9
	sub $t8, $t9, $t4       # t8 = 0x1

	nop                 
	nop                 
	nop                 
	nop                 
	nop  
            

	# Case 12
	lw $t4, 12($a0)          # t4 = Mem[3] = 0x18
	add $t6, $t5, $zero      # t6 = 0xB
	sub $t7, $t4, $t6        # t7 = 0xD

	nop
	nop
	nop
	nop
	nop

	# Case 13
	lw $t9, 4($a0)          # t9 = Mem[1] = 0x8
	sw $t9, 8($a0)          # Mem[2] = t9 = XX
	lw $t9, 8($a0)          # t9 = Mem[2] = 0x8
	
	nop                 
	nop                 
	nop                 
	nop                 
	nop                

	# Case 14
	lw $t7, 4($a0)            # t7 = Mem[1] = 8
	beq $t7, $t9, branch4     # branch4 taken
	
	addi $t0, $zero, -1  # Flag for branch failure
	
    nop
    nop	
	nop

branch4:
	j branch5

	addi $t0, $zero, -1  # Flag for branch failure
	
	nop
    nop	
	nop


	# Case 15 rt depedency
branch5: 


	lw $t7, 4($a0)            # t7 = Mem[1] = 8
	addi $t4, $zero, 20  # t4 = 20, indepedent, 0x14
	beq $t7, $t9, branch6     # branch6 taken
	
	addi $t0, $zero, -1  # Flag for branch failure

    nop
    nop	
	nop
               
branch6:

	j branch7
	addi $t0, $zero, -1  # Flag for branch failure
	
    nop
    nop	
	nop

	# Case 16
branch7:

	addi $t0,$zero,11  # t0 = 0xB
	beq $t0, $t6, exit
	
	addi $t0, $zero, -1  # Flag for branch failure

    nop
    nop	
	nop

exit:

	j main
	
	addi $t0, $zero, -1  # Flag for branch failure	

    nop
    nop	
	nop

