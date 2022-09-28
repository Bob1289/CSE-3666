merge: (c[], d1[], n1, d2[], n2)
copy(d[], c[], n)

# Intake d[] and n
msort:
	addi	sp,sp,-1036 
	
	sw	s1,1024(sp) 
	sw	s2,1028(sp)
	sw	ra,1032(sp)
	
	addi	s1,a0,0 #Save D[] to s1
	addi	s2,a1,0 #Save n
	
	addi	t0,t0,2 # t0 = 2 
	
	blt	a1,t0,exit # return if n < 2
	
	srai	t1,s2,1 # a1 = n1 = n/2
	addi	a1,t1,0
	jal	ra,msort  # call msort(d,n1)
	
	slli	t3,t1,2 #Shift n1
	add	t3,t3,s1 #Address of d[n1]
	add	a0,t3,0
	sub	t4,s2,t1 #n-n1
	addi	a1,t4,0
	jal	ra,msort  # call msort(&d[n1], n – n1)
	
	addi	a0,sp,0 #c
	addi	a1,s1,0 #d
	addi	a2,t1,0 #n1
	addi	a3,t3,0 #&d[n1]
	addi	a4,t4,0 #n-n1
	jal	ra,merge
	
	addi	a0,s1,0 #d
	addi	a1,sp,0 #c
	addi	a2,s2,0 #n
	jal	ra,copy
	
exit:
	lw	s1,1024(sp) 
	lw	s2,1028(sp)
	lw	ra,1032(sp)
	
	addi	sp,sp,1036 
	
	jr ra
	
