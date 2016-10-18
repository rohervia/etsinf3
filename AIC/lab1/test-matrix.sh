#!/bin/bash
args="1 1024"
echo matrix-std
time ./matrix-std $args
echo matrix-sse
time ./matrix-sse $args
echo matrix-res
time ./matrix-res $args
