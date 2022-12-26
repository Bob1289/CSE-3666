#       CSE 3666 Lab 3
#       TAG: 3c888496fd2090b0213533082fd1e6f7

        # code
        .text
        .globl  main
main:   
        addi    s0, x0, -1
        addi    s1, x0, -1
        addi    s2, x0, -1
        addi    s3, x0, -1
        addi    s4, x0, -1
        addi    s5, x0, -1
        # help to check if any saved registers are changed during the function call
        # could add more...

        # read an integer from the console
        # use system call 5 to read an integer
        addi    a7, x0, 5
        ecall
        
        # call print_bin to print it
        # the interger is already in a0
        jal     ra, print_oct

        # set a breakpoint here and check if any saved register was changed
        # exit
exit:   addi    a7, x0, 10      
        ecall

# a function that print a string
puts: 
        # the string address is already in a0   
        addi    a7, x0, 4
        ecall
 
        addi    a7, x0, 11
        addi    a0, x0, '\n'
        ecall        
         
        jr      ra
        
#### Do not change lines above
# void print_oct(int n)
# This function prints integer n in ternary format and a newline
# It does not return a value
print_oct:

        # TODO
        # save registers
        # allocate 16 bytes from the stack
        
        # Beginning of the loop
        addi	sp,sp,-16
        addi	s1,sp,0
        sw	s1,0(sp)
        sw	s2,4(sp)
        sw	s3,8(sp)
        sw	ra,12(sp)
        
        
        addi    s2, x0, 11      # i = 11
        addi    s3, x0, '0'
      
loop:   
        andi    t0, a0, 7
        add     t0, s3, t0

        addi    s2, s2, -1
                
        add     t1, s1, s2      # addr of buf[i]
        sb      t0, 0(t1)
        
        srli    a0, a0, 3
        
        bne     s2, x0, loop
        # End of the loop

        sb      x0, 11(s1)      # set the null

        # TODO
        #       print the string
        #       free storage allocated for buf
        #       restore saved registers and sp
        
        add	a0,s1,x0
        jal	ra,puts
        lw	s1,0(sp)
        lw	s2,4(sp)
        lw	s3,8(sp)
        lw	ra,12(sp)
        addi	sp,sp,16
        
        jr      ra