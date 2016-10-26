args = -Wall -fopenmp -lm

all: primo_grande primo_numeros

primo_grande: pg-seq pg-par

primo_numeros: pn-seq pn-par

pg-seq:
	gcc $(args) -o primo_grande_seq primo_grande.c

pg-par:
	gcc $(args) -o primo_grande_par primo_grande_par.c

pn-seq:
	gcc $(args) -o primo_numeros_seq primo_numeros.c

pn-par:
	gcc $(args) -o primo_numeros_par primo_numeros_par.c

clean:
	rm primo_numeros_{par,seq}
	rm primo_grande_{par,seq}
