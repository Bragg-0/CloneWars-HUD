/*
	Function: CWHUD_fnc_onSwitchExternalViewDisableHUD
	Author: Bragg [CWHUD]
	Public: Yes
	
	Description: Function to disable the HUD when the player switch to external view
	
	Arguments:
	0: player <object> - player
	
	Returns:
	None
	
	Exemple:
	[_player] call CWHUD_fnc_onSwitchExternalViewDisableHUD;
*/

#include "..\script_component.hpp"

params ["_player"];

if !(isPlayer _player) exitWith {
	private _errortext = format ["CWHUD_fnc_onSwitchExternalViewDisableHUD: %1 is not a player", _player];
	CreateError(_errortext);
};

[_player] spawn {
	_player = _this select 0;
	private _hudenable = CWHUD_enableByDefault;
	while { true } do {
		sleep 1;

		waitUntil {
			sleep 1;
			((cameraView == "EXTERNAL") || (vehicle _player != _player))
		};

		_hudenable = _player getVariable ["CWHUD_enable", false];
		[_player, false] call CWHUD_fnc_enableHUD;

		waitUntil {
			sleep 1;
			((cameraView == "INTERNAL") && (vehicle _player == _player))
		};

		[_player, _hudenable] call CWHUD_fnc_enableHUD;
	};
};