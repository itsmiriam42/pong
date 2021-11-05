# Authors: Miriam Penger, Lena Gerken, Tina Hoeflich

# Moves the ball of the pong game using the draw_rectangle function.
# Only paints the pixel differences of old and new position after movement for more efficient performance.
# Paints two black rectangles to cover the sections of the ball that aren't needed anymore. only draws the overlapping corner part once, with the horizontal component.
# Paints two white rectangles to add the new sections to the ball. only draws the overlapping corner part once, with the horizontal component.
# Since the position of the rectangles depends on the general direction in which the ball is heading, there is a case for all 4 of them

move_ball:
#----Inputs:----
# a1: x coordinate of old point
# a2: y coordinate of old point
# a3: x coordinate of new point
# a4: y coordinate of new point	

	# Save all necessary values to the stack
	addi sp, sp, -20
	sw ra, (sp)
	sw a1, 4 (sp)
	sw a2, 8 (sp)
	sw a3, 12 (sp)
	sw a4, 16 (sp)	

	sub t0, a3, a1  # x-jumping-width
	sub t1, a4, a2  # y-jumping-height
	
	ble a1, a3, x_right
	ble a2, a4, y_down_1
	
	########## up and to the left ##########
	
	# black vertical rectangle
	addi t3, a3, 3		# x1 = x_new + 3
	addi t4, a2, -3		# y1 = y_old - 3
	addi t5, a1, 3		# x2 = x_old + 3
	addi t6, a2, 3		# y2 = y_old + 3
	
	# paint
	mv a3, t3
	mv a4, t4
	mv a5, t5
	mv a6, t6
	li a7, 0	# black
	#li a7, 0x0000ff	# blue FOR TESTING PURPOSES
	jal draw_rectangle	
	# Restore values
	lw a1, 4 (sp)
	lw a2, 8 (sp)
	lw a3, 12 (sp)
	lw a4, 16 (sp)

	# black horizontal rectangle	
	addi t3, a1, -3		# x1 = x_old - 3 
	addi t5, a3, 3		# x2 = x_new + 3
	addi t4, a4, 3		# y1 = y_new + 3
	addi t6, a2, 3		# y2 = y_old + 3
	
	# paint
	mv a3, t3
	mv a4, t4
	mv a5, t5
	mv a6, t6
	li a7, 0	# black
	#li a7, 0x0000ff	# blue FOR TESTING PURPOSES
	jal draw_rectangle	
	# Restore values
	lw a1, 4 (sp)
	lw a2, 8 (sp)
	lw a3, 12 (sp)
	lw a4, 16 (sp)
	
	# white vertical rectangle
	addi t3, a3, -3		# x1 = x_new - 3
	addi t5, a1, -3		# x2 = x_old - 3
	addi t4, a4, -3		# y1 = y_new - 3
	addi t6, a4, 3		# y2 = y_new + 3
	
	# paint white
	mv a3, t3
	mv a4, t4
	mv a5, t5
	mv a6, t6
	li a7, 0xffffff
	jal draw_rectangle
	# Restore values
	lw a1, 4 (sp)
	lw a2, 8 (sp)
	lw a3, 12 (sp)
	lw a4, 16 (sp)
	
	# white horizontal rectangle
	addi t3, a3, -3 	# x1 = x_new - 3
	addi t5, a3, 3		# x2 = x_new + 3.
	addi t4, a4, -3		# y1 = y_new - 3
	addi t6, a2, -3		# y2 = y_old - 3
	
	# paint white
	mv a3, t3
	mv a4, t4
	mv a5, t5
	mv a6, t6
	li a7, 0xffffff
	jal draw_rectangle
	# Restore values
	lw a1, 4 (sp)
	lw a2, 8 (sp)
	lw a3, 12 (sp)
	lw a4, 16 (sp)
	
	j end_case
	
	########## down and to the left ##########
	
	y_down_1:
			
	# black vertical rectangle
	addi t3, a3, 3		# x1 = x_new + 3
	addi t4, a2, -3		# y1 = y_old - 3
	addi t5, a1, 3		# x2 = x_old + 3
	addi t6, a2, 3		# y2 = y_old + 3
	
	# paint
	mv a3, t3
	mv a4, t4
	mv a5, t5
	mv a6, t6
	li a7, 0	# black
	#li a7, 0x0000ff	# blue FOR TESTING PURPOSES
	jal draw_rectangle	
	# Restore values
	lw a1, 4 (sp)
	lw a2, 8 (sp)
	lw a3, 12 (sp)
	lw a4, 16 (sp)

	# black horizontal rectangle	
	addi t3, a1, -3		# x1 = x_old - 3 
	addi t5, a3, 3		# x2 = x_new + 3
	addi t4, a2, -3		# y1 = y_old - 3
	addi t6, a4, -3		# y2 = y_new - 3
	
	# paint
	mv a3, t3
	mv a4, t4
	mv a5, t5
	mv a6, t6
	li a7, 0	# black
	#li a7, 0x0000ff	# blue FOR TESTING PURPOSES
	jal draw_rectangle	
	# Restore values
	lw a1, 4 (sp)
	lw a2, 8 (sp)
	lw a3, 12 (sp)
	lw a4, 16 (sp)
	
	# white vertical rectangle
	addi t3, a3, -3		# x1 = x_new - 3
	addi t5, a1, -3		# x2 = x_old - 3
	addi t4, a4, -3		# y1 = y_new - 3
	addi t6, a4, 3		# y2 = y_new + 3
	
	# paint white
	mv a3, t3
	mv a4, t4
	mv a5, t5
	mv a6, t6
	li a7, 0xffffff
	jal draw_rectangle
	# Restore values
	lw a1, 4 (sp)
	lw a2, 8 (sp)
	lw a3, 12 (sp)
	lw a4, 16 (sp)
	
	# white horizontal rectangle
	addi t3, a1, -3 	# x1 = x_old - 3
	addi t5, a3, 3		# x2 = x_new + 3.
	addi t4, a2, 3		# y1 = y_old + 3
	addi t6, a4, 3		# y2 = y_new + 3
	
	# paint white
	mv a3, t3
	mv a4, t4
	mv a5, t5
	mv a6, t6
	li a7, 0xffffff
	jal draw_rectangle
	# Restore values
	lw a1, 4 (sp)
	lw a2, 8 (sp)
	lw a3, 12 (sp)
	lw a4, 16 (sp)
	
	j end_case
	x_right:
	ble a2, a4, y_down_2
	
	########## up and to the right ##########
	
	# black vertical rectangle
	addi t3, a1, -3		# x1 = x_old - 3
	addi t5, a3, -3 	# x2 = x_new - 3
	addi t4, a2, -3		# y1 = y_old - 3
	addi t6, a2, 3		# y2 = y_old + 3
	
	# paint
	mv a3, t3
	mv a4, t4
	mv a5, t5
	mv a6, t6
	li a7, 0	# black
	#li a7, 0x0000ff	# blue FOR TESTING PURPOSES
	jal draw_rectangle	
	# Restore values
	lw a1, 4 (sp)
	lw a2, 8 (sp)
	lw a3, 12 (sp)
	lw a4, 16 (sp)

	# black horizontal rectangle	
	addi t3, a3, -3		# x1 = x_new - 3 
	addi t5, a1, 3		# x2 = x_old + 3
	addi t4, a4, 3		# y1 = y_new + 3
	addi t6, a2, 3		# y2 = y_old + 3
	
	# paint
	mv a3, t3
	mv a4, t4
	mv a5, t5
	mv a6, t6
	li a7, 0	# black
	#li a7, 0x0000ff	# blue FOR TESTING PURPOSES
	jal draw_rectangle	
	# Restore values
	lw a1, 4 (sp)
	lw a2, 8 (sp)
	lw a3, 12 (sp)
	lw a4, 16 (sp)
	
	# white vertical rectangle
	addi t3, a1, 3		# x1 = x_old + 3
	addi t5, a3, 3		# x2 = x_new + 3
	addi t4, a4, -3		# y1 = y_new - 3
	addi t6, a4, 3		# y2 = y_new + 3
	
	# paint white
	mv a3, t3
	mv a4, t4
	mv a5, t5
	mv a6, t6
	li a7, 0xffffff
	jal draw_rectangle
	# Restore values
	lw a1, 4 (sp)
	lw a2, 8 (sp)
	lw a3, 12 (sp)
	lw a4, 16 (sp)
	
	# white horizontal rectangle
	addi t3, a3, -3 	# x1 = x_new - 3
	addi t5, a1, 3		# x2 = x_old + 3.
	addi t4, a4, -3		# y1 = y_new - 3
	addi t6, a2, -3		# y2 = y_old - 3
	
	# paint white
	mv a3, t3
	mv a4, t4
	mv a5, t5
	mv a6, t6
	li a7, 0xffffff
	jal draw_rectangle
	# Restore values
	lw a1, 4 (sp)
	lw a2, 8 (sp)
	lw a3, 12 (sp)
	lw a4, 16 (sp)
	
	j end_case
	
	########## down and to the right ##########
	
	y_down_2:
		
	# black vertical rectangle
	addi t3, a1, -3		# x1 = x_old - 3
	addi t5, a3, -3 	# x2 = x_new - 3
	addi t4, a2, -3		# y1 = y_old - 3
	addi t6, a2, 3		# y2 = y_old + 3
	
	# paint
	mv a3, t3
	mv a4, t4
	mv a5, t5
	mv a6, t6
	li a7, 0	# black
	#li a7, 0x0000ff	# blue FOR TESTING PURPOSES
	jal draw_rectangle	
	# Restore values
	lw a1, 4 (sp)
	lw a2, 8 (sp)
	lw a3, 12 (sp)
	lw a4, 16 (sp)

	# black horizontal rectangle	
	addi t3, a3, -3		# x1 = x_new - 3 
	addi t5, a1, 3		# x2 = x_old + 3
	addi t4, a2, -3		# y1 = y_old - 3
	addi t6, a4, -3		# y2 = y_new - 3
	
	# paint
	mv a3, t3
	mv a4, t4
	mv a5, t5
	mv a6, t6
	li a7, 0	# black
	#li a7, 0x0000ff	# blue FOR TESTING PURPOSES
	jal draw_rectangle	
	# Restore values
	lw a1, 4 (sp)
	lw a2, 8 (sp)
	lw a3, 12 (sp)
	lw a4, 16 (sp)
	
	# white vertical rectangle
	addi t3, a1, 3		# x1 = x_old + 3
	addi t5, a3, 3		# x2 = x_new + 3
	addi t4, a4, -3		# y1 = y_new - 3
	addi t6, a4, 3		# y2 = y_new + 3
	
	# paint white
	mv a3, t3
	mv a4, t4
	mv a5, t5
	mv a6, t6
	li a7, 0xffffff
	jal draw_rectangle
	# Restore values
	lw a1, 4 (sp)
	lw a2, 8 (sp)
	lw a3, 12 (sp)
	lw a4, 16 (sp)
	
	# white horizontal rectangle
	addi t3, a3, -3 	# x1 = x_new - 3
	addi t5, a1, 3		# x2 = x_old + 3.
	addi t4, a2, 3		# y1 = y_old + 3
	addi t6, a4, 3		# y2 = y_new + 3
	
	# paint white
	mv a3, t3
	mv a4, t4
	mv a5, t5
	mv a6, t6
	li a7, 0xffffff
	jal draw_rectangle
	# Restore values
	lw a1, 4 (sp)
	lw a2, 8 (sp)
	lw a3, 12 (sp)
	lw a4, 16 (sp)
	
	end_case:
	lw ra, 0 (sp)
	addi sp, sp, 20
	ret
	
#	.include "draw_rectangle.asm"
