# Authors: Miriam Penger, Lena Gerken, Tina Höflich
# Tests for the functions in ball_actions.asm

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
li a7, 11
li a0, 47
ecall		# slash

# test code for check_ball_position if the ball is within the playing area
# gets:
# a1 current x coordinate of the ball
lw a1, 0(sp)
jal check_ball_position
# returns:
# a0 = 0 if the ball is within the playing area
# a0=1 if the ball is in the left scoring area
# a0=2 if the ball is in the right scoring area
li a7, 1
ecall		# print
li a7, 11
li a0, 47
ecall		# slash

# test code for check_ball_position if the ball is in the left scoring area
# gets:
# a1 current x coordinate of the ball
li a1, 30
jal check_ball_position
# returns:
# a0 = 0 if the ball is within the playing area
# a0=1 if the ball is in the left scoring area
# a0=2 if the ball is in the right scoring area
li a7, 1
ecall		# print
li a7, 11
li a0, 47
ecall		# slash

# test code for check_ball_position if the ball is in the right scoring area
# gets:
# a1 current x coordinate of the ball
li a1, 220
jal check_ball_position
# returns:
# a0 = 0 if the ball is within the playing area
# a0=1 if the ball is in the left scoring area
# a0=2 if the ball is in the right scoring area
li a7, 1
ecall		# print
li a7, 11
li a0, 47
ecall		# slash

# test code for check_paddle_hit if the ball hit the paddle:
# gets: 
# a1 current y coordinate of the ball
li a1, 70
# a2 highest y coordinate reached by the relevant paddle 
li a2, 110
# a3 lowest y coordinate reached by the relevant paddle 
li a3, 60
jal check_paddle_hit
# returns:
# a0 = 0 if the ball hit the paddle
# a0 = 1 if the ball didn't hit the paddle
li a7, 1
ecall		# print
li a7, 11
li a0, 47
ecall		# slash

# test code for check_paddle_hit if the ball didn't hit the paddle:
# gets: 
# a1 current y coordinate of the ball
li a1, 50
# a2 highest y coordinate reached by the relevant paddle 
li a2, 110
# a3 lowest y coordinate reached by the relevant paddle 
li a3, 60
jal check_paddle_hit
# returns:
# a0 = 0 if the ball hit the paddle
# a0 = 1 if the ball didn't hit the paddle
li a7, 1
ecall		# print
li a7, 11
li a0, 47
ecall		# slash

# test code for change_ball_direction_wall:
# gets:
# a2 x-component of the ball's current vector
li a2, 3
# a3 y-component of the ball's current vector
li a3, 2
jal change_ball_direction_wall
# returns:
# a0 x-component of the ball's new vector
li a7, 1
ecall		# print
li a7, 11
li a0, 47
ecall		# slash
# a1 y-component of the ball's new vector
li a7, 1
mv a0, a1
ecall		# print
li a7, 11
li a0, 47
ecall		# slash

# test code for change_ball_direction_paddle:
# gets:
# a2 x-component of the ball's current vector
li a2, -3
# a3 y-component of the ball's current vector
li a3, 2
# a4 current x coordinate of the ball
li a4, 39
# a5 current y coordinate of the ball
li a5, 78
# a6 highest y coordinate reached by the paddle that was hit
li a6, 112
# a7 lowest y coordinate reached by the paddle that was hit
li a7, 62
jal change_ball_direction_paddle
# returns:
# a0 x-component of the ball's new vector
li a7, 1
ecall		# print
li a7, 11
li a0, 47
ecall		# slash
# a1 y-component of the ball's new vector
li a7, 1
mv a0, a1
ecall		# print
li a7, 11
li a0, 47
ecall		# slash

addi sp, sp, 16	# stackpointer back
li a7, 10
ecall

.include "ball_actions.asm"
