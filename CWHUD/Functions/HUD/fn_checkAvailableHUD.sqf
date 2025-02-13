/*
	Function: CWHUD_fnc_checkAvailableHUD
	Author: Bragg [CWHUD]
	Public: Yes
	
	Description: Function to check if the HUD is available
	
	Arguments:
	0: player <object> - player
	
	Returns:
	<boolean> - true if the HUD is available, false otherwise
	
	Exemple:
	[_player] call CWHUD_fnc_checkAvailableHUD;
*/

#include "..\script_component.hpp"

params ["_player"];

if !(isPlayer _player) exitWith {
	private _errortext = format ["CWHUD_fnc_checkAvailableHUD: %1 is not a player", _player];
	CreateError(_errortext);
	false
};

if (isNil "CWHUD_HUDParms") exitWith {
	private _errortext = "CWHUD_fnc_checkAvailableHUD: CWHUD_HUDParms is not defined";
	CreateError(_errortext);
	false
};

private _listOfAllHelmetP1 = CWHUD_HUDParms select 0;
private _listOfAllHelmetP2 = CWHUD_HUDParms select 1;
private _listOfAllHelmetARF = CWHUD_HUDParms select 2;
private _listOfAllHelmetBARC = CWHUD_HUDParms select 3;

private _listOfAllHelmetAvailable = _listOfAllHelmetP1 + _listOfAllHelmetP2 + _listOfAllHelmetARF + _listOfAllHelmetBARC;

private _helmet = headgear _player;

if (_helmet in _listOfAllHelmetAvailable) exitWith {
	true
};

false