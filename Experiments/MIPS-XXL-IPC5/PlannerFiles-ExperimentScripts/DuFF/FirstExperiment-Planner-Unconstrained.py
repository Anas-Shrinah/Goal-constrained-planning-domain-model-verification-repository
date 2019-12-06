#!/usr/bin/env python
import os
import subprocess
import numpy as np
import math

# Goal-constrained planning domain model verification of safety properties.
# Anas Shrinah and Kerstin Eder.
# Section 6 - experiments.
# First experiment - Unconstrained verification - experiment script.

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


def PrepearDomainFile(errorDepth):
	# locate the error setting line and change the critical variable threshold as per the error depth.
	with open("./Experiments/FirstExperiment/Planner/Unconstrained/PDDL/FirstExperiment-Unconstrained-PlanningDomainModel.pddl", "r") as myFile:
		for num, line in enumerate(myFile, 1):
			if ":precondition (and (= (critical-variable)" in line:
				print 'found at line:', num
				break
	with open('./Experiments/FirstExperiment/Planner/Unconstrained/PDDL/FirstExperiment-Unconstrained-PlanningDomainModel.pddl', 'r') as file:
	    # read a list of lines into data
	    data = file.readlines()

	data[num-1] = '    :precondition (and (= (critical-variable) '+str(errorDepth)+') )\n'

	with open('./Experiments/FirstExperiment/Planner/Unconstrained/PDDL/FirstExperiment-Unconstrained-PlanningDomainModel.pddl', 'w') as file:
		file.writelines( data )


if __name__ == '__main__':


	for errorDepth in range(1,31):

		PrepearDomainFile(errorDepth)

		with open('./Experiments/FirstExperiment/Planner/Unconstrained/Results/CompileOut/First-Unconstrtained-CompileOut'+str(errorDepth)+'.txt', 'w') as f:
			process = subprocess.call(['./CompileAndPlannerRun-FirstExperiment-Unconstrained.sh'], stdout=f)

		with open('./Experiments/FirstExperiment/Planner/Unconstrained/Results/FF-MetricOut/First-Unconstrtained-FF-MetricOut'+str(errorDepth)+'.txt', 'w') as f:
			process = subprocess.call(['./FF-MetricRun.sh'], stdout=f)
