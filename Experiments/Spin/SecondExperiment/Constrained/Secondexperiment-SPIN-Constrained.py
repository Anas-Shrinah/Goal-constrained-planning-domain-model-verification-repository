#!/usr/bin/env python
import os
import subprocess
import numpy as np
import math
import sys


# Goal-constrained planning domain model verification of safety properties.
# Anas Shrinah and Kerstin Eder.
# Section 6 - experiments.
# Second experiment - goal constrained verification - Experiment script.

# The second experiment investigates the effect of the early
# termination of the verification process, after achieving the
# goal, on the cost of verification tasks while increasing the depth
# of the planning goal. The model used in this experiment has one critical
# and four independent variables, each with a range from 0 to 15.
# Variables have two actions as in the previous model. This time, there is
# no error in the model and the goal condition is varied from critical value
# 1 to 14.

def PrepearModelFile(errorDepth):
# locate the error setting line and change the critical variable threshold as per the error depth.

	with open("./PromelaModel-SecondExperiment-Constrained.pml", "r") as myFile:
		for num, line in enumerate(myFile, 1):
			if "ltl p0 {!(<>(Error == 1) && <> (CriticalVariable == " in line:
				print 'found at line:', num
				break
	with open('./PromelaModel-SecondExperiment-Constrained.pml', 'r') as file:
	    # read a list of lines into data
	    data = file.readlines()

	data[num-1] = 'ltl p0 {!(<>(Error == 1) && <> (CriticalVariable == '+str(errorDepth)+'))}\n'

	with open('./PromelaModel-SecondExperiment-Constrained.pml', 'w') as file:
		file.writelines( data )

######################################################
	with open("./PromelaModel-SecondExperiment-Constrained.pml", "r") as myFile:
		for num, line in enumerate(myFile, 1):
			if "::(!(CriticalVariable == " in line:
				print 'found at line:', num
				break
	with open('./PromelaModel-SecondExperiment-Constrained.pml', 'r') as file:
	    # read a list of lines into data
	    data = file.readlines()

	data[num-1] = '	::(!(CriticalVariable == '+str(errorDepth)+')) ->\n'

	with open('./PromelaModel-SecondExperiment-Constrained.pml', 'w') as file:
		file.writelines( data )

######################################################
	with open("./PromelaModel-SecondExperiment-Constrained.pml", "r") as myFile:
		for num, line in enumerate(myFile, 1):
			if "::  (CriticalVariable ==" in line:
				print 'found at line:', num
				break
	with open('./PromelaModel-SecondExperiment-Constrained.pml', 'r') as file:
	    # read a list of lines into data
	    data = file.readlines()

	data[num-1] = '::  (CriticalVariable == '+str(errorDepth)+' )-> break\n'

	with open('./PromelaModel-SecondExperiment-Constrained.pml', 'w') as file:
		file.writelines( data )





if __name__ == '__main__':


	for errorDepth in range(1,16):

		PrepearModelFile(errorDepth)
		if sys.argv[1] == 'Depth':
			with open('./Results/DepthFirst/Constrained-2-'+str(errorDepth)+'.txt', 'w') as f:
				process = subprocess.call(['./SpinRun-SecondExperiment-Constrained-Depth.sh'], stdout=f)
		else:
			if sys.argv[1] == 'Breadth':
				with open('./Results/BreadthFirst/Constrained-2-'+str(errorDepth)+'.txt', 'w') as f:
					process = subprocess.call(['./SpinRun-SecondExperiment-Constrained-Breadth.sh'], stdout=f)
			else:
				print "Invalid argument! Please choose either Depth or Breadth"

