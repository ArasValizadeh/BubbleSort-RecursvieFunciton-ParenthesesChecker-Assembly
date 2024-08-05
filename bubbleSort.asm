.data
array : .space 256 
newline : .asciiz  " \0"
test : .asciiz "-\0"
.text 
main : 
	li $v0 , 5
	syscall 
	move $s0 , $v0  # n
	li $t0 , 0 # i
	la $t1 , array 
inputloop :
	beq $t0 , $s0 , endinputloop
	sll $t3 , $t0 , 2 
	add $t2 , $t1 , $t3
	li $v0 , 5 
	syscall 
	sw $v0 , 0($t2)
	addi $t0 , $t0 , 1 
	j inputloop 
	
endinputloop :
	li $t0 , 0 #i
	la $t1 , array
	addi $t2 , $s0 , -1 # n-1
	
outerloop:
	beq $t0 , $t2 , endouterloop # i < n-1
	li $t3 , 0 # j = 0 
	sub $t4 , $t2 , $t0 # t4 = (n-1) - i
	
innerloop:
	beq $t3 , $t4 , endinnerloop
	
	add $t5 , $t3 , $zero
	sll $t5 , $t5 , 2 # j << 2
	add $t5 , $t5 , $t1 # add j with base address of array
	lw $t6 , 0($t5)
	lw $t7 , 4($t5)
	
	
	bge $t7 , $t6 , smaller
	sw $t6 , 4($t5)
	sw $t7 , 0($t5)
smaller:
	addi $t3 , $t3 , 1 # j++
	j innerloop
endinnerloop:
	addi $t0 , $t0 , 1 # i++
	j outerloop
endouterloop:
	li $t0 , 0
	la $t1 , array
printloop :	
	beq $t0 , $s0 , end
	sll $t3 , $t0 , 2 
	
	add $t2 , $t1 , $t3
	lw $a0 , 0($t2)
	li $v0 , 1
	syscall 
	
	li $v0 , 4 
	la $a0 , newline
	syscall
	
	
	addi $t0 , $t0 , 1 
	j printloop
end:
	li $v0, 10             
    	syscall
	
