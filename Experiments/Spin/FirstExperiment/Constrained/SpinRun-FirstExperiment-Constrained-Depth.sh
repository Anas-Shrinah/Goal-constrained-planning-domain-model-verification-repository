#!/bin/bash
spin -a  PromelaModel-FirstExperiment-Constrained.pml
gcc -DMEMLIM=10240 -O2 -DXUSAFE -DSAFETY -w -o pan pan.c
./pan -m70000000  -N p0