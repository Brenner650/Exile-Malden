/*
	"Outpost." v1 static mission for MALDEN.
	Created by Thomas TKO
	O_T_LSV_02_armed_viper_F increases persistent chance with difficulty
	tko-gameserver.de
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_cash0", "_crate_loot_values0", "_crate_weapons0", "_crate_items0", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_pinCode", "_VehicleChance"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [11631.9,4462.0]; //insert the centre here

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
_AICount = (15 + (round (random 5)));					//AI starting numbers
_AIMaxReinforcements = (4 + (round (random 4)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (1 + (round (random 1)));						//Max amount of AI in reinforcement wave
_AIdelay = (1 + (round (random 1)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 10;									//10% SpawnPersistentVehicle chance
_crate_weapons0 	= (40 + (round (random 5)));		//Crate 0 weapons number
_crate_items0 		= (30 + (round (random 5)));		//Crate 0 items number
_cash0 = (30000 + round (random (1500)));				//Tabs for crate0
	};
	case "moderate":
	{
_difficulty = "moderate";
_AICount = (20 + (round (random 2)));
_AIMaxReinforcements = (6 + (round (random 4)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (1 + (round (random 1)));						//Max amount of AI in reinforcement wave
_AIdelay = (1 + (round (random 1)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 50;									//20% SpawnPersistentVehicle chance
_crate_weapons0 	= (50 + (round (random 5)));
_crate_items0 		= (30 + (round (random 5)));
_cash0 = (40000 + round (random (1500)));				//Tabs for crate0
	};
	case "difficult":
	{
_difficulty = "difficult";
_AICount = (22 + (round (random 5)));
_AIMaxReinforcements = (6 + (round (random 4)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (1 + (round (random 1)));						//Max amount of AI in reinforcement wave
_AIdelay = (1 + (round (random 1)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 70;									//20% SpawnPersistentVehicle chance
_crate_weapons0 	= (60 + (round (random 5)));
_crate_items0 		= (40 + (round (random 5)));
_cash0 = (50000 + round (random (1500)));				//Tabs for crate0
	};
	//case "hardcore":
	default
	{
_difficulty = "hardcore";
_AICount = (25 + (round (random 5)));
_AIMaxReinforcements = (8 + (round (random 4)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (1 + (round (random 1)));						//Max amount of AI in reinforcement wave
_AIdelay = (1 + (round (random 1)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 90;									//20% SpawnPersistentVehicle chance
_crate_weapons0 	= (60 + (round (random 5)));
_crate_items0 		= (50 + (round (random 5)));
_cash0 = (70000 + round (random (1500)));				//Tabs for crate0
	};
};

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
	//ai
	[11605.2,4456.98,0],
	[11597.2,4487.19,0],
	[11631.5,4496.01,0],
	[11649.5,4475.8,0],
	[11627,4474.35,0],
	[11665.8,4486.11,0],
	[11688,4502.72,13.0],
	[11709.3,4487.99,0],
	[11696,4480.13,13.0],
	[11672.1,4469.88,0],
	[11668.5,4443.41,0],
	[11658.9,4436.6,0],
	[11636.5,4438.5,0],
	[11605.3,4425.92,0],
	[11619.7,4483.45,0],
	[11613.2,4508.7,0],
	[11581.1,4484.65,0],
	[11700.5,4459.9,0],
	[11632.3,4467.14,0],
	[11614.3,4410.21,0],
	[11683.5,4469,13.0],
	[11657.6,4502.39,0]
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
    //hoch hmg
	[11707.3,4507.82,17.889],
	[11703.6,4499.28,17.792],
	[11697.6,4507.61,17.889],
	[11591.5,4522.54,18.252],
	[11583,4526.63,17.911],
	[11583.4,4516.79,17.805],
	[11609.7,4405.3,17.058],
	[11619.7,4399.14,16.326],
	[11619.5,4406.81,17.767],
	[11657.4,4460.53,4.344],
	[11646.1,4491.51,3.127],
	[11645,4484.71,3.127],
	[11673.4,4498.88,3.277],
	[11670.6,4493.89,3.175],
	[11661.8,4495.47,2.975],
	[11703.4,4507.89,4.641],
	[11584.6,4518.04,8.555],
	[11652.9,4433.59,6.977],
	[11648.6,4433.16,6.977],
	[11650.4,4434.95,3.68],
	//boden hmg
	[11604.6,4437.56,0],
	[11603.1,4450.29,0],
	[11586.4,4460.62,0],
	[11597.2,4426.14,0],
	[11631.2,4432.08,0],
	[11618,4475.99,0],
	[11608.3,4493.92,0],
	[11598.4,4492.49,0],
	[11650.5,4466.71,0],
	[11645.1,4442.96,0],
	[11627.1,4469.06,0],
	[11629,4453.59,0],
	[11706.9,4495.13,0],
	[11706.6,4476.99,0],
	[11660.4,4490.05,0],
	[11694.6,4442.39,0],
	[11590.1,4421.35,0],
	[11658.3,4443.05,0],
	[11656.4,4476.17,0],
	[11704.4,4507.74,0]
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
    //hoch hmg
	[11707.3,4507.82,17.889],
	[11703.6,4499.28,17.792],
	[11697.6,4507.61,17.889],
	[11591.5,4522.54,18.252],
	[11583,4526.63,17.911],
	[11583.4,4516.79,17.805],
	[11609.7,4405.3,17.058],
	[11619.7,4399.14,16.326],
	[11619.5,4406.81,17.767],
	[11657.4,4460.53,4.344],
	[11646.1,4491.51,3.127],
	[11645,4484.71,3.127],
	[11673.4,4498.88,3.277],
	[11670.6,4493.89,3.175],
	[11661.8,4495.47,2.975],
	[11703.4,4507.89,4.641],
	[11584.6,4518.04,8.555],
	[11652.9,4433.59,6.977],
	[11648.6,4433.16,6.977],
	[11650.4,4434.95,3.68],
	//boden hmg
	[11604.6,4437.56,0],
	[11603.1,4450.29,0],
	[11586.4,4460.62,0],
	[11597.2,4426.14,0],
	[11631.2,4432.08,0],
	[11618,4475.99,0],
	[11608.3,4493.92,0],
	[11598.4,4492.49,0],
	[11650.5,4466.71,0],
	[11645.1,4442.96,0],
	[11627.1,4469.06,0],
	[11629,4453.59,0],
	[11706.9,4495.13,0],
	[11706.6,4476.99,0],
	[11660.4,4490.05,0],
	[11694.6,4442.39,0],
	[11590.1,4421.35,0],
	[11658.3,4443.05,0],
	[11656.4,4476.17,0],
	[11704.4,4507.74,0]
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
	[[11666.4,4498.08,3.024],"I_CargoNet_01_ammo_F"],
	[[11642.8,4493.39,3.024],"I_CargoNet_01_ammo_F"]
];

{
	deleteVehicle (nearestObject _x);		// Make sure to remove any previous crates.
} forEach _crateClasses_and_Positions;

// Shuffle the list
_crateClasses_and_Positions = _crateClasses_and_Positions call ExileClient_util_array_shuffle;


// Create Crates
_crate0 = [_crateClasses_and_Positions select 0 select 1, _crateClasses_and_Positions select 0 select 0] call DMS_fnc_SpawnCrate;

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
} forEach [_crate0];

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
	_crate_items0			// Set in difficulty select - Items
];

// add cash to crates
_crate0 setVariable ["ExileMoney", _cash0,true];

// is %chance greater than random number[30026.7,17458.6,5]O_T_VTOL_02_vehicle_grey_F
if (_VehicleChance >= (random 100)) then {
											_pinCode = (1000 +(round (random 8999)));
											_vehicle = ["B_CTRG_Heli_Transport_01_sand_F",[11683.3,4446.58,0],_pinCode] call DMS_fnc_SpawnPersistentVehicle;
											_msgWIN = ['#0080ff',format ["Haste gut gemacht der code ist %1...",_pinCode]];
											} else
											{
											_vehicle = ["B_CTRG_Heli_Transport_01_sand_F",[11683.3,4446.58,0]] call DMS_fnc_SpawnNonPersistentVehicle;
											_msgWIN = ['#0080ff',"Haste gut gemacht code gibt es nicht"];
											};

// Define mission-spawned objects and loot values with vehicle
_missionObjs =
[
	_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
	[_vehicle],				// vehicle prize
	[[_crate0,_crate_loot_values0]]
];	
											
// Define Mission Start message
_msgStart = ['#FFFF00',format["Outpost Party mit %1 Truppen",_difficultyM]];

// Define Mission Win message defined in vehicle choice

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Kein wunder mit der Knifte"];

// Define mission name (for map marker and logging)
_missionName = "Outpost";

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