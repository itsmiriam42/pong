# Function to call the funtions that display the start and win - screen
j main

.include "cesplib_rars.asm"
.include "display_image.asm"

.text
main:

jal start_image


li a7, 10
ecall
