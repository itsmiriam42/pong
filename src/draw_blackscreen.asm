# Funtion to draw a blackscreen on the display, so it is resetted

# gets:
# - 
#returns:
# - 

draw_blackscreen:
addi sp, sp, -4
sw ra, 0(sp)
# draw rectangle with the following parameters:
# a3: unsigned integer x1 -- left boundary of rectangle: 0
# a4: unsigned integer y1 -- top boundary of rectangle: 0
# a5: unsigned integer x2 -- right boundary of rectangle: 256
# a6: unsigned integer y2 -- bottom boundary of rectangle: 128
# a7: unsigned integer c  -- fill color of rectangle as RGB value :0 

li a3, 0
li a4, 0
li a5, 256
li a6, 128
li a7, 0
jal draw_rectangle

lw ra, 0(sp)	
addi sp, sp, 4	
ret