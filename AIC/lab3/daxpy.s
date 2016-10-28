        ; z = a*x + y
        ; Tamaño de los vectores: 64 palabras
        ; Vector x
	.data
x:      .double 0,1,2,3,4,5,6,7,8,9
        .double 10,11,12,13,14,15,16,17,18,19
        .double 20,21,22,23,24,25,26,27,28,29
        .double 30,31,32,33,34,35,36,37,38,39
        .double 40,41,42,43,44,45,46,47,48,49
        .double 50,51,52,53,54,55,56,57,58,59
        .double 60,61,62,63

	; Vector y
y:      .double 100,100,100,100,100,100,100,100,100,100
	.double 100,100,100,100,100,100,100,100,100,100
	.double 100,100,100,100,100,100,100,100,100,100
	.double 100,100,100,100,100,100,100,100,100,100
	.double 100,100,100,100,100,100,100,100,100,100
	.double 100,100,100,100,100,100,100,100,100,100
	.double 100,100,100,100

        ; Vector z
	;   64 elementos son 512 bytes
z:      .space 512

        ; Escalar a
a:      .double 1

        ; El código
	.text

start:
	l.d f0, a(r0)
	dadd r2, r0, x
	dadd r3, r0, y
	dadd r4, r0, z
	daddi r10, r0, #64

loop:
	l.d f2, 0(r2)
	l.d f4, 0(r3)
	mul.d f6, f0, f2
	add.d f6, f6, f4
	s.d f6, 0(r4)
	daddi r2, r2, #8
	daddi r3, r3, #8
	daddi r4, r4, #8
	dsubi r10, r10, #1
	bnez r10, loop
	nop

	trap #0

