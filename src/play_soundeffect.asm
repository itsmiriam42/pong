
#function to play a short soundeffect 
# gets:
# - 
# returns:
# - 
.text

 
play_soundeffect:

	addi sp, sp, -4
	sw ra, 0x0 (sp)
	li a7,33
        addi    a0, zero, 45
       	addi 	a1, zero, 500
        addi    a3, zero, 127
        addi    a2, zero, 118 #Percussion
        ecall   
       
        #restore
        lw ra, 0 (sp)
	addi sp, sp, 4
        mv      a0, zero
        ret
