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
# First experiment - goal constrained verification - results plot.

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
FilesNameConstrained = './FirstExperiment/Constrained/Results/BreadthFirst/Constrained-1-'
FilesNameUnconstrained = './FirstExperiment/Unconstrained/Results/BreadthFirst/Unconstrained-1-'
NumberOfExperiment = 30


def ReadExperimentResultsConstrained(errorDepth):

	with open(FilesNameConstrained+str(errorDepth)+'.txt', 'r') as myFile:
		for num, line in enumerate(myFile, 1):
			if "transitions (= stored+matched)" in line:
				print 'found at line:', num
				break
	with open(FilesNameConstrained+str(errorDepth)+'.txt', 'r') as file:
	    # read a list of lines into data
	    data = file.readlines()

	print(data[num-1])
	result = re.search('(.*)transitions', data[num-1])
	print(result)
	print(result.group(1))
	ConstrainedResultsList.append(float(result.group(1)))



def ReadExperimentResultsUnconstrained(errorDepth):

	with open(FilesNameUnconstrained+str(errorDepth)+'.txt', 'r') as myFile:
		for num, line in enumerate(myFile, 1):
			if "transitions (= stored+matched)" in line:
				print 'found at line:', num
				break
	with open(FilesNameUnconstrained+str(errorDepth)+'.txt', 'r') as file:
	    # read a list of lines into data
	    data = file.readlines()

	print(data[num-1])
	result = re.search('(.*)transitions', data[num-1])
	print(result)
	print(result.group(1))
	UnconstrainedResultsList.append(float(result.group(1)))


def millions(x, pos):
	# format the x axis scale	 
    'The two args are the value and tick position'
    if x == 0:
    	return '%1i' % (x * 1)
    if x > 400000:
    	return '%1.1fM' % (x * 1e-6)
    else:
    	return '%1iK' % (x * 1e-3)

def get_axis_limits(ax, scale=.9):
    return ax.get_xlim()[1]*scale, ax.get_ylim()[1]*scale


if __name__ == '__main__':


	for errorDepth in range(1,NumberOfExperiment+1):

		ReadExperimentResultsConstrained(errorDepth)
		ReadExperimentResultsUnconstrained(errorDepth)


	ConstrainedResultsArray = np.asarray(ConstrainedResultsList,dtype=np.float32)
	UnConstrainedResultsArray = np.asarray(UnconstrainedResultsList,dtype=np.float32)


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

	axs[0].set_yticks(range(3500000, 5500001, 1000000))
	axs[0].set_ylim(3400000, 5600000)

	axs[0].grid()


	
	axs[1].yaxis.set_major_formatter(formatter)
	axs[1].scatter(range(1,13+1), ConstrainedResultsArray[:13], color='red',label='Goal-Constrained',marker ="o",s=30)

	axs[1].set_yticks(range(20000, 100000, 20000))
	axs[1].set_ylim(10000, 90000)

	axs[1].grid()

	axs[2].yaxis.set_major_formatter(formatter)
	axs[2].scatter(range(1,NumberOfExperiment+1), UnConstrainedResultsArray, color='blue',label='Unconstrained',marker = "x",s=30)
	axs[2].set_yticks(range(0, 410000, 100000))
	axs[2].set_ylim(-50000, 450000)
	axs[2].set_xlabel('Error depth (critical variable value)',fontsize=19)
	axs[2].grid()


	fig.text(0.001, 0.5, 'Number of evaluated states', va='center', rotation='vertical',fontsize=19)


	plt.xlim(0, 31)
	plt.rcParams['axes.grid'] = True

	axs[1].legend(loc='lower right',fontsize=17)
	axs[2].legend(loc='upper left',fontsize=17)
	axs[0].annotate("(1)", weight='bold', xy=(0.85, 0.70), xycoords="axes fraction")
	axs[1].annotate("(2)",weight='bold', xy=(0.85, 0.70), xycoords="axes fraction")
	axs[2].annotate("(3)",weight='bold', xy=(0.85, 0.77), xycoords="axes fraction")


	axs[0].axvline(x=14, c = 'black', linestyle='--',linewidth = 2)
	axs[1].axvline(x=14, c = 'black', linestyle='--',linewidth = 2)
	axs[2].axvline(x=14, c = 'black', linestyle='--',linewidth = 2)

	plt.savefig('FirstExperimentSPIN-EvaluatedStates-BreadthFirst-SubPlot.png')
	plt.show()