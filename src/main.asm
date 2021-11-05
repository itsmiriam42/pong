# Main-Funktion 
# Spielablauf:
# 1. Startbildschirm aufrufen
# 2. Init: draw_ball + draw_paddle
# 3. Init scoreboard 
# 
# while score <11  {
# do  {
# 4. move_paddel
# 5. ball_control  } while keine Kollision
# 
# wenn Kollision:  {
#  scoreboard        ( 1 linke Seite, 2 rechte Seite, 0 alles gut :))
#  soundeffekt
# score ++
#  } }
# display_image
# soundeffekt
# score = 0

.data
loop_test: .string "for_loop\n"


.include "cesplib_rars.asm"
.text
main: 
jal start_image
start_loop:
li s0, KEYBOARD_ADDDRESS
lw t0, (s0)
beq t0, zero start_loop
lw t0, 4(s0)
li t1, 'p'
#print to console
li  a7, 4          # Prints a null-terminated string to the console
la a0, loop_test
ecall
bne 	t0, 	t1, 	start_loop
	jal draw_blackscreen
	jal init_ball 
	# move returned values into registers s1-s4 
	# s1-s4 used by ball_control
	mv s1, a0 # x-coordinate of the ball's center
	mv s2, a1 # y-coordinate of the ball's center
	mv s3, a2 # x-component of the ball's new vector
	mv s4, a3 # y-component of the ball's new vector

	# draw ball to Bitmap Display
	mv a1, s1 
	mv a2,s2
	li a3, 0xffffff	#white
	jal draw_ball

	# initial draw of paddles 
	jal draw_paddles	
	mv s5, a4 			# highest y coordinate reached by the paddle on the left
	mv s7, a6 			# highest y coordinate reached by the paddle on the right
	# initialize scoreboard: display 0 : 0
	jal init_scoreboard 

	li s10, 0 # score left
	li s11, 0 # score right

	while_loop:
		li t1, 11
		beq s10,t1 , end_game
		beq s11, t1, end_game
		
		mv a4, s5		# highest y coordinate reached by the paddle on the left
		mv a6, s7		# highest y coordinate reached by the paddle on the right
		jal move_paddles

		mv s5, a3 		# highest y coordinate reached by the paddle on the left
		mv s6, a4 		# lowest y coordinate reached by the paddle on the left
		mv s7, a5 		# highest y coordinate reached by the paddle on the right
		mv s8, a6 		# lowest y coordinate reached by the paddle on the right
		jal ball_control
		
		# cesp_sleep to adapt speed of ball
		#li a0, 50
		#li a7, 32
  		#ecall
		
		li t1, 0
		beq s9, t1, while_loop
		li t1,1
		beq s9, t1, score_left
		li t1, 2
		beq s9, t1, score_right
		score_left: # Right Player scored on the left side
			#li t1, 1
			#add s10, t1 ,s10
			addi s10, s10, 1	#score left ++
			li s9, 0 #score indicator = 0
			mv a2, s10
			jal draw_right_number
			jal play_soundeffect
			jal init_ball
			# move returned values into registers s1-s4 
			# s1-s4 used by ball_control
			mv s1, a0 # x-coordinate of the ball's center
			mv s2, a1 # y-coordinate of the ball's center
			mv s3, a2 # x-component of the ball's new vector
			mv s4, a3 # y-component of the ball's new vector

			# draw ball to Bitmap Display
			mv a1, s1 
			mv a2,s2
			li a3, 0xffffff	#white
			jal draw_ball
			j while_loop
		score_right: # Left Player scored on the right side
			li t1, 1
			add s11, s11,t1 #score right ++
			li s9, 0 #score indicator = 0
			mv a2, s11
			jal draw_left_number
			jal play_soundeffect
			jal init_ball
			# move returned values into registers s1-s4 
			# s1-s4 used by ball_control
			mv s1, a0 # x-coordinate of the ball's center
			mv s2, a1 # y-coordinate of the ball's center
			mv s3, a2 # x-component of the ball's new vector
			mv s4, a3 # y-component of the ball's new vector

			# draw ball to Bitmap Display
			mv a1, s1 
			mv a2,s2
			li a3, 0xffffff	#white
			jal draw_ball
		j while_loop
	end_game:
	#print to console
	li  a7, 1          # Prints 1
	li a0, 1
	ecall
		li t1, 11
		beq s10, t1,  win_left_player
		beq s11, t1,  win_right_player
		win_right_player:
			jal draw_blackscreen
			jal draw_winscreen
			#jal win_image_right
			li  a7, 1          # Prints 2
			li a0, 2
			ecall
			j sound_end
		win_left_player:
			jal draw_blackscreen
			jal draw_winscreen
			li  a7, 1          # Prints 3
			li a0, 3
			ecall
		
		sound_end:
		#jal play_sound_brass

	
	# end game 
		li a7, 10
		ecall
		
.include "move_paddles.asm"	
.include "draw_pixel.asm"
.include "draw_line.asm"
.include "draw_circle.asm"
.include "ball_actions.asm"
.include "draw_ball.asm"
.include "draw_paddles.asm"
.include "draw_rectangle.asm"
.include "move_ball.asm"
.include "play_sound_win.asm"	
.include "play_soundeffect.asm"
.include "scoreboard.asm"
.include "readwordunaligned.asm"
.include "display_image.asm"
.include "draw_blackscreen.asm"
.include "draw_winscreen.asm"
