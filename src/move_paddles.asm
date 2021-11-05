# Based on CESP lecture
# Authors: Miriam Penger, Lena Gerken, Tina Hoeflich

# Moves paddles according to keyboard inputs.
# 'w' and 's' for up/down movement of left paddle
# '8' and '2' (num block) for up/down movement of right paddle

# Inputs:
# a4: highest y coordinate reached by the paddle on the left
# a6: highest y coordinate reached by the paddle on the right

# Using:
# a3: x0 - left boundary of rectangle
# a4: y0 - top boundary of rectangle
# a5: x1 - right boundary of rectangle
# a6: y1 - bottom boundary of rectangle
# a7: fill color of rectangle as RGB value

# Returns:
# a3: highest y coordinate reached by the paddle on the left
# a4: lowest y coordinate reached by the paddle on the left
# a5: highest y coordinate reached by the paddle on the right
# a6: lowest y coordinate reached by the paddle on the right

j move_paddles

.text

move_paddles:

	# allocate memory for a4 and a6 input values
	addi sp, sp, -12
	sw ra, 0 (sp)
	sw a4, 4 (sp)
	sw a6, 8 (sp)

	li s0, KEYBOARD_ADDDRESS
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
			ble a4, zero, switch.end_paddles	# won't move left paddle beyond the top screen boundaries
			
			li a3, 18	# set left boundary
					# a4 is already set through input value
			li a5, 23	# set right boundary
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
			li t3, DISPLAY_HEIGHT
			addi t2, t3, -30	# subtract paddle length of 30 as only top y coordinate is known for bottom impact collision detection
			bge a4, t2, switch.end_paddles	# won't move left paddle beyond the bottom screen boundaries

			li a3, 18	# set left boundary
					# a4 is already set through input value
			li a5, 23	# set right boundary
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
			ble a6, zero, switch.end_paddles	# won't move right paddle beyond the top screen boundaries

			li a3, 233	# set left boundary
			mv a4, a6	# a4 is already set through input value a6
			li a5, 238	# set right boundary
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
			addi a6, a4, -30
			lw a4, 4 (sp)	# stays the same as it was not moved
			
			beq zero, zero switch.end_paddles
		# right paddle down (num block)
		switch.num2:
			li t1, '2'
			bne t0, t1 switch.end_paddles
			li t3, DISPLAY_HEIGHT
			addi t2, t3, -30	# subtract paddle length of 30 as only top y coordinate is known for bottom impact collision detection
			bge a6, t2, switch.end_paddles	# won't move right paddle beyond the bottom screen boundaries

			li a3, 233	# set left boundary
			mv a4, a6	# a4 is already set through input value a6
			li a5, 238	# set right boundary
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
					# a6 is already correct

			beq zero, zero switch.end_paddles
	switch.end_paddles:
		mv a3, a4	# highest y coordinate reached by the paddle on the left
		addi a4, a3, 30	# lowest y coordinate reached by the paddle on the left
		mv a5, a6	# highest y coordinate reached by the paddle on the right
		addi a6, a5, 30	# lowest y coordinate reached by the paddle on the right 
		
		lw ra, 0 (sp)
		addi sp, sp, 12

		ret
