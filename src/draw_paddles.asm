# Authors: Miriam Penger, Lena Gerken, Tina Hoeflich

# Draws both paddles using the draw_rectangle function.
# This only acts as an init function on startup.
# Looped movement via keyboard is done in move_paddles.asm

# Returns:
# a4: highest y-coordinate reached by the paddle on the left
# a6: highest y-coordinate reached by the paddle on the right

draw_paddles:
	
	# Save all necessary values to the stack
	addi sp, sp, -4
	sw ra, (sp)
	
	# initial setup of rectangle coordinates
	# left paddle
	li t0, LEFT_PADDLE_BOUNDARY			
	mv a3, t0		# rectangle x0 = 18
	li t3, TOP_PADDLE_BOUNDARY
	mv a4, t3		# rectangle y0 = 50
	li t1, PADDLE_WIDTH
	add t2, t0, t1
	mv a5, t2		# rectangle x1 = 23 (18 + 5)
	li t2, PADDLE_HEIGHT
	add t3, a4, t2
	mv a6, t3		# rectangle y1 = 80 (50 + 30)
	li a7, 0xffffff		# color: white
	jal draw_rectangle
	
	# right paddle
	li t0, RIGHT_PADDLE_BOUNDARY
	mv a3, t0		# rectangle x0 = 233
	li t3, TOP_PADDLE_BOUNDARY
	mv a4, t3		# rectangle y0 = 50
	li t1, PADDLE_WIDTH
	add t2, t0, t1
	mv a5, t2		# rectangle x1 = 238 (233 + 5)
	li t2, PADDLE_HEIGHT
	add t3, a4, t2
	mv a6, t3		# rectangle y1 = 80 (50 + 30)
	li a7, 0xffffff		# color: white
	jal draw_rectangle
		
	# restore and jump back
	li t3, TOP_PADDLE_BOUNDARY
	mv a4, t3	# returns highest y-coordinate reached by the paddle on the left
	mv a6, t3	# returns highest y-coordinate reached by the paddle on the right
	lw ra, 0 (sp)
	addi sp, sp, 4
	ret
	

li a7, 10
ecall