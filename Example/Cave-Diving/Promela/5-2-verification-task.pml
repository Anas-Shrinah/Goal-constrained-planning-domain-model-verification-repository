/*
Goal-constrained planning domain model verification of safety properties.
Anas Shrinah and Kerstin Eder.
Section 5 - verification task 2.
Verification with safety property and incomplete goal (mission target only).
ps. The model used here is the original model without any additional guards. We would get the same result 
with the augmented model as per Section 5.1 because the verification property has no goal here. 
The safety property: diver has no full tanks, the dive is not at the entrance, and the location, where the diver is, has no full tanks.
The incomplete goal is have a photo of the first location
Spin returns unreachable counterexample: <prepare-tank, prepare-tank, enter-water,
swim(L0 , L1 ), take-photo*/
ltl p0 {!(<>((fullTanksD == 0) && (fulltanksL[location] == 0)  && (location != 0)) && <> (photo == 1) )}
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
			
	od;
}


init {
	
	atomic{run trans()}
}

