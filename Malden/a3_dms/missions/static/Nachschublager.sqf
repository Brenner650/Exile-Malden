/*
	"Nachschublager." v1 static mission for lYTHIUM.
	Created by Thomas TKO
	O_T_LSV_02_armed_viper_F increases persistent chance with difficulty
	tko-gameserver.de
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_pinCode", "_VehicleChance"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [7498.34,10580,0]; //insert the centre here

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
_AIMaxReinforcements = (4 + (round (random 1)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (1 + (round (random 1)));						//Max amount of AI in reinforcement wave
_AIdelay = (1 + (round (random 1)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 10;									//20% SpawnPersistentVehicle chance
_crate_weapons0 	= (35 + (round (random 5)));
_crate_items0 		= (35 + (round (random 5)));
_crate_backpacks0 	= (5 + (round (random 1)));
_crate_weapons1 	= (40 + (round (random 5)));
_crate_items1 		= (40 + (round (random 5)));
_crate_backpacks1 	= (5 + (round (random 5)));
	};
	case "difficult":
	{
_difficulty = "difficult";
_AICount = (22 + (round (random 5)));
_AIMaxReinforcements = (6 + (round (random 1)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (1 + (round (random 1)));						//Max amount of AI in reinforcement wave
_AIdelay = (1 + (round (random 1)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 50;									//20% SpawnPersistentVehicle chance
_crate_weapons0 	= (45 + (round (random 5)));
_crate_items0 		= (40 + (round (random 5)));
_crate_backpacks0 	= (5 + (round (random 1)));
_crate_weapons1 	= (40 + (round (random 5)));
_crate_items1 		= (45 + (round (random 5)));
_crate_backpacks1 	= (5 + (round (random 5)));
	};
	//case "hardcore":
	default
	{
_difficulty = "hardcore";
_AICount = (25 + (round (random 5)));
_AIMaxReinforcements = (8 + (round (random 1)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (1 + (round (random 1)));						//Max amount of AI in reinforcement wave
_AIdelay = (1 + (round (random 1)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 50;									//20% SpawnPersistentVehicle chance
_crate_weapons0 	= (50 + (round (random 5)));
_crate_items0 		= (45 + (round (random 5)));
_crate_backpacks0 	= (5 + (round (random 1)));
_crate_weapons1 	= (45 + (round (random 5)));
_crate_items1 		= (50 + (round (random 5)));
_crate_backpacks1 	= (5 + (round (random 5)));
	};
};

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
	//AI
	[7533.14,10547.6,0],
	[7520.19,10534.6,0],
	[7559.3,10534.6,0],
	[7557.46,10557.5,0],
	[7504.45,10535.3,0],
	[7480.39,10535.8,0],
	[7458.65,10557.4,0],
	[7490.21,10578.3,0],
	[7489.45,10597.6,0],
	[7523.56,10613.2,0],
	[7548.5,10613,0],
	[7529.7,10578.7,0],
	[7505.5,10575.1,0],
	[7504.85,10552.1,0],
	[7454.75,10574.6,0],
	[7519.58,10593.7,0]
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
    //Hoch
	[7439.7,10573.5,17.889],
	[7439.45,10579.9,17.889],
	[7447.3,10581.1,17.889],
	[7490.55,10557.7,3.121],
	[7482.92,10552.6,3.130],
	[7481.43,10557.8,3.128],
	[7502.1,10526.1,4.344],
	[7491.64,10526.2,4.338],
	[7489.12,10610.7,4.343],
	[7502.62,10611.2,4.344],
	[7520.16,10546.5,3.872],
	//Boden
	[7568.27,10535.1,0],
	[7551.55,10530.2,0],
	[7516.41,10530.7,0],
	[7459.76,10538.6,0],
	[7463.58,10568.5,0],
	[7464,10608.5,0],
	[7461.25,10605.4,0],
	[7483.89,10605.7,0],
	[7514.38,10612.7,0],
	[7531.47,10613.1,0],
	[7553.05,10617.8,0],
	[7544.04,10583.2,0],
	[7556.65,10592.9,0],
	[7564.77,10567.4,0],
	[7569.93,10545.5,0],
	[7545.22,10532.5,0],
	[7528.8,10532.6,0]
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
    //Hoch
	[7439.7,10573.5,17.889],
	[7439.45,10579.9,17.889],
	[7447.3,10581.1,17.889],
	[7490.55,10557.7,3.121],
	[7482.92,10552.6,3.130],
	[7481.43,10557.8,3.128],
	[7502.1,10526.1,4.344],
	[7491.64,10526.2,4.338],
	[7489.12,10610.7,4.343],
	[7502.62,10611.2,4.344],
	[7520.16,10546.5,3.872],
	//Boden
	[7568.27,10535.1,0],
	[7551.55,10530.2,0],
	[7516.41,10530.7,0],
	[7459.76,10538.6,0],
	[7463.58,10568.5,0],
	[7464,10608.5,0],
	[7461.25,10605.4,0],
	[7483.89,10605.7,0],
	[7514.38,10612.7,0],
	[7531.47,10613.1,0],
	[7553.05,10617.8,0],
	[7544.04,10583.2,0],
	[7556.65,10592.9,0],
	[7564.77,10567.4,0],
	[7569.93,10545.5,0],
	[7545.22,10532.5,0],
	[7528.8,10532.6,0]
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
	[[7538.82,10532.5,0],"I_CargoNet_01_ammo_F"],
	[[7534.2,10532.4,0],"I_CargoNet_01_ammo_F"]
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
											_vehicle = ["O_T_Truck_03_covered_ghex_F",[7498.34,10580,0],_pinCode] call DMS_fnc_SpawnPersistentVehicle;
											_msgWIN = ['#0080ff',format ["Haste schoen gemacht der code ist %1...",_pinCode]];
											} else
											{
											_vehicle = ["O_T_Truck_03_covered_ghex_F",[7498.34,10580,0]] call DMS_fnc_SpawnNonPersistentVehicle;
											_msgWIN = ['#0080ff',"Haste schoen gemacht code gibt es nicht"];
											};

// Define mission-spawned objects and loot values with vehicle
_missionObjs =
[
	_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
	[_vehicle],				// vehicle prize
	[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]]
];	
											
// Define Mission Start message
_msgStart = ['#FFFF00',format["Ai Party an der Nachschublager %1 Truppen",_difficultyM]];

// Define Mission Win message defined in vehicle choice

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Kein wunder mit der Knifte"];

// Define mission name (for map marker and logging)
_missionName = "Nachschublager";

// Create Markers
_markers =
[
	_pos,
	_missionName,
	_difficultyM
] call DMS_fnc_CreateMarker;

_circle = _markers select 1;
_circle setMarkerDir 0;
_circle setMarkerSize [400,400];

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