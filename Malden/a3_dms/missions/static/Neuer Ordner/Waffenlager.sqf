/*
	"Waffenlager" v1 static mission for Taunus.
	Created by Thomas TKO
	O_T_LSV_02_armed_viper_F increases persistent chance with difficulty
	tko-gameserver.de
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_pinCode", "_VehicleChance"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [17225.705,4844.789,0]; //insert the centre here

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
	case "moderate":
	{
_difficulty = "moderate";
_AICount = (20 + (round (random 5)));
_AIMaxReinforcements = (2 + (round (random 4)));
_AItrigger = (8 + (round (random 5)));
_AIwave = (4 + (round (random 4)));
_AIdelay = (2 + (round (random 10)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 10;									//20% SpawnPersistentVehicle chance
_crate_weapons0 	= (25 + (round (random 5)));
_crate_items0 		= (25 + (round (random 5)));
_crate_backpacks0 	= (5 + (round (random 1)));
_crate_weapons1 	= (25 + (round (random 5)));
_crate_items1 		= (25 + (round (random 5)));
_crate_backpacks1 	= (5 + (round (random 5)));
	};
	case "difficult":
	{
_difficulty = "difficult";
_AICount = (20 + (round (random 5)));
_AIMaxReinforcements = (2 + (round (random 4)));
_AItrigger = (8 + (round (random 5)));
_AIwave = (4 + (round (random 4)));
_AIdelay = (2 + (round (random 10)));					//The delay between reinforcements ,Die Verzögerung zwischen Verstärkungen
_VehicleChance = 10;									//20% SpawnPersistentVehicle chance
_crate_weapons0 	= (25 + (round (random 5)));
_crate_items0 		= (25 + (round (random 5)));
_crate_backpacks0 	= (5 + (round (random 1)));
_crate_weapons1 	= (25 + (round (random 5)));
_crate_items1 		= (25 + (round (random 5)));
_crate_backpacks1 	= (5 + (round (random 5)));
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
_VehicleChance = 30;									//20% SpawnPersistentVehicle chance
_crate_weapons0 	= (25 + (round (random 5)));
_crate_items0 		= (25 + (round (random 5)));
_crate_backpacks0 	= (5 + (round (random 1)));
_crate_weapons1 	= (25 + (round (random 5)));
_crate_items1 		= (25 + (round (random 5)));
_crate_backpacks1 	= (5 + (round (random 5)));
	};
};

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
	//AI
	[19035.9,18834.3,0],	
	[18992.7,18843.5,0],
	[18959.2,18851.9,0],
	[18960.3,18871.6,0],
	[19000.2,18859.9,0],
	[19032.8,18849,0],
	[19010,18837.5,0],
	[18866.3,18879.6,0],
	[18876.7,18843.2,0],
	[18956.8,18819.6,0],
	[19035.1,18804.5,0],
	[19207.5,18939.1,0],
	[19174.7,18962.4,0],
	[19197.6,18926.7,0],
	[19154,18938.5,0],
	[19148.5,18763.5,0],
	[19131.4,18775.3,0],
	[19155.5,18775.5,0],
	[19135.2,18778.7,0],
	[19162.6,18798.1,0],
	[19165.6,18779.6,0],
	[19159.9,18766.3,0],
	[18848.5,18873.7,0],
	[18861.8,18859.1,0]
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
    //Hmg Hoch
	[19066,18833.1,17.889],
	[19074.3,18834.3,17.889],
	[19068.6,18841.2,17.889],
	[19164.1,18761.3,3.127],
	[19166.4,18781.6,4.344],
	[19154.9,18755.3,3.127],
	[19130.3,18767.1,4.344],
	[19199.6,18968,17.889],
	[19193,18960,17.792],
	[19200.8,18964.3,17.889],
	[18839.3,18885.5,3.956],
	[18848.8,18887.1,3.956],
	[18842.7,18900.2,6.906],
	[18827.7,18848,4.344],
	[19057.7,18790.2,6.906],
	[19219.2,18917.1,6.906],
	[18905.6,18827,4.440],
	[18972.9,19079.6,17.889],
	[18969.6,19086.3,17.889],
	[18977.7,19087.3,17.889],
	//BodenHMG
	[19168.8,18771,0],
	[19144.9,18756.9,0],
	[19126.3,18764.9,0],
	[19161.7,18779.8,0],
	[18948.4,18819.7,0],
	[18827.8,18863.9,0],
	[18861.3,18867.2,0],
	[18844,18874.2,0],
	[19000.7,18867.1,0],
	[18950.6,18888.8,0],
	[18940.1,18856.3,0],
	[18979.8,18845.4,0],
	[19025.8,18833.1,0],
	[19159.8,18946.8,0],
	[19184.4,18935.4,0],
	[19240.8,18989.6,0],
	[18984,18882.2,0]
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
    //Hmg Hoch
	[19066,18833.1,17.889],
	[19074.3,18834.3,17.889],
	[19068.6,18841.2,17.889],
	[19164.1,18761.3,3.127],
	[19166.4,18781.6,4.344],
	[19154.9,18755.3,3.127],
	[19130.3,18767.1,4.344],
	[19199.6,18968,17.889],
	[19193,18960,17.792],
	[19200.8,18964.3,17.889],
	[18839.3,18885.5,3.956],
	[18848.8,18887.1,3.956],
	[18842.7,18900.2,6.906],
	[18827.7,18848,4.344],
	[19057.7,18790.2,6.906],
	[19219.2,18917.1,6.906],
	[18905.6,18827,4.440],
	[18972.9,19079.6,17.889],
	[18969.6,19086.3,17.889],
	[18977.7,19087.3,17.889],
	//BodenHMG
	[19168.8,18771,0],
	[19144.9,18756.9,0],
	[19126.3,18764.9,0],
	[19161.7,18779.8,0],
	[18948.4,18819.7,0],
	[18827.8,18863.9,0],
	[18861.3,18867.2,0],
	[18844,18874.2,0],
	[19000.7,18867.1,0],
	[18950.6,18888.8,0],
	[18940.1,18856.3,0],
	[18979.8,18845.4,0],
	[19025.8,18833.1,0],
	[19159.8,18946.8,0],
	[19184.4,18935.4,0],
	[19240.8,18989.6,0],
	[18984,18882.2,0]
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
	[[18941.4,18882.1,0],"I_CargoNet_01_ammo_F"],
	[[19044.6,18847,0],"I_CargoNet_01_ammo_F"]
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
											_vehicle = ["B_CTRG_Heli_Transport_01_tropic_F",[19012.6,18853,0],_pinCode] call DMS_fnc_SpawnPersistentVehicle;
											_msgWIN = ['#0080ff',format ["Hura ! Waffenlager ausgeräumt, code ist %1...",_pinCode]];
											} else
											{
											_vehicle = ["I_MRAP_03_hmg_F",[19012.6,18853,0]] call DMS_fnc_SpawnNonPersistentVehicle;
											_msgWIN = ['#0080ff',"Hura ! Waffenlager ausgeräumt"];
											};

// Define mission-spawned objects and loot values with vehicle
_missionObjs =
[
	_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
	[_vehicle],				// vehicle prize
	[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]]
];	
											
// Define Mission Start message
_msgStart = ['#FFFF00',format["Die Regirung veranstaltet eine Schieß wetbewerb mit %1 Soldaten",_difficultyM]];

// Define Mission Win message defined in vehicle choice

// Define Mission Lose message
_msgLOSE = ['#FF0000',"War nix mit deiner Knifte"];

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