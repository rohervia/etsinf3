    ; suma las componentes del vector hasta que encuentra
    ; una componente a 0
    ; almacena el resultado en a
        .data
a:  .word  0
y:  .word  1,2,3,0,4,5,6,7,8
        .text
    add r2,r0,y; r2 recorre y
    add r1,r0,r0; r1=0
    nop ; evitar riesgos de datos no previstos
bucle:  lw r3,0(r2); r3 es y[i]
    add r1,r3,r1; este riesgo está previsto
    add r2,r2,#4
    bnez r3,bucle
    sw r1,a(r0)
final:
