# Authors: Miriam Penger, Lena Gerken, Tina Hoeflich
# Test for the function in move_paddles.asm

# Paints the paddles initially and then calls the move function.
# Since no keyboard input can be included in this unit test,
# the paddles are not moved and the return values of the function are printed in the console.

.include "cesplib_rars.asm"

.text

li a4, 50
li a6, 50
jal draw_paddles

# cesp_sleep
li a0, 50
li a7, 32
ecall

jal move_paddles

mv a0, a3	# get highest y-coordinate reached by the paddle on the left
li a7, 1
ecall		# print: 50

li a7, 11
li a0, 47
ecall		# print slash

mv a0, a4	# get lowest y-coordinate reached by the paddle on the left
li a7, 1
ecall		# print: 80

li a7, 11
li a0, 47
ecall		# print slash

mv a0, a5	# get highest y-coordinate reached by the paddle on the right
li a7, 1
ecall		# print: 50

li a7, 11
li a0, 47
ecall		# print slash

mv a0, a6	# get lowest y-coordinate reached by the paddle on the right
li a7, 1
ecall		# print: 80

li a7, 10
ecall

.include "draw_paddles.asm"
.include "draw_rectangle.asm"
.include "draw_pixel.asm"
.include "move_paddles.asm"
