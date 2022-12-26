   
#       CSE 3666 Lab 2

        # data 
	.data
buf:	.space		64


        # code
        .text

        .globl  main

main:   
        
        # read one integer from the console and 
        # print the number in binary 
 
        # use system call 5 to read an integer
        addi    a7, x0, 5
        ecall
        addi    s1, a0, 0               # copy a0 to s1

        # use system call 35 to print a0 in binary
        # a0 already has the integer to print
        addi    a7, x0, 35
        ecall

        # print new line
        # system call 11 prints the character in a0
        addi    a7, x0, 11
        addi    a0, x0, '\n'
        ecall 
        
        # TODO
        # Add you code here
        #   generate a string that is the binary format of the number
        #   append a newline to the end of the string
        #   print the string
        
        #   let s4 be the base address of the string
        #   we only need LA once in this program
        la	s4, buf		
        lui	s2,0x80000 #load upper part of mask
        addi	s2,s2,0x000
        addi	s3,s3,0 #i = 0
        addi	s5,x0,32 #constant 32
        
        beq	x0,x0,condi
        
        action:	and	t0,s1,s2 #stores mask number
        	add	t2,s3,s4
        	beq	t0,x0,zero_cond
        	
        one_cond:	addi	t3,x0,'1'
        		sb	t3,0(t2)
        		beq	x0,x0,bcond
        	
        zero_cond:	addi	t3,x0,'0'
        		sb	t3,0(t2)
        
        bcond:	slli	s1,s1,1
        	addi	s3,s3,1 #increment i by 1
        	slli	t1,s3,2
        condi:	blt	s3,s5,action
	addi t0, x0,'\n'
	
	sb t0, 32(s4)
	sb x0, 33(s4)
	
	addi a7, x0,4
	add a0, s4, zero
	ecall

        # exit
exit:   addi    a7, x0, 10      
        ecall