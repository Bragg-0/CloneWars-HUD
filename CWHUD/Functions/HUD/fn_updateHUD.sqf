/*
	Function: CWHUD_fnc_updateHUD
	Author: Bragg [CWHUD]
	Public: Yes
	
	Description: Function to update the HUD
	
	Arguments:
	0: player <object> - player
	
	Returns:
	None
	
	Exemple:
	[_player] call CWHUD_fnc_updateHUD;
*/

#include "..\script_component.hpp"

params ["_player"];

if !(isPlayer _player) exitWith {
	private _errortext = format ["CWHUD_fnc_updateHUD: %1 is not a player", _player];
	CreateError(_errortext);
};

if !([_player] call CWHUD_fnc_checkAvailableHUD) exitWith {
	[_player, false] call CWHUD_fnc_enableHUD;
};

[_player] spawn {
	private _player = _this select 0;
	[_player, false] call CWHUD_fnc_enableHUD;
	uiSleep 0.1;
	[_player, true] call CWHUD_fnc_enableHUD;
};