        .ireg 15,60
        .data
a:      .word  100
b:      .word  0
        .text
inicio:	bnez r5,final
        add r3,r1,r2
        sub r4,r1,r2
        and r5,r1,r2
        or r6,r1,r2
        xor r7,r1,r2
        lw r1,a(r0)
        sw r3,b(r0)
        sgt r2,r3,r4
        beqz r0,inicio ; salto incondicional
final:
