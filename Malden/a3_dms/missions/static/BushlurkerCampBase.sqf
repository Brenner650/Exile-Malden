/*
	"TKO BushlurkerCampBase" v 1 static mission for Taunus.
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_pinCode", "_VehicleChance"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [5260.66,10793.2,0]; //insert the centre here

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};

//create possible difficulty add more of one difficulty to weight it towards that
_PossibleDifficulty		= 	[	
                                "easy",
								"moderate",
								"difficult",
								"hardcore"
							];
//choose mission difficulty and set value and is also marker colour
_difficultyM = selectRandom _PossibleDifficulty;

switch (_difficultyM) do
{
	case "easy":
	{
_difficulty = "easy";									//AI difficulty
_AICount = (12 + (round (random 5)));					//AI starting numbers
_AIMaxReinforcements = (1 + (round (random 1)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (1 + (round (random 1)));						//Max amount of AI in reinforcement wave
_AIdelay = (1 + (round (random 1)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 10;									//10% SpawnPersistentVehicle chance
_crate_weapons0 	= (5 + (round (random 20)));		//Crate 0 weapons number
_crate_items0 		= (5 + (round (random 20)));		//Crate 0 items number
_crate_backpacks0 	= (3 + (round (random 1)));			//Crate 0 back packs number
_crate_weapons1 	= (4 + (round (random 2)));			//Crate 1 weapons number
_crate_items1 		= (10 + (round (random 40)));		//Crate 1 items number
_crate_backpacks1 	= (1 + (round (random 8)));			//Crate 1 back packs number
	};
	case "moderate":
	{
_difficulty = "moderate";
_AICount = (15 + (round (random 5)));
_AIMaxReinforcements = (1 + (round (random 1)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (1 + (round (random 1)));						//Max amount of AI in reinforcement wave
_AIdelay = (1 + (round (random 1)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 10;									//20% SpawnPersistentVehicle chance
_crate_weapons0 	= (20 + (round (random 15)));
_crate_items0 		= (20 + (round (random 15)));
_crate_backpacks0 	= (3 + (round (random 1)));
_crate_weapons1 	= (20 + (round (random 3)));
_crate_items1 		= (22 + (round (random 30)));
_crate_backpacks1 	= (5 + (round (random 4)));
	};
	case "difficult":
	{
_difficulty = "difficult";
_AICount = (20 + (round (random 5)));
_AIMaxReinforcements = (1 + (round (random 1)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (1 + (round (random 1)));						//Max amount of AI in reinforcement wave
_AIdelay = (1 + (round (random 1)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 10;									//75% SpawnPersistentVehicle chance
_crate_weapons0 	= (20 + (round (random 20)));
_crate_items0 		= (30 + (round (random 10)));
_crate_backpacks0 	= (3 + (round (random 1)));
_crate_weapons1 	= (20 + (round (random 3)));
_crate_items1 		= (30 + (round (random 20)));
_crate_backpacks1 	= (6 + (round (random 4)));
	};
	//case "hardcore":
	default
	{
_difficulty = "hardcore";
_AICount = (20 + (round (random 5)));
_AIMaxReinforcements = (1 + (round (random 1)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (1 + (round (random 1)));						//Max amount of AI in reinforcement wave
_AIdelay = (1 + (round (random 1)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 30;									//90% SpawnPersistentVehicle chance
_crate_weapons0 	= (35 + (round (random 5)));
_crate_items0 		= (40 + (round (random 5)));
_crate_backpacks0 	= (5 + (round (random 1)));
_crate_weapons1 	= (40 + (round (random 2)));
_crate_items1 		= (35 + (round (random 10)));
_crate_backpacks1 	= (5 + (round (random 2)));
	};
};

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
	//Ai
	[5250.31,10761.5,0],
	[5241.72,10753.1,0],
	[5252.16,10742.7,0],
	[5260.12,10751.2,0],
	[5264.23,10731.3,0],
	[5273.35,10739.3,0],
	[5270.8,10702.4,0],
	[5285.7,10730,0],
	[5283.92,10772.5,0],
	[5314.83,10752.3,0],
	[5235.51,10772.7,0],
	[5220.25,10800.2,0],
	[5245.44,10843.9,0],
	[5253.5,10839.4,0],
	[5259.94,10834.7,0],
	[5275.17,10790.7,0],
	[5258.2,10806.2,0],
	[5261.41,10777.6,0],
	[5236.65,10812.8,0],
	[5297.24,10735.8,0]

];

_group =
[
	_AISoldierSpawnLocations+[_pos,_pos,_pos],			// Pass the regular spawn locations as well as the center pos 3x
	_AICount,											// Set in difficulty select
	_difficulty,										// Set in difficulty select
	"random",
	_side
] call DMS_fnc_SpawnAIGroup_MultiPos;

//Reduce Static guns if mission is easy
if (_difficultyM isEqualTo "easy") then {
_staticGuns =
[
	[
    //HmgHoch
	[5188.04,10788.8,4.344],
	[5207.02,10767.6,4.344],
	[5231.15,10791.6,3.120],
	[5229.23,10802.3,3.093],
	[5227.36,10828.9,3.102],
	[5226.16,10840.4,3.129],
	[5251.07,10864.9,4.345],
	[5276.55,10837.6,4.344],
	[5289.76,10789.8,4.344],
	[5288.37,10697,4.341],
	[5290.32,10699,4.345],
	[5297.38,10709,3.127],
	[5297.57,10718.6,3.127],
	[5291.94,10712.4,3.127],
	//HmgBoden
	[5280.05,10704.2,0],
	[5282.89,10694.6,0],
	[5229.08,10776.9,297.0],
	[5209.3,10804.8,0],
	[5224.12,10784.8,0],
	[5237.78,10825.3,0],
	[5232.4,10845.1,0],
	[5266.11,10846.4,0],
	[5247.43,10806.9,0],
	[5269.45,10817.7,0],
	[5285.41,10802.2,0],
	[5262.51,10767.5,0],
	[5321.57,10733.9,0],
	[5330.81,10745.5,0],
	[5305.02,10728,0],
	[5312.43,10726.7,0],
	[5216.51,10818,0]
	],
	_group,
	"assault",
	_difficulty,
	"bandit",
	"random"
] call DMS_fnc_SpawnAIStaticMG;
										} else
										{
_staticGuns =
[
	[
    //HmgHoch
	[5188.04,10788.8,4.344],
	[5207.02,10767.6,4.344],
	[5231.15,10791.6,3.120],
	[5229.23,10802.3,3.093],
	[5227.36,10828.9,3.102],
	[5226.16,10840.4,3.129],
	[5251.07,10864.9,4.345],
	[5276.55,10837.6,4.344],
	[5289.76,10789.8,4.344],
	[5288.37,10697,4.341],
	[5290.32,10699,4.345],
	[5297.38,10709,3.127],
	[5297.57,10718.6,3.127],
	[5291.94,10712.4,3.127],
	//HmgBoden
	[5280.05,10704.2,0],
	[5282.89,10694.6,0],
	[5229.08,10776.9,297.0],
	[5209.3,10804.8,0],
	[5224.12,10784.8,0],
	[5237.78,10825.3,0],
	[5232.4,10845.1,0],
	[5266.11,10846.4,0],
	[5247.43,10806.9,0],
	[5269.45,10817.7,0],
	[5285.41,10802.2,0],
	[5262.51,10767.5,0],
	[5321.57,10733.9,0],
	[5330.81,10745.5,0],
	[5305.02,10728,0],
	[5312.43,10726.7,0],
	[5216.51,10818,0]
	],
	_group,
	"assault",
	_difficulty,
	"bandit",
	"random"
] call DMS_fnc_SpawnAIStaticMG;
										};

// Define the classnames and locations where the crates can spawn (at least 2, since we're spawning 2 crates)
_crateClasses_and_Positions =
[
	//[[15793.1,5629.58,0.0],"I_CargoNet_01_ammo_F"],
	//[[15826.7,5652.14,0.0],"I_CargoNet_01_ammo_F"],
	[[5291.07,10804.6,0],"I_CargoNet_01_ammo_F"],
	[[5275.92,10820.5,0],"I_CargoNet_01_ammo_F"]
];

{
	deleteVehicle (nearestObject _x);		// Make sure to remove any previous crates.
} forEach _crateClasses_and_Positions;

// Shuffle the list
_crateClasses_and_Positions = _crateClasses_and_Positions call ExileClient_util_array_shuffle;

// Create Crates
_crate0 = [_crateClasses_and_Positions select 0 select 1, _crateClasses_and_Positions select 0 select 0] call DMS_fnc_SpawnCrate;
_crate1 = [_crateClasses_and_Positions select 1 select 1, _crateClasses_and_Positions select 1 select 0] call DMS_fnc_SpawnCrate;

// Don't think an armed AI vehicle fit the idea behind the mission. You're welcome to uncomment this if you want.
//_veh =
//[
//	[
//		[_pos,100,random 360] call DMS_fnc_SelectOffsetPos,
//		_pos
//	],
//	_group,
//	"assault",
//	_difficulty,
//	_side
//] call DMS_fnc_SpawnAIVehicle;

// Enable smoke on the crates due to size of area
{
	_x setVariable ["DMS_AllowSmoke", true];
} forEach [_crate0,_crate1];

// Define mission-spawned AI Units
_missionAIUnits =
[
	_group 		// We only spawned the single group for this mission
];

// Define the group reinforcements
_groupReinforcementsInfo =
[
	[
		_group,			// pass the group
		[
			[
				0,		// Let's limit number of units instead...
				0
			],
			[
				_AIMaxReinforcements,	// Maximum units that can be given as reinforcements (defined in difficulty selection).
				0
			]
		],
		[
			_AIdelay,		// The delay between reinforcements. >> you can change this in difficulty settings
			diag_tickTime
		],
		_AISoldierSpawnLocations,
		"random",
		_difficulty,
		_side,
		"reinforce",
		[
			_AItrigger,		// Set in difficulty select - Reinforcements will only trigger if there's fewer than X members left
			_AIwave			// X reinforcement units per wave. >> you can change this in mission difficulty section
		]
	]
];

// setup crates with items from choices
_crate_loot_values0 =
[
	_crate_weapons0,		// Set in difficulty select - Weapons
	_crate_items0,			// Set in difficulty select - Items
	_crate_backpacks0 		// Set in difficulty select - Backpacks
];
_crate_loot_values1 =
[
	_crate_weapons1,		// Set in difficulty select - Weapons
	_crate_items1,			// Set in difficulty select - Items
	_crate_backpacks1 		// Set in difficulty select - Backpacks
];

// is %chance greater than random number O_APC_Tracked_02_cannon_F   O_T_APC_Wheeled_02_rcws_ghex_F  B_APC_Tracked_01_rcws_F   gorgon I_APC_Wheeled_03_cannon_F ["O_T_APC_Tracked_02_cannon_ghex_F",[23130.7,19778.7,0],
if (_VehicleChance >= (random 100)) then {
											_pinCode = (1000 +(round (random 8999)));
											_vehicle = ["B_CTRG_Heli_Transport_01_sand_F",[5260.66,10793.2,0],_pinCode] call DMS_fnc_SpawnPersistentVehicle;
											_msgWIN = ['#0080ff',format ["Ihr habt den BushlurkerCampBase gesichert, code ist %1...",_pinCode]];
											} else
											{
											_vehicle = ["B_CTRG_Heli_Transport_01_sand_F",[5260.66,10793.2,0]] call DMS_fnc_SpawnNonPersistentVehicle;
											_msgWIN = ['#0080ff',"Ihr habt den BushlurkerCampBase gesichert"];
											};

// Define mission-spawned objects and loot values with vehicle
_missionObjs =
[
	_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
	[_vehicle],				// vehicle prize
	[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]]
];	
											
// Define Mission Start message
_msgStart = ['#FFFF00',format["Im BushlurkerCampBase werden Waffen von %1 Soldaten umgeladen",_difficultyM]];

// Define Mission Win message defined in vehicle choice

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Soldaten haben die Waffen gesichert."];

// Define mission name (for map marker and logging)
_missionName = "BushlurkerCampBase";

// Create Markers
_markers =
[
	_pos,
	_missionName,
	_difficultyM
] call DMS_fnc_CreateMarker;

_circle = _markers select 1;
_circle setMarkerDir 0;
_circle setMarkerSize [450,450];

_time = diag_tickTime;

// Parse and add mission info to missions monitor
_added =
[
	_pos,
	[
		[
			"kill",
			_group
		],
		[
			"playerNear",
			[_pos,100]
		]
	],
	_groupReinforcementsInfo,
	[
		_time,
		DMS_StaticMissionTimeOut call DMS_fnc_SelectRandomVal
	],
	_missionAIUnits,
	_missionObjs,
	[_missionName,_msgWIN,_msgLOSE],
	_markers,
	_side,
	_difficultyM,
	[[],[]]
] call DMS_fnc_AddMissionToMonitor_Static;

// Check to see if it was added correctly, otherwise delete the stuff
if !(_added) exitWith
{
	diag_log format ["DMS ERROR :: Attempt to set up mission %1 with invalid parameters for DMS_fnc_AddMissionToMonitor_Static! Deleting mission objects and resetting DMS_MissionCount.",_missionName];

	_cleanup = [];
	{
		_cleanup pushBack _x;
	} forEach _missionAIUnits;

	_cleanup pushBack ((_missionObjs select 0)+(_missionObjs select 1));
	
	{
		_cleanup pushBack (_x select 0);
	} foreach (_missionObjs select 2);

	_cleanup call DMS_fnc_CleanUp;

	// Delete the markers directly
	{deleteMarker _x;} forEach _markers;

	// Reset the mission count
	DMS_MissionCount = DMS_MissionCount - 1;
};

// Notify players
[_missionName,_msgStart] call DMS_fnc_BroadcastMissionStatus;

if (DMS_DEBUG) then
{
	(format ["MISSION: (%1) :: Mission #%2 started at %3 with %4 AI units and %5 difficulty at time %6",_missionName,_num,_pos,_AICount,_difficulty,_time]) call DMS_fnc_DebugLog;
};