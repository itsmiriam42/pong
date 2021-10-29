
# Function to draw rectangle from position x1,y1 to x2,y2 with fill color c
# a3: unsigned integer x1 -- left boundary of rectangle
# a4: unsigned integer y1 -- top boundary of rectangle
# a5: unsigned integer x2 -- right boundary of rectangle
# a6: unsigned integer y2 -- bottom boundary of rectangle
# a7: unsigned integer c  -- fill color of rectangle as RGB value

draw_rectangle:
	#Save and restore all necessary register to/from the stack

	addi sp, sp, -4
	sw ra, 0(sp)
	
	
	
	addi t3, zero, 0
	addi t4, zero, 0
	
	#sw t0, 4(sp)
	#sw t1, 8(sp)
	_loopy:
		_loopx:	
			#Move the right value to registers a1-a3 and call draw_pixel
			add a1, a3, t3	#t0 schleifenvariable für spalte
			add a2, a4, t4  #t1 schleifenvariable für zeile
			mv t2, a3	#a3-wert zwischengespeichert	
			addi a3, a7, 0		
			jal draw_pixel  #funktionsaufruf
			mv a3, t2
			
			addi t3, t3, 1	#eine spalte weiter
			bne t3, a5, _loopx	#abbruchbedingung letzte spalte erreicht
		addi t4, t4, 1
		addi t3, zero, 0					
		bne t4, a6, _loopy

	lw ra, 0(sp)	# korrekte rücksprungadresse vorgeben
	addi sp, sp, 4	# stackpointer zurücksetzen
	ret


.include "draw_pixel.asm"
