#!/bin/bash
args="100000 1024"
echo scalar-std
time ./scalar-std $args
echo scalar-sse
time ./scalar-std-sse $args
echo scalar-none
time ./scalar-std-bullshit $args
