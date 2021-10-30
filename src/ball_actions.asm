# authors: Miriam, Tina, Lena
# handles various actions concerning the ball in pong

.eqv LEFT_SCORING_BORDER 40	# assuming a display width of 256 and a scoring area width of 40
.eqv RIGHT_SCORING_BORDER 216	# assuming a display width of 256 and a scoring area width of 40

# function to find out whether the ball reached the scoring area
check_ball_position:
# gets:
# a1 current x coordinate of the ball
# returns:
# a0 = 0 if the ball is within the playing area
# a0=1 if the ball is in the left scoring area
# a0=2 if the ball is in the right scoring area
li t1, LEFT_SCORING_BORDER
li t2, RIGHT_SCORING_BORDER
li a0, 0			# assumtion: the ball is within the playing area
blt t1, a1, no_left_score
li a0, 1			# this part only gets executed if the ball is within the left scoring area
no_left_score:
blt a1, t2, no_right_score
li a0, 2			# this part only gets executed if the ball is within the right scoring area
no_right_score:
ret

# function to find out whether the ball hit a paddle or not
# should only be called if check_ball_position returned 1 or 2 (meaning the ball reached the scoring area)
check_paddle_hit:
# gets: 
# a1 current y coordinate of the ball
# a2 highest y coordinate reached by the relevant paddle 
# a3 lowest y coordinate reached by the relevant paddle 
# returns:
# a0 = 0 if the ball hit the paddle
# a0 = 1 if the ball didn't hit the paddle
li a0, 1		# assumtion: the ball didn't hit the paddle
blt a2, a1, no_hit	# branch if ball is above the paddle
blt a1, a3, no_hit	# branch if ball is below the paddle
li a0, 0		# ball hit the paddle
no_hit:
ret

# EXPLANATION ON HOW THE BALL MOVEMENTS ARE BEING DESCRIBED
# the coordinate system I'm using has its point of origin in the upper left corner of the display.
# now onwards to the ball's direction. I'm describing that by using a vector, e.g. (-3,2).
# then, a possible direction for the ball would be (1,0) if it is heading straight to the right. (0,1) would mean the opposite movement, to the left.
# moving at an angle could be described by using (1,1) for heading towards the lower right corner if one starts from the center, (1,-1) stands for the upper right corner, and so on.
# for other angles, (-5. 4) could be used to indicate a movement of the ball to the left while also moving a little bit in the upwards direction.
# these vectors are just there to indicate the direction and might need to be modified in order to have the ball moving at the same speed in all directions. 
# so, (5.0) should mean the exact same thing as (1,0) because the vector should just be used to describe direction, not speed.
# (0, x) needs to be avoided at all costs: the ball should never end up moving like this because the game would essentially be stuck.
# (x, 0) should also be avoided because it would be boring, as te ball would never change the y-coordinate of its position.

# function to calculate the new direction of the ball if it hit the edge of the playing field: "einfallswinkel=ausfallswinkel"
change_ball_direction_wall:
# gets:
# a2 x-component of the ball's current vector
# a3 y-component of the ball's current vector
# returns:
# a0 x-component of the ball's new vector
# a1 y-component of the ball's new vector
blt a2, zero, case_2
# case 1: x>0
blt a3, zero, flip_y	# x>0, y<0
j flip_x		# else: x>0, y>0
case_2: # x<0
blt a3, zero, flip_x 	# x<0, y<0
j flip_y		#else: x<0, y>0
flip_x:
li t0, -1
mul a0, a2, t0	# x = x*(-1)
mv a1, a3	# y remains the same
j end_switch
flip_y:
li t0, -1
mv a0, a2	# x remains the same
mul a1, a3, t0	# y = y*(-1)
end_switch:
ret

# function to calculate the new direction of the ball if it hit the edge of the playing field: the closer to the edge of the paddle, the bigger the angle
change_ball_direction_paddle:
# gets:
# a2 x-component of the ball's current vector
# a3 y-component of the ball's current vector
# a4 current x coordinate of the ball
# a5 current y coordinate of the ball
# a6 highest y coordinate reached by the paddle that was hit
# a7 lowest y coordinate reached by the paddle that was hit
# returns:
# a0 x-component of the ball's new vector
# a1 y-component of the ball's new vector

# assuming a paddle length of 50p, it is divided in 6 sections	# TODO: modify for paddle length of 60p
mv t0, zero	# counter for paddle pixels
li t1, 60	# somewhere in the middle of the field, definitely between the paddles -> TODO: check with field definition if correct, maybe use constant here, also in the following cases
mv t0, a7

# check all the sections. if the ball is found, set the direction to the predefined values matching the section.
# ---check first section---
addi t0, t0, 5		# t0 is now 5 pixels into the paddle
bgt a3, t0, next_15	# not in the checked section, jump to the next
# lowest y-coordinate -> highest section of the paddle
li a1, -2	# y coordinate the same for both paddles
# distinguish between a hit of the paddle on the left and one on the right by using the ball's x coordinate
blt a4, t1, left_paddle_5	# t1 contains the paddle length constant
li a0, -2		# right paddle
j direction_done
left_paddle_5:
li a0, 2
j direction_done

# ---check second section---
next_15:
addi t0, t0, 10		# t0 is now 15 pixels into the paddle
bgt a3, t0, next_25	# not in the checked section, jump to the next
li a1, -2
blt a4, t1, left_paddle_15
li a0, -3		# right paddle
j direction_done
left_paddle_15:
li a0, 3
j direction_done

# ---check third section---
next_25:
addi t0, t0, 10		# t0 is now 25 pixels into the paddle
bgt a3, t0, next_35	# not in the checked section, jump to the next
li a1, -2
blt a4, t1, left_paddle_25
li a0, -4		# right paddle
j direction_done
left_paddle_25:
li a0, 4
j direction_done

# ---check forth section---
next_35:
addi t0, t0, 10		# t0 is now 35 pixels into the paddle
bgt a3, t0, next_45	# not in the checked section, jump to the next
li a1, 2
blt a4, t1, left_paddle_35
li a0, -4		# right paddle
j direction_done
left_paddle_35:
li a0, 4
j direction_done

# ---check fifth section---
next_45:
addi t0, t0, 5		# t0 is now 45 pixels into the paddle
bgt a3, t0, next_50	# not in the checked section, jump to the next
li a1, 2
blt a4, t1, left_paddle_45
li a0, -3		# right paddle
j direction_done
left_paddle_45:
li a0, 3
j direction_done

# ---check sixth section---
next_50:
addi t0, t0, 5		# t0 is now 50 pixels into the paddle, which is the end of the paddle
bgt a3, t0, error	# not in the checked section, jump to the next
li a1, 2
blt a4, t1, left_paddle_50
li a0, -2		# right paddle
j direction_done
left_paddle_50:
li a0, 2
j direction_done

error:
# TODO: this line should never be reached, maybe return an error that the ball doesn't seem to have hit the paddle
direction_done:
ret

# function to move the ball in a given direction
update_ball_position:
# gets:
# a2 x-component of the ball's current vector
# a3 y-component of the ball's current vector
# a4 current x coordinate of the ball
# a5 current y coordinate of the ball
# returns:
# a0 x-coordinate of the ball's new position
# a1 y-coordinate of the ball's new position
add a0, a4, a2		# the new position is the old one plus the vector values
add a1, a5, a3
ret

# TODO: see if the vector solution for speed runs smooth enough, add a speed handling function if necessary
# TODO: some kind of control function to bring it all together
# TODO: first ball position using the random int ecall

# function to initialize the ball by giving it a random y-Position and direction
init_ball:
# returns:
# a0 x-coordinate of the ball's new position
# a1 y-coordinate of the ball's new position
# a2 x-component of the ball's new vector
# a3 y-component of the ball's new vector
mv a0, zero
li a7, 42	# ecall returning a random integer in a defined range
# x-component vector
li a1, 5	# 6 possible outcomes
ecall
mv a2, a0	# random number in a2
li t0, 2
ble a2, t0, move_left
# move_right: 2, 3 or 4
li t0, 1
sub a2, a2, t0
j end_x_component
move_left:	# -2, -3 or -4
li t0, 4
sub a2, a2, t0
end_x_component:
mv a0, zero
# y-component vector
li a1, 1	# 2 possible outcomes: +2 or -2
ecall
mv a3, a0
li t0, 1
beq a3, t0, move_down
# move_up:
li a3, -2
j end_y_component
move_down:
addi a3, a3, 1	#a3 = 2
end_y_component:
# y-coordinate: random number 0-128
li a0, 0
li a1, 128
ecall	# randintrange in a0
mv a1, a0
# x-coordinate
li a0, 128	# ball always starts in the middle of the field
ret
