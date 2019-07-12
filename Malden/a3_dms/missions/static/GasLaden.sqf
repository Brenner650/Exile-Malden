/*
	"GasLaden." v1 static mission for lYTHIUM.
	Created by Thomas TKO
	O_T_LSV_02_armed_viper_F increases persistent chance with difficulty
	tko-gameserver.de
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_pinCode", "_VehicleChance"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [7775.01,3322.96,0]; //insert the centre here

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
_VehicleChance = 20;									//10% SpawnPersistentVehicle chance
_crate_weapons0 	= (25 + (round (random 5)));		//Crate 0 weapons number
_crate_items0 		= (20 + (round (random 5)));		//Crate 0 items number
_crate_backpacks0 	= (3 + (round (random 1)));			//Crate 0 back packs number
_crate_weapons1 	= (20 + (round (random 5)));			//Crate 1 weapons number
_crate_items1 		= (25 + (round (random 5)));		//Crate 1 items number
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
_VehicleChance = 40;									//20% SpawnPersistentVehicle chance
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
_VehicleChance = 70;									//20% SpawnPersistentVehicle chance
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
	[7782.42,3322.38,10.0],
	[7803.64,3287.74,10.0],
	[7772.23,3270.33,0],
	[7741.77,3262.41,0],
	[7737.95,3249.27,0],
	[7715.48,3308.1,0],
	[7720.37,3334.24,0],
	[7688.77,3362.14,0],
	[7673.96,3356.67,0],
	[7716.7,3410.35,0],
	[7745.2,3367.53,0],
	[7729.22,3364.69,0],
	[7714.13,3371.04,0],
	[7729.51,3451.53,0],
	[7716.97,3429.45,0],
	[7696.91,3411.14,0],
	[7743.42,3421.8,0],
	[7729.04,3311.38,0]
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
	[7790.12,3205.21,6.523],
	[7769.62,3201.13,6.524],
	[7767.83,3224.36,6.524],
	[7789.16,3222.58,10.314],
	[7788.03,3231.52,10.560],
	[7769.39,3241.68,10.12],
	[7718.54,3284.38,6.428],
	[7694.81,3342.43,6.016],
	[7694.85,3317.45,5.984],
	[7739.21,3401.5,17.313],
	[7738.22,3380.38,17.313],
	[7730.48,3394.3,17.317],
	[7665.27,3324.64,5.996],
	[7660.05,3330.42,6.362],
	[7659.28,3337.93,6.364],
	[7657.82,3321.7,3.045],
	[7661.27,3314.26,2.826],
	[7659.86,3320.76,4.933],
	[7724.86,3466.71,0.487],
	[7705.04,3460.31,0.296],
	[7739.46,3385.74,12.099],
	//BodenHMG
	[7685.21,3387.68,0],
	[7700.09,3366.75,0],
	[7670.93,3379.81,0],
	[7702.86,3295.71,0],
	[7709.09,3299.02,0],
	[7754.71,3381.33,0],
	[7745.6,3413.62,0],
	[7727.59,3409.39,0],
	[7735.16,3427.45,0],
	[7708.54,3446.91,0],
	[7694,3388.81,0],
	[7772.67,3338.76,0.0],
	[7788.75,3333.93,0.0],
	[7785.4,3312.57,0.0],
	[7755.67,3254.75,0],
	[7733.85,3255.81,0],
	[7747.75,3271.39,0],
	[7779.61,3271.86,0],
	[7765.66,3261.51,0],
	[7784.03,3242.82,0]
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
	[7790.12,3205.21,6.523],
	[7769.62,3201.13,6.524],
	[7767.83,3224.36,6.524],
	[7789.16,3222.58,10.314],
	[7788.03,3231.52,10.560],
	[7769.39,3241.68,10.12],
	[7718.54,3284.38,6.428],
	[7694.81,3342.43,6.016],
	[7694.85,3317.45,5.984],
	[7739.21,3401.5,17.313],
	[7738.22,3380.38,17.313],
	[7730.48,3394.3,17.317],
	[7665.27,3324.64,5.996],
	[7660.05,3330.42,6.362],
	[7659.28,3337.93,6.364],
	[7657.82,3321.7,3.045],
	[7661.27,3314.26,2.826],
	[7659.86,3320.76,4.933],
	[7724.86,3466.71,0.487],
	[7705.04,3460.31,0.296],
	[7739.46,3385.74,12.099],
	//BodenHMG
	[7685.21,3387.68,0],
	[7700.09,3366.75,0],
	[7670.93,3379.81,0],
	[7702.86,3295.71,0],
	[7709.09,3299.02,0],
	[7754.71,3381.33,0],
	[7745.6,3413.62,0],
	[7727.59,3409.39,0],
	[7735.16,3427.45,0],
	[7708.54,3446.91,0],
	[7694,3388.81,0],
	[7772.67,3338.76,0.0],
	[7788.75,3333.93,0.0],
	[7785.4,3312.57,0.0],
	[7755.67,3254.75,0],
	[7733.85,3255.81,0],
	[7747.75,3271.39,0],
	[7779.61,3271.86,0],
	[7765.66,3261.51,0],
	[7784.03,3242.82,0]
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
	[[7791.09,3315.66,0],"I_CargoNet_01_ammo_F"],
	[[7775.01,3322.96,0],"I_CargoNet_01_ammo_F"]
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
											_vehicle = ["B_CTRG_Heli_Transport_01_sand_F",[7722.29,3437.57,0],_pinCode] call DMS_fnc_SpawnPersistentVehicle;
											_msgWIN = ['#0080ff',format ["Haste gut gemacht der code ist %1...",_pinCode]];
											} else
											{
											_vehicle = ["Mrshounka_veneno_c_noir",[7722.29,3437.57,0]] call DMS_fnc_SpawnNonPersistentVehicle;
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
_msgStart = ['#FFFF00',format["Party im GasLaden %1 Truppen",_difficultyM]];

// Define Mission Win message defined in vehicle choice

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Kein wunder mit der Knifte"];

// Define mission name (for map marker and logging)
_missionName = "GasLaden";

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