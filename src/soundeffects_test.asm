#Function to test the soundeffects

.data 
sucess_label: .string "Programm terminated sucessfully \0"

.text
main:
jal play_soundeffect
jal play_sound_brass

li a7, 4 
la a0, sucess_label 
ecall

li a7, 10
ecall
.include "play_sound_win.asm"	
.include "play_soundeffect.asm"	