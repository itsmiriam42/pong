.data
.eqv DISPLAY_ADDRESS 0x10010000
.eqv DISPLAY_WIDTH 256
.eqv DISPLAY_HEIGHT 128
.eqv KEYBOARD_ADDDRESS 0xFFFF0000
.eqv LEFT_SCORING_BORDER 26		# left scoring border is reached when the ball's center reaches this x coordinate value
.eqv RIGHT_SCORING_BORDER 230	# right scoring border is reached when the ball's center reaches this x coordinate value
.eqv PADDLE_WIDTH 5
.eqv PADDLE_HEIGHT 30
.eqv PADDLE_MOVEMENT_SPEED 3	# number of pixels that the paddle moves per keystroke
.eqv LEFT_PADDLE_BOUNDARY 18	# initial x-coordinate of the left side of the left paddle
.eqv RIGHT_PADDLE_BOUNDARY 233	# initial x-coordinate of the left side of the right paddle
.eqv TOP_PADDLE_BOUNDARY 50		# initial y-coordinate of the top side of both paddles

#cesp_sleep:
# Input:
#   a0: number of ms to sleep
  #li a7, 32
  #ecall
  #ret

#cesplib.end:
