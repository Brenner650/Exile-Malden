/*
	"TKO Hanfplantage" v 1 static mission for Taunus.
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_pinCode", "_VehicleChance"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [10774.3,15513.2,0]; //insert the centre here

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
_VehicleChance = 10;								//20% SpawnPersistentVehicle chance
_crate_weapons0 	= (30 + (round (random 15)));
_crate_items0 		= (30 + (round (random 15)));
_crate_backpacks0 	= (3 + (round (random 1)));
_crate_weapons1 	= (30 + (round (random 3)));
_crate_items1 		= (30 + (round (random 30)));
_crate_backpacks1 	= (5 + (round (random 4)));
	};
	case "difficult":
	{
_difficulty = "difficult";
_AICount = (20 + (round (random 5)));
_AIMaxReinforcements = (2 + (round (random 4)));
_AItrigger = (8 + (round (random 5)));
_AIwave = (4 + (round (random 4)));
_AIdelay = (25 + (round (random 120)));
_VehicleChance = 10;									//75% SpawnPersistentVehicle chance
_crate_weapons0 	= (35 + (round (random 20)));
_crate_items0 		= (35 + (round (random 10)));
_crate_backpacks0 	= (3 + (round (random 1)));
_crate_weapons1 	= (35 + (round (random 3)));
_crate_items1 		= (35 + (round (random 20)));
_crate_backpacks1 	= (6 + (round (random 4)));
	};
	//case "hardcore":
	default
	{
_difficulty = "hardcore";
_AICount = (25 + (round (random 5)));
_AIMaxReinforcements = (4 + (round (random 4)));
_AItrigger = (8 + (round (random 5)));
_AIwave = (4 + (round (random 4)));
_AIdelay = (2 + (round (random 10)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 50;									//90% SpawnPersistentVehicle chance
_crate_weapons0 	= (30 + (round (random 5)));
_crate_items0 		= (30 + (round (random 5)));
_crate_backpacks0 	= (2 + (round (random 1)));
_crate_weapons1 	= (30 + (round (random 2)));
_crate_items1 		= (30 + (round (random 10)));
_crate_backpacks1 	= (5 + (round (random 2)));
	};
};

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
	//AI
	[10652.3,15398.5,0],
	[10603.8,15406.5,0],
	[10628.8,15375.1,0],
	[10681.3,15441.9,0],
	[10655.4,15477.5,0],
	[10623.5,15462.8,0],
	[10698.2,15504.6,0],
	[10729.1,15470.5,0],
	[10697.2,15410.2,0],
	[10735.2,15408.3,0],
	[10790.6,15495.9,0],
	[10710.8,15530.4,0],
	[10726.2,15559.4,0],
	[10845.7,15590.2,0],
	[10880,15579.5,0],
	[10907.5,15611.6,0],
	[10909,15598,0],
	[10903.8,15620.9,0],
	[10887.1,15624,0],
	[10874.9,15615.2,0],
	[10877.8,15604.4,0],
	[10936.7,15639,0],
	[10859.2,15560,0],
	[10791.4,15472.3,0],
	[10744.9,15435.1,0],
	[10757.6,15396.8,0],
	[10706.4,15466.3,0]
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
	[10629.7,15353.6,17.889],
	[10625.8,15361.3,17.892],
	[10620,15355.3,17.889],
	[10848,15535.8,17.889],
	[10856.1,15534.7,17.889],
	[10852.4,15543.1,17.889],
	[10782.9,15442.2,17.852],
	[10772.7,15423.1,17.852],
	[10782.5,15417.7,17.852],
	[10792.4,15437.7,17.852],
	[10700.7,15536.1,9.356],
	[10707,15549.6,9.045],
	[10713.7,15563.3,9.060],
	[10721.1,15343.9,5.695],
	//BodenHMG
	[10764.8,15420.2,0],
	[10798,15433.5,0],
	[10777.3,15407,0],
	[10720.3,15352.9,0],
	[10590.6,15416.3,0],
	[10648.6,15486.8,0],
	[10683.3,15502.2,0],
	[10697.4,15528.2,0],
	[10812.8,15532.2,0],
	[10825.9,15571.5,0],
	[10919.4,15647.3,0],
	[10927,15637.1,0],
	[10931.6,15629.7,0],
	[10884.2,15595.6,0],
	[10891.2,15584.1,0],
	[10961.9,15624.8,0],
	[10812.5,15461.3,0],
	[10746,15505.1,0],
	[10757.7,15528.6,0],
	[10624.7,15470.4,0],
	[10614.3,15438.0,0]
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
	[10629.7,15353.6,17.889],
	[10625.8,15361.3,17.892],
	[10620,15355.3,17.889],
	[10848,15535.8,17.889],
	[10856.1,15534.7,17.889],
	[10852.4,15543.1,17.889],
	[10782.9,15442.2,17.852],
	[10772.7,15423.1,17.852],
	[10782.5,15417.7,17.852],
	[10792.4,15437.7,17.852],
	[10700.7,15536.1,9.356],
	[10707,15549.6,9.045],
	[10713.7,15563.3,9.060],
	[10721.1,15343.9,5.695],
	//BodenHMG
	[10764.8,15420.2,0],
	[10798,15433.5,0],
	[10777.3,15407,0],
	[10720.3,15352.9,0],
	[10590.6,15416.3,0],
	[10648.6,15486.8,0],
	[10683.3,15502.2,0],
	[10697.4,15528.2,0],
	[10812.8,15532.2,0],
	[10825.9,15571.5,0],
	[10919.4,15647.3,0],
	[10927,15637.1,0],
	[10931.6,15629.7,0],
	[10884.2,15595.6,0],
	[10891.2,15584.1,0],
	[10961.9,15624.8,0],
	[10812.5,15461.3,0],
	[10746,15505.1,0],
	[10757.7,15528.6,0],
	[10624.7,15470.4,0],
	[10614.3,15438.0,0]
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
	[[10663.2,15431,0],"I_CargoNet_01_ammo_F"],
	//[[9112.19,3164.98,0],"I_CargoNet_01_ammo_F"],
	[[10766,15410.8,0],"I_CargoNet_01_ammo_F"]
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
											_vehicle = ["B_T_LSV_01_armed_CTRG_F ",[10774.3,15513.2,0],_pinCode] call DMS_fnc_SpawnPersistentVehicle;
											_msgWIN = ['#0080ff',format ["Die Hanfplantage ist abgeerntet, code ist %1...",_pinCode]];
											} else
											{
											_vehicle = ["I_MRAP_03_hmg_F",[10774.3,15513.2,0]] call DMS_fnc_SpawnNonPersistentVehicle;
											_msgWIN = ['#0080ff',"Die Hanfplantage ist abgeerntet"];
											};

// Define mission-spawned objects and loot values with vehicle
_missionObjs =
[
	_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
	[_vehicle],				// vehicle prize
	[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]]
];	
											
// Define Mission Start message
_msgStart = ['#FFFF00',format["Auf der Hanfplantage werden Waffen verladen von %1 Soldaten",_difficultyM]];

// Define Mission Win message defined in vehicle choice

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Die Hanfplantage ist verlassen."];

// Define mission name (for map marker and logging)
_missionName = "Hanfplantage";

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