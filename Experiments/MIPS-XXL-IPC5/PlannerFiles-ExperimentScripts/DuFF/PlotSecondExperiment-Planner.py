#!/usr/bin/env python
import os
import subprocess
import numpy as np
import math
import re
import matplotlib.pyplot as plt

# Goal-constrained planning domain model verification of safety properties.
# Anas Shrinah and Kerstin Eder.
# Section 6 - experiments.
# Second experiment - results plot.

# The second experiment investigates the effect of the early
# termination of the verification process, after achieving the
# goal, on the cost of verification tasks while increasing the depth
# of the planning goal. The model used in this experiment has one critical
# and four independent variables, each with a range from 0 to 15.
# Variables have two actions as in the previous model. This time, there is
# no error in the model and the goal condition is varied from critical value
# 1 to 14.


UnconstrainedResultsList =[]
ConstrainedResultsList =[]
FilesNameConstrained = './Experiments/SecondExperiment/Planner/Constrained/Results/FF-MetricOut/FF-MetricOut-Constrained-'
NumberOfExperiment = 14
FilesNameUnconstrained = './Experiments/SecondExperiment/Planner/Unconstrained/Results/FF-MetricOut/FF-MetricOut-Unconstrained.txt'

def ReadExperimentResultsConstrained(errorDepth):

	with open(FilesNameConstrained+str(errorDepth)+'.txt', 'r') as myFile:
		for num, line in enumerate(myFile, 1):
			if "searching, evaluating" in line:
				print 'found at line:', num
				break
	with open(FilesNameConstrained+str(errorDepth)+'.txt', 'r') as file:
	    # read a list of lines into data
	    data = file.readlines()

	print(data[num-1])
	result = re.search('evaluating (.*) states', data[num-1])
	print(result.group(1))
	ConstrainedResultsList.append(float(result.group(1)))


def ReadExperimentResultsUnconstrained(errorDepth):

	with open(FilesNameUnconstrained, 'r') as myFile:
		for num, line in enumerate(myFile, 1):
			if "searching, evaluating" in line:
				print 'Unconstrained Unconstrained found at line:', num
				break
	with open(FilesNameUnconstrained, 'r') as file:
	    # read a list of lines into data
	    data = file.readlines()

	print(data[num-1])
	result = re.search('evaluating (.*) states', data[num-1])
	print(result)
	print(result.group(1))
	UnconstrainedResultsList.append(float(result.group(1)))


if __name__ == '__main__':


	for errorDepth in range(1,NumberOfExperiment+1):

		ReadExperimentResultsConstrained(errorDepth)
		ReadExperimentResultsUnconstrained(errorDepth)


	ConstrainedResultsArray = np.asarray(ConstrainedResultsList,dtype=np.float32)
	ConstrainedResultsArray = ConstrainedResultsArray /1000000
	UnConstrainedResultsArray = np.asarray(UnconstrainedResultsList,dtype=np.float32)
	UnConstrainedResultsArray = UnConstrainedResultsArray /1000000

	fig, ax1 = plt.subplots()
	ax1.set_xlabel('Goal depth (critical variable value)',fontsize=19)
	ax1.set_ylabel('Number of evaluated states X 1M',fontsize=19)
	ax1.scatter(range(1,NumberOfExperiment+1), ConstrainedResultsArray, color='red',label='Goal-Constrained',marker ="o",s=30)
	ax1.tick_params(axis='both',labelsize = 17)
	
	ax1.scatter(range(1,NumberOfExperiment+1), UnConstrainedResultsArray, color='blue',label='Unconstrained',marker = "x",s=30)

	fig.tight_layout()  # otherwise the right y-label is slightly clipped
	plt.xlim(0, 15)
	plt.legend(loc='lower right',fontsize=17)
	plt.grid(True)
	plt.savefig('SecondExperimentPlanner.png')
	plt.show()