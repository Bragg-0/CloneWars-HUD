/*
	Function: CWHUD_fnc_enableSunFilter
	Author: Bragg [CWHUD]
	Public: Yes
	
	Description: Function to enable the sun filter
	
	Arguments:
	0: player <object> - player
	1: enable <bool> - enable or disable the sun filter (default: true)
	
	Returns:
	None
	
	Exemple:
	[_player, true] call CWHUD_fnc_enableSunFilter;
*/

#include "..\script_component.hpp"

params ["_player", ["_enable", true, true]];

if !(isPlayer _player) exitWith {
	private _errortext = format ["CWHUD_fnc_enableSunFilter: %1 is not a player", _player];
	CreateError(_errortext);
};

_player setVariable ["CWHUD_SunFilter", _enable, true];

[_player] call CWHUD_fnc_updateHUD;