foo:
	addi	sp,sp,-20 #Allocate space 
	sw	s1,0(sp)
	sw	s2,4(sp)
	sw	s3,8(sp)
	sw	s4,12(sp)
	sw	ra,16(sp)
	
	addi	s1,s1,0 #s1 = sum = 0
	addi	s2,s2,0 #s2 = i = 0
	addi	s3,s3,0 #s3 = d address = ? 
	addi	s4,s4,100 #s4 = n = ? 
	
loop:	
	slli	a0,s2,2 #offset of i
	add	a0,a0,s3 #&d[i]
	sub	a1,s4,s2 #n-i
	jal	ra,bar #bar(&d[i],n-i)
	
	add	s1,s1,a0 #sum += output of bar(&d[i],n-i)
	
	addi	s2,s2,1 #i+=1
	blt	s2,s4,loop #if i < n

return:
	addi	a0,s1,0 #foo returns sum so into a0

	#restore all
	lw	s1,0(sp)
	lw	s2,4(sp)
	lw	s3,8(sp)
	lw	s4,12(sp)
	lw	ra,16(sp)
	
	addi	sp,sp,20
	
	jr ra
	
	 