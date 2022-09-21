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
        addi	s2,s2,0
        addi	s3,s3,0
        BLT	s2,32,LOOP
        LOOP:	andi	s3,0x80000000
        	beq	s3,zero,ELSE
        		ELSE:		
        
        #   let s4 be the base address of the string
        #   we only need LA once in this program
        la	s4, buf		


        # exit
exit:   addi    a7, x0, 10      
        ecall