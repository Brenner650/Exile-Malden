/*
	"TKO Kolbenberg" v 1 static mission for Taunus.
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_pinCode", "_VehicleChance"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [9856.11,12708.2,0]; //insert the centre here

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};

//create possible difficulty add more of one difficulty to weight it towards that
_PossibleDifficulty		= 	[	

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
_AIMaxReinforcements = (1 + (round (random 4)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 5)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (8 + (round (random 1)));						//Max amount of AI in reinforcement wave
_AIdelay = (2 + (round (random 10)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
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
_AIMaxReinforcements = (2 + (round (random 4)));
_AItrigger = (8 + (round (random 5)));
_AIwave = (4 + (round (random 4)));
_AIdelay = (2 + (round (random 10)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
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
_AIMaxReinforcements = (2 + (round (random 4)));
_AItrigger = (8 + (round (random 5)));
_AIwave = (4 + (round (random 4)));
_AIdelay = (2 + (round (random 10)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
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
_AIMaxReinforcements = (4 + (round (random 4)));
_AItrigger = (8 + (round (random 5)));
_AIwave = (8 + (round (random 2)));
_AIdelay = (2 + (round (random 10)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 40;									//90% SpawnPersistentVehicle chance
_crate_weapons0 	= (30 + (round (random 5)));
_crate_items0 		= (20 + (round (random 5)));
_crate_backpacks0 	= (2 + (round (random 1)));
_crate_weapons1 	= (20 + (round (random 2)));
_crate_items1 		= (30 + (round (random 10)));
_crate_backpacks1 	= (5 + (round (random 2)));
	};
};

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
	//AI
	[9881.29,12752.9,0],
	[9838.86,12752.5,0],
	[9862.15,12753.4,0],
	[9882.01,12721.6,0],
	[9885.08,12710.8,0],
	[9855.89,12722.7,0],
	[9857.63,12704.5,0],
	[9844.42,12692.3,0],
	[9826.98,12693.7,0],
	[9849.51,12679.1,0],
	[9893.01,12711.7,0],
	[9893.01,12676.6,0],
	[9878.23,12664.8,0],
	[9859.98,12664.4,0],
	[9829.14,12664.5,0],
	[9822.4,12712.2,0],
	[9823.58,12749.5,0],
	[9856.79,12760.8,0],
	[9880.2,12762.9,0],
	[9886.25,12739.6,0],
	[9878.83,12714.5,0],
	[9857.68,12738.8,0],
	[9851.6,12696.5,0]
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
	//HMGHoch
	[9829.55,12755.5,17.890],
	[9822.44,12763.8,17.890],
	[9829.03,12763.9,17.890],
	[9894.7,12757.3,17.895],
	[9887.58,12757,17.895],
	[9892.65,12764.9,17.895],
	[9886.99,12663.8,16.893],
	[9887.23,12655.2,18.365],
	[9894.72,12663,17.903],
	[9893.87,12655.6,19.178],
	[9858.04,12682.1,22.339],
	[9828.56,12682.4,3.127],
	[9831.04,12674,3.127],
	//HMGBoden
	[9878.58,12739.8,0],
	[9883.3,12736.5,0],
	[9827.37,12739.7,0],
	[9827.7,12700.4,0],
	[9826.8,12687.6,0],
	[9822.39,12699.9,0],
	[9821.94,12689.1,0],
	[9856.65,12733.8,0],
	[9840.89,12675.9,0],
	[9886.48,12672.7,0],
	[9826.25,12666.2,0],
	[9892.29,12672.6,0],
	[9892.29,12740,0],
	[9826.04,12763.1,0],
	[9891.37,12763.3,0],
	[9822.37,12741.5,0]
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
	//HMGHoch
	[9829.55,12755.5,17.890],
	[9822.44,12763.8,17.890],
	[9829.03,12763.9,17.890],
	[9894.7,12757.3,17.895],
	[9887.58,12757,17.895],
	[9892.65,12764.9,17.895],
	[9886.99,12663.8,16.893],
	[9887.23,12655.2,18.365],
	[9894.72,12663,17.903],
	[9893.87,12655.6,19.178],
	[9858.04,12682.1,22.339],
	[9828.56,12682.4,3.127],
	[9831.04,12674,3.127],
	//HMGBoden
	[9878.58,12739.8,0],
	[9883.3,12736.5,0],
	[9827.37,12739.7,0],
	[9827.7,12700.4,0],
	[9826.8,12687.6,0],
	[9822.39,12699.9,0],
	[9821.94,12689.1,0],
	[9856.65,12733.8,0],
	[9840.89,12675.9,0],
	[9886.48,12672.7,0],
	[9826.25,12666.2,0],
	[9892.29,12672.6,0],
	[9892.29,12740,0],
	[9826.04,12763.1,0],
	[9891.37,12763.3,0],
	[9822.37,12741.5,0]
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
	//Loot
	[[9872.68,12761.4,0],"I_CargoNet_01_ammo_F"],
	[[9874.88,12747.3,0],"I_CargoNet_01_ammo_F"],
	[[9833.91,12761.4,0],"I_CargoNet_01_ammo_F"],
	[[9852.41,12726.6,0],"I_CargoNet_01_ammo_F"]
];

{
	deleteVehicle (nearestObject _x);		// Make sure to remove any previous crates.
} forEach _crateClasses_and_Positions;

// Shuffle the list
_crateClasses_and_Positions = _crateClasses_and_Positions call ExileClient_util_array_shuffle;

// Create Crates
_crate0 = [_crateClasses_and_Positions select 0 select 1, _crateClasses_and_Positions select 0 select 0] call DMS_fnc_SpawnCrate;
_crate1 = [_crateClasses_and_Positions select 1 select 1, _crateClasses_and_Positions select 1 select 0] call DMS_fnc_SpawnCrate;


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
											_vehicle = ["B_CTRG_Heli_Transport_01_tropic_F ",[9847.39,12754.6,0],_pinCode] call DMS_fnc_SpawnPersistentVehicle;
											_msgWIN = ['#0080ff',format ["Der Kolbenberg ist ausgeräuchert, code ist %1...",_pinCode]];
											} else
											{
											_vehicle = ["I_MRAP_03_hmg_F",[9857.37,12752.6,0]] call DMS_fnc_SpawnNonPersistentVehicle;
											_msgWIN = ['#0080ff',"Der Kolbenberg ist ausgeräuchert"];
											};

// Define mission-spawned objects and loot values with vehicle
_missionObjs =
[
	_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
	[_vehicle],				// vehicle prize
	[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]]
];	
											
// Define Mission Start message
_msgStart = ['#FFFF00',format["Auf dem Kolbenberg werden Waffen verladen von %1 Soldaten",_difficultyM]];

// Define Mission Win message defined in vehicle choice

// Define Mission Lose message
_msgLOSE = ['#FF0000',"War nix mit dem BergFest"];

// Define mission name (for map marker and logging)
_missionName = "Kolbenberg";

// Create Markers
_markers =
[
	_pos,
	_missionName,
	_difficultyM
] call DMS_fnc_CreateMarker;

_circle = _markers select 1;
_circle setMarkerDir 0;
_circle setMarkerSize [600,600];

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