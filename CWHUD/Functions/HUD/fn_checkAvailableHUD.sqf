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

params ["_player"];

private _listOfAllHelmetP1 = CWHUD_HelmetList select 0;
private _listOfAllHelmetP2 = CWHUD_HelmetList select 1;
private _listOfAllHelmetARF = CWHUD_HelmetList select 2;
private _listOfAllHelmetBARC = CWHUD_HelmetList select 3;

private _listOfAllHelmetAvailable = _listOfAllHelmetP1 + _listOfAllHelmetP2 + _listOfAllHelmetARF + _listOfAllHelmetBARC;

private _helmet = headgear _player;

if (_helmet in _listOfAllHelmetAvailable) exitWith {
	true
};

false