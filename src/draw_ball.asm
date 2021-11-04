# Authors: Miriam Penger, Lena Gerken, Tina Hoeflich

# Draws the ball of the pong game using the draw_circle function.
# Note: This only acts as an init function on startup.

draw_ball:
#----Inputs:----
# a1: x coordinate of center
# a2: y coordinate of center
	
	#Save all necessary values to the stack
	addi sp, sp, -12
	sw ra, (sp)
	sw a1, 4 (sp)
	sw a2, 8 (sp)

	# calc start & end point
	addi a3, a1, -3	# x = a1 - radius // left boundary of rectangle
	addi a4, a2, -3
	addi a5, a1, 3
	addi a6, a2, 3
	li a7, 0xffffff
	jal draw_rectangle
	
	
	#Restore and jump back
	lw ra, 0 (sp)
	lw a1, 4 (sp)
	lw a2, 8 (sp)
	addi sp, sp, 12
	ret
	

li a7, 10
ecall

#.include "draw_rectangle.asm"