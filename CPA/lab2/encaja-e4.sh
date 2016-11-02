#!/bin/bash
#PBS -l nodes=1,walltime=00:10:00
#PBS -q cpa
#PBS -d .

make e4

echo ./encaja-e4-pJ
./encaja-e4-pJ
echo "cmp Lenna.ppm binLenna1024.ppm"
cmp Lenna.ppm binLenna1024.ppm

echo ''

echo ./encaja-e4-pX
./encaja-e4-pX
echo "cmp Lenna.ppm binLenna1024.ppm"
cmp Lenna.ppm binLenna1024.ppm

echo ''
