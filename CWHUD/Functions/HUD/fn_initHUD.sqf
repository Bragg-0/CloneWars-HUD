/*
	Function: CWHUD_fnc_initHUD
	Author: Bragg [CWHUD]
	Public: Yes
	
	Description: Function to initialize the HUD env
	
	Arguments:
	None
	
	Returns:
	None
	
	Exemple:
	[] call CWHUD_fnc_initHUD;
*/
if (isServer) then {
	if (isNil "CWHUD_HelmetList") then {
		private _listOfAllHelmetP1 = [];
		private _listOfAllHelmetP2 = [];
		private _listOfAllHelmetARF = [];
		private _listOfAllHelmetBARC = [];

		_listOfAllHelmetP1 = "getText (_x >> 'CWHUD_Type') == 'P1'" configClasses (configFile >> "CfgWeapons");
		_listOfAllHelmetP2 = "getText (_x >> 'CWHUD_Type') == 'P2'" configClasses (configFile >> "CfgWeapons");
		_listOfAllHelmetARF = "getText (_x >> 'CWHUD_Type') == 'ARF'" configClasses (configFile >> "CfgWeapons");
		_listOfAllHelmetBARC = "getText (_x >> 'CWHUD_Type') == 'BARC'" configClasses (configFile >> "CfgWeapons");

		private _listOfCompatibleHelmetFromOtherAddons = [
			["JLTS_CloneHelmetAB", "BARC"],
			["JLTS_CloneHelmetBARC", "BARC"],
			["JLTS_CloneHelmetP2", "P2"],
			["JLTS_CloneHelmetP2MC", "P2"],
			["JLTS_CloneHelmetP2_rework", "P2"],
			["SWLB_P1_Pilot_Helmet", "P1"],
			["SWLB_P1_SpecOps_Helmet", "P1"],
			["SWLB_clone_AB_helmet", "BARC"],
			["SWLB_clone_ARF_P1_helmet", "ARF"],
			["SWLB_clone_ARF_P2_helmet", "ARF"],
			["SWLB_clone_BARC_helmet", "BARC"],
			["SWLB_clone_P15_helmet", "P2"],
			["SWLB_clone_P1_2_helmet", "P1"],
			["SWLB_clone_P1_helmet", "P1"],
			["SWLB_clone_P2_helmet", "P2"],
			["SWLB_clone_commando_helmet_k1", "P1"],
			["SWLB_clone_eng_helmet", "ARF"],
			["SWLB_clone_pilot_P2_helmet", "P2"],
			["ls_gar_barc_helmet", "BARC"],
			["ls_gar_phase1Arf_helmet", "ARF"],
			["ls_gar_phase1Pilot_helmet", "P1"],
			["ls_gar_phase1_helmet", "P1"],
			["ls_gar_phase2_helmet", "P2"],
			["ls_gar_rex_helmet", "P1"],
			["ls_gar_scout_helmet", "ARF"],
			["lsd_gar_airborne_helmet", "BARC"],
			["lsd_gar_arc_helmet", "P2"],
			["lsd_gar_atrtDriver_helmet", "P2"],
			["lsd_gar_phase2_helmet", "P2"]
		];

		{
			private _class = _x select 0;
			private _type = _x select 1;
			if (isclass (configFile >> "CfgWeapons" >> _class)) then {
				private _classes = [];
				{
					private _parents = [_x, true] call BIS_fnc_returnParents;
					if (_class in _parents) then {
						_classes pushBack (configName _x);
					};
				} forEach ("true" configClasses (configFile >> "CfgWeapons"));
				{
					switch (_type) do {
						case "P1": {
							_listOfAllHelmetP1 pushBackUnique _x;
						};
						case "P2": {
							_listOfAllHelmetP2 pushBackUnique _x;
						};
						case "ARF": {
							_listOfAllHelmetARF pushBackUnique _x;
						};
						case "BARC": {
							_listOfAllHelmetBARC pushBackUnique _x;
						};
					};
				} forEach _classes;
			};
		} forEach _listOfCompatibleHelmetFromOtherAddons;

		_paramsClassListType = call (compile CWHUD_classListType);

		if !(_paramsClassListType isEqualType []) exitWith {
			["[CWHUD] CWHUD_fnc_initHUD: %1 is not valid, check CBA parameter : CWHUD_classListType", _paramsClassListType] call BIS_fnc_logFormat;
			CWHUD_HelmetList = [_listOfAllHelmetP1, _listOfAllHelmetP2, _listOfAllHelmetARF, _listOfAllHelmetBARC];
			publicVariable "CWHUD_HelmetList";
		};

		{
			private _class = _x select 0;
			private _type = _x select 1;

			if !(_class isEqualType "") exitWith {
				["[CWHUD] CWHUD_fnc_initHUD: %1 is not a valid parameter, check CBA parameter : CWHUD_classListType", _class] call BIS_fnc_logFormat;
			};

			if !(_type isEqualType "") exitWith {
				["[CWHUD] CWHUD_fnc_initHUD: %1 is not a valid parameter, check CBA parameter : CWHUD_classListType", _type] call BIS_fnc_logFormat;
			};

			switch (true) do {
				case (_type == "P1"): {
					_listOfAllHelmetP1 pushBackUnique _class;
				};
				case (_type == "P2"): {
					_listOfAllHelmetP2 pushBackUnique _class;
				};
				case (_type == "ARF"): {
					_listOfAllHelmetARF pushBackUnique _class;
				};
				case (_type == "BARC"): {
					_listOfAllHelmetBARC pushBackUnique _class;
				};
				default {
					["[CWHUD] CWHUD_fnc_initHUD: %1 is not a valid type, check CBA parameter : CWHUD_classListType", _type] call BIS_fnc_logFormat;
				};
			};
		} forEach _paramsClassListType;

		CWHUD_HelmetList = [_listOfAllHelmetP1, _listOfAllHelmetP2, _listOfAllHelmetARF, _listOfAllHelmetBARC];
		publicVariable "CWHUD_HelmetList";
	};
};

if (hasInterface) then {
	[] spawn {
		waitUntil {
			sleep 5;
			((!isNull player) && (!isNil "CWHUD_HelmetList"))
		};
		[player] call CWHUD_fnc_setupHUD;
	};
};