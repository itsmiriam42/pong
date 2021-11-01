# Authors: Miriam Penger, Lena Gerken, Tina Hoeflich

# Moves the ball of the pong game using the draw_rectangle function.
# Only paints the pixel differences of old and new position after movement for more efficient performance.

move_ball:
#----Inputs:----
# a1: x coordinate of old point
# a2: y coordinate of old point
# a3: x coordinate of new point
# a4: y coordinate of new point
	
	#Save all necessary values to the stack
	addi sp, sp, -20
	sw ra, (sp)
	sw a1, 4 (sp)
	sw a2, 8 (sp)
	sw a3, 12 (sp)
	sw a4, 16 (sp)
	
	sub t0, a3, a1  # x-Sprungweite
	sub t1, a4, a2  # y-Sprungweite
	

	##################### paint old position black #####################

	# calculate first old rectangle
	ble a1, a3, x_right_old
	
	# calculate horizontal shift to the left
	addi t3, a3, 3		# x1 = x_new + 3
	add t5, t3, t0		# x2 = x_new + 3 + x-Sprungweite
	addi t4, a2, -3		# y1 = y_old - 3
	addi t6, a2, 3		# y2 = y_old + 3
	j exit_1
	
	# calculate horizontal shift to the right
	x_right_old:
	addi t3, a3, -3		# x1 = x_new - 3
	sub t5, t3, t0		# x2 = x_new - 3 - x-Sprungweite
	addi t4, a2, -3		# y1 = y_old - 3
	addi t6, a2, 3		# y2 = y_old + 3
	j exit_1
	
	exit_1:
	# paint old one black
	mv a3, t3
	mv a4, t4
	mv a5, t5
	mv a6, t6
	li a7, 0	# black
	jal draw_rectangle
	
	# Restore values
	lw ra, 0 (sp)
	lw a1, 4 (sp)
	lw a2, 8 (sp)
	lw a3, 12 (sp)
	lw a4, 16 (sp)
	
	ble a2, a4, y_down_old	# if (y_old <= y_new)
	
	# calculate vertical shift up
	addi t3, a1, -3		# x1 = x_old - 3
	addi t5, a3, 3		# x2 = x_new + 3
	addi t4, a4, 3		# y1 = y_new + 3
	addi t6, a2, 3		# y2 = y_old + 3
	j exit_2
	
	# calculate vertical shift down
	y_down_old:
	addi t3, a3, -3		# x1 = x_new - 3
	addi t5, a1, 3		# x2 = x_old + 3
	addi t4, a2, -3		# y1 = y_old - 3
	addi t6, a4, -3		# y2 = y_new - 3
	j exit_2
	
	exit_2:
	# paint old one black
	mv a3, t3
	mv a4, t4
	mv a5, t5
	mv a6, t6
	li a7, 0	# black
	jal draw_rectangle
	

	##################### paint new position white #####################

	# calculate first new rectangle
	ble a1, a3, x_right_new
	
	# calculate horizontal shift to the left
	addi t3, a3, -3		# x1 = x_new - 3
	addi t5, a1, -3		# x2 = x_old - 3
	addi t4, a4, -3		# y1 = y_new - 3
	addi t6, a4, 3		# y2 = y_new + 3
	j exit_3
	
	# calculate horizontal shift to the right
	x_right_new:
	addi t3, a1, 3		# x1 = x_old + 3
	addi t5, a3, 3		# x2 = x_new + 3
	addi t4, a4, -3		# y1 = y_new - 3
	addi t6, a4, 3		# y2 = y_new + 3
	j exit_3
	
	exit_3:
	# paint new one white
	mv a3, t3
	mv a4, t4
	mv a5, t5
	mv a6, t6
	li a7, 0xffffff
	jal draw_rectangle
	
	# Restore values
	lw ra, 0 (sp)
	lw a1, 4 (sp)
	lw a2, 8 (sp)
	lw a3, 12 (sp)
	lw a4, 16 (sp)
	
	ble a2, a4, y_down_new	# if (y_old <= y_new)
	
	# calculate vertical shift up
	addi t3, a1, -3		# x1 = x_old - 3
	addi t5, a3, 3		# x2 = x_new + 3
	addi t4, a4, -3		# y1 = y_new - 3
	addi t6, a2, -3		# y2 = y_old - 3
	j exit_4
	
	# calculate vertical shift down
	y_down_new:
	addi t3, a3, -3		# x1 = x_new - 3
	addi t5, a1, 3		# x2 = x_old + 3
	addi t4, a2, 3		# y1 = y_old + 3
	addi t6, a4, 3		# y2 = y_new + 3
	j exit_4
	
	exit_4:
	# paint new one white
	mv a3, t3
	mv a4, t4
	mv a5, t5
	mv a6, t6
	li a7, 0xffffff
	jal draw_rectangle

	
	# Restore and jump back
	lw ra, 0 (sp)
	lw a1, 4 (sp)
	lw a2, 8 (sp)
	lw a3, 12 (sp)
	lw a4, 16 (sp)
	addi sp, sp, 20
	ret

li a7, 10
ecall

.include "draw_ball.asm"