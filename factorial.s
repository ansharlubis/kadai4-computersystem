	.text
main:
	li $v0, 5 
	syscall 
	move $t0, $v0 

	addi $sp, $sp, -8
	sw $ra, 0($sp)				# save return address
	sw $t0, 4($sp)				# save initial n
	jal fact

	li $v0, 1
	move $a0, $t3
	syscall
	lw $ra, 0($sp)
	addi $sp, $sp, 8
	jr $ra

fact:
	lw $t1, 4($sp)
	lw $t3, 4($sp)
	beq $t1, $zero, zero

notzero:	
	addi $t1, $t1, -1
	beq $t1, $zero, end
	mul $t3, $t3, $t1
	j notzero

end:
	jr $ra

zero:
	li $t3, 1
	jr $ra


