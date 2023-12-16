#!/bin/sh
rm *.o
dmd -ofday16 *.d
./day16
rm day16 *.o
