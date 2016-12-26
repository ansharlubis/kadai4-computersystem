	.text
main:
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	li $t3, 0		 			# initial sum

	# ambil jumlah elemen
	li $v0, 5
	syscall
	move $t0, $v0
	move $a0, $t0
	beq $a0, $zero, end

	sw $t0, 4($sp)	 			# simpan jumlah elemen
	jal create_array
	j end

create_array:
	sll $t0, $t0, 2	 			# ukuran memori yang diperlukan = jumlah elemen * 4
	
	# dapat alamat baru untuk ukuran jumlah elemen * 4
	li $v0, 9		 
	move $a0, $t0
	syscall

	move $t0, $v0    			# alamat baru $v0
	sw $t0, 8($sp)	 			# simpan alamat ujung 
	lw $a1, 4($sp)   			# jumlah elemen
		
read_int:
	li $v0, 5		 			# ambil isi array
	syscall
	move $a0, $v0
	sw $a0, 0($t0)	 			# masukin ke alamat
	addi $a1, $a1, -1			# kurangi jumlah elemen yang perlu dimasukin
	beq $a1, $zero, calc_sum	# kalo udah 0, bisa hitung jumlah
	addi $t0, $t0, 4
	j read_int					# ambil elemen selanjutnya

calc_sum:
	lw $t0, 8($sp)				# ambil alamat ujung
	lw $a1, 4($sp)				# ambil jumlah elemen
sum:
	lw $t1, 0($t0)				# ambil elemen dari alamat yang ditentukan
	add $t3, $t3, $t1
	addi $a1, $a1, -1
	beq $a1, $zero, end
	addi $t0, $t0, 4
	j sum

end:
	# tulis hasil sum
	li $v0, 1
	move $a0, $t3
	syscall

	# beresin stack
	lw $ra, 0($sp)
	addi $sp, $sp, 8
	jr $ra


