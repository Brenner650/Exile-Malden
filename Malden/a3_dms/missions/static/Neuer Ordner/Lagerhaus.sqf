/*
	"TKO Lagerhaus" v 1 static mission for Taunus.
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_pinCode", "_VehicleChance"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [9076,3169.49,0]; //insert the centre here

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
_AIMaxReinforcements = (1 + (round (random 4)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 5)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (6 + (round (random 1)));						//Max amount of AI in reinforcement wave
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
_AIMaxReinforcements = (2 + (round (random 4)));
_AItrigger = (8 + (round (random 5)));
_AIwave = (4 + (round (random 4)));
_AIdelay = (2 + (round (random 10)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 10;									//90% SpawnPersistentVehicle chance
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
	[9095.93,3133.67,0.0],
	[9110.36,3123.31,0.0],
	[9107.1,3195.23,0.0],
	[9024.26,3145.59,0.0],
	[9053.74,3194.99,0.0],
	[9075.87,3176.86,0.0],
	[9025.48,3165.15,0.0],
	[9033.92,3184.73,0.0],
	[9102.46,3079.14,0.0],
	[9146.41,3136.03,0.0],
	[9086.98,3154.83,0.0],
	[9160.87,3168.21,0.0],
	[9123.52,3142.19,0.0],
	[9092.7,3205.2,0.0],
	[9136.24,3187.52,0.0],
	[9141.59,3179.98,0.0]	
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
    //HochHmg
	[9170.25,3171.36,17.708],
	[9179.04,3172.05,18.218],
	[9003.29,3155.61,18.020],
	[9005.36,3165.49,17.765],
	[9088.36,3129.99,42.063],
	[9110.45,3175.08,12.184],
	[9129.58,3203.47,11.327],
	[9149.75,3189.83,12.842],
	[9135.28,3160.3,14.093],
	[9049.98,3219.51,11.644],
	[9068.29,3246.26,11.681],
	[9072.08,3133.41,11.842],
	[9061.38,3156.18,9.108],
	[9041.58,3115.79,11.686],
    //BodenHmg
	[9139.78,3156.22,0.0],
	[9130.83,3123.13,0.0],
	[9086.75,3137.36,0.0],
	[9103.66,3104.72,0.0],
	//[8975.32,3200.97,0.0],
	[9097.15,3227.49,0.0],
	[9123.48,3209.63,0.0],
	[9109.23,3219.84,0.0],
	[9160.15,3187.35,0.0]	
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
    //HochHmg
	[9170.25,3171.36,17.708],
	[9179.04,3172.05,18.218],
	[9003.29,3155.61,18.020],
	[9005.36,3165.49,17.765],
	[9088.36,3129.99,42.063],
	[9110.45,3175.08,12.184],
	[9129.58,3203.47,11.327],
	[9149.75,3189.83,12.842],
	[9135.28,3160.3,14.093],
	[9049.98,3219.51,11.644],
	[9068.29,3246.26,11.681],
	[9072.08,3133.41,11.842],
	[9061.38,3156.18,9.108],
	[9041.58,3115.79,11.686],
    //BodenHmg
	[9139.78,3156.22,0.0],
	[9130.83,3123.13,0.0],
	[9086.75,3137.36,0.0],
	[9103.66,3104.72,0.0],
	//[8975.32,3200.97,0.0],
	[9097.15,3227.49,0.0],
	[9123.48,3209.63,0.0],
	[9109.23,3219.84,0.0],
	[9160.15,3187.35,0.0]	
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
	[[9040.87,3205.22,0],"I_CargoNet_01_ammo_F"],
	[[9112.19,3164.98,0],"I_CargoNet_01_ammo_F"],
	[[9073.75,3191.28,0],"I_CargoNet_01_ammo_F"]
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
											_vehicle = ["B_T_LSV_01_armed_CTRG_F ",[9094.08,3184.57,0],_pinCode] call DMS_fnc_SpawnPersistentVehicle;
											_msgWIN = ['#0080ff',format ["Lagerhaus gestuermt der , code ist %1...",_pinCode]];
											} else
											{
											_vehicle = ["I_MRAP_03_hmg_F",[9094.08,3184.57,0]] call DMS_fnc_SpawnNonPersistentVehicle;
											_msgWIN = ['#0080ff',"Lagerhaus gestuermt"];
											};

// Define mission-spawned objects and loot values with vehicle
_missionObjs =
[
	_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
	[_vehicle],				// vehicle prize
	[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]]
];	
											
// Define Mission Start message
_msgStart = ['#FFFF00',format["Im Lagerhaus wird ein Strider mit Waffen verladen von %1 Soldaten",_difficultyM]];

// Define Mission Win message defined in vehicle choice

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Lagerhaus ist verlassen."];

// Define mission name (for map marker and logging)
_missionName = "Lagerhaus";

// Create Markers
_markers =
[
	_pos,
	_missionName,
	_difficultyM
] call DMS_fnc_CreateMarker;

_circle = _markers select 1;
_circle setMarkerDir 0;
_circle setMarkerSize [500,500];

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