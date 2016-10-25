#!/bin/bash
#PBS -l nodes=1,walltime=00:10:00
#PBS -q cpa
#PBS -d .

echo ./encaja-3
./encaja-3
echo -e "\n\ncmp Lenna.ppm binLenna1024.ppm"
cmp Lenna.ppm binLenna1024.ppm
echo ./encaja-3-par1
./encaja-3-par1
echo -e "\n\ncmp Lenna.ppm binLenna1024.ppm"
cmp Lenna.ppm binLenna1024.ppm
echo ./encaja-3-par2
./encaja-3-par2
echo -e "\n\ncmp Lenna.ppm binLenna1024.ppm"
cmp Lenna.ppm binLenna1024.ppm
