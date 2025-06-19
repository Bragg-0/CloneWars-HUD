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

params ["_player", ["_enable", true]];

_player setVariable ["CWHUD_enableSunfilter", _enable];

[_player] call CWHUD_fnc_updateHUD;