# Based on CESP lecture
# Authors: Miriam Penger, Lena Gerken, Tina Höflich

j draw_pixel
#.include "cesplib_fpgrars.asm"
#.include "cesplib_rars.asm"

draw_pixel:
# Draws a colored pixel at position (x,y)  

# Inputs
#----------------------
#    a1: x
#    a2: y
#    a3: color
#li a1, 50
#li a2, 50
#li a3, 0xffffff

# Outputs: None

	#allocate memory
	addi sp, sp, -28
	sw s0, 0 (sp)
	sw s1, 4 (sp)
	sw s2, 8 (sp)
	sw ra, 12(sp)
	sw a1, 16(sp) 
	sw a2, 20(sp)
	sw a3, 24(sp)


	#DISPLAY_ADDRESS and DISPLAY_WIDTH defined in cesplib_rars.asm and
	# arguments passed via registers a1 and a2 to calculate the memory address 
	li s0, DISPLAY_ADDRESS
	li s1, DISPLAY_WIDTH
	
	# y_offset
	mul s2, s1, a2  # y*DISPLAY_WIDTH
			
	# crt_address = base_address + x_offset + y_offset
	add s2, a1, s2
	slli s2, s2, 2 # *4 to byte address
	
	add s2, s2, s0 

	# *crt_address = a3
	sw a3, (s2)

	#Restore and jump back
	lw s0, 0 (sp)
	lw s1, 4 (sp)
	lw s2, 8 (sp)
	lw ra, 12(sp)  
	lw a1, 16(sp) 
	lw a2, 20(sp)
	lw a3, 24(sp)
	addi sp, sp, 28
	ret
