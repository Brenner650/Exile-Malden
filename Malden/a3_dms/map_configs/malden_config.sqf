/*
	Custom configs for lythium.
	Created by Thomas 
*/

// Making these configs below as strict as possible will help in reducing the number of attempts taken to find a valid position, and as a result, improve performance.

DMS_MinDistFromWestBorder			= 500;
DMS_MinDistFromEastBorder			= 500;
DMS_MinDistFromSouthBorder			= 500;
DMS_MinDistFromNorthBorder			= 500;
DMS_MinSurfaceNormal				= 0.8;
DMS_PlayerNearBlacklist				= 500;
DMS_SpawnZoneNearBlacklist			= 200;
DMS_TraderZoneNearBlacklist			= 1000;
DMS_MissionNearBlacklist			= 1500;
DMS_WaterNearBlacklist				= 100;


DMS_findSafePosBlacklist append

[

	[[866,12277],500]		// RainMainAir are blacklisted for lythium by default.

];

DMS_StaticMissionTypes append 			[
                                            //["SaftLaden",1],
                                            //["Schiessplatz",1],
                                            ["Underwater",1],
											["AnkesTanke",1],
                                            ["Outpost",1],
	                                        ["Waffenlager",1],
											["GasLaden",1],
											["DerPate",1],
											["Nachschublager",1],
											["Sperrgebiet",1],
											//["Funke",1],
											["TropicalIsland",1]
];

// Add the "salt flats base" and "slums" to the "bases" to spawn on server startup. NOTE: "append" and "pushback" are NOT the same."saltflatsbase",
//DMS_BasesToImportOnServerStart append ["slums_objects"];
