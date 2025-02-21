/*
	Function: CWHUD_fnc_enableHUD
	Author: Bragg [CWHUD]
	Public: Yes
	
	Description: Function to enable or disable the HUD
	
	Arguments:
	0: player <object> - player
	1: enable <bool> - enable or disable the sun filter (default: true)
	
	Returns:
	None
	
	Exemple:
	[_player, true] call CWHUD_fnc_enableHUD;
*/

params ["_player", ["_enable", true]];

profileNameSpace setVariable ["CWHUD_enable", _enable];

[_player] call CWHUD_fnc_updateHUD;