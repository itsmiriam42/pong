#Function to test the soundeffects


main:
jal play_sound_brass

li a7, 10
ecall
.include "play_sound_loose.asm"	