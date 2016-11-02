#!/bin/bash
#PBS -l nodes=1,walltime=00:10:00
#PBS -q cpa
#PBS -d .
#PBS -o res
#PBS -e error

make -s e1 e2 e3 e4

echo -e '# program\t\tthreads\t\ttiming'

for file in $(ls encaja-e?); do
	echo -ne $file'\t\t1\t\t';
	./$file;
	if ! cmp Lenna.ppm binLenna1024.ppm; then
		echo $file execution was not correct;
	fi
done

for file in $(ls encaja-e?-p?); do
	for threads in $(echo 2 4 8 16 32); do
		echo -ne $file'\t\t'$threads'\t\t';
		OMP_NUM_THREADS=$threads ./$file
		if ! cmp Lenna.ppm binLenna1024.ppm; then
			echo $file execution with $threads threads was not correct;
		fi
	done
done

make -s clean

