# Authors: Miriam Penger, Lena Gerken, Tina H�flich

#draws the scoreboard of the pong game pixel by pixel using the draw pixel function
#

j main

.include "draw_pixel.asm"
.include "draw_line.asm"
.include "draw_circle.asm"

.text

#Funktion to draw dots that separate the numbers on the scoreboard
draw_dots:
#allocate Memory:
addi sp, sp,-20
sw a3,   (sp)
sw a4,  4 (sp)
sw a5, 8 (sp)
sw a7, 12 (sp)
sw ra,  16 (sp)

#draw dots
  li a3, 117
  li a4, 14
  li a5, 1
  li a7, 0xffffff #white
  jal draw_circle
  li a3, 117
  li a4, 20
  li a5, 1
  li a7, 0xffffff #white
  jal draw_circle
  
  #restore and Jump back
 lw ra, 16 (sp)
 addi sp, sp, 20
 ret
 
 #Function to draw left numbers on the scoreboard
draw_left_number:
# allocate memory for x0-y1 + color variable
addi sp, sp,-28
sw a2,  0 (sp)
sw a3,  4 (sp)
sw a4,  8 (sp)
sw a5, 12 (sp)
sw a6, 16 (sp)
sw a7, 20 (sp)
sw ra,  24 (sp)

#draw a black 18 to remove numbers:
# ----------- 18-----------
  #-1---
  li a3, 95
  li a4, 10
  li a5, 95
  li a6, 25
  li a7,0
  jal draw_line
    #-1----
  li a3, 110
  li a4, 10
  li a5, 110
  li a6, 25  
  # -- 8 -----
  li a3, 100
  li a4, 10
  li a5, 100
  li a6, 25
  jal draw_line
 li a3, 100
  li a4, 10
  li a5, 110
  li a6, 10
  jal draw_line
  li a3, 110
  li a4, 10
  li a5, 110
  li a6, 25  
  jal draw_line
  li a3, 100
  li a4, 25
  li a5, 110
  li a6, 25
  jal draw_line
  li a3, 100
  li a4, 17
  li a5, 110
  li a6, 17
  jal draw_line


li a7, 0xffffff #white
lw t0, (sp) #input number
switch.start:
# ----------- 0 ------------
  switch.0:
  li t1, 0
  bne t0, t1 switch.1
  li a3, 100
  li a4, 10
  li a5, 100
  li a6, 25
  jal draw_line
 li a3, 100
  li a4, 10
  li a5, 110
  li a6, 10
  jal draw_line
  li a3, 110
  li a4, 10
  li a5, 110
  li a6, 25  
  jal draw_line
  li a3, 100
  li a4, 25
  li a5, 110
  li a6, 25
  jal draw_line
  beq zero, zero switch.end
 #----------------1------------
   switch.1:
   li t1, 1
  bne t0, t1 switch.2
  li a3, 110
  li a4, 10
  li a5, 110
  li a6, 25  
  jal draw_line
   beq zero, zero switch.end
 #---------------2-------------
  switch.2:
   li t1, 2
  bne t0, t1 switch.3
  li a3, 100
  li a4, 17
  li a5, 100
  li a6, 25
  jal draw_line
   li a3, 110
  li a4, 10
  li a5, 110
  li a6, 17
  jal draw_line
 li a3, 100
  li a4, 10
  li a5, 110
  li a6, 10
  jal draw_line
  li a3, 100
  li a4, 25
  li a5, 110
  li a6, 25
  jal draw_line
   li a3, 100
  li a4, 17
  li a5, 110
  li a6, 17
  jal draw_line
  #-------------3---------------
  switch.3:
   li t1, 3
  bne t0, t1 switch.4
  li a3, 100
  li a4, 10
  li a5, 110
  li a6, 10
  jal draw_line
   li a3, 110
  li a4, 10
  li a5, 110
  li a6, 25
  jal draw_line
 li a3, 100
  li a4, 17
  li a5, 110
  li a6, 17
  jal draw_line
  li a3, 100
  li a4, 25
  li a5, 110
  li a6, 25
  jal draw_line
   li a3, 100
  li a4, 17
  li a5, 110
  li a6, 17
  jal draw_line
  beq zero, zero switch.end
  #--------------4-------------
   switch.4:
   li t1, 4
  bne t0, t1 switch.5
  li a3, 100
  li a4, 10
  li a5, 100
  li a6, 17
  jal draw_line
   li a3, 110
  li a4, 10
  li a5, 110
  li a6, 25
  jal draw_line
 li a3, 100
  li a4, 17
  li a5, 110
  li a6, 17
  jal draw_line
  beq zero, zero switch.end
  #--------------5------------
  switch.5:
   li t1, 5
  bne t0, t1 switch.6
  li a3, 100
  li a4, 10
  li a5, 100
  li a6, 17
  jal draw_line
   li a3, 110
  li a4, 17
  li a5, 110
  li a6, 25
  jal draw_line
   li a3, 100
  li a4, 10
  li a5, 110
  li a6, 10
  jal draw_line
 li a3, 100
  li a4, 17
  li a5, 110
  li a6, 17
  jal draw_line
   li a3, 100
  li a4, 25
  li a5, 110
  li a6, 25
  jal draw_line
  beq zero, zero switch.end
   #--------------6------------
  switch.6:
   li t1, 6
  bne t0, t1 switch.7
  li a3, 100
  li a4, 10
  li a5, 100
  li a6, 25
  jal draw_line
   li a3, 110
  li a4, 17
  li a5, 110
  li a6, 25
  jal draw_line
  li a3, 100
  li a4, 25
  li a5, 110
  li a6, 25
  jal draw_line
 li a3, 100
  li a4, 17
  li a5, 110
  li a6, 17
  jal draw_line
   li a3, 100
  li a4, 10
  li a5, 110
  li a6, 10
  jal draw_line
  beq zero, zero switch.end
  #--------------7------------
  switch.7:
   li t1,7
  bne t0, t1 switch.8
   li a3, 110
  li a4, 10
  li a5, 110
  li a6, 25
  jal draw_line
  li a3, 100
  li a4, 10
  li a5, 110
  li a6, 10
  jal draw_line
  beq zero, zero switch.end
  # ----------- 8------------
  switch.8:
  li t1, 8
  bne t0, t1 switch.9
  li a3, 100
  li a4, 10
  li a5, 100
  li a6, 25
  jal draw_line
 li a3, 100
  li a4, 10
  li a5, 110
  li a6, 10
  jal draw_line
  li a3, 110
  li a4, 10
  li a5, 110
  li a6, 25  
  jal draw_line
  li a3, 100
  li a4, 25
  li a5, 110
  li a6, 25
  jal draw_line
   li a3, 100
  li a4, 17
  li a5, 110
  li a6, 17
  jal draw_line
  beq zero, zero switch.end
  # ----------- 9------------
  switch.9:
  li t1,9
  bne t0, t1 switch.10
  li a3, 100
  li a4, 10
  li a5, 100
  li a6, 17
  jal draw_line
 li a3, 100
  li a4, 10
  li a5, 110
  li a6, 10
  jal draw_line
  li a3, 110
  li a4, 10
  li a5, 110
  li a6, 25  
  jal draw_line
  li a3, 100
  li a4, 25
  li a5, 110
  li a6, 25
  jal draw_line
   li a3, 100
  li a4, 17
  li a5, 110
  li a6, 17
  jal draw_line
  beq zero, zero switch.end
  # ----------- 10------------
  switch.10:
  li t1,10
  bne t0, t1 switch.11
  #-0----
  li a3, 100
  li a4, 10
  li a5, 100
  li a6, 25
  jal draw_line
 li a3, 100
  li a4, 10
  li a5, 110
  li a6, 10
  jal draw_line
  li a3, 110
  li a4, 10
  li a5, 110
  li a6, 25  
  jal draw_line
  li a3, 100
  li a4, 25
  li a5, 110
  li a6, 25
  jal draw_line
  #-1---
  li a3, 95
  li a4, 10
  li a5, 95
  li a6, 25
  jal draw_line
  beq zero, zero switch.end
  # ----------- 11-----------
  switch.11:
  li t1,11
  bne t0, t1 switch.end
  #-1----
  li a3, 110
  li a4, 10
  li a5, 110
  li a6, 25  
  jal draw_line
  #-1---
  li a3, 95
  li a4, 10
  li a5, 95
  li a6, 25
  jal draw_line
  beq zero, zero switch.end
 switch.end:
 lw ra, 24 (sp)
 addi sp, sp, 28
 ret

#function to draw right number to the scoreboard
draw_right_number:
# allocate memory for x0-y1 + color variable
addi sp, sp,-28
sw a2,  0 (sp)
sw a3,  4 (sp)
sw a4,  8 (sp)
sw a5, 12 (sp)
sw a6, 16 (sp)
sw a7, 20 (sp)
sw ra, 24 (sp)

#-----------dots---------
  
#draw a black 18 to remove numbers:
# ----------- 18-----------
  #-1---
  li a3, 125
  li a4, 10
  li a5, 125
  li a6, 25
  li a7,0
  jal draw_line
    #-1----
  li a3, 140
  li a4, 10
  li a5, 140
  li a6, 25  
  # -- 8 -----
  li a3, 130
  li a4, 10
  li a5, 130
  li a6, 25
  jal draw_line
 li a3, 130
  li a4, 10
  li a5, 140
  li a6, 10
  jal draw_line
  li a3, 140
  li a4, 10
  li a5, 140
  li a6, 25  
  jal draw_line
  li a3, 130
  li a4, 25
  li a5, 140
  li a6, 25
  jal draw_line
  li a3, 130
  li a4, 17
  li a5, 140
  li a6, 17
  jal draw_line


  li a7, 0xffffff #white
  lw t0, (sp) #input number
  switch.start_2:
 # ----------- 0 ------------
  switch.null:
  li t1, 0
  bne t0, t1 switch.eins
  li a3, 130
  li a4, 10
  li a5, 130
  li a6, 25
  jal draw_line
  li a3, 130
  li a4, 10
  li a5, 140
  li a6, 10
  jal draw_line
  li a3, 140
  li a4, 10
  li a5, 140
  li a6, 25  
  jal draw_line
  li a3, 130
  li a4, 25
  li a5, 140
  li a6, 25
  jal draw_line
  beq zero, zero switch.end_2
 #----------------1------------
   switch.eins:
   li t1, 1
  bne t0, t1 switch.zwei
  li a3, 140
  li a4, 10
  li a5, 140
  li a6, 25  
  jal draw_line
   beq zero, zero switch.end_2
 #---------------2-------------
  switch.zwei:
   li t1, 2
  bne t0, t1 switch.drei
  li a3, 130
  li a4, 17
  li a5, 130
  li a6, 25
  jal draw_line
   li a3, 140
  li a4, 10
  li a5, 140
  li a6, 17
  jal draw_line
 li a3, 130
  li a4, 10
  li a5, 140
  li a6, 10
  jal draw_line
  li a3, 130
  li a4, 25
  li a5, 140
  li a6, 25
  jal draw_line
   li a3, 130
  li a4, 17
  li a5, 140
  li a6, 17
  jal draw_line
  #-------------3---------------
  switch.drei:
   li t1, 3
  bne t0, t1 switch.vier
  li a3, 130
  li a4, 10
  li a5, 140
  li a6, 10
  jal draw_line
   li a3, 140
  li a4, 10
  li a5, 140
  li a6, 25
  jal draw_line
 li a3, 130
  li a4, 17
  li a5, 140
  li a6, 17
  jal draw_line
  li a3, 130
  li a4, 25
  li a5, 140
  li a6, 25
  jal draw_line
   li a3, 130
  li a4, 17
  li a5, 140
  li a6, 17
  jal draw_line
  beq zero, zero switch.end_2
  #--------------4-------------
   switch.vier:
   li t1, 4
  bne t0, t1 switch.fuenf
  li a3, 130
  li a4, 10
  li a5, 130
  li a6, 17
  jal draw_line
   li a3, 140
  li a4, 10
  li a5, 140
  li a6, 25
  jal draw_line
 li a3, 130
  li a4, 17
  li a5, 140
  li a6, 17
  jal draw_line
  beq zero, zero switch.end_2
  #--------------5------------
  switch.fuenf:
   li t1, 5
  bne t0, t1 switch.sechs
  li a3, 130
  li a4, 10
  li a5, 130
  li a6, 17
  jal draw_line
   li a3, 140
  li a4, 17
  li a5, 140
  li a6, 25
  jal draw_line
   li a3, 130
  li a4, 10
  li a5, 140
  li a6, 10
  jal draw_line
 li a3, 130
  li a4, 17
  li a5, 140
  li a6, 17
  jal draw_line
   li a3, 130
  li a4, 25
  li a5, 140
  li a6, 25
  jal draw_line
  beq zero, zero switch.end_2
   #--------------6------------
  switch.sechs:
   li t1, 6
  bne t0, t1 switch.sieben
  li a3, 130
  li a4, 10
  li a5, 130
  li a6, 25
  jal draw_line
   li a3, 140
  li a4, 17
  li a5, 140
  li a6, 25
  jal draw_line
  li a3, 130
  li a4, 25
  li a5, 140
  li a6, 25
  jal draw_line
 li a3, 130
  li a4, 17
  li a5, 140
  li a6, 17
  jal draw_line
   li a3, 130
  li a4, 10
  li a5, 140
  li a6, 10
  jal draw_line
  beq zero, zero switch.end_2
  #--------------7------------
  switch.sieben:
   li t1,7
  bne t0, t1 switch.acht
   li a3, 140
  li a4, 10
  li a5, 140
  li a6, 25
  jal draw_line
  li a3, 130
  li a4, 10
  li a5, 140
  li a6, 10
  jal draw_line
  beq zero, zero switch.end_2
  # ----------- 8------------
  switch.acht:
  li t1, 8
  bne t0, t1 switch.neun
  li a3, 130
  li a4, 10
  li a5, 130
  li a6, 25
  jal draw_line
 li a3, 130
  li a4, 10
  li a5, 140
  li a6, 10
  jal draw_line
  li a3, 140
  li a4, 10
  li a5, 140
  li a6, 25  
  jal draw_line
  li a3, 130
  li a4, 25
  li a5, 140
  li a6, 25
  jal draw_line
   li a3, 130
  li a4, 17
  li a5, 140
  li a6, 17
  jal draw_line
  beq zero, zero switch.end_2
  # ----------- 9------------
  switch.neun:
  li t1,9
  bne t0, t1 switch.zehn
  li a3, 130
  li a4, 10
  li a5, 130
  li a6, 17
  jal draw_line
 li a3, 130
  li a4, 10
  li a5, 140
  li a6, 10
  jal draw_line
  li a3, 140
  li a4, 10
  li a5, 140
  li a6, 25  
  jal draw_line
  li a3, 130
  li a4, 25
  li a5, 140
  li a6, 25
  jal draw_line
   li a3, 130
  li a4, 17
  li a5, 140
  li a6, 17
  jal draw_line
  beq zero, zero switch.end_2
  # ----------- 10------------
  switch.zehn:
  li t1,10
  bne t0, t1 switch.elf
  #-0----
  li a3, 130
  li a4, 10
  li a5, 130
  li a6, 25
  jal draw_line
 li a3, 130
  li a4, 10
  li a5, 140
  li a6, 10
  jal draw_line
  li a3, 140
  li a4, 10
  li a5, 140
  li a6, 25  
  jal draw_line
  li a3, 130
  li a4, 25
  li a5, 140
  li a6, 25
  jal draw_line
  #-1---
  li a3, 125
  li a4, 10
  li a5, 125
  li a6, 25
  jal draw_line
  beq zero, zero switch.end_2
  # ----------- 11-----------
  switch.elf:
  li t1,11
  bne t0, t1 switch.end_2
  #-1----
  li a3, 140
  li a4, 10
  li a5, 140
  li a6, 25  
  jal draw_line
  #-1---
  li a3, 125
  li a4, 10
  li a5, 125
  li a6, 25
  jal draw_line
  beq zero, zero switch.end_2
  
 switch.end_2:
 lw ra, 24 (sp)
 addi sp, sp, 28
 ret
 
 #Main function to test, will be called by other functions!! 
main:
jal draw_dots
li a2,11
jal draw_left_number

li a2,11
jal draw_right_number


li a2,1
jal draw_left_number


li a2,10
jal draw_left_number
