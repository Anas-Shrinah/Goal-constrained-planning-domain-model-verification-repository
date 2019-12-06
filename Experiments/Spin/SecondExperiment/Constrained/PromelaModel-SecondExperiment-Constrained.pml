/*
Goal-constrained planning domain model verification of safety properties.
Anas Shrinah and Kerstin Eder.
Section 6 - experiments.
Second experiment - goal constrained verification - Promela model.

TThe second experiment investigates the effect of the early
termination of the verification process, after achieving the
goal, on the cost of verification tasks while increasing the depth
of the planning goal. The model used in this experiment has one critical
and four independent variables, each with a range from 0 to 15.
Variables have two actions as in the previous model. This time, there is
no error in the model and the goal condition is varied from critical value
1 to 14.*/

ltl p0 {!(<>(Error == 1) && <> (CriticalVariable == 15))}

unsigned CriticalVariable : 4 = 0;
unsigned IndpendentVariable1 :4  = 0;
unsigned IndpendentVariable2 :4 = 0;
unsigned IndpendentVariable3: 4 = 0;
unsigned IndpendentVariable4 :4  = 0;
bit Error = 0;
proctype trans()
{


	do
	/*Section 4.1: The model M is modified to M' by augmenting the guards of all transitions with the negation of the goal condition*/
	// This guard is the negation of the goal. This guard is added to all of the model transitions as explained in Section 4.1
	::(!(CriticalVariable == 15)) ->
		if
		
		::atomic{ (CriticalVariable < 15) ->  CriticalVariable++}
		::atomic{ (CriticalVariable > 0) ->  CriticalVariable--}


		::atomic{(IndpendentVariable1 < 15)->IndpendentVariable1++}
		::atomic{(IndpendentVariable1 > 0) ->IndpendentVariable1--}
		::atomic{(IndpendentVariable2 < 15)->IndpendentVariable2++}
		::atomic{(IndpendentVariable2 > 0) ->IndpendentVariable2--}
		::atomic{(IndpendentVariable3 < 15)->IndpendentVariable3++}
		::atomic{(IndpendentVariable3 > 0) ->IndpendentVariable3--}

		::atomic{(IndpendentVariable4 < 15)->IndpendentVariable4++}
		::atomic{(IndpendentVariable4 > 0) ->IndpendentVariable4--}

		// Set the Error bit when the the CriticalVariable value is equal to 16.
		// This is outside the range of the CriticalVariable, hence, the error cannot be asserted.
		::atomic{ (CriticalVariable == 16)  -> Error = 1}

		fi
	// This is the goal condition used as a guard to break the loop.
::  (CriticalVariable == 15 )-> break
			
	od;
}


init {
	
	atomic{run trans()}
}

