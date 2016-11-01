        .ireg 0,0,0,65
        .data
a:      .word 100        
        .text
        lw r3,a(r0)
        sub r3,r3,r4
        ; el resultado debe ser r3=35
