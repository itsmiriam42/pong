.eqv DISPLAY_ADDRESS 0x10010000
.eqv DISPLAY_WIDTH 256
.eqv DISPLAY_HEIGHT 256
.eqv KEYBOARD_ADDDRESS 0xFFFF0000

j cesplib.end

cesp_sleep:
# Input:
#   a0: number of ms to sleep
  li a7, 32
  ecall
  ret


cesplib.end:
