#!/bin/bash
#PBS -l nodes=1,walltime=00:10:00
#PBS -q cpa
#PBS -d .
#PBS -o res.csv
#PBS -e error

if [[ $1 == seq ]] then;
    make -s e1 e3
    echo 'program,time'

    for file in $(ls src/encaja-e?); do
        printf "%s," $file;
        src/$file -o img/Lenna.ppm;
        if ! cmp img/Lenna.ppm img/binLenna1024.ppm; then
            echo "%s execution was not correct" src/$file;
        fi
    done

    make -s clean
elif [[ $1 == par ]]; then
    make -s e2 e4
    echo 'program,2,4,8,16,32'

    for file in $(ls src/encaja-e?-p?); do
        printf "%s," $file;
        for threads in $(echo 2 4 8 16 32); do
            OMP_NUM_THREADS=$threads src/$file -o img/Lenna.ppm;
            if ! cmp img/Lenna.ppm img/binLenna1024.ppm; then
                printf "%s execution with %d threads was not correct" src/$file $threads;
            fi
            if [ $threads -ne 32 ]; then
                printf ",";
            fi
        done
        printf "\n";
    done

    make -s clean
else
    echo -e 'Usage: qsub encaja.sh seq\|par';
fi

