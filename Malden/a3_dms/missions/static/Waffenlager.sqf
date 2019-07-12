/*
	"Waffenlager." v1 static mission for lYTHIUM.
	Created by Thomas TKO
	O_T_LSV_02_armed_viper_F increases persistent chance with difficulty
	tko-gameserver.de
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_cash0", "_cash1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_pinCode", "_VehicleChance"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [7709.15,4185.92,0]; //insert the centre here

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
_AIMaxReinforcements = (1 + (round (random 1)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (1 + (round (random 1)));						//Max amount of AI in reinforcement wave
_AIdelay = (1 + (round (random 1)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 10;									//10% SpawnPersistentVehicle chance
_crate_weapons0 	= (35 + (round (random 5)));		//Crate 0 weapons number
_crate_items0 		= (15 + (round (random 5)));		//Crate 0 items number
_crate_backpacks0 	= (3 + (round (random 5)));			//Crate 0 back packs number
_crate_weapons1 	= (35 + (round (random 5)));			//Crate 1 weapons number
_crate_items1 		= (20 + (round (random 5)));		//Crate 1 items number
_crate_backpacks1 	= (1 + (round (random 5)));			//Crate 1 back packs number
_cash0 = (5000 + round (random (1500)));				//Tabs for crate0
_cash1 = (5000 + round (random (2000)));				//Tabs for crate1
	};
	case "moderate":
	{
_difficulty = "moderate";
_AICount = (20 + (round (random 2)));
_AIMaxReinforcements = (1 + (round (random 1)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (1 + (round (random 1)));						//Max amount of AI in reinforcement wave
_AIdelay = (1 + (round (random 1)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 50;									//20% SpawnPersistentVehicle chance
_crate_weapons0 	= (50 + (round (random 5)));
_crate_items0 		= (20 + (round (random 5)));
_crate_backpacks0 	= (5 + (round (random 5)));
_crate_weapons1 	= (50 + (round (random 5)));
_crate_items1 		= (20 + (round (random 5)));
_crate_backpacks1 	= (5 + (round (random 5)));
_cash0 = (6000 + round (random (1500)));				//Tabs for crate0
_cash1 = (6000 + round (random (2000)));				//Tabs for crate1
	};
	case "difficult":
	{
_difficulty = "difficult";
_AICount = (22 + (round (random 5)));
_AIMaxReinforcements = (1 + (round (random 1)));		//AI reinforcement cap , AI Verstärkungskappe
_AItrigger = (6 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax , Maximaler AI-Wert in Verstärkungswellen
_AIwave = (1 + (round (random 1)));						//Max amount of AI in reinforcement wave
_AIdelay = (1 + (round (random 1)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 80;									//20% SpawnPersistentVehicle chance
_crate_weapons0 	= (60 + (round (random 5)));
_crate_items0 		= (30 + (round (random 5)));
_crate_backpacks0 	= (5 + (round (random 5)));
_crate_weapons1 	= (60 + (round (random 5)));
_crate_items1 		= (30 + (round (random 5)));
_crate_backpacks1 	= (5 + (round (random 5)));
_cash0 = (7000 + round (random (1500)));				//Tabs for crate0
_cash1 = (7000 + round (random (2000)));				//Tabs for crate1
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
_VehicleChance = 100;									//20% SpawnPersistentVehicle chance
_crate_weapons0 	= (60 + (round (random 5)));
_crate_items0 		= (40 + (round (random 5)));
_crate_backpacks0 	= (5 + (round (random 5)));
_crate_weapons1 	= (60 + (round (random 5)));
_crate_items1 		= (40 + (round (random 5)));
_crate_backpacks1 	= (5 + (round (random 5)));
_cash0 = (8000 + round (random (1500)));				//Tabs for crate0
_cash1 = (8000 + round (random (2000)));				//Tabs for crate1
	};
};

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
	//AI
	[7671.98,4220.5,0],
	[7665.95,4228.03,0],
	[7661.9,4235.12,0],
	[7696.27,4241.13,0],
	[7677.21,4210.65,0],
	[7734.37,4229.4,0],
	[7703.81,4208.9,0],
	[7690.69,4168.68,0],
	[7700.69,4115.31,0],
	[7732.25,4119.08,0],
	[7735.43,4155.78,0],
	[7778.27,4124.01,0],
	[7769.92,4170.05,0],
	[7745.33,4201.95,0],
	[7727.17,4200.16,0],
	[7771.24,4225.82,0],
	[7719.2,4130.28,0],
	[7691.78,4131.52,0],
	[7710.05,4250,37.0],
	[7673,4259.08,0],
	[7661.07,4242.84,0],
	[7691.09,4155.29,0],
	[7689.06,4202.73,37.0],
	[7715.3,4235.19,0],
	[7767.52,4199.65,0],
	[7774.75,4153.59,0]
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
    //HMG Hoch
	[7860.18,4121.41,22.562],
	[7852.63,4121.59,22.562],
	//[7853.65,4121.1,8.442],
	[7858.02,4124.03,8.314],
	[7854.89,4118.96,8.314],
	[7790.57,4113.47,17.889],
	//[7781.86,4118.42,17.889],
	[7782.84,4109.36,17.792],
	[7694.27,4103.64,17.835],
	[7695.33,4110.94,17.835],
	[7687.04,4103.53,17.835],
	[7677.85,4190.43,17.682],
	//[7686.69,4185.59,17.682],
	[7686.88,4193.69,17.682],
	[7766.41,4240.39,17.889],
	[7774.41,4232.22,17.889],
	[7773.3,4240.69,17.889],
	[7751.63,4046.48,4.334],
	//[7748.81,4045.7,4.334],
	[7715.05,4267.56,4.427],
	[7712.99,4265.54,4.427],
	//[7763.78,4091.2,3.134],
	[7755.69,4086.97,3.134],
	[7754.51,4094.29,3.134],
	//[7761.88,4097.25,3.134],
	[7682.97,4270.99,2.161],
	[7691.22,4261.7,3.962],
	[7686.39,4244.73,3.962],
	//HMG Boden
	[7731.68,4100.19,0],
	[7734.63,4052.71,34.0],
	//[7741.15,4108.41,0],
	[7731.54,4107.5,0],
	[7681.51,4160.29,0],
	[7680.06,4175.38,0],
	//[7682.13,4273.41,0],
	[7716.8,4254.7,37.0],
	[7709.98,4260.89,37.0],
	[7722.29,4169.27,0],
	[7699.76,4147.06,0],
	[7713.88,4211.24,0],
	//[7744.22,4213.86,0],
	[7759.45,4207.81,0],
	[7764.27,4214.58,0],
	[7761.57,4238.25,0],
	[7758.67,4151.39,0],
	//[7745.06,4132.95,0],
	[7758,4122.73,0],
	[7677.35,4200.34,37.0],
	[7652,4234.46,0],
	//[7689.34,4281.1,0],
	[7722.69,4247.98,37.0],
	[7691.11,4244.34,0],
	[7781.4,4147.53,0]
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
    //HMG Hoch
	[7860.18,4121.41,22.562],
	[7852.63,4121.59,22.562],
	[7853.65,4121.1,8.442],
	[7858.02,4124.03,8.314],
	[7854.89,4118.96,8.314],
	[7790.57,4113.47,17.889],
	[7781.86,4118.42,17.889],
	[7782.84,4109.36,17.792],
	[7694.27,4103.64,17.835],
	[7695.33,4110.94,17.835],
	[7687.04,4103.53,17.835],
	[7677.85,4190.43,17.682],
	[7686.69,4185.59,17.682],
	[7686.88,4193.69,17.682],
	[7766.41,4240.39,17.889],
	[7774.41,4232.22,17.889],
	[7773.3,4240.69,17.889],
	[7751.63,4046.48,4.334],
	[7748.81,4045.7,4.334],
	[7715.05,4267.56,4.427],
	[7712.99,4265.54,4.427],
	[7763.78,4091.2,3.134],
	[7755.69,4086.97,3.134],
	[7754.51,4094.29,3.134],
	[7761.88,4097.25,3.134],
	[7682.97,4270.99,2.161],
	[7691.22,4261.7,3.962],
	[7686.39,4244.73,3.962],
	//HMG Boden
	[7731.68,4100.19,0],
	[7734.63,4052.71,34.0],
	[7741.15,4108.41,0],
	[7731.54,4107.5,0],
	[7681.51,4160.29,0],
	[7680.06,4175.38,0],
	[7682.13,4273.41,0],
	[7716.8,4254.7,37.0],
	[7709.98,4260.89,37.0],
	[7722.29,4169.27,0],
	[7699.76,4147.06,0],
	[7713.88,4211.24,0],
	[7744.22,4213.86,0],
	[7759.45,4207.81,0],
	[7764.27,4214.58,0],
	[7761.57,4238.25,0],
	[7758.67,4151.39,0],
	[7745.06,4132.95,0],
	[7758,4122.73,0],
	[7677.35,4200.34,37.0],
	[7652,4234.46,0],
	[7689.34,4281.1,0],
	[7722.69,4247.98,37.0],
	[7691.11,4244.34,0],
	[7781.4,4147.53,0]
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
	[[7770.5,4220.7,0],"I_CargoNet_01_ammo_F"],
	[[7709.15,4185.92,0],"I_CargoNet_01_ammo_F"]
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
// add cash to crates
_crate0 setVariable ["ExileMoney", _cash0,true];
_crate1 setVariable ["ExileMoney", _cash1,true];

// is %chance greater than random number[30026.7,17458.6,5]O_T_VTOL_02_vehicle_grey_F
if (_VehicleChance >= (random 100)) then {
											_pinCode = (1000 +(round (random 8999)));
											_vehicle = ["shounka_porsche911_noir",[7688.37,4234.23,0],_pinCode] call DMS_fnc_SpawnPersistentVehicle;
											_msgWIN = ['#0080ff',format ["Haste gut gemacht der code ist %1...",_pinCode]];
											} else
											{
											_vehicle = ["shounka_porsche911_noir",[7688.37,4234.23,0]] call DMS_fnc_SpawnNonPersistentVehicle;
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
_msgStart = ['#FFFF00',format["Party am Waffenlager %1 Truppen",_difficultyM]];

// Define Mission Win message defined in vehicle choice

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Kein wunder mit der Knifte"];

// Define mission name (for map marker and logging)
_missionName = "Waffenlager";

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