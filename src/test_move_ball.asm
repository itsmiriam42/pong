# Authors: Miriam Penger, Lena Gerken, Tina Hoeflich
# Test for the function in move_ball.asm

# Drawing the ball in the top left corner of the display.
# Then, moving the ball from coordinates (3/3) to (5/6).

.include "cesplib_rars.asm"

.text

li a1, 3
li a2, 3
li a3, 0xffffff
jal draw_ball

# cesp_sleep
li a0, 50
li a7, 32
ecall

li a1, 3
li a2, 3
li a3, 5
li a4, 6

jal move_ball

li a7, 10
ecall

.include "draw_ball.asm"
.include "draw_rectangle.asm"
.include "draw_pixel.asm"
.include "move_ball.asm"
