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
		CWHUD_HelmetList = [];

		private _listOfAllHelmetP1 = [];
		private _listOfAllHelmetP2 = [];
		private _listOfAllHelmetARF = [];
		private _listOfAllHelmetBARC = [];

		_listOfAllHelmetP1 = "getText (_x >> 'CWHUD_Type') == 'P1'" configClasses (configFile >> "CfgWeapons");
		_listOfAllHelmetP2 = "getText (_x >> 'CWHUD_Type') == 'P2'" configClasses (configFile >> "CfgWeapons");
		_listOfAllHelmetARF = "getText (_x >> 'CWHUD_Type') == 'ARF'" configClasses (configFile >> "CfgWeapons");
		_listOfAllHelmetBARC = "getText (_x >> 'CWHUD_Type') == 'BARC'" configClasses (configFile >> "CfgWeapons");

		private _paramsClassListType = CWHUD_classListType;

		_paramsClassListType = call (compile _paramsClassListType);

		if (_paramsClassListType isEqualType []) exitWith {
			["[CWHUD] CWHUD_fnc_initHUD: %1 is not valid, check CBA parameter : CWHUD_classListType", _paramsClassListType] call BIS_fnc_logFormat;
		};

		{
			if !(_x isEqualTypeArray ["", ""]) exitWith {
				["[CWHUD] CWHUD_fnc_initHUD: %1 is not a valid parameter, check CBA parameter : CWHUD_classListType", _x] call BIS_fnc_logFormat;
			};

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

		CWHUD_HelmetList set [0, _listOfAllHelmetP1];
		CWHUD_HelmetList set [1, _listOfAllHelmetP2];
		CWHUD_HelmetList set [2, _listOfAllHelmetARF];
		CWHUD_HelmetList set [3, _listOfAllHelmetBARC];
		publicVariable "CWHUD_HelmetList";
	};
};

if (hasInterface) then {
	[] spawn {
		waitUntil {
			sleep 5;
			(!isNull player)
		};
		[player] call CWHUD_fnc_setupHUD;
	};
};