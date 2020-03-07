# Goal-constrained planning domain model verification of safety properties
## Example
As an example, we consider the classical cave diving planning domain taken from the Satisficing Track of the IPC-2014. For this example, a slightly modified version of the cave diving model is used. The modifications are further explained in the commented planning domain model PDDL file, the tasks problem PDDL and Promela files in the **Example** folder. 

The PDDL and Promela files of the following verification tasks are in [Verification_tasks_PDDL](https://github.com/Anas-Shrinah/Goal-constrained-planning-domain-model-verification-repository/tree/master/Example/Cave-Diving/PDDL) and [Verification_tasks_Promela](https://github.com/Anas-Shrinah/Goal-constrained-planning-domain-model-verification-repository/tree/master/Example/Cave-Diving/Promela), respectively.

1. Unconstrained verification with only the safety property.   
1. Verification with safety property and incomplete goal (mission target only).
1. Verification using Spin with both safety property and proper goal but without the augmented model M'.(This is only in Promela folder as it is related to model checking only)
1. Goal-constrained planning domain verification, as presented in this paper.

## Experiments
The first experiment focuses on comparing the cost of both unconstrained and goal-constrained verification tasks while varying the safety property violation depth.

The second experiment investigates the effect of the early termination of the verification process, after achieving the goal, on the cost of verification tasks while increasing the depth of the planning goal.

Each experiment is carried out using the Spin model checker and the MIPS-XXL planner to contrast our approach *goal constrained verification* and the unconstrained traditional method.

To run first and second experiments for both constrained and unconstrained approaches using Spin, execute the Python codes in [here](https://github.com/Anas-Shrinah/Goal-constrained-planning-domain-model-verification-repository/tree/master/Experiments/Spin). Please make sure you have Spin installed first [Install Spin](http://spinroot.com/spin/whatispin.html).

The scripts to plot all experiments using Spin are in [here](https://github.com/Anas-Shrinah/Goal-constrained-planning-domain-model-verification-repository/tree/master/Experiments/Spin)

To run the same experiments with the MIPS-XXL planner, execute the Python codes in [here](https://github.com/Anas-Shrinah/Goal-constrained-planning-domain-model-verification-repository/tree/master/Experiments/MIPS-XXL-IPC5/PlannerFiles-ExperimentScripts/DuFF)


* FirstExperiment-Planner-Unconstrained.py
* FirstExperiment-Planner-Constrained.py
* SecondExperiment-Planner-Unconstrained.py
* SecondExperiment-Planner-Constrained.py


The scripts to plot all experiments using MIPS-XXL are in [here](https://github.com/Anas-Shrinah/Goal-constrained-planning-domain-model-verification-repository/tree/master/Experiments/MIPS-XXL-IPC5/PlannerFiles-ExperimentScripts/DuFF)



