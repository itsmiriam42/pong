# Based on CESP lecture
# Authors: Miriam Penger, Lena Gerken, Tina Höflich



# Function to draw line from position x1,y1 to x2,y2 with fill color 
#Uses draw_pixel that needs to be included in calling function!
draw_line:
#----Inputs:----
# a3: unsigned integer x1 --  x coordinate of starting point
# a4: unsigned integer y1 -- y coordinate of starting point
# a5: unsigned integer x2 -- x coordinate of ending point
# a6: unsigned integer y2 -- y coordinate of ending point
# a7: unsigned integer c  -- fill color of rectangle as RGB value
	
	#Save all necessary values to the stack
	addi sp, sp, -36
	sw ra, (sp)
	sw s0, 4 (sp)
	sw s1, 8 (sp)
	sw s2, 12 (sp)
	# a3-a7 are stored as local variable on the stack
	sw a3, 16 (sp)
	sw a4, 20 (sp)
	sw a5, 24 (sp)
	sw a6, 28 (sp)
	sw a7, 32 (sp)

	
	lw t0, 16 (sp) # int x
	lw t1, 20 (sp) # int y
	#Anzahl an Durchläufe des x loops in t2 speichern:
	sub t2, a5,a3
	#Anzahl an Durchläufe des y loops in t3 speichern:
	sub t3 a6,a4
	
	_loop:
	add t4, t3, t2
		mv a1, t0
		mv a2, t1
		mv a3, a7
		jal draw_pixel
	beqz t4, _loop.end
		beq t0, a5,_loop_y		
		addi t0, t0, 1
		addi t2,t2, -1
	_loop_y:
		beq t1, a6,_loop		
		addi t1, t1, 1
		addi t3,t3, -1
		
		j _loop
	
	_loop.end:
	#Restore and return 
	lw ra, (sp)
	lw s0, 4 (sp)
	lw s1, 8 (sp)
	lw s2, 12 (sp)
	lw a3, 16 (sp)
	lw a4, 20 (sp)
	lw a5, 24 (sp)
	lw a6, 28 (sp)
	lw a7, 32 (sp)
	addi sp, sp, 36
	ret



