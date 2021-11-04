#function to play a short melody using rars ecall
#      
.data
.L__const.main.pitches:
        .word   64                              # 0x40
        .word   67                             # 0x43
        .word   72                              # 0x47
        


.L__const.main.duration:
        .word   200                             # 0x190
        .word   200                             # 0x190
        .word   800                             # 0x190
       
 
.text

 
play_sound_brass:   

	mv      a4, zero
        lui     a0, %hi(.L__const.main.pitches) #load upper address
        addi    a6, a0, %lo(.L__const.main.pitches) #load lower address a6 = a0+lower 12 bit label address
        lui     a0, %hi(.L__const.main.duration)
        addi    t0, a0, %lo(.L__const.main.duration)
        addi    a7, zero, 64
addi sp, sp, -8
	sw ra, 0x0 (sp)
	sw s0,4(sp)

.LBB1_1:  
	li s0, 7
	beq a4,s0, .LBB1_1_end                              # =>This Inner Loop Header: Depth=1
        slli    a0, a4, 2
        andi    a0, a0, 28
        add     a1, a0, a6
        lw      t1, 0(a1)
        add     a0, a0, t0
        lw      a5, 0(a0)
        addi    a7, zero, 33
        mv      a0, t1
        mv      a1, a5
        addi    a3, zero, 127
        addi    a2, zero, 60 #bass
        addi    a4, a4, 1
        ecall   
        
        bne     a4, s0, .LBB1_1
.LBB1_1_end:     
        #restore
        lw ra, 0 (sp)
        lw s0,4(sp)
	addi sp, sp, 8	
        mv      a0, zero
        ret
