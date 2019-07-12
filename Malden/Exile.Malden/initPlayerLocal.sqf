//Modifed by Thomas [T.K.O] need TKO_Objekt server addon
///////////////////////////////////////////////////////////////////////////////
// Static Objects
///////////////////////////////////////////////////////////////////////////////


/**
 * Created with Exile Mod 3DEN Plugin
 * www.exilemod.com
 */

if (!hasInterface || isServer) exitWith {};

// 36 NPCs
private _npcs = [
["Exile_Trader_Armory", [], "Exile_Trader_Armory", "WhiteHead_01", [["srifle_DMR_06_olive_F","","","",[],[],""],[],[],["U_Rangemaster",[]],["V_Rangemaster_belt",[]],[],"H_Cap_headphones","G_Shades_Black",[],["","","","","",""]], [7827.03, 4719.57, 34.3404], [-0.126329, 0.991988, 0], [0, 0, 1]],
["Exile_Trader_Equipment", [], "Exile_Trader_Equipment", "GreekHead_A3_05", [["arifle_MX_GL_Black_F","","","",[],[],""],[],[],["U_BG_Guerrilla_6_1",[]],["V_I_G_resistanceLeader_F",[]],[],"H_Watchcap_khk","rhs_googles_yellow",[],["","","","","",""]], [7820.2, 4718.73, 34.2077], [-0.1257, 0.992068, 0], [0, 0, 1]],
["Exile_Trader_Food", ["InBaseMoves_HandsBehindBack1"], "Exile_Trader_Food", "GreekHead_A3_07", [[],[],[],["U_C_Poloshirt_blue",[]],[],[],"H_Cap_tan","",[],["","","","","",""]], [7795.4, 4737.4, 32.6019], [0.980036, 0.198822, 0], [0, 0, 1]],
["Exile_Trader_Hardware", ["InBaseMoves_HandsBehindBack1"], "Exile_Trader_Hardware", "WhiteHead_20", [[],[],[],["U_C_WorkerCoveralls",[]],["V_BandollierB_rgr",[]],["B_UAV_01_backpack_F",[]],"H_Booniehat_khk_hs","rhs_googles_yellow",[],["","","","","",""]], [7799.17, 4725.34, 33.1463], [0.990497, 0.137533, 0], [0, 0, 1]],
["Exile_Trader_Office", ["InBaseMoves_HandsBehindBack1"], "Exile_Trader_Office", "WhiteHead_17", [[],[],[],["U_I_G_resistanceLeader_F",[]],["V_Rangemaster_belt",[]],[],"H_Hat_brown","G_Combat",[],["","","","","",""]], [7816.4, 4775.69, 32.6483], [0.273608, -0.961841, 0], [0, 0, 1]],
["Exile_Trader_SpecialOperations", [], "Exile_Trader_SpecialOperations", "WhiteHead_01", [["arifle_MX_Black_F","","","",[],[],""],[],[],["U_B_CTRG_1",[]],["V_PlateCarrierGL_blk",[]],["B_Parachute",[]],"H_HelmetB_light_black","G_Balaclava_lowprofile",[],["","","","","","NVGoggles_OPFOR"]], [7807.09, 4723.09, 33.6388], [-0.230222, 0.973138, 0], [0, 0, 1]],
["Exile_Trader_VehicleCustoms", ["InBaseMoves_HandsBehindBack1"], "Exile_Trader_VehicleCustoms", "WhiteHead_07", [[],[],[],["Exile_Uniform_ExileCustoms",[]],[],[],"","G_Combat",[],["","","","","",""]], [7799.25, 4765.58, 32.0377], [0.146413, -0.989224, 0], [0, 0, 1]],
["Exile_Trader_Vehicle", ["HubSittingChairUB_idle3"], "Exile_Trader_Vehicle", "WhiteHead_09", [[],[],[],["Exile_Uniform_ExileCustoms",[]],[],[],"H_RacingHelmet_4_F","G_Aviator",[],["","","","","",""]], [7837.75, 4776.23, 32.6199], [0.0753664, -0.997156, 0], [0, 0, 1]],
["Exile_Trader_WasteDump", ["InBaseMoves_HandsBehindBack1"], "Exile_Trader_WasteDump", "AfricanHead_01", [[],[],[],["U_I_G_Story_Protagonist_F",[]],["V_Rangemaster_belt",[]],[],"H_MilCap_gry","",[],["","","","","",""]], [7793.84, 4748.2, 32.1799], [0.990497, 0.137533, 0], [0, 0, 1]],
["Exile_Trader_RussianRoulette", ["InBaseMoves_HandsBehindBack1"], "Exile_Trader_RussianRoulette", "WhiteHead_11", [[],[],["hgun_Pistol_Signal_F","","","",[],[],""],["U_Marshal",[]],["V_Rangemaster_belt",[]],[],"H_Cap_marshal","G_Sport_Blackyellow",[],["","","","","",""]], [7807.43, 4735.62, 33.3821], [0.972338, -0.23358, 0], [0, 0, 1]],
["Exile_Trader_Armory", ["AmovPsitMstpSrasWrflDnon_WeaponCheck1"], "Exile_Trader_Armory", "WhiteHead_17", [["srifle_DMR_06_olive_F","","","",[],[],""],[],[],["U_Rangemaster",[]],["V_Rangemaster_belt",[]],[],"H_Cap_headphones","G_Shades_Black",[],["","","","","",""]], [5095.84, 9040.62, 349.98], [0.897019, 0.441991, 0], [0, 0, 1]],
["Exile_Trader_Equipment", ["AmovPsitMstpSrasWrflDnon_WeaponCheck1"], "Exile_Trader_Equipment", "WhiteHead_13", [["arifle_MX_GL_Black_F","","","",[],[],""],[],[],["U_BG_Guerrilla_6_1",[]],["V_I_G_resistanceLeader_F",[]],[],"H_Watchcap_khk","G_Tactical_Clear",[],["","","","","",""]], [5092.35, 9046.58, 350.135], [0.897297, 0.441428, 0], [0, 0, 1]],
["Exile_Trader_Food", ["InBaseMoves_table1"], "Exile_Trader_Food", "WhiteHead_02", [[],[],[],["U_C_Poloshirt_blue",[]],[],[],"H_Cap_tan","G_Tactical_Clear",[],["","","","","",""]], [5092.66, 9075.5, 350.209], [-0.815219, 0.579153, 0], [0, 0, 1]],
["Exile_Trader_Hardware", ["Acts_InjuredLookingRifle03"], "Exile_Trader_Hardware", "GreekHead_A3_08", [[],[],[],["U_C_WorkerCoveralls",[]],["V_BandollierB_rgr",[]],["B_UAV_01_backpack_F",[]],"H_Booniehat_khk_hs","G_Combat",[],["","","","","",""]], [5083.69, 9065.14, 350.675], [-0.651328, 0.758797, 0], [0, 0, 1]],
["Exile_Trader_Office", ["InBaseMoves_HandsBehindBack1"], "Exile_Trader_Office", "WhiteHead_08", [[],[],[],["U_I_G_resistanceLeader_F",[]],["V_Rangemaster_belt",[]],[],"H_Hat_brown","G_Combat",[],["","","","","",""]], [5098.39, 9076.84, 350.669], [0.934073, -0.357081, 0], [0, 0, 1]],
["Exile_Trader_SpecialOperations", ["AmovPsitMstpSrasWrflDnon_WeaponCheck2"], "Exile_Trader_SpecialOperations", "WhiteHead_04", [["arifle_MX_Black_F","","","",[],[],""],[],[],["U_B_CTRG_1",[]],["V_PlateCarrierGL_blk",[]],["B_Parachute",[]],"H_HelmetB_light_black","G_Balaclava_lowprofile",[],["","","","","","NVGoggles_OPFOR"]], [5091.7, 9049.84, 350.796], [0.214513, 0.976721, 0], [0, 0, 1]],
["Exile_Trader_VehicleCustoms", ["HubSittingChairUB_idle3"], "Exile_Trader_VehicleCustoms", "GreekHead_A3_08", [[],[],[],["Exile_Uniform_ExileCustoms",[]],[],[],"","rhs_googles_orange",[],["","","","","",""]], [5133.08, 9088.68, 353.366], [0.375691, -0.926745, 0], [0, 0, 1]],
["Exile_Trader_Vehicle", ["HubSittingChairUB_idle3"], "Exile_Trader_Vehicle", "WhiteHead_03", [[],[],[],["Exile_Uniform_ExileCustoms",[]],[],[],"H_RacingHelmet_4_F","",[],["","","","","",""]], [5143.18, 9091.22, 353.018], [-0.557075, -0.830462, 0], [0, 0, 1]],
["Exile_Trader_WasteDump", ["AmovPercMstpSnonWnonDnon_exercisePushup"], "Exile_Trader_WasteDump", "WhiteHead_20", [[],[],[],["U_I_G_Story_Protagonist_F",[]],["V_Rangemaster_belt",[]],[],"H_MilCap_gry","",[],["","","","","",""]], [5114.56, 9080.55, 351.132], [0.452108, -0.891963, 0], [0, 0, 1]],
["Exile_Trader_RussianRoulette", ["HubSittingChairUB_idle3"], "Exile_Trader_RussianRoulette", "WhiteHead_17", [[],[],["hgun_Pistol_Signal_F","","","",[],[],""],["U_Marshal",[]],["V_Rangemaster_belt",[]],[],"H_Cap_marshal","G_Sport_Blackyellow",[],["","","","","",""]], [5100.05, 9079.33, 351.098], [0.589678, 0.807639, 0], [0, 0, 1]],
["Exile_Trader_Armory", [], "Exile_Trader_Armory", "GreekHead_A3_08", [["srifle_DMR_06_olive_F","","","",[],[],""],[],[],["U_Rangemaster",[]],["V_Rangemaster_belt",[]],[],"H_Cap_headphones","G_Shades_Black",[],["","","","","",""]], [5520.88, 3502.94, 70.2685], [-0.982033, 0.18871, 0], [0, 0, 1]],
["Exile_Trader_Equipment", [], "Exile_Trader_Equipment", "GreekHead_A3_05", [["arifle_MX_GL_Black_F","","","",[],[],""],[],[],["U_BG_Guerrilla_6_1",[]],["V_I_G_resistanceLeader_F",[]],[],"H_Watchcap_khk","G_Tactical_Black",[],["","","","","",""]], [5519.75, 3495.65, 70.4483], [-0.981913, 0.189332, 0], [0, 0, 1]],
["Exile_Trader_Food", ["InBaseMoves_HandsBehindBack1"], "Exile_Trader_Food", "WhiteHead_14", [[],[],[],["U_C_Poloshirt_blue",[]],[],[],"H_Cap_tan","rhs_googles_yellow",[],["","","","","",""]], [5513.11, 3476.61, 71.1499], [-0.175608, -0.98446, 0], [0, 0, 1]],
["Exile_Trader_Hardware", ["InBaseMoves_HandsBehindBack1"], "Exile_Trader_Hardware", "WhiteHead_21", [[],[],[],["U_C_WorkerCoveralls",[]],["V_BandollierB_rgr",[]],["B_UAV_01_backpack_F",[]],"H_Booniehat_khk_hs","rhs_googles_orange",[],["","","","","",""]], [5492.43, 3487.58, 71.5362], [0.823313, 0.567587, 0], [0, 0, 1]],
["Exile_Trader_Office", ["InBaseMoves_HandsBehindBack1"], "Exile_Trader_Office", "GreekHead_A3_08", [[],[],[],["U_I_G_resistanceLeader_F",[]],["V_Rangemaster_belt",[]],[],"H_Hat_brown","rhs_googles_yellow",[],["","","","","",""]], [5509.33, 3481.04, 71.5678], [-0.0685833, 0.997645, 0], [0, 0, 1]],
["Exile_Trader_SpecialOperations", [], "Exile_Trader_SpecialOperations", "GreekHead_A3_05", [["arifle_MX_Black_F","","","",[],[],""],[],[],["U_B_CTRG_1",[]],["V_PlateCarrierGL_blk",[]],["B_Parachute",[]],"H_HelmetB_light_black","G_Balaclava_lowprofile",[],["","","","","","NVGoggles_OPFOR"]], [5518.52, 3491.49, 70.6464], [-0.996457, 0.08411, 0], [0, 0, 1]],
["Exile_Trader_VehicleCustoms", ["Acts_passenger_flatground_leanright"], "Exile_Trader_VehicleCustoms", "AfricanHead_03", [[],[],[],["Exile_Uniform_ExileCustoms",[]],[],[],"","",[],["","","","","",""]], [5475.89, 3489.83, 72.7036], [-0.948876, 0.315649, 0], [0, 0, 1]],
["Exile_Trader_Vehicle", ["Acts_passenger_flatground_leanright"], "Exile_Trader_Vehicle", "AfricanHead_02", [[],[],[],["Exile_Uniform_ExileCustoms",[]],[],[],"H_RacingHelmet_4_F","rhs_googles_orange",[],["","","","","",""]], [5473.56, 3484.63, 71.6658], [-0.595797, 0.803135, 0], [0, 0, 1]],
["Exile_Trader_WasteDump", ["InBaseMoves_HandsBehindBack1"], "Exile_Trader_WasteDump", "WhiteHead_18", [[],[],[],["U_I_G_Story_Protagonist_F",[]],["V_Rangemaster_belt",[]],[],"H_MilCap_gry","G_Combat",[],["","","","","",""]], [5484.58, 3492.76, 71.3724], [0.263341, 0.964703, 0], [0, 0, 1]],
["Exile_Trader_RussianRoulette", ["InBaseMoves_HandsBehindBack1"], "Exile_Trader_RussianRoulette", "WhiteHead_17", [[],[],["hgun_Pistol_Signal_F","","","",[],[],""],["U_Marshal",[]],["V_Rangemaster_belt",[]],[],"H_Cap_marshal","G_Sport_Blackyellow",[],["","","","","",""]], [5496.28, 3479.79, 71.4297], [-0.598709, -0.800967, 0], [0, 0, 1]],
["Exile_Trader_Aircraft", ["Acts_passenger_flatground_leanright"], "Exile_Trader_Aircraft", "GreekHead_A3_06", [[],[],[],["U_I_pilotCoveralls",[]],[],[],"H_PilotHelmetHeli_O","G_Tactical_Black",[],["","","","","",""]], [675.227, 12143.1, 29.1214], [0.984884, 0.173217, 0], [0, 0, 1]],
["Exile_Trader_AircraftCustoms", ["Acts_passenger_flatground_leanright"], "Exile_Trader_AircraftCustoms", "AfricanHead_02", [[],[],[],["Exile_Uniform_ExileCustoms",[]],["V_RebreatherB",[]],[],"H_PilotHelmetFighter_B","G_Combat",[],["","","","","",""]], [670.697, 12147.4, 28.9214], [0, 1, 0], [0, 0, 1]],
["Exile_Trader_Aircraft", ["Acts_passenger_flatground_leanright"], "Exile_Trader_Aircraft", "AfricanHead_03", [[],[],[],["U_I_pilotCoveralls",[]],[],[],"H_PilotHelmetHeli_O","G_Aviator",[],["","","","","",""]], [8059.48, 9700.57, 30.2903], [-0.994162, -0.107893, 0], [0, 0, 1]],
["Exile_Trader_AircraftCustoms", ["Acts_passenger_flatground_leanright"], "Exile_Trader_AircraftCustoms", "WhiteHead_03", [[],[],[],["Exile_Uniform_ExileCustoms",[]],["V_RebreatherB",[]],[],"H_PilotHelmetFighter_B","G_Tactical_Clear",[],["","","","","",""]], [8059.51, 9698.7, 30.2932], [-0.999993, -0.00362108, 0], [0, 0, 1]],
["Exile_Trader_BoatCustoms", ["Acts_passenger_flatground_leanright"], "Exile_Trader_BoatCustoms", "GreekHead_A3_05", [[],[],[],["Exile_Uniform_ExileCustoms",[]],[],[],"","",[],["","","","","",""]], [8529.5, 3746.45, 4.36138], [0.998207, 0.0598638, 0], [0, 0, 1]],
["Exile_Trader_Boat", ["Acts_passenger_flatground_leanright"], "Exile_Trader_Boat", "AfricanHead_01", [[],[],[],["U_OrestesBody",[]],[],[],"H_Cap_surfer","rhs_googles_orange",[],["","","","","",""]], [8528.73, 3747.24, 4.36138], [0.181072, 0.98347, 0], [0, 0, 1]]
];

{
    private _logic = "Logic" createVehicleLocal [0, 0, 0];
    private _trader = (_x select 0) createVehicleLocal [0, 0, 0];
    private _animations = _x select 1;
    
    _logic setPosWorld (_x select 5);
    _logic setVectorDirAndUp [_x select 6, _x select 7];
    
    _trader setVariable ["BIS_enableRandomization", false];
    _trader setVariable ["BIS_fnc_animalBehaviour_disable", true];
    _trader setVariable ["ExileAnimations", _animations];
    _trader setVariable ["ExileTraderType", _x select 2];
    _trader disableAI "ANIM";
    _trader disableAI "MOVE";
    _trader disableAI "FSM";
    _trader disableAI "AUTOTARGET";
    _trader disableAI "TARGET";
    _trader disableAI "CHECKVISIBLE";
    _trader allowDamage false;
    _trader setFace (_x select 3);
    _trader setUnitLoadOut (_x select 4);
    _trader setPosWorld (_x select 5);
    _trader setVectorDirAndUp [_x select 6, _x select 7];
    _trader reveal _logic;
    _trader attachTo [_logic, [0, 0, 0]];
    _trader switchMove (_animations select 0);
    _trader addEventHandler ["AnimDone", {_this call ExileClient_object_trader_event_onAnimationDone}];
}
forEach _npcs;

