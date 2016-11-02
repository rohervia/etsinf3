# CPA Lab2: parallel image recovery algorithm.

## Task
An image has had its rows shuffled. The first row remains in its place. That row is selected as the current row `i`, and the distance between it and all rows below (`j`) is computed as the sumatory of the difference between each column of pixels. The most similar row to the current one is placed below it and gets selected as current row.


## Exercises
1. [Timing](src/encaja-e1.c#L167)
2. Parallelization of various loops: [loop J](src/encaja-e2-pJ.c#L118) and [loop X](src/encaja-e2-pX.c#L120).
3. [Improvement of the algorithm](src/encaja-e3.c#L122): stop computing the difference between rows if it is already bigger than the current minimum.
4. Parallelization of various loops of exercise 3: [loop J](src/encaja-e4-pJ.c#L118) and [loop X](src/encaja-e4-pX.c#L120).

## How to run
1. Compile with `make eX` where X is the number of exercise, for example `make e1`
2. Run the program as `src/encaja-e1 [-o outputFile.ppm] [-i inputFile.ppm] [-t] [-h]` where `-t` means test run. The defaults for input and output files are `/labos/asignaturas/ETSINF/cpa/p2/binLenna1024c.ppm` and `./Lenna.ppm`, respectively.
    * Alternatively, use `qsub encaja.sh` to send this program to a program queue to execute in a cluster.

## Analysis and report
Graphs of the different [tables](./csv): [time](img/time.png), [speedup](img/speedup.png) and [efficiency](img/efficiency.png).

[Final report](pdf/report.pdf) of the data
