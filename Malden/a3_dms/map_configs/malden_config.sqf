/*
	Custom configs for malden.
	Created by Thomas 
*/

// Making these configs below as strict as possible will help in reducing the number of attempts taken to find a valid position, and as a result, improve performance.

DMS_MinDistFromWestBorder			= 1500;
DMS_MinDistFromEastBorder			= 1500;
DMS_MinDistFromSouthBorder			= 1500;
DMS_MinDistFromNorthBorder			= 1500;

// Plenty of slopes
DMS_MinSurfaceNormal				= 0.8;


DMS_findSafePosBlacklist append

[

	//[[5759,1973],1500]		// RainMainAir are blacklisted for lythium by default.

];

DMS_StaticMissionTypes append 			[
                                            //["SaftLaden",1],
                                            //["Schiessplatz",1],
                                            //["Sportschau",1],
											//["AbInDenUrlaub",1],
                                            //["Kolbenberg",1],
	                                        ["Barrikade",1],
											["PuestoCrow",1],
											["MartinFob",1],
											["LamboParty",1],
											["BushlurkerCampBase",1],
											["FabianoBase",1],
											["Factory",1]
];

// Add the "salt flats base" and "slums" to the "bases" to spawn on server startup. NOTE: "append" and "pushback" are NOT the same."saltflatsbase",
//DMS_BasesToImportOnServerStart append ["slums_objects"];
