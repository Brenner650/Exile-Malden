/*
	"TropicalIsland." v1 static mission for lYTHIUM.
	Created by Thomas TKO
	O_T_LSV_02_armed_viper_F increases persistent chance with difficulty
	tko-gameserver.de
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_pinCode", "_VehicleChance"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [9734.836,3917.738,0]; //insert the centre here

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
_AIMaxReinforcements = (1 + (round (random 1)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (1 + (round (random 1)));						//Max amount of AI in reinforcement wave
_AIdelay = (1 + (round (random 1)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 50;									//20% SpawnPersistentVehicle chance
_crate_weapons0 	= (54 + (round (random 5)));
_crate_items0 		= (40 + (round (random 5)));
_crate_backpacks0 	= (5 + (round (random 1)));
_crate_weapons1 	= (30 + (round (random 5)));
_crate_items1 		= (40 + (round (random 5)));
_crate_backpacks1 	= (5 + (round (random 5)));
	};
	case "difficult":
	{
_difficulty = "difficult";
_AICount = (22 + (round (random 5)));
_AIMaxReinforcements = (1 + (round (random 1)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (1 + (round (random 1)));						//Max amount of AI in reinforcement wave
_AIdelay = (1 + (round (random 1)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 70;									//20% SpawnPersistentVehicle chance
_crate_weapons0 	= (40 + (round (random 5)));
_crate_items0 		= (54 + (round (random 5)));
_crate_backpacks0 	= (5 + (round (random 1)));
_crate_weapons1 	= (30 + (round (random 5)));
_crate_items1 		= (54 + (round (random 5)));
_crate_backpacks1 	= (5 + (round (random 5)));
	};
	//case "hardcore":
	default
	{
_difficulty = "hardcore";
_AICount = (25 + (round (random 5)));
_AIMaxReinforcements = (1 + (round (random 1)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (1 + (round (random 1)));						//Max amount of AI in reinforcement wave
_AIdelay = (1 + (round (random 1)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 80;									//20% SpawnPersistentVehicle chance
_crate_weapons0 	= (54 + (round (random 5)));
_crate_items0 		= (54 + (round (random 5)));
_crate_backpacks0 	= (5 + (round (random 1)));
_crate_weapons1 	= (54 + (round (random 5)));
_crate_items1 		= (54 + (round (random 5)));
_crate_backpacks1 	= (5 + (round (random 5)));
	};
};

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
	//AI
	[9748.33,3975.98,0],
	[9720.79,3933.76,0],
	[9690.3,3939.95,0],
	[9680.44,3903.18,0],
	[9699.54,3871.04,0],
	[9742.33,3868.47,0],
	[9775.45,3880.2,0],
	[9794.94,3866.99,0],
	[9798.71,3923.21,0],
	[9768.3,3930.11,0],
	[9743.94,3919.24,0],
	[9744.84,3910.44,0],
	[9744.53,3901.24,0],
	[9745.57,3893.41,0],
	[9735.56,3856.51,0],
	[9762.54,3890.8,0],
	[9728.29,3896.16,0],
	[9712.86,3909.7,0],
	[9734.84,3917.79,0],
	[9708.13,3939.27,0],
	[9738.3,3965.13,0],
	[9679.43,3987.21,0],
	[9668.74,3903.27,0],
	[9676.52,3861.06,0],
	[9766.01,3988.14,0],
	[9734.97,3987.23,0]
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
	[9698.47,3851.58,17.889],
	[9694.13,3859.1,17.792],
	[9704.23,3859.36,17.889],
	[9801.03,3927.45,17.792],
	[9800.63,3937.41,17.889],
	[9809.01,3931.58,17.889],
	[9669.34,3862.84,4.307],
	[9668.54,3921.24,4.344],
	[9690.14,4011.77,17.889],
	[9692.14,4002.18,17.889],
	[9684.23,4003.31,17.889],
	[9687.65,4009.46,4.641],
	[9806.14,3933.87,44.641],
	//BodenHMG
	[9704.92,3892.42,0],
	[9687.39,3961.33,0],
	[9728.45,3956.41,0],
	[9718.07,3973.38,0],
	[9688.35,3952.64,0],
	[9740.03,3976.41,0],
	[9757.19,3976.78,0],
	[9744.74,3928.57,0],
	[9745.11,3887.21,0],
	[9794.07,3859.56,0],
	[9793.72,3875.66,0],
	[9796.27,3915.07,0],
	[9772.14,3948.81,0],
	[9683.43,3887.85,0],
	[9710.52,3926.07,0],
	[9776.53,3932.48,0],
	[9781.54,3890.02,0],
	[9764.71,3872.93,0],
	[9716.42,3880.82,0],
	[9727.59,3978.22,0],
	[9762.08,3947.49,0],
	[9681.21,3856.15,0],
	[9668.93,3855.97,0],
	[9672.06,3981.8,0],
	[9672.38,3992.23,0],
	[9762.66,4003.37,0],
	[9773.04,4002.32,0]
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
	[9698.47,3851.58,17.889],
	[9694.13,3859.1,17.792],
	[9704.23,3859.36,17.889],
	[9801.03,3927.45,17.792],
	[9800.63,3937.41,17.889],
	[9809.01,3931.58,17.889],
	[9669.34,3862.84,4.307],
	[9668.54,3921.24,4.344],
	[9690.14,4011.77,17.889],
	[9692.14,4002.18,17.889],
	[9684.23,4003.31,17.889],
	[9687.65,4009.46,4.641],
	[9806.14,3933.87,44.641],
	//BodenHMG
	[9704.92,3892.42,0],
	[9687.39,3961.33,0],
	[9728.45,3956.41,0],
	[9718.07,3973.38,0],
	[9688.35,3952.64,0],
	[9740.03,3976.41,0],
	[9757.19,3976.78,0],
	[9744.74,3928.57,0],
	[9745.11,3887.21,0],
	[9794.07,3859.56,0],
	[9793.72,3875.66,0],
	[9796.27,3915.07,0],
	[9772.14,3948.81,0],
	[9683.43,3887.85,0],
	[9710.52,3926.07,0],
	[9776.53,3932.48,0],
	[9781.54,3890.02,0],
	[9764.71,3872.93,0],
	[9716.42,3880.82,0],
	[9727.59,3978.22,0],
	[9762.08,3947.49,0],
	[9681.21,3856.15,0],
	[9668.93,3855.97,0],
	[9672.06,3981.8,0],
	[9672.38,3992.23,0],
	[9762.66,4003.37,0],
	[9773.04,4002.32,0]
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
	[[9743.55,3952.24,0],"I_CargoNet_01_ammo_F"],
	[[9697.17,3910.51,0],"I_CargoNet_01_ammo_F"],
	[[9705.29,3878.84,0],"I_CargoNet_01_ammo_F"],
	[[9771.32,3915.37,0],"I_CargoNet_01_ammo_F"]
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
											_vehicle = ["B_CTRG_Heli_Transport_01_tropic_F",[9705.45,3962.32,0],_pinCode] call DMS_fnc_SpawnPersistentVehicle;
											_msgWIN = ['#0080ff',format ["Haste schoen gemacht der code ist %1...",_pinCode]];
											} else
											{
											_vehicle = ["B_CTRG_Heli_Transport_01_tropic_F",[9705.45,3962.32,0]] call DMS_fnc_SpawnNonPersistentVehicle;
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
_msgStart = ['#FFFF00',format["Ai Party an der TropicalIsland %1 Truppen",_difficultyM]];

// Define Mission Win message defined in vehicle choice

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Kein wunder mit der Knifte"];

// Define mission name (for map marker and logging)
_missionName = "TropicalIsland";

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