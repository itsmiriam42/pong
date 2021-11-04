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

.include "cesplib_rars.asm"
.text
main:

#start_loop:
#jal start_image
#li 	t0, KEYBOARD_ADDDRESS
#li 	t1, 'k'
#bne 	t0, t1, start_loop

	jal init_ball 
	# move returened values into registers s1-s4 
	# s1-s4 used by ball_control
	mv s1, a0 # x-coordinate of the ball's center
	mv s2, a1 # y-coordinate of the ball's center
	mv s3, a2 # x-component of the ball's new vector
	mv s4, a3 # y-component of the ball's new vector

	# draw ball to Bitmap Display
	mv a1, s1 
	mv a2,s2
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
		li t1, 0
		beq s9, t1, while_loop
		li t1,1
		beq s9, t1, score_left
		li t1, 2
		beq s9, t1, score_right
		score_left:
			li t1, 1
			add s10, t1 ,s10#score left ++
			mv a2, s10
			jal draw_left_number
			jal play_soundeffect
		score_right:
			li t1, 1
			add s11, s11,t1 #score right ++
			mv a2, s11
			jal draw_right_number
			jal play_soundeffect
		j while_loop
	end_game:
		li t1, 11
		beq s10, t1 , win_left_player
		beq s11, t1 , win_right_player
		win_left_player:
			jal win_image_left
		win_right_player:
			jal win_image_right
		jal play_sound_brass

	
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
