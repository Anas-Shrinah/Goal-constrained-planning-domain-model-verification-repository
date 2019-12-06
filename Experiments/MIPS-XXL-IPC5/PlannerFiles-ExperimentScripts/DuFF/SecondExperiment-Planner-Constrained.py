#!/usr/bin/env python
import os
import subprocess
import numpy as np
import math

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

def PrepearDomainFile(errorDepth):
	with open("./Experiments/SecondExperiment/Planner/Constrained/PDDL/SecondExperiment-Constrained-PlanningProblem.pddl", "r") as myFile:
		for num, line in enumerate(myFile, 1):
			if "(and        (= (critical-variable)" in line:
				print 'found at line:', num
				break
	with open('./Experiments/SecondExperiment/Planner/Constrained/PDDL/SecondExperiment-Constrained-PlanningProblem.pddl', 'r') as file:
	    # read a list of lines into data
	    data = file.readlines()

	data[num-1] = '(and        (= (critical-variable) '+str(errorDepth)+')\n'

	with open('./Experiments/SecondExperiment/Planner/Constrained/PDDL/SecondExperiment-Constrained-PlanningProblem.pddl', 'w') as file:
		file.writelines( data )


	with open("./Experiments/SecondExperiment/Planner/Constrained/PDDL/SecondExperiment-Constrained-PlanningProblem.pddl", "r") as myFile:
		for num, line in enumerate(myFile, 1):
			if "(sometime-before (= (critical-variable)" in line:
				print 'found at line:', num
				break
	with open('./Experiments/SecondExperiment/Planner/Constrained/PDDL/SecondExperiment-Constrained-PlanningProblem.pddl', 'r') as file:
	    # read a list of lines into data
	    data = file.readlines()

	data[num-1] = '      (sometime-before (= (critical-variable) '+str(errorDepth)+') (error))\n'

	with open('./Experiments/SecondExperiment/Planner/Constrained/PDDL/SecondExperiment-Constrained-PlanningProblem.pddl', 'w') as file:
		file.writelines( data )


if __name__ == '__main__':


	for errorDepth in range(1,16):

		PrepearDomainFile(errorDepth)

		with open('./Experiments/SecondExperiment/Planner/Constrained/Results/CompileOut/CompileOut-Constrained-'+str(errorDepth)+'.txt', 'w') as f:
			process = subprocess.call(['./CompileAndPlannerRun-SecondExperiment-Constrained.sh'], stdout=f)

		with open('./Experiments/SecondExperiment/Planner/Constrained/Results/FF-MetricOut/FF-MetricOut-Constrained-'+str(errorDepth)+'.txt', 'w') as f:
			process = subprocess.call(['./FF-MetricRun.sh'], stdout=f)
