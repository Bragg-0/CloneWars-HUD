/*
	Function: CWHUD_fnc_updateSunFilter
	Author: Bragg [CWHUD]
	Public: Yes
	
	Description: Function to update the sun filter
	
	Arguments:
	0: control <control> - control
	1: player <object> - player
	
	Returns:
	None
	
	Exemple:
	[_ctrl, _player] call CWHUD_fnc_updateSunFilter;
*/

#include "..\script_component.hpp"

params ["_ctrl", "_player"];

if !(isPlayer _player) exitWith {
	private _errortext = format ["CWHUD_fnc_updateSunFilter: %1 is not a player", _player];
	CreateError(_errortext);
};

if !(isControl _ctrl) exitWith {
	private _errortext = format ["CWHUD_fnc_updateSunFilter: %1 is not a control", _ctrl];
	CreateError(_errortext);
};

private _enable = _player getVariable ["CWHUD_SunFilter", false];

_ctrl ctrlCommit 2;

if (_enable) then {
	_ctrl ctrlSetFade 1;
} else {
	_ctrl ctrlSetFade 0;
};