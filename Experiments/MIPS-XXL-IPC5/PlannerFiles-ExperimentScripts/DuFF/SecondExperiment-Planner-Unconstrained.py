#!/usr/bin/env python
import os
import subprocess
import numpy as np
import math


# Goal-constrained planning domain model verification of safety properties.
# Anas Shrinah and Kerstin Eder.
# Section 6 - experiments.
# Second experiment - Unconstrained verification - Experiment script.

# The second experiment investigates the effect of the early
# termination of the verification process, after achieving the
# goal, on the cost of verification tasks while increasing the depth
# of the planning goal. The model used in this experiment has one critical
# and four independent variables, each with a range from 0 to 15.
# Variables have two actions as in the previous model. This time, there is
# no error in the model and the goal condition is varied from critical value
# 1 to 14.


if __name__ == '__main__':


	with open('./Experiments/SecondExperiment/Planner/Unconstrained/Results/CompileOut/CompileOut-Unconstrained.txt', 'w') as f:
			process = subprocess.call(['./CompileAndPlannerRun-SecondExperiment-Unonstrained.sh'], stdout=f)

	with open('./Experiments/SecondExperiment/Planner/Unconstrained/Results/FF-MetricOut/FF-MetricOut-Unconstrained.txt', 'w') as f:
		process = subprocess.call(['./FF-MetricRun.sh'], stdout=f)
