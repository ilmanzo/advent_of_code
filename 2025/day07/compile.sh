#!/bin/sh
echo "--- naive ---"
ldmd2 day07_naive.d -boundscheck=off -mcpu=native -O3
rm day07_naive.o ; strip day07_naive
./day07_naive input.txt && rm day07_naive
echo "--- optimized ---"
ldmd2 day07.d -boundscheck=off -mcpu=native -O3
rm day07.o ; strip day07
./day07 input.txt && rm day07