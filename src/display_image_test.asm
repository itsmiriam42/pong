
j main

.include "cesplib_rars.asm"
.include "display_image.asm"

.text
main:
la a1, bmp_filename_winner_r
li a2, BMP_BUFFER
li a3, DISPLAY_ADDRESS

jal load_bmp


li a7, 10
ecall
