#!/bin/bash
spin -a  PromelaModel-SecondExperiment-Constrained.pml
gcc -DMEMLIM=10240 -O2 -DBFS -DXUSAFE -DSAFETY -w -o pan pan.c
./pan -m70000000  -N p0