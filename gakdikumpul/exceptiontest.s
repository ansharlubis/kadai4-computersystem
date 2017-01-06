	.text
main:
	li $v0, 100
	li $a0, 55
	teq $zero, $zero

	move $a0, $v0
	li $v0, 1
	syscall

	jr $ra