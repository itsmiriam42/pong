.data
.eqv DISPLAY_ADDRESS 0x10010000
.eqv DISPLAY_WIDTH 256
.eqv DISPLAY_HEIGHT 128
.eqv KEYBOARD_ADDDRESS 0xFFFF0000

bmp_filename_winner_r: .string "C:/rars_programming_project/pong-main/src/winner_right.bmp"
bmp_filename_start: .string "C:/rars_programming_project/pong-main/src/startbildschirm.bmp"
mp_filename_winner_l: .string "C:/rars_programming_project/pong-main/src/winner_right.bmp"
j cesplib.end

cesp_sleep:
# Input:
#   a0: number of ms to sleep
  li a7, 32
  ecall
  ret


cesplib.end:
