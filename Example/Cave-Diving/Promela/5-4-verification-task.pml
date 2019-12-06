/*
Goal-constrained planning domain model verification of safety properties.
Anas Shrinah and Kerstin Eder.
Section 5 - verification task 4.
Verification using Spin with both safety property and proper goal and with the augmented model M'.
The safety property: diver has no full tanks, the dive is not at the entrance, and the location, where the diver is, has no full tanks.
The goal is have a photo of the first location and to get the diver outside the water.
No counterexample is returned by Spin with exhaustive verification mode*/
ltl p0 {!(<>((fullTanksD == 0) && (fulltanksL[location] == 0)  && (location != 0)) && <> ((photo == 1) && (decompressing == 1)) )}
// Number of full tanks held by the diver
unsigned fullTanksD: 3 = 0;
// Array of the length of the number of locations each element represent the number of full tanks at that location.
byte fulltanksL[3] = {0,0,0};
// The diver current location
unsigned location : 2 = 0;
// Flag to show the decompressing status of the diver( 0 means compressed i.e underwater, 1 means decompressed) 
bit decompressing = 0;
// This variable stores the location number where last photo has been taken. 
// With this variable, only a photo of one location can be taken at a time. 
// Make it an array like the fulltanksL[] to store photos of different locations at the same time.
unsigned photo : 2 = 0;
//The main process where it loops influentially randomly selecting a legal action to perform.
proctype trans()
{

	// Number of all available tanks in store. Once a tank is taken from the store it cannot be returned.
	unsigned in_storage  : 4 = 8; 
	// A flag to show whether the diver at the surface or underwater.
	bit at_surface = 1;
	// How many more full tanks can the diver hold. Maximum is 4.
	unsigned capacity : 3 = 4;
	// Temporary variable to select the destination of swim action 	
	unsigned to :2 = 0;

	do
	/*Section 5.1: The model M is modified to M' by augmenting the guards of all transitions with the negation of the goal condition*/
	// This guard is the negation of the goal. This guard is added to all of the model transitions as explained in Section 5.1
	:: (!((photo == 1) && (decompressing == 1))) ->
		if
		//Prepare-tank action
		::atomic{((at_surface == 1) && (in_storage > 0) && (capacity > 0))
		 -> fullTanksD ++; capacity --; in_storage--}
		 //Enter-water action
		::atomic{(at_surface == 1)-> at_surface = 0; location = 0}
		//Swim form the current location to a randomly selected destination that is not the same as the current location
		::atomic{ ((at_surface == 0) && (fullTanksD > 0)) -> 
															do
															:: (to == location) ->
																if
																:: to = 0
																:: to = 1
																:: to = 2
																fi
															:: else ->
																break
															od;
																	
																	
															
															((at_surface == 0) && (fullTanksD > 0) && ((location - to == -1)||(location - to == 1)) )
															->  location = to; fullTanksD --;decompressing = 0}
		//Take-photo of the current location
		::atomic{((at_surface == 0) && (fullTanksD > 0) )->photo = location; fullTanksD --;decompressing = 0}

		//Decompress action
		::atomic{((at_surface == 0) && (location == 0) )->at_surface = 1;decompressing = 1}

		//Pick-up a tank action
		::atomic{( (fulltanksL[location] >0) && (at_surface == 0) && (capacity >0))-> fullTanksD ++; capacity --; fulltanksL[location]--}
		
		//Drop-off an empty tank action
		::atomic{((at_surface == 0)  && (fullTanksD < (4 - capacity) ))->capacity ++}
		
		//Drop-off a full tank action
		::atomic{((at_surface == 0)  && (fullTanksD >0))->capacity ++; fullTanksD --;fulltanksL[location]++}
		fi
	// This is the goal condition used as a guard to break the loop.
	:: ((photo == 1) && (decompressing == 1))-> break
			
	od;
}


init {
	
	atomic{run trans()}
}

