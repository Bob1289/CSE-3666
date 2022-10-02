merge inputs in (c[], d1[], n1, d2[], n2)
copy inputs in (d[], c[], n)

# Inputs in d[] and int n
msort:
	addi	sp,sp,-1036 #allocate space for variables
	
	sw	ra,1032(sp)
	sw	s2,1028(sp)
	sw	s1,1024(sp) 
	
	addi	s1,a0,0 #Save D[] to s1
	addi	s2,a1,0 #Save n to s2
	
	addi	t0,t0,2 # t0 = 2 for if statement
	blt		a1,t0,exit # return if n < 2

	srai	t1,s2,1 # n1 = n/2
	addi	a1,t1,0 # a1 = n1
	jal		ra,msort  # call msort(d,n1)
	
	slli	t3,t1,2 #t3 = n1 * 4
	add		a0,t3,s1 #n1 + d address = address of d[n1] = a0
	sub		a1,s2,t1 #n-n1 = a1
	jal		ra,msort  # call msort(&d[n1], n – n1)
	
	addi	a0,sp,0 #c
	addi	a1,s1,0 #d
	addi	a2,t1,0 #n1
	add		a3,t3,s1 #n1 + d address = address of d[n1] = a3
	sub		a4,s2,t1 #n-n1 = a4
	jal		ra,merge #merge(c, d, n1, &d[n1], n – n1)
	
	addi	a0,s1,0 #d
	addi	a1,sp,0 #c
	addi	a2,s2,0 #n
	jal		ra,copy #copy(d, c, n)
	
exit:
	#restore registers
	lw		s1,1024(sp) 
	lw		s2,1028(sp)
	lw		ra,1032(sp)
	
	addi	sp,sp,1036 
	
	jr ra
	
