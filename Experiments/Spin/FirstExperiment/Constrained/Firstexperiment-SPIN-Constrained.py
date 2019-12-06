#!/usr/bin/env python
import os
import subprocess
import numpy as np
import math
import sys


# Goal-constrained planning domain model verification of safety properties.
# Anas Shrinah and Kerstin Eder.
# Section 6 - experiments.
# First experiment - goal constrained verification - experiment script.

# The first experiment focuses on comparing the cost of both
# unconstrained and goal-constrained verification tasks while
# varying the safety property violation depth in order to explore 
# situations with and without a valid planning counterexample.

# The safety property violation depth is hereafter termed (error depth).
# We synthesised a fully reachable model that consists of one critical and three
# independent variables, each with a range from 0 to 31. 
# Each variable has two actions, one to increase and one to decrease its value
# by one. The goal is achieved when the critical variable value
# reaches 14. The error condition is changed from the value of
# the critical variable being 1 to 31.


def PrepearModelFile(errorDepth):
# locate the error setting line and change the critical variable threshold as per the error depth.

	with open("./PromelaModel-FirstExperiment-Constrained.pml", "r") as myFile:
		for num, line in enumerate(myFile, 1):
			if "::atomic{ (CriticalVariable == " in line:
				print 'found at line:', num
				break
	with open('./PromelaModel-FirstExperiment-Constrained.pml', 'r') as file:
	    # read a list of lines into data
	    data = file.readlines()

	data[num-1] = '		::atomic{ (CriticalVariable == '+str(errorDepth)+')  -> Error = 1}\n'

	with open('./PromelaModel-FirstExperiment-Constrained.pml', 'w') as file:
		file.writelines( data )


if __name__ == '__main__':

	print sys.argv[1]

	for errorDepth in range(1,31):

		PrepearModelFile(errorDepth)

		if sys.argv[1] == 'Depth':
			with open('./Results/DepthFirst/Constrained-1-'+str(errorDepth)+'.txt', 'w') as f:
				process = subprocess.call(['./SpinRun-FirstExperiment-Constrained-Depth.sh'], stdout=f)
		else:
			if sys.argv[1] == 'Breadth':
				with open('./Results/BreadthFirst/Constrained-1-'+str(errorDepth)+'.txt', 'w') as f:
					rocess = subprocess.call(['./SpinRun-FirstExperiment-Constrained-Breadth.sh'], stdout=f)
			else:
				print "Invalid argument! Please choose either Depth or Breadth"

	