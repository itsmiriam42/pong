#   ___ ___ ___ ___   _    ___ ___ _____ _   _ ___ ___ 
#  / __| __/ __| _ \ | |  | __/ __|_   _| | | | _ \ __|
# | (__| _|\__ \  _/ | |__| _| (__  | | | |_| |   / _| 
#  \___|___|___/_|   |____|___\___| |_|  \___/|_|_\___|
#
# Copyright 2021 Michael J. Klaiber

	
read_word_unaligned:
	#input 
	#     a1: (unaligned) address
	#output
	#     a0: value at address a1
	
	addi sp, sp, -16
	sw s3, (sp)
	sw s4, 4 (sp)
	sw s5, 8 (sp)
	sw ra, 12(sp)
	
	andi s3, a1, 0x3 # byte offset
	slli s3, s3, 3 # byte offset in bit
	andi a1, a1, 0xfffffffc # get next word aligned address
	lw s4, 0 (a1)
	lw s5, 4 (a1)
	srl s4, s4, s3
	addi s3, s3, -32
	sub s3, zero, s3 
	sll s5, s5, s3
	or a0, s4, s5
	
	lw s3, (sp)
	lw s4, 4 (sp)
	lw s5, 8 (sp)
	lw ra, 12(sp)
	addi sp, sp, 16
	
	ret
