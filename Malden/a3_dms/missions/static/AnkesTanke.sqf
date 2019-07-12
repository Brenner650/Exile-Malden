/*
	"AnkesTanke." v1 static mission for MALDEN.
	Created by Thomas TKO
	O_T_LSV_02_armed_viper_F increases persistent chance with difficulty
	tko-gameserver.de
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_cash0", "_crate_loot_values0", "_crate_weapons0", "_crate_items0", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_pinCode", "_VehicleChance"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [6625.49,8792.66,0]; //insert the centre here

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
_VehicleChance = 30;									//10% SpawnPersistentVehicle chance
_crate_weapons0 	= (50 + (round (random 5)));		//Crate 0 weapons number
_crate_items0 		= (30 + (round (random 10)));		//Crate 0 items number
_cash0 = (40000 + round (random (8000)));				//Tabs for crate0
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
_crate_items0 		= (30 + (round (random 10)));
_cash0 = (50000 + round (random (8000)));				//Tabs for crate0
	};
	case "difficult":
	{
_difficulty = "difficult";
_AICount = (22 + (round (random 5)));
_AIMaxReinforcements = (8 + (round (random 4)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (1 + (round (random 1)));						//Max amount of AI in reinforcement wave
_AIdelay = (1 + (round (random 1)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 70;									//20% SpawnPersistentVehicle chance
_crate_weapons0 	= (60 + (round (random 10)));
_crate_items0 		= (40 + (round (random 5)));
_cash0 = (60000 + round (random (8000)));				//Tabs for crate0
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
_crate_weapons0 	= (70 + (round (random 10)));
_crate_items0 		= (50 + (round (random 10)));
_cash0 = (80000 + round (random (8000)));				//Tabs for crate0
	};
};

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
	//AI
	[6635.03,8838.22,0],
	[6611.26,8832.15,0],
	[6606.93,8847.77,0],
	[6671.17,8843.75,0],
	[6685.41,8822.97,0],
	[6660.58,8825.47,0],
	[6683.75,8803.46,0],
	[6652.83,8804.69,0],
	[6644.73,8770.17,0],
	[6641.41,8781.85,0],
	[6670.07,8769.83,0],
	[6612.48,8766.9,0],
	[6619.58,8783.51,0],
	[6621.07,8751.85,0],
	[6609.89,8755.14,0],
	[6596,8803.55,0],
	[6584.93,8822.61,0],
	[6568.59,8820.71,0],
	[6547.1,8812.96,0],
	[6554.48,8795.66,0],
	[6577.9,8799.5,0],
	[6569.08,8781.14,0],
	[6596.06,8776.29,0],
	[6642.33,8808.46,0],
	[6625.29,8806.71,0],
	[6613.94,8797.45,0]
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
	[6635.92,8778.68,0.410],
	[6660.12,8778.41,0.319],
	[6630.11,8757.86,0.327],
	[6635.08,8780.53,3.922],
	[6610.14,8805.68,0.567],
	[6615.88,8812.26,0.564],
	[6659.61,8845.12,4.522],
	[6651.47,8833.15,2.874],
	[6659.91,8833.46,2.898],
	[6589.31,8833.92,4.091],
	[6579.24,8811.1,0.154],
	[6572.4,8804.98,3.664],
	[6636.32,8804.54,5.015],
	[6630.31,8808.83,5.010],
	//BodenHMG
	[6668.63,8852.74,0],
	[6683.44,8853.6,0],
	[6691.4,8819.07,0],
	[6668.02,8813.57,0],
	[6646.79,8852.01,0],
	[6615.98,8850.16,0],
	[6633.66,8851.31,0],
	[6615.2,8818.52,0],
	[6651.54,8818.18,0],
	[6653.47,8786.93,0],
	[6667.56,8789.65,0],
	[6648.39,8776.86,0],
	[6635.14,8764.28,0],
	[6641.91,8756.47,0],
	[6616.74,8767.61,0],
	[6597.24,8757.53,0],
	[6567.07,8801.54,0],
	[6548.33,8788.81,0],
	[6545.13,8822.55,0],
	[6605.49,8839.47,0],
	[6611.27,8801.57,0],
	[6607.71,8776.26,0],
	[6588.63,8794.62,0],
	[6647.61,8834.23,0],
	[6631.78,8784.17,0]
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
	[6635.92,8778.68,0.410],
	[6660.12,8778.41,0.319],
	[6630.11,8757.86,0.327],
	[6635.08,8780.53,3.922],
	[6610.14,8805.68,0.567],
	[6615.88,8812.26,0.564],
	[6659.61,8845.12,4.522],
	[6651.47,8833.15,2.874],
	[6659.91,8833.46,2.898],
	[6589.31,8833.92,4.091],
	[6579.24,8811.1,0.154],
	[6572.4,8804.98,3.664],
	[6636.32,8804.54,5.015],
	[6630.31,8808.83,5.010],
	//BodenHMG
	[6668.63,8852.74,0],
	[6683.44,8853.6,0],
	[6691.4,8819.07,0],
	[6668.02,8813.57,0],
	[6646.79,8852.01,0],
	[6615.98,8850.16,0],
	[6633.66,8851.31,0],
	[6615.2,8818.52,0],
	[6651.54,8818.18,0],
	[6653.47,8786.93,0],
	[6667.56,8789.65,0],
	[6648.39,8776.86,0],
	[6635.14,8764.28,0],
	[6641.91,8756.47,0],
	[6616.74,8767.61,0],
	[6597.24,8757.53,0],
	[6567.07,8801.54,0],
	[6548.33,8788.81,0],
	[6545.13,8822.55,0],
	[6605.49,8839.47,0],
	[6611.27,8801.57,0],
	[6607.71,8776.26,0],
	[6588.63,8794.62,0],
	[6647.61,8834.23,0],
	[6631.78,8784.17,0]
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
	[[6624.01,8848.6,0],"I_CargoNet_01_ammo_F"],
	[[6544.3,8807.05,0],"I_CargoNet_01_ammo_F"],
	[[6656.13,8768.38,0],"I_CargoNet_01_ammo_F"],
	[[6638.94,8816.31,0],"I_CargoNet_01_ammo_F"]
];

{
	deleteVehicle (nearestObject _x);		// Make sure to remove any previous crates.
} forEach _crateClasses_and_Positions;

// Shuffle the list
_crateClasses_and_Positions = _crateClasses_and_Positions call ExileClient_util_array_shuffle;


// Create Crates
_crate0 = [_crateClasses_and_Positions select 0 select 1, _crateClasses_and_Positions select 0 select 0] call DMS_fnc_SpawnCrate;

// Don't think an armed AI vehicle fit the idea behind the mission. You're welcome to uncomment this if you want.
_veh =
[
	[
		[_pos,100,random 360] call DMS_fnc_SelectOffsetPos,
		_pos
	],
	_group,
	"assault",
	_difficulty,
	_side
] call DMS_fnc_SpawnAIVehicle;

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
											_vehicle = ["Mrshounka_agera_p_noir",[6625.49,8792.66,0],_pinCode] call DMS_fnc_SpawnPersistentVehicle;
											_msgWIN = ['#0080ff',format ["Haste gut gemacht der code ist %1...",_pinCode]];
											} else
											{
											_vehicle = ["Mrshounka_agera_p_noir",[6625.49,8792.66,0]] call DMS_fnc_SpawnNonPersistentVehicle;
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
_msgStart = ['#FFFF00',format["AnkesTanke Party mit %1 Truppen",_difficultyM]];

// Define Mission Win message defined in vehicle choice

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Kein wunder mit der Knifte"];

// Define mission name (for map marker and logging)
_missionName = "AnkesTanke";

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