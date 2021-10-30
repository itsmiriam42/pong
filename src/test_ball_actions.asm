# authors: Miriam, Tina, Lena
# tests for the functions in ball_actions.asm

# test code for init_ball
jal init_ball
addi sp, sp, -16
sw a0, 0(sp)	# save x-coordinate
li a7, 1
ecall		# print x-coordinate
li a7, 11
li a0, 47
ecall		# slash
li a7, 1
sw a1, 4(sp)	# save y-coordinate
mv a0, a1
ecall		# print y-coordinate
li a7, 11
li a0, 47
ecall		# slash
li a7, 1
sw a2, 8(sp)	# save x-component direction
mv a0, a2
ecall		# print x-component direction
li a7, 11
li a0, 47
ecall		# slash
li a7, 1
sw a3, 12(sp)	# save y-component direction
mv a0, a3
ecall		# print y-component direction
li a7, 11
li a0, 47
ecall		# slash

# test code for update_ball_position
# gets:
# a2 x-component of the ball's current vector
mv a2, t2
lw a2, 8(sp)
# a3 y-component of the ball's current vector
lw a3, 12(sp)
# a4 current x coordinate of the ball
lw a4, 0(sp)
# a5 current y coordinate of the ball
lw a5, 4(sp)
jal update_ball_position
# returns:
# a0 x-coordinate of the ball's new position
li a7, 1
sw a0, 0(sp)	# save x-coordinate
ecall		# print
li a7, 11
li a0, 47
ecall		# slash
# a1 y-coordinate of the ball's new position
li a7, 1
sw a1, 4(sp)	# save y-coordinate
mv a0, a1
ecall		# print

addi sp, sp, 16	# stackpointer zurücksetzen
li a7, 10
ecall

.include "ball_actions.asm"
