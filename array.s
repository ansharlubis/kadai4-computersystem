	.text
main:
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	li $t3, 0		 			# initial sum

	# take length of array
	li $v0, 5
	syscall
	move $t0, $v0
	move $a0, $t0
	beq $a0, $zero, end

	sw $t0, 4($sp)	 			# store length of array
	jal create_array
	j end

create_array:
	sll $t0, $t0, 2	 			# necessary memory = length of array*4
	
	# get address for the array
	li $v0, 9		 
	move $a0, $t0
	syscall

	move $t0, $v0    			# copy the new address to $t0
	sw $t0, 8($sp)	 			# store the address of the first element
	lw $a1, 4($sp)   			# load the length of array
		
read_int:
	li $v0, 5		 			# read integer input from user
	syscall
	move $a0, $v0
	sw $a0, 0($t0)	 			# store into the address
	addi $a1, $a1, -1			# decrease the remaining amount of element
	beq $a1, $zero, calc_sum	# if 0, jump to calc_sum to do the summation
	addi $t0, $t0, 4
	j read_int					# read next input

calc_sum:
	lw $t0, 8($sp)				# load the address of the first element of the array
	lw $a1, 4($sp)				# load the length of array
sum:
	lw $t1, 0($t0)				# load element from the specified address
	add $t3, $t3, $t1
	addi $a1, $a1, -1
	beq $a1, $zero, end
	addi $t0, $t0, 4
	j sum

end:
	# display the sum
	li $v0, 1
	move $a0, $t3
	syscall

	# restore stack
	lw $ra, 0($sp)
	addi $sp, $sp, 8
	jr $ra


