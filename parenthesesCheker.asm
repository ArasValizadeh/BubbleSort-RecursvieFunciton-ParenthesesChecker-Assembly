	.data
buffer: .space 256 
prompt : .asciiz  "enter your parentheses\n\0"
Yes : .asciiz  "Yes\0"
No : .asciiz "No\0"
	.text
main:
    li $v0, 4
    la $a0, prompt
    syscall # print prmot
    li $v0, 8
    la $a0, buffer
    li $a1, 256 # maximum string that you can read
    syscall # get input
    li $s0 , 0 #counter
    la $t0 , buffer #get the address of buffer
    addi $t1 , $t0 , 256
loop :   
    beq $t0 , $t1  , endmain 
    lb $t2 , 0($t0) 
    bne $t2 , '(' , open
    addi $s0 , $s0 , 1
    open:
    bne $t2 , ')' , close
    addi $s0 ,$s0 , -1
    close:
    bltz $s0 , endmain
    addi $t0 , $t0 , 1
    j loop
endmain :
    beqz $s0 , printYes
    li $v0, 4
    la $a0, No
    syscall # print No
    j end
printYes : 
    li $v0, 4
    la $a0, Yes
    syscall # print Yes
    
end : 
    li $v0, 10             
    syscall 
    
    
