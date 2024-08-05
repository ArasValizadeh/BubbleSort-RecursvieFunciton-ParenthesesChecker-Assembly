	.data
	.text
main:
	li $s0 , 0 # res = 0
	li $v0, 5 # getting n
	syscall
    	move $s1, $v0 # set n
    	addi $a1 , $s1 , 0 #passing n to a1
    	li $a0 , 1
    	li $a2 , 1 
    	
    	jal func # calling function ans save return address
    	
    	li $v0, 1
	move $a0 , $s0 # print res
    	syscall 
    	li $v0, 10  # finishing programme
    	syscall     	
func:
	# saving argumants in S2,S3,S4 
	move $s2 , $a0  # i
	move $s3 , $a1  # n
	move $s4 , $a2  # index
	addi $s5 ,$s2 , 0 # j = i
	bnez $s3 , loop # while n not equal to zero
		addi $s0 , $s0 , 1 # if n == 0 res ++
	loop:
		bgt $s5 , $s3 , endfunc # if j > n endfunction
		add $a0 , $zero , $s5 # a0 = j
		sub $a1 , $s3 , $s5 # a1 = n - j
		addi $a2 , $s4 , 1 # a2 = index + 1
		
		sub $sp,$sp,4 # allocating space in stack
		sw $s5,($sp)
	
		sub $sp,$sp,4
		sw $s2,($sp)
		
		sub $sp,$sp,4
		sw $s3,($sp)
		
		sub $sp,$sp,4
		sw $s4,($sp)
		
		sub $sp,$sp,4
		sw $ra,($sp)
		
		jal func
		
		lw $ra,($sp)
		addiu $sp,$sp,4
    		
    		lw $s4,($sp)
		addiu $sp,$sp,4
    		
    		lw $s3,($sp)
		addiu $sp,$sp,4
    		
    		lw $s2,($sp)
		addiu $sp,$sp,4
    		
    		lw $s5,($sp)
		addiu $sp,$sp,4
    		
    		addi $s5 , $s5 , 1
    		j loop
	endfunc:
		jr $ra
