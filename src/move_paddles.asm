# Authors: Miriam Penger, Lena Gerken, Tina Hoeflich
# Based on CESP lecture

# Moves paddles according to keyboard inputs.
# 'w' and 's' for up/down movement of left paddle
# 'o' and 'l' for up/down movement of right paddle

# Inputs:
# a4: highest y-coordinate reached by the paddle on the left
# a6: highest y-coordinate reached by the paddle on the right

# Using:
# a3: x0 - left boundary of rectangle
# a4: y0 - top boundary of rectangle
# a5: x1 - right boundary of rectangle
# a6: y1 - bottom boundary of rectangle
# a7: fill color of rectangle as RGB value

# Returns:
# a3: highest y-coordinate reached by the paddle on the left
# a4: lowest y-coordinate reached by the paddle on the left
# a5: highest y-coordinate reached by the paddle on the right
# a6: lowest y-coordinate reached by the paddle on the right

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
			
			li t2, LEFT_PADDLE_BOUNDARY
			mv a3, t2	# set left boundary
					# a4 is already set through input value
			li t3, PADDLE_WIDTH
			add t4, t2, t3
			mv a5, t4	# set right boundary
			li t2, PADDLE_HEIGHT
			add a6, a4, t2	# set bottom boundary

			# draw white section on top
			mv a6, a4
			li t3, PADDLE_MOVEMENT_SPEED
			sub a4, a4, t3
			li a7, 0xffffff
			jal draw_rectangle

			# draw black section underneath
			li t2, PADDLE_HEIGHT
			add a4, a4, t2
			add a6, a6, t2
			li a7, 0x000000
			jal draw_rectangle

			# update initial a4 and a6 values
			li t2, PADDLE_HEIGHT
			sub a4, a4, t2
			lw a6, 8 (sp)	# stays the same as it was not moved

			beq zero, zero switch.end_paddles
		# left paddle down
		switch.s:
			li t1, 's'
			bne t0, t1 switch.o
			li t3, DISPLAY_HEIGHT
			li t4, PADDLE_HEIGHT
			sub t2, t3, t4	# subtract paddle height as only top y-coordinate is known for bottom impact collision detection
			bge a4, t2, switch.end_paddles	# won't move left paddle beyond the bottom screen boundaries

			li t2, LEFT_PADDLE_BOUNDARY
			mv a3, t2	# set left boundary
					# a4 is already set through input value
			li t3, PADDLE_WIDTH
			add t5, t2, t3
			mv a5, t5	# set right boundary
			add a6, a4, t4	# set bottom boundary

			# draw white section underneath
			add a4, a4, t4
			li t5, PADDLE_MOVEMENT_SPEED
			add a6, a6, t5
			li a7, 0xffffff
			jal draw_rectangle

			# draw black section on top
			li t4, PADDLE_HEIGHT
			sub a4, a4, t4
			sub a6, a6, t4
			li a7, 0x000000
			jal draw_rectangle

			# update initial a4 and a6 values
			li t5, PADDLE_MOVEMENT_SPEED
			add a4, a4, t5
			lw a6, 8 (sp)	# stays the same as it was not moved

			beq zero, zero switch.end_paddles
		# right paddle up
		switch.o:
			li t1, 'o'
			bne t0, t1 switch.l
			ble a6, zero, switch.end_paddles	# won't move right paddle beyond the top screen boundaries

			li t2, RIGHT_PADDLE_BOUNDARY
			mv a3, t2	# set left boundary
			mv a4, a6	# a4 is already set through input value a6
			li t3, PADDLE_WIDTH
			add t4, t2, t3
			mv a5, t4	# set right boundary
			li t2, PADDLE_HEIGHT
			add a6, a4, t2	# set bottom boundary

			# draw white section on top
			mv a6, a4
			li t3, PADDLE_MOVEMENT_SPEED
			sub a4, a4, t3
			li a7, 0xffffff
			jal draw_rectangle

			# draw black section underneath
			li t2, PADDLE_HEIGHT
			add a4, a4, t2
			add a6, a6, t2
			li a7, 0x000000
			jal draw_rectangle

			# update initial a4 and a6 values
			li t2, PADDLE_HEIGHT
			sub a6, a4, t2
			lw a4, 4 (sp)	# stays the same as it was not moved
			
			beq zero, zero switch.end_paddles
		# right paddle down
		switch.l:
			li t1, 'l'
			bne t0, t1 switch.end_paddles
			li t3, DISPLAY_HEIGHT
			li t4, PADDLE_HEIGHT
			sub t2, t3, t4	# subtract paddle height of 30 as only top y-coordinate is known for bottom impact collision detection
			bge a6, t2, switch.end_paddles	# won't move right paddle beyond the bottom screen boundaries

			li t2, RIGHT_PADDLE_BOUNDARY
			mv a3, t2	# set left boundary
			mv a4, a6	# a4 is already set through input value a6
			li t3, PADDLE_WIDTH
			add t5, t2, t3
			mv a5, t5	# set right boundary
			add a6, a4, t4	# set bottom boundary

			# draw white section underneath
			add a4, a4, t4
			li t5, PADDLE_MOVEMENT_SPEED
			add a6, a6, t5
			li a7, 0xffffff
			jal draw_rectangle

			# draw black section on top
			li t4, PADDLE_HEIGHT
			sub a4, a4, t4
			sub a6, a6, t4
			li a7, 0x000000
			jal draw_rectangle

			# update initial a4 and a6 values
			lw a4, 4 (sp)	# stays the same as it was not moved
					# a6 is already correct

			beq zero, zero switch.end_paddles
	switch.end_paddles:
		li t2, PADDLE_HEIGHT
		mv a3, a4	# highest y-coordinate reached by the paddle on the left
		add a4, a3, t2	# lowest y-coordinate reached by the paddle on the left
		mv a5, a6	# highest y-coordinate reached by the paddle on the right
		add a6, a5, t2	# lowest y-coordinate reached by the paddle on the right 
		
		lw ra, 0 (sp)
		addi sp, sp, 12

		ret
