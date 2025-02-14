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