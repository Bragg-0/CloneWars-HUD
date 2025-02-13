/*
	Function: CWHUD_fnc_enableHUD
	Author: Bragg [CWHUD]
	Public: Yes
	
	Description: Function to enable the HUD
	
	Arguments:
	0: player <object> - player
	1: bool <bool> - enable or disable the HUD (default : true)
	
	Returns:
	None
	
	Exemple:
	[_player, true] call CWHUD_fnc_enableHUD;
*/

#include "..\script_component.hpp"

params ["_player", ["_enable", true, true]];

if !(isPlayer _player) exitWith {
	private _errortext = format ["CWHUD_fnc_enableHUD: %1 is not a player", _player];
	CreateError(_errortext);
};

_player setVariable ["CWHUD_enable", _enable, true];

private _layerID = _player getVariable ["CWHUD_layerID", -1];

if (_layerID == -1) then {
	_layerID = [(format ["HUD_%1", getPlayerUID _player])] call BIS_fnc_rscLayer;
	_player setVariable ["CWHUD_layerID", _layerID, true];
};

if (_enable) then {
	_layerID cutRsc ["CWHUD_HUD", "BLACK IN", 1, false, true];
} else {
	_layerID cutRsc ["", "BLACK OUT", 1];
};