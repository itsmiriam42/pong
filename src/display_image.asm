#Function to display a picture on the bitmap display
# gets:
# - 
# returns:
# - 
# !!! Function calls uses paths to load the pictures that are displayed on the screen !!!
# !!! individual pathnames have to be added !!! 
.data

.eqv max_read 400000
.eqv BMP_BUFFER 0x10070000

# Paths where images are stored
bmp_filename_winner_l: .string "C:/rars_programming_project/pong-main/src/winner_left.bmp"
bmp_filename_start: .string "C:/rars_programming_project/pong-main/src/startbildschirm.bmp"
bmp_filename_winner_r: .string "C:/rars_programming_project/pong-main/src/winner_right.bmp"
bmp_filename_reset_screen: .string "C:/rars_programming_project/pong-main/src/reset_screen.bmp"


.text
# Display image saying "Right Player wins"
win_image_right:
addi sp, sp ,-4
sw ra, 0(sp)
la a1, bmp_filename_winner_r
li a2, BMP_BUFFER
li a3, DISPLAY_ADDRESS

jal load_bmp
lw ra, 0(sp)
addi sp, sp 4
ret

# Display image saying "Left Player wins"
win_image_left:
addi sp, sp,-4
sw ra, 0(sp)
la a1, bmp_filename_winner_l
li a2, BMP_BUFFER
li a3, DISPLAY_ADDRESS

jal load_bmp
lw ra, 0(sp)
addi sp, sp 4
ret

# Display image saying "Pong - press space to start"
start_image:
addi sp, sp ,-4
sw ra, 0(sp)
la a1, bmp_filename_start
li a2, BMP_BUFFER
li a3, DISPLAY_ADDRESS

jal load_bmp
lw ra, 0(sp)
addi sp, sp 4
ret

#Function that loads a .bmp image 
load_bmp:
	#input
	#	a1 : pointer to string of filename
	#	a2 : address of buffer where bmp data is stored
	#	a3 : address to display buffer
	
	
	#intermediate
	#	s0: address of image buffer
	#	s1: image size in bytes
	#	s2: bitmap offset
	#       s3: pointer to string of filename
	#	s4: image width
	#       s5: image height
	#       s6: filehandle
	
	addi sp, sp, -32
	sw s0, 0x0 (sp)
	sw s1, 0x4 (sp)
	sw s2, 0x8 (sp)
	sw s3, 0xc (sp)
	sw s4, 0x10 (sp)
	sw s5, 0x14 (sp)	
	sw s6, 0x18 (sp)	
	sw ra, 0x1c (sp)	

	mv s0, a2
	mv s3, a1
	mv gp, s0


	# Open file handle for reading
	li a7, 1024
	mv a0, s3
	add a1, zero, zero
	ecall             


	li a7, 63
	# a0 = file name 
	add a1, zero, a2 # set buffer to a1
	li a2, max_read
	ecall
	
	# Get image width
	lh s4, 18(a1) # image width
		
	# Get image height
	lh s5, 22(a1) # image height

	# copy image
	# t0: src pointer
	# t1: dst pointer
	# t3: width counter
	# t4: height counter
	# t5: display width 
	# t6: distance in bytes between end of row and next row in destination buffer : 4 *(DISPLAY_WIDTH - image_width)

	#Copy the image from IMAGE_BUFFER to DISPLAY_ADDRESS
	add t0, a1, a0 # src = BMP_BUFFER + IMAGE_SIZE (die kommt aus dem read ecall)
	add t1, zero, a3 # dst = DISPLAY_ADDRESS
	li t3, 4 # hilfswert für multiplikation mit 4
	mv t4, s5 # outer for-loop zählt rückwärts
	li t5, 512 # sollte display width sein (256), keine ahnung wieso 1024
	
	li t6, DISPLAY_WIDTH # diese und die nächsten 2 Zeilen machen: 4 *(DISPLAY_WIDTH - image_width)
	sub t6, t6, s4
	mul t6, t6, t3
	
	
	sub t0, t0, t5 # go back by 1 row
	sub t0, t0, t5 # go back by 1 row
	sub t0, t0, t5 # go back by 1 row
	sub t0, t0, t5 # go back by 1 row
	loop_y:
		mv t3, s4 # inner for-loop zählvariable zählt rückwärts von image width
		loop_x:
		         # Use read_word_unaligned to read a pixel, then update the pixel format
		         add a1, zero, t0
		         jal read_word_unaligned # der Wert an adresse a1 ist unaligned und wird in a0 gespeichert
		         srli a0, a0, 8 # convert RGBA to RGB
		         sw a0, (t1) # send value to display
		         
		         addi t0, t0, 4 # src +=4 - don't ask me why + and not -
		         addi t1, t1, 4 # dst +=4
		         
		         addi t3, t3, -1 # innere zählvariable veringern
		         bnez t3, loop_x
		sub t0, t0, t5 # go back by 1 row
		sub t0, t0, t5 # go back by 1 row
		sub t0, t0, t5 # go back by 1 row
		sub t0, t0, t5 # go back by 1 row
		add t1, t1, t6 # t6 = 4? (DISPLAY_WIDTH ? image_width);
		
		addi t4, t4, -1 # äußere Zählvariable veringern
		bnez t4, loop_y
		
	lw s0, 0x0 (sp)
	lw s1, 0x4 (sp)
	lw s2, 0x8 (sp)
	lw s3, 0xc (sp)
	lw s4, 0x10 (sp)
	lw s5, 0x14 (sp)	
	lw s6, 0x18 (sp)	
	lw ra, 0x1c (sp)
	addi sp, sp, 32	

	ret
		
	  


