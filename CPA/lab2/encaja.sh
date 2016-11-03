#!/bin/bash
#PBS -l nodes=1,walltime=00:10:00
#PBS -q cpa
#PBS -d .
#PBS -o res.csv
#PBS -e error

make -s exercises

echo 'seq-program,time'

for file in $(ls out/encaja-e?); do
	printf "%s," $file;
	$file -o out/Lenna.ppm;
	printf "\n";
	if ! cmp out/Lenna.ppm img/binLenna1024.ppm; then
		echo "%s execution was not correct" $file;
	fi
done

printf "\n";

echo 'par-program,2,4,8,16,32'

for file in $(ls out/encaja-e?-p?); do
	printf "%s," $file;
	for threads in $(echo 2 4 8 16 32); do
		OMP_NUM_THREADS=$threads $file -o out/Lenna.ppm;
		if ! cmp out/Lenna.ppm img/binLenna1024.ppm; then
			printf "%s execution with %d threads was not correct" $file $threads;
		fi
		if [ $threads -ne 32 ]; then
			printf ",";
		fi
	done
	printf "\n";
done

make -s clean

