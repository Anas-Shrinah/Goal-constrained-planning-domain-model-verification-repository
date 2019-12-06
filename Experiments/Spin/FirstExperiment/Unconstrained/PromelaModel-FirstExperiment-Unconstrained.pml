/*
Goal-constrained planning domain model verification of safety properties.
Anas Shrinah and Kerstin Eder.
Section 6 - experiments.
First experiment - Unconstrained verification.

The first experiment focuses on comparing the cost of both
unconstrained and goal-constrained verification tasks while
varying the safety property violation depth in order to explore 
situations with and without a valid planning counterexample.

The safety property violation depth is hereafter termed “error depth”.
We synthesised a fully reachable model that consists of one critical and three
independent variables, each with a range from 0 to 31. 
Each variable has two actions, one to increase and one to decrease its value
by one. The goal is achieved when the critical variable value
reaches 14. The error condition is changed from the value of
the critical variable being 1 to 31.*/

ltl p0 {!(<>(Error == 1))}

unsigned CriticalVariable : 5 = 0;
unsigned IndpendentVariable1 :5  = 0;
unsigned IndpendentVariable2 :5 = 0;
unsigned IndpendentVariable3:5 = 0;
bit Error = 0;

proctype trans()
{

	do

	:: (1) ->
		if
		
		::atomic{ (CriticalVariable < 31) ->  CriticalVariable++}
		::atomic{ (CriticalVariable > 0) ->  CriticalVariable--}

		::atomic{(IndpendentVariable1 < 31)->IndpendentVariable1++}
		::atomic{(IndpendentVariable1 > 0) ->IndpendentVariable1--}
		::atomic{(IndpendentVariable2 < 31)->IndpendentVariable2++}
		::atomic{(IndpendentVariable2 > 0) ->IndpendentVariable2--}
		::atomic{(IndpendentVariable3 < 31)->IndpendentVariable3++}
		::atomic{(IndpendentVariable3 > 0) ->IndpendentVariable3--}

		::atomic{ (CriticalVariable == 30)  -> Error = 1}

		fi			
	od;
}


init {
	
	atomic{run trans()}
}

