/*
	"Sperrgebiet." v1 static mission for Australia.
	Created by Thomas TKO
	O_T_LSV_02_armed_viper_F increases persistent chance with difficulty
	tko-gameserver.de
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_pinCode", "_VehicleChance"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [6285.48,10821.2,0]; //insert the centre here

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
_AICount = (20 + (round (random 5)));					//AI starting numbers
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
_AICount = (20 + (round (random 5)));
_AIMaxReinforcements = (6 + (round (random 1)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (1 + (round (random 1)));						//Max amount of AI in reinforcement wave
_AIdelay = (1 + (round (random 1)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 50;									//20% SpawnPersistentVehicle chance
_crate_weapons0 	= (40 + (round (random 5)));
_crate_items0 		= (40 + (round (random 5)));
_crate_backpacks0 	= (5 + (round (random 1)));
_crate_weapons1 	= (40 + (round (random 5)));
_crate_items1 		= (40 + (round (random 5)));
_crate_backpacks1 	= (5 + (round (random 5)));
	};
	case "difficult":
	{
_difficulty = "difficult";
_AICount = (20 + (round (random 5)));
_AIMaxReinforcements = (1 + (round (random 1)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (2 + (round (random 2)));						//Max amount of AI in reinforcement wave
_AIdelay = (10 + (round (random 1)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 80;									//20% SpawnPersistentVehicle chance
_crate_weapons0 	= (50 + (round (random 5)));
_crate_items0 		= (50 + (round (random 5)));
_crate_backpacks0 	= (5 + (round (random 1)));
_crate_weapons1 	= (50 + (round (random 5)));
_crate_items1 		= (50 + (round (random 5)));
_crate_backpacks1 	= (5 + (round (random 5)));
	};
	//case "hardcore":
	default
	{
_difficulty = "hardcore";
_AICount = (20 + (round (random 5)));
_AIMaxReinforcements = (10 + (round (random 1)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (8 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (4 + (round (random 2)));						//Max amount of AI in reinforcement wave
_AIdelay = (15 + (round (random 10)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 100;									//20% SpawnPersistentVehicle chance
_crate_weapons0 	= (60 + (round (random 5)));
_crate_items0 		= (60 + (round (random 5)));
_crate_backpacks0 	= (5 + (round (random 1)));
_crate_weapons1 	= (60 + (round (random 5)));
_crate_items1 		= (60 + (round (random 5)));
_crate_backpacks1 	= (5 + (round (random 5)));
	};
};

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
	//AI
	[6405.81,10678.4,0],
	[6359.32,10669.7,0],
	[6308.67,10665.6,0],
	[6349.54,10724.6,0],
	[6337.19,10750,0],
	[6264.09,10723,0],
	[6218.91,10673.4,0],
	[6248.81,10825.6,0],
	[6321.59,10841.7,0],
	[6241.49,10789.5,0],
	[6190.96,10764.9,0],
	[6147.96,10798,0],
	[6101.48,10760.5,0],
	[6057.03,10813.9,0],
	[6043.99,10724.6,0],
	[6084.37,10763.2,0],
	[6116.87,10858.6,0],
	[6071.11,10791.3,0],
	[6076.35,10845.1,0],
	[6108.18,10729,0],
	[6005.65,10758,0],
	[6016.78,10797.6,0],
	[6105.84,10794.2,0],
	[6186.84,10815.2,0],
	[6237.05,10725.2,0],
	[6402.23,10768.9,0]
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
    //HochHMG
	[6429.78,10787.3,1.034],
	[6412.46,10657.7,4.497],
	[6338.52,10861.8,0.222],
	[6332.23,10864.1,0.554],
	[6274.1,10879.2,1.084],
	[6305.72,10700.5,3.160],
	[6304.99,10709.1,3.2],
	[6174.96,10672.7,0.507],
	[6173.88,10733.6,5.240],
	[6233.95,10774.9,17.849],
	[6242.03,10778.6,17.915],
	[6235.7,10783.3,17.820],
	[6282.48,10779.7,4.479],
	[6154.78,10843.8,5.027],
	[6131.66,10858.7,3.127],
	[6127.57,10865.7,3.127],
	[6082.1,10869.3,0.889],
	[6031.12,10800.2,1.078],
	[5993.09,10815.9,0.771],
	//BodenHMG
	[6405.09,10640.2,0],
	[6284.31,10653.8,0],
	[6283.05,10722.5,0],
	[6322.7,10729.7,0],
	[6362.63,10734.2,0],
	[6307.4,10791.9,0],
	[6295.93,10866.2,0],
	[6255.73,10846.5,0],
	[6239.18,10823.7,0],
	[6229.44,10673.9,0],
	[6148.29,10861.5,0],
	[6117.17,10760.2,0],
	[6139.62,10795.4,0],
	[6053.04,10812.4,0],
	[6038.03,10800.4,0],
	[5993.95,10772.4,0],
	[6052.82,10718.3,0],
	[6073.6,10760.2,0],
	[6143.68,10717.4,0]
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
    //HochHMG
	[6429.78,10787.3,1.034],
	[6412.46,10657.7,4.497],
	[6338.52,10861.8,0.222],
	[6332.23,10864.1,0.554],
	[6274.1,10879.2,1.084],
	[6305.72,10700.5,3.160],
	[6304.99,10709.1,3.2],
	[6174.96,10672.7,0.507],
	[6173.88,10733.6,5.240],
	[6233.95,10774.9,17.849],
	[6242.03,10778.6,17.915],
	[6235.7,10783.3,17.820],
	[6282.48,10779.7,4.479],
	[6154.78,10843.8,5.027],
	[6131.66,10858.7,3.127],
	[6127.57,10865.7,3.127],
	[6082.1,10869.3,0.889],
	[6031.12,10800.2,1.078],
	[5993.09,10815.9,0.771],
	//BodenHMG
	[6405.09,10640.2,0],
	[6284.31,10653.8,0],
	[6283.05,10722.5,0],
	[6322.7,10729.7,0],
	[6362.63,10734.2,0],
	[6307.4,10791.9,0],
	[6295.93,10866.2,0],
	[6255.73,10846.5,0],
	[6239.18,10823.7,0],
	[6229.44,10673.9,0],
	[6148.29,10861.5,0],
	[6117.17,10760.2,0],
	[6139.62,10795.4,0],
	[6053.04,10812.4,0],
	[6038.03,10800.4,0],
	[5993.95,10772.4,0],
	[6052.82,10718.3,0],
	[6073.6,10760.2,0],
	[6143.68,10717.4,0]
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
	[[6254.22,10815.2,0],"I_CargoNet_01_ammo_F"],
	[[6292.47,10860.9,0],"I_CargoNet_01_ammo_F"]
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

// is %chance greater than random number[30026.7,17458.6,5]O_T_VTOL_02_vehicle_grey_F
if (_VehicleChance >= (random 100)) then {
											_pinCode = (1000 +(round (random 8999)));
											_vehicle = ["B_CTRG_Heli_Transport_01_tropic_F",[6285.48,10821.2,0],_pinCode] call DMS_fnc_SpawnPersistentVehicle;
											_msgWIN = ['#0080ff',format ["Haste gut gemacht der code ist %1...",_pinCode]];
											} else
											{
											_vehicle = ["B_CTRG_Heli_Transport_01_tropic_F",[6285.48,10821.2,0]] call DMS_fnc_SpawnNonPersistentVehicle;
											_msgWIN = ['#0080ff',"Haste gut gemacht code gibt es nicht"];
											};

// Define mission-spawned objects and loot values with vehicle
_missionObjs =
[
	_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
	[_vehicle],				// vehicle prize
	[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]]
];	
											
// Define Mission Start message
_msgStart = ['#FFFF00',format["Ai Party an der Sperrgebiet %1 Truppen",_difficultyM]];

// Define Mission Win message defined in vehicle choice

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Kein wunder mit der Knifte"];

// Define mission name (for map marker and logging)
_missionName = "Sperrgebiet";

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