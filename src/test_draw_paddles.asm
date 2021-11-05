# Authors: Miriam Penger, Lena Gerken, Tina Hoeflich
# Test for the function in draw_paddles.asm

# Both paddles are drawn on the display.
# The function returns the y-coordinates of the topmost paddle edges;
# these are printed to the console.

.include "cesplib_rars.asm"

.text

jal draw_paddles

mv a0, a4	# get highest y-coordinate reached by the paddle on the left
li a7, 1
ecall		# print: 50

li a7, 11
li a0, 47
ecall		# print slash

mv a0, a6	# highest y-coordinate reached by the paddle on the right
li a7, 1
ecall		# print: 50

li a7, 10
ecall

.include "draw_paddles.asm"
.include "draw_rectangle.asm"
.include "draw_pixel.asm"