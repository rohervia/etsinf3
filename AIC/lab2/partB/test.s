	.data
a:	.word 0xffffffff
cero:	.word 0
uno:	.word 1
diez:	.word 10
once:	.word 11
g1: 	.word 0
g2: 	.word 0
g3: 	.word 0
g4: 	.word 0
g5: 	.word 0
g6: 	.word 0
g7: 	.word 0
g8: 	.word 0
g9: 	.word 0
g10:	.word 0

	.text
	; Preparacion
	add r1,r0,#10
	add r2,r0,#20
	add r3,r0,#30	

	; Riesgos

	; UAL - UAL
	add r5,r3,r1
	sub r6,r5,r1
	add r7,r5,r1
	sw g1(r0),r6
	sw g2(r0),r7

	; CARGA - UAL
	lw r5,diez(r0)
	add r6,r5,r1
	sw g3(r0),r6

	; UAL - CARGA
	add r5,r0,diez
	lw r6,0(r5)
	lw r7,4(r5)
	sw g4(r0),r6
	sw g5(r0),r7
 
	; UAL - ALMACENAMIENTO
	add r5,r0,g6
	sw 0(r5),r1
	sw 4(r5),r2

	; UAL - ALMACENAMIENTO
	add r5,r1,r2
	sw g8(r0),r5

	; CARGA - ALMACENAMIENTO
	lw r5,diez(r0)
	sw g9(r0),r5

	; CARGA - CARGA
	lw r5,cero(r0)
	lw r6,diez(r5)
	sw g10(r0),r6

