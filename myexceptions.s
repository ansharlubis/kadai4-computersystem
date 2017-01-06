	.ktext 0x80000180
	# obtaining the exception code from Cause register
	mfc0 $k0, $13				
	srl $k0, $k0, 2				
	andi $k0, $k0, 0x1f			

	# checking whether the exception code is not equal with 13
	li $k1, 13					
	bne $k0, $k1, done			

	# checking whether the system call number is equal with 100
	li $k1, 100
	beq $v0, $k1, done			

	# multiply the value in $a0 by 10
	li $k1, 10 					
	mul $a0, $a0, $k1
	move $v0, $a0

done:
	mfc0 $k0, $14
	addi $k0, $k0, 4
	mtc0 $k0, $14
	eret

	.text
	.globl _start

_start:
	jal main

	li $v0, 10
	syscall