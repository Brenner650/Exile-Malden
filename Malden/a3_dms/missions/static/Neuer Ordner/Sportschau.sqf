/*
	"Sportschau" v1 static mission for Taunus.
	Created by Thomas TKO
	O_T_LSV_02_armed_viper_F increases persistent chance with difficulty
	tko-gameserver.de
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_pinCode", "_VehicleChance"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [12719.9,17065.6,0]; //insert the centre here

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
_AIwave = (5 + (round (random 5)));						//Max amount of AI in reinforcement wave
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
_VehicleChance = 10;								//90% SpawnPersistentVehicle chance
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
	[12712.1,17006.6,0],
	[12688.1,16985.1,0],
	[12724.6,16990,0],
	[12677.3,16993,0],
	[12652,17040.5,0],
	[12661.7,17018.7,0],
	[12665.8,17043.8,0],
	[12749.1,17024.1,0],
	[12738.4,17028.1,0],
	[12818.6,16974.1,0],
	[12757.1,16981.7,0],
	[12786.7,17022,0],
	[12784.4,17052.5,0],
	[12772.3,17088.3,0],
	[12745.7,17109,0],
	[12709.2,17090.8,0],
	[12673.3,17122.8,0],
	[12699.7,17144.9,0],
	[12686.7,17140.6,0],
	[12674.7,17138,0],
	[12711.5,17126.7,0],
	[12720.4,17078.4,0],
	[12691.6,17067.4,0],
	[12737.4,17056.4,0],
	[12714.9,17047.3,0],
	[12711.7,17056.3,0],
	[12718.7,17040.5,0],
	[12740.7,17048.8,0],
	[12741.4,17040.3,0],
	[12726.1,17033.6,0],
	[12693.9,17031,0],
	[12688.3,17046.3,0],
	[12697.7,17037.1,0],
	[12697.1,17021.7,0]
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
	[12669.4,17109.5,2.54],
	[12723.5,17129.9,2.54],
	[12743.1,17097.2,2.980],
	[12669.6,17067.3,2.980],
	[12743.4,17090.1,2.980],
	[12758.5,17045.8,2.980],
	[12746.3,17076,2.980],
	[12707.6,17066.5,2.980],
	[12774.2,17049.6,2.980],
	[12758.7,17081,2.980],
	[12767.6,17065.8,2.980],
	[12736.2,17026.7,3.765],
	//HMG Boden
	[12812,17012.9,0],
	[12806.1,17026.1,0],
	[12780.1,17016.6,04],
	[12644.8,17080.6,0],
	[12650.5,17067.1,0],
	[12684.4,17162.9,0],
	[12677.2,17157.8,0],
	[12662.3,17136.3,0],
	[12689.8,17145.7,0],
	[12712,17153.8,0],
	[12754.9,17085.2,0],
	[12764.3,17117.7,0],
	[12759.4,17127.2,0],
	[12770,17043.4,0],
	[12715.4,16974.1,0],
	[12773.6,17019.6,0],
	[12734,17024.2,0],
	[12754.8,17042.1,0],
	[12690,17015.2,0],
	[12667.2,17010.3,0]
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
	[12669.4,17109.5,2.54],
	[12723.5,17129.9,2.54],
	[12743.1,17097.2,2.980],
	[12669.6,17067.3,2.980],
	[12743.4,17090.1,2.980],
	[12758.5,17045.8,2.980],
	[12746.3,17076,2.980],
	[12707.6,17066.5,2.980],
	[12774.2,17049.6,2.980],
	[12758.7,17081,2.980],
	[12767.6,17065.8,2.980],
	[12736.2,17026.7,3.765],
	//HMG Boden
	[12812,17012.9,0],
	[12806.1,17026.1,0],
	[12780.1,17016.6,04],
	[12644.8,17080.6,0],
	[12650.5,17067.1,0],
	[12684.4,17162.9,0],
	[12677.2,17157.8,0],
	[12662.3,17136.3,0],
	[12689.8,17145.7,0],
	[12712,17153.8,0],
	[12754.9,17085.2,0],
	[12764.3,17117.7,0],
	[12759.4,17127.2,0],
	[12770,17043.4,0],
	[12715.4,16974.1,0],
	[12773.6,17019.6,0],
	[12734,17024.2,0],
	[12754.8,17042.1,0],
	[12690,17015.2,0],
	[12667.2,17010.3,0]
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
	[[12668.4,17004.6,0],"I_CargoNet_01_ammo_F"],
	[[12762.8,17035.3,0],"I_CargoNet_01_ammo_F"],
	[[12668.5,17124.5,0],"I_CargoNet_01_ammo_F"],
	[[12714.6,17139.3,0],"I_CargoNet_01_ammo_F"],
	[[12736,17102.7,0],"I_CargoNet_01_ammo_F"],
	[[12654.8,17037.3,0],"I_CargoNet_01_ammo_F"]
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
											_vehicle = ["I_MRAP_03_hmg_F",[12760.3,17021.4,0],_pinCode] call DMS_fnc_SpawnPersistentVehicle;
											_msgWIN = ['#0080ff',format ["Hura ! Sportschau gewonnen, code ist %1...",_pinCode]];
											} else
											{
											_vehicle = ["I_MRAP_03_hmg_F",[12760.3,17021.4,0]] call DMS_fnc_SpawnNonPersistentVehicle;
											_msgWIN = ['#0080ff',"Hura ! Sportschau gewonnen"];
											};

// Define mission-spawned objects and loot values with vehicle
_missionObjs =
[
	_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
	[_vehicle],				// vehicle prize
	[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]]
];	
											
// Define Mission Start message
_msgStart = ['#FFFF00',format["Die Regirung veranstaltet eine Sportschau mit %1 Soldaten",_difficultyM]];

// Define Mission Win message defined in vehicle choice

// Define Mission Lose message
_msgLOSE = ['#FF0000',"War nix mit dem Sport"];

// Define mission name (for map marker and logging)
_missionName = "Sportschau";

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