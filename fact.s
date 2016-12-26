	.text
main:
	li $t0, 5
	beq $t0, $zero, zero
	move $t3, $t0			# t3 for result
	
notzero:
	addi $t0, $t0, -1
	beq $t0, $zero, end
	mul $t3, $t3, $t0
	j notzero

zero:
	li $t3, 1				# t3 for result

end:
	li $v0, 1
	move $a0, $t3
	syscall
	jr $ra
