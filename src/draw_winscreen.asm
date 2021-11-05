# Function to draw a "win" on the display

# a3: unsigned integer x1 --  x coordinate of starting point
# a4: unsigned integer y1 -- y coordinate of starting point
# a5: unsigned integer x2 -- x coordinate of ending point
# a6: unsigned integer y2 -- y coordinate of ending point
# a7: unsigned integer c  -- fill color of rectangle as RGB value
draw_winscreen:
addi sp, sp,-28
sw a2,  0 (sp)
sw a3,  4 (sp)
sw a4,  8 (sp)
sw a5, 12 (sp)
sw a6, 16 (sp)
sw a7, 20 (sp)
sw ra,  24 (sp)

  li a7 , 0xff0000 #rgb rot
# ---colour: red --------
 # 1
  li a3, 78
  li a4, 32
  li a5, 78
  li a6, 80  
  jal draw_line
  # 2
   li a3, 98
  li a4, 42
  li a5, 98
  li a6, 80  
  jal draw_line
  # 3
  li a3, 118
  li a4, 32
  li a5, 118
  li a6, 80  
  jal draw_line
  # 4 und 5
  li a3, 78
  li a4, 80
  li a5, 118
  li a6, 80  
  jal draw_line
  
  # i 
  
  
    li a3, 128
  li a4, 32
  li a5, 128
  li a6, 80  
  jal draw_line
  
  # n
  # 7
    li a3, 148
  li a4, 32
  li a5, 148
  li a6, 80  
  jal draw_line
  # 8
    li a3, 148
  li a4, 32
  li a5, 173
  li a6, 32  
  jal draw_line
  
  # 9 
    li a3, 173
  li a4, 32
  li a5, 173
  li a6, 80  
  jal draw_line
  
  # !
  li a3, 190
  li a4, 32
  li a5, 190
  li a6, 60  
  jal draw_line
  
  # .
  li a3, 190
  li a4, 70
  li a5, 1
  jal draw_circle
  lw ra, 24 (sp)
 addi sp, sp, 28
 ret
 
 
