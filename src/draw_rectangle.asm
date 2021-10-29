# Based on CESP lecture
# Authors: Miriam Penger, Lena Gerken, Tina Höflich

.include "draw_pixel.asm"

# Function to draw rectangle from position x1,y1 to x2,y2 with fill color c
draw_rectangle:
#----Inputs--------
# a3: unsigned integer x1 -- left boundary of rectangle
# a4: unsigned integer y1 -- top boundary of rectangle
# a5: unsigned integer x2 -- right boundary of rectangle
# a6: unsigned integer y2 -- bottom boundary of rectangle
# a7: unsigned integer c  -- fill color of rectangle as RGB value

	#li a1,DISPLAY_ADDRESS	# a1: base address of frame buffer
	#li a2,DISPLAY_WIDTH	# a2: width/height of quadratic image
	#li a3,10 		# a3: unsigned integer x0 -- left boundary of rectangle
	#li a4,90		# a4: unsigned integer y0 -- top boundary of rectangle
	#li a5,15		# a5: unsigned integer x1 -- right boundary of rectangle
	#li a6,150		# a6: unsigned integer y1 -- bottom boundary of rectangle
	#li a7,0xFFFFFF	
	
	
	#memory allocation
	addi sp, sp, -36
	sw ra, (sp)
	sw s0, 4 (sp)
	sw s1, 8 (sp)
	sw s2, 12 (sp)
	sw a3, 16 (sp)
	sw a4, 20 (sp)
	sw a5, 24 (sp)
	sw a6, 28 (sp)
	sw a7, 32 (sp)


	lw t0, 16 (sp) # int x
	lw t1, 20 (sp) # int y
	
	_loopy:
		_loopx:
		 	#Moving values to registers a1-a3 to call draw_pixel
			mv a1, t0
			mv a2, t1
			mv a3, a7
			jal draw_pixel
			
			addi t0, t0, 1 #x=x+1
			bne t0, a5, _loopx
	addi t1, t1, 1 #y +=1 
	lw t0, 16 (sp)
	bne t1, a6, _loopy

	lw ra, (sp)
	lw s0, 4 (sp)
	lw s1, 8 (sp)
	lw s2, 12 (sp)
	# a3-a7 do not need to be restored according to calling convention
	addi sp, sp, 36
	ret
