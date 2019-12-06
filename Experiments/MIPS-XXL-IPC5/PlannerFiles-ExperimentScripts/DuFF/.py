#!/usr/bin/env python
import os
import subprocess
import numpy as np
import math



def PrepearDomainFile(errorDepth):
	with open("/home/anas/domain-model-verification-revisited/Goal-Constrained-Planning-Domain-Verification-Example-master/Cave-Diving/PDDL/Preliminary/SimplestwithAdditionalActions-Dom-autoTemplate.pddl", "r") as myFile:
		for num, line in enumerate(myFile, 1):
			if ":precondition (and (= (critical-variable)" in line:
				print 'found at line:', num
				break
	with open('/home/anas/domain-model-verification-revisited/Goal-Constrained-Planning-Domain-Verification-Example-master/Cave-Diving/PDDL/Preliminary/SimplestwithAdditionalActions-Dom-autoTemplate.pddl', 'r') as file:
	    # read a list of lines into data
	    data = file.readlines()

	data[num-1] = '    :precondition (and (= (critical-variable) '+str(errorDepth)+') )\n'

	with open('/home/anas/domain-model-verification-revisited/Goal-Constrained-Planning-Domain-Verification-Example-master/Cave-Diving/PDDL/Preliminary/SimplestwithAdditionalActions-Dom-autoTemplate.pddl', 'w') as file:
		file.writelines( data )


if __name__ == '__main__':


	for errorDepth in range(15,16):

		PrepearDomainFile(errorDepth)

		with open('Goal-Constrained-Experiment-1/CompileOut'+str(errorDepth)+'.txt', 'w') as f:
			process = subprocess.call(['./CompileRun.sh'], stdout=f)

		with open('Goal-Constrained-Experiment-1/FF-MetricOut'+str(errorDepth)+'.txt', 'w') as f:
			process = subprocess.call(['./FF-MetricRun.sh'], stdout=f)
