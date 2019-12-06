#!/usr/bin/env python
import os
import subprocess
import numpy as np
import math
import re
import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter


# Goal-constrained planning domain model verification of safety properties.
# Anas Shrinah and Kerstin Eder.
# Section 6 - experiments.
# First experiment - results plot.

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

UnconstrainedResultsList =[]
ConstrainedResultsList =[]
FilesNameUnConstrained = 'Goal-Constrained-Experiment-1/FirstExperiment-planner-unconstrained/FF-MetricOut-Unconstrained-1-'
NumberOfExperiment = 30
FilesNameConstrained = 'Goal-Constrained-Experiment-1/FirstExperiment-planner-constrained/05-11-2019/FF-MetricOut'

def ReadExperimentResultsConstrained(errorDepth):

	with open(FilesNameConstrained+str(errorDepth)+'.txt', 'r') as myFile:
		for num, line in enumerate(myFile, 1):
			if "searching, evaluating" in line:
				# print 'found at line:', num
				break
	with open(FilesNameConstrained+str(errorDepth)+'.txt', 'r') as file:
	    # read a list of lines into data
	    data = file.readlines()

	result = re.search('evaluating (.*) states', data[num-1])
	print(result.group(1))

	ConstrainedResultsList.append(int(result.group(1)))


def ReadExperimentResultsUnConstrained(errorDepth):

	with open(FilesNameUnConstrained+str(errorDepth)+'.txt', 'r') as myFile:
		for num, line in enumerate(myFile, 1):
			if "searching, evaluating" in line:
				# print 'found at line:', num
				break
	with open(FilesNameUnConstrained+str(errorDepth)+'.txt', 'r') as file:
	    # read a list of lines into data
	    data = file.readlines()

	result = re.search('evaluating (.*) states', data[num-1])
	print(result.group(1))
	UnconstrainedResultsList.append(int(result.group(1)))


def millions(x, pos):
	# format the x axis scale
    'The two args are the value and tick position'
    if x > 400000:
    	return '%1.1fM' % (x * 1e-6)
    else:
    	return '%1iK' % (x * 1e-3)



if __name__ == '__main__':


	for errorDepth in range(1,NumberOfExperiment+1):

		ReadExperimentResultsConstrained(errorDepth)
		ReadExperimentResultsUnConstrained(errorDepth)

	ConstrainedResultsArray = np.asarray(ConstrainedResultsList,dtype=np.float32)
	ConstrainedResultsArrayK = ConstrainedResultsArray / 1000
	ConstrainedResultsArrayM = ConstrainedResultsArray / 1000000

	for x in range(NumberOfExperiment):
		print ConstrainedResultsArray[x] 
	
		print x
		print "======================================"



	UnConstrainedResultsArray = np.asarray(UnconstrainedResultsList)
	

	formatter = FuncFormatter(millions)
	



	fig, axs = plt.subplots(3, 1, sharex=True)
	# Remove horizontal space between axes
	fig.subplots_adjust(hspace=0)
	axs[0].tick_params(axis='both',labelsize = 17)
	axs[1].tick_params(axis='both',labelsize = 17)
	axs[2].tick_params(axis='both',labelsize = 17)


	# Plot each graph, and manually set the y tick values
	axs[0].yaxis.set_major_formatter(formatter)
	axs[0].scatter(range(14,NumberOfExperiment+1),ConstrainedResultsArray[13:], color='red',label='Goal-Constrained',marker ="o",s=30)
	axs[0].set_yticks(np.arange(1500000, 2600000, 500000))
	axs[0].set_ylim(1400000, 2600000)

	axs[0].grid()


	
	axs[1].yaxis.set_major_formatter(formatter)
	axs[1].scatter(range(1,13+1), ConstrainedResultsArray[:13], color='red',label='Goal-Constrained',marker ="o",s=30)
	axs[1].set_yticks(np.arange(10000, 31000, 5000))
	axs[1].set_ylim(9000, 32000)

	axs[1].grid()

	axs[2].scatter(range(1,NumberOfExperiment+1), UnConstrainedResultsArray, color='blue',label='Unconstrained',marker = "x",s=30)
	axs[2].set_yticks(range(0, 160, 50))
	axs[2].set_ylim(0, 170)

	axs[2].set_xlabel('Error depth (critical variable value)',fontsize=19)
	axs[2].grid()


	fig.text(0.001, 0.5, 'Number of evaluated states', va='center', rotation='vertical',fontsize=19)

	plt.xlim(0, 31)

	plt.rcParams['axes.grid'] = True


	axs[1].legend(loc='lower right',fontsize=17)
	axs[2].legend(loc='upper left',fontsize=17)
	axs[0].annotate("(1)", weight='bold', xy=(0.85, 0.67), xycoords="axes fraction")
	axs[1].annotate("(2)",weight='bold', xy=(0.85, 0.80), xycoords="axes fraction")
	axs[2].annotate("(3)",weight='bold', xy=(0.85, 0.80), xycoords="axes fraction")


	axs[0].axvline(x=14, c = 'black', linestyle='--',linewidth = 2)
	axs[1].axvline(x=14, c = 'black', linestyle='--',linewidth = 2)
	axs[2].axvline(x=14, c = 'black', linestyle='--',linewidth = 2)

	plt.savefig('FirstExperimentPlanner-Subplots.png')
	plt.show()