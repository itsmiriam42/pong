
#function to play a short soundeffect 
.text

main:                                   
        
	jal play_soundeffect  
	#end
	li a7, 10
	ecall
	
 
play_soundeffect:

	addi sp, sp, -4
	sw ra, 0x0 (sp)
	li a7,33
        addi    a0, zero, 60
       	addi 	a1, zero, 400
        addi    a3, zero, 127
        addi    a2, zero, 113 #bass
        ecall   

        #restore
        lw ra, 0 (sp)
	addi sp, sp, 4
        mv      a0, zero
        ret
