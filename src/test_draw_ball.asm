# Authors: Miriam Penger, Lena Gerken, Tina Hoeflich
# Test for the function in draw_ball.asm

# The ball is shown in the upper left corner of the display so that the outer edges are exactly at the edge of the display.
# When executed correctly, the edge lengths of the ball are equal.

.include "cesplib_rars.asm"

.text

li a1, 3 
li a2, 3
li a3, 0xffffff	#white

jal draw_ball

li a7, 10
ecall

.include "draw_ball.asm"
.include "draw_rectangle.asm"
.include "draw_pixel.asm"