# Authors: Miriam Penger, Lena Gerken, Tina Hoeflich

# Draws both paddles using the draw_rectangle function.
# Note: This only acts as an init function on startup.

# returns:
# a4: highest y coordinate reached by the paddle on the left
# a6: highest y coordinate reached by the paddle on the right

draw_paddles:
	
	# Save all necessary values to the stack
	addi sp, sp, -4
	sw ra, (sp)
	
	# initial setup of rectangle coordinates
	# left paddle
	li a3, 18	# rectangle x0
	li a4, 50	# rectangle y0
	li a5, 23	# rectangle x1
	li a6, 80	# rectangle y1
	li a7, 0xffffff	# color: white
	jal draw_rectangle
	
	# right paddle
	li a3, 233	# rectangle x0
	li a4, 50	# rectangle y0
	li a5, 238	# rectangle x1
	li a6, 80	# rectangle y1
	li a7, 0xffffff	# color: white
	jal draw_rectangle
		
	# Restore and jump back
	li a4, 50	# returns highest y coordinate reached by the paddle on the left
	li a6, 50	# returns highest y coordinate reached by the paddle on the right
	lw ra, 0 (sp)
	addi sp, sp, 4
	ret
	

li a7, 10
ecall

#.include "draw_rectangle.asm"
