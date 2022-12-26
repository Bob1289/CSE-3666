#       CSE 3666 Lab 4
#	TAG: 63a79cdd7323aef99cd2fa35bc24b7d7

	.data
	.align	2	
word_array:     .word
        0,   10,   20,  30,  40,  50,  60,  70,  80,  90, 
        100, 110, 120, 130, 140, 150, 160, 170, 180, 190,
        200, 210, 220, 230, 240, 250, 260, 270, 280, 290,
        300, 310, 320, 330, 340, 350, 360, 370, 380, 390,
        400, 410, 420, 430, 440, 450, 460, 470, 480, 490,
        500, 510, 520, 530, 540, 550, 560, 570, 580, 590,
        600, 610, 620, 630, 640, 650, 660, 670, 680, 690,
        700, 710, 720, 730, 740, 750, 760, 770, 780, 790,
        800, 810, 820, 830, 840, 850, 860, 870, 880, 890,
        900, 910, 920, 930, 940, 950, 960, 970, 980, 990
array_end:

        # code
        .text
        .globl  main
main:   
	addi	s0, x0, -1
	addi	s1, x0, -1
	addi	s2, x0, -1
	addi	s3, x0, -1
	addi	s4, x0, -1
	addi	s5, x0, -1
	# help to check if any saved registers are changed during the function call
	# could add more...

        la      s1, word_array   # defined in data section at the end of the file
        la      s2, array_end
        sub     s2, s2, s1
        srai    s2, s2, 2       # s2 is the number of elements in the array

        # read an integer from the console
        addi    a7, x0, 5
        ecall

        addi    s3, a0, 0       # keep a copy of v in s3
        
        # call binary search
        addi	a0, s1, 0
        addi	a1, s2, 0
        addi	a2, s3, 0
        jal	ra, binary_search

	# print the return value
        jal	ra, print_int

	# set a breakpoint here and check if any saved register was changed
        # exit
exit:   addi    a7, x0, 10      
        ecall

# a function that prints an integer, followed by a newline
print_int: 
        addi    a7, x0, 1
        ecall
 
        # print newline
        addi    a7, x0, 11
        addi    a0, x0, '\n'
        ecall        
         
	jr	ra
	
#### Do not change lines above
binary_search:

        # TODO
        #Allocate space
        addi	sp, sp, -12 
        sw	s1, 0(sp)
        sw	s2, 4(sp)
        sw	ra, 8(sp)
        
        if_nothing:
        	bne	a1,x0,if_end #if n!=0
        	addi	a0, x0, -1 #rv = -1
        	beq	x0, x0, return #Go to return
        	
        if_end:
        	srai 	s1, a1, 1 #s1 = n / 2
		slli 	t0, s1, 2 #calculate half	
		add 	t0, t0, a0 #a[half]
		lw 	a6, 0(t0) #half_v = a[half]
	
	if_half:
		bne 	a6, a2, else_if #half_v != v
		add 	a0, s1, x0 #rv = half
		beq 	x0, x0, return #Go to return
		
	else_if:
		blt 	a6, a2, else #v > half_v
		add 	a1, s1, x0 #a1 = half
		jal 	binary_search #binary_search(a, half, v)
		beq 	x0, x0, return #return
		
	else:
		addi 	s2, s1, 1 # left val
		slli 	t2, s2, 2 #bytes from a
		add 	a0, a0, t2 #&a[left]
		sub 	a1, a1, s2 # n-=left	
		jal 	binary_search #binary_search(&a[left], n - left, v)
		blt 	a0, x0, return # Go to return
		add 	a0, a0, s2		
        	
        return:
        	lw 	s1, 0(sp)
        	lw 	s2, 4(sp)
        	lw 	ra, 8(sp)
        	
        	addi 	sp, sp 12
        	
        	jr	ra	
        
        
        jr	ra