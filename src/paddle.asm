# Based on CESP lecture
# Authors: Miriam Penger, Lena Gerken, Tina Hoeflich

j main



.include "draw_rectangle.asm"


.text
#STEP 1: Start with main function: Assign values to correct registers, so that you can use the draw_rectangle function
main:

# STEP x initial setup of rectangle coordinates
li a3, 15 # rectangle x0
li a4, 55 # rectangle y0
li a5, 5 # rectangle x1
li a6, 20 # rectangle y1
li a7, 0xffffff # color: Here white. 


# allocate memory for x0-y1 + color variable
addi sp, sp, -20
sw a3,  0 (sp)
sw a4,  4 (sp)
sw a5,  8 (sp)
sw a6, 12 (sp)
sw a7, 16 (sp)

li s0, KEYBOARD_ADDDRESS
main.loop:
lw a3,  0 (sp)
lw a4,  4 (sp)
lw a5,  8 (sp)
lw a6, 12 (sp)
lw a7, 16 (sp) 


lw t0, (s0)
beq t0, zero switch.end
lw t0, 4(s0)
switch.start:
  switch.w:
  li t1, 'w'
  bne t0, t1 switch.s
  addi a4, a4, -3
  addi a6, a6, -3
  beq zero, zero switch.end
  switch.s:
  li t1, 's'
  bne t0, t1 switch.end
  addi a4, a4, 3
  addi a6, a6, 3
  beq zero, zero switch.end
switch.end:
  #Store changed variables
  sw a3,  0 (sp)
  sw a4,  4 (sp)
  sw a5,  8 (sp)
  sw a6, 12 (sp)

#STEP x: clear key vector
sw zero, (s0)

# STEP x draw rectangle
jal draw_rectangle

#STEP x : Sleep 20 ms 
li a0, 2
jal cesp_sleep

#STEP x:  Remove rectangle again by drawing a black rectangle of the same dimensions
lw a3,  0 (sp)
lw a4,  4 (sp)
lw a5,  8 (sp)
lw a6, 12 (sp)
li a7, 0 #schwarz
jal draw_rectangle

j main.loop
