
.include "cesplib_rars.asm"
.text
main:

	
	# initial draw of paddles 
	jal draw_paddles	
	mv s5, a4 			# top y left
	mv s7, a6 			# top y right
	
	
	while_loop:
				
		mv a4, s5		# top y left
		mv a6, s7		# top y right
		jal move_paddles

		mv s5, a3 		# top y left
		mv s6, a4 		# bottom y left
		mv s7, a5 		# top y right
		mv s8, a6 		# bottom y right
		
		j while_loop
	
		
.include "move_paddles.asm"
.include "draw_paddles.asm"
.include "draw_rectangle.asm"
.include "draw_pixel.asm"