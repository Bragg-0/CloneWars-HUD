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

#include "..\script_component.hpp"

if (isNil "CWHUD_HUDParms") then {
	CWHUD_HUDParms = [];

	private _listOfAllHelmetP1 = "getText (_x >> 'CWHUD_Type') == 'P1'" configClasses (configFile >> "CfgWeapons");
	private _listOfAllHelmetP2 = "getText (_x >> 'CWHUD_Type') == 'P2'" configClasses (configFile >> "CfgWeapons");
	private _listOfAllHelmetARF = "getText (_x >> 'CWHUD_Type') == 'ARF'" configClasses (configFile >> "CfgWeapons");
	private _listOfAllHelmetBARC = "getText (_x >> 'CWHUD_Type') == 'BARC'" configClasses (configFile >> "CfgWeapons");

	private _paramsClassListType = CWHUD_classListType;

	if (isNil "_paramsClassListType" || _paramsClassListType isEqualTo "") then {
		private _errortext = "CWHUD_fnc_initHUD: CWHUD_classListType is not defined";
		CreateError(_errortext);
		_paramsClassListType = "[]";
	};

	_paramsClassListType = call (compile _paramsClassListType);

	{
		private _class = _x select 0;
		private _type = _x select 1;

		if ((isNil "_class") || (isNil "_type") || (_class isEqualType "") || (_type isEqualType "")) then {
			private _errortext = format ["CWHUD_fnc_initHUD: %1 or %2 is not valid", _class, _type];
			CreateError(_errortext);
		} else {
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
					private _errortext = format ["CWHUD_fnc_initHUD: %1 is not a valid type", _type];
					CreateError(_errortext);
				};
			};
		};
	} forEach _paramsClassListType;

	CWHUD_HUDParms set [0, _listOfAllHelmetP1];
	CWHUD_HUDParms set [1, _listOfAllHelmetP2];
	CWHUD_HUDParms set [2, _listOfAllHelmetARF];
	CWHUD_HUDParms set [3, _listOfAllHelmetBARC];
	publicVariable "CWHUD_HUDParms";
};

if (hasInterface) then {
	[] spawn {
		waitUntil {
			sleep 5;
			((!isNull player) && (!isNil "CWHUD_HUDParms"))
		};

		if (CWHUD_enableByDefault) then {
			[player, true] call CWHUD_fnc_enableHUD;
		} else {
			[player, false] call CWHUD_fnc_enableHUD;
		};

		player addEventHandler ["InventoryClosed", {
			params ["_unit", "_container"];
			[_unit] call CWHUD_fnc_updateHUD;
		}];

		player addEventHandler ["Respawn", {
			params ["_unit", "_corpse"];
			[_unit] call CWHUD_fnc_updateHUD;
		}];

		[player] call CWHUD_fnc_onSwitchExternalViewDisableHUD;

		[player] call CWHUD_fnc_updateHUD;
	};
};