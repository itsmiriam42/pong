# Based on CESP lecture
# Authors: Miriam Penger, Lena Gerken, Tina Hoeflich

# Inputs:
# a4: highest y coordinate reached by the paddle on the left
# a6: highest y coordinate reached by the paddle on the right

# using:
# a3: x0 - left boundary of rectangle
# a4: y0 - top boundary of rectangle
# a5: x1 - right boundary of rectangle
# a6: y1 - bottom boundary of rectangle
# a7: fill color of rectangle as RGB value

# returns:
# a3: highest y coordinate reached by the paddle on the left
# a4: lowest y coordinate reached by the paddle on the left
# a5: highest y coordinate reached by the paddle on the right
# a6: lowest y coordinate reached by the paddle on the right

# TODO: remove loop and sleep

j move_paddles
#.include "draw_rectangle.asm"

.text

move_paddles:

	# allocate memory for x0-y1 + color variable
	addi sp, sp, -12
	sw ra, 0 (sp)
	sw a4, 4 (sp)
	sw a6, 8 (sp)
	#sw a3,  0 (sp)
	#sw a4,  4 (sp)
	#sw a5,  8 (sp)
	#sw a6, 12 (sp)
	#sw a7, 16 (sp)
	#sw ra, 20 (sp)

	li s0, KEYBOARD_ADDDRESS
	#move_paddles.loop:
		lw a4, 4 (sp)
		lw a6, 8 (sp)

		lw t0, (s0)
		beq t0, zero switch.end_paddles
		lw t0, 4(s0)
		switch.start_paddles:
			# left paddle up
			switch.w:
				li t1, 'w'
				bne t0, t1 switch.s

				li a3, 18		# set left boundary
				# a4 is already set through input value
				li a5, 23		# set right boundary
				addi a6, a4, 30	# set bottom boundary

				# draw white section on top
				add a6, a4, zero
				addi a4, a4, -3
				li a7, 0xffffff
				jal draw_rectangle

				# draw black section underneath
				addi a4, a4, 30
				addi a6, a6, 30
				li a7, 0x000000
				jal draw_rectangle

				# update initial a4 and a6 values
				addi a4, a4, -30
				lw a6, 8 (sp)	# stays the same as it was not moved

				beq zero, zero switch.end_paddles
			# left paddle down
			switch.s:
				li t1, 's'
				bne t0, t1 switch.num8

				li a3, 18		# set left boundary
				# a4 is already set through input value
				li a5, 23		# set right boundary
				addi a6, a4, 30	# set bottom boundary

				# draw white section underneath
				addi a4, a4, 30
				addi a6, a6, 3
				li a7, 0xffffff
				jal draw_rectangle

				# draw black section on top
				addi a4, a4, -30
				addi a6, a6, -30
				li a7, 0x000000
				jal draw_rectangle

				# update initial a4 and a6 values
				addi a4, a4, 3
				lw a6, 8 (sp)	# stays the same as it was not moved

				beq zero, zero switch.end_paddles
			# right paddle up (num block)
			switch.num8:
				li t1, '8'
				bne t0, t1 switch.num2

				li a3, 233		# set left boundary
				mv a4, a6		# a4 is already set through input value a6
				li a5, 238		# set right boundary
				addi a6, a4, 30	# set bottom boundary

				# draw white section on top
				add a6, a4, zero
				addi a4, a4, -3
				li a7, 0xffffff
				jal draw_rectangle

				# draw black section underneath
				addi a4, a4, 30
				addi a6, a6, 30
				li a7, 0x000000
				jal draw_rectangle

				# update initial a4 and a6 values
				lw a4, 4 (sp)	# stays the same as it was not moved
				addi a6, a6, -30
				
				beq zero, zero switch.end_paddles
			# right paddle down (num block)
			switch.num2:
				li t1, '2'
				bne t0, t1 switch.end_paddles

				li a3, 233		# set left boundary
				mv a4, a6		# a4 is already set through input value a6
				li a5, 238		# set right boundary
				addi a6, a4, 30	# set bottom boundary

				# draw white section underneath
				addi a4, a4, 30
				addi a6, a6, 3
				li a7, 0xffffff
				jal draw_rectangle

				# draw black section on top
				addi a4, a4, -30
				addi a6, a6, -30
				li a7, 0x000000
				jal draw_rectangle

				# update initial a4 and a6 values
				lw a4, 4 (sp)	# stays the same as it was not moved
				addi a6, a6, 3

				beq zero, zero switch.end_paddles
		switch.end_paddles:
			#Store changed variables
			#sw a4, 4 (sp)
			#sw a6, 8 (sp)
			

		# clear key vector
		#sw zero, (s0)

		#STEP x : Sleep 20 ms 
		#li a0, 20
		#jal cesp_sleep

		#j move_paddles.loop
	mv a3, a4		# highest y coordinate reached by the paddle on the left
	addi a4, a3, 30	# lowest y coordinate reached by the paddle on the left
	mv a5, a6		# highest y coordinate reached by the paddle on the right
	addi a6, a5, 30	# lowest y coordinate reached by the paddle on the right 
	
	lw ra, 0 (sp)
	addi sp, sp, 12

	ret
