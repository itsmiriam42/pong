# Function to test the scoreboard.asm
.data 
sucess_label: .string "Programm terminated sucessfully \0"
.include "cesplib_rars.asm"
.text

main:

jal draw_winscreen


li a7, 4 
la a0, sucess_label 
ecall

li a7, 10
ecall

.include "draw_circle.asm"
.include "draw_line.asm"
.include "draw_pixel.asm"
.include "draw_winscreen.asm" 
.include "scoreboard.asm"