/*
	Function: CWHUD_fnc_setupHUD
	Author: Bragg [CWHUD]
	Public: Yes
	
	Description: Function to setup the HUD
	
	Arguments:
	0: player <object> - player
	
	Returns:
	None
	
	Exemple:
	[_player] call CWHUD_fnc_setupHUD;
*/

params ["_player"];

disableSerialization;

_player setVariable ["CWHUD_enable", CWHUD_enableByDefault, true];

_player addEventHandler ["InventoryClosed", {
	params ["_unit", "_container"];
	[_unit] call CWHUD_fnc_updateHUD;
}];

_player addEventHandler ["Respawn", {
	params ["_unit", "_corpse"];
	[_unit] call CWHUD_fnc_updateHUD;
}];

[_player] spawn {
	_player = _this select 0;
	private _hudenable = CWHUD_enableByDefault;
	while { true } do {
		sleep 1;

		waitUntil {
			sleep 1;
			((cameraView == "EXTERNAL") || (vehicle _player != _player)) || !(isNull curatorCamera)
		};

		_hudenable = _player getVariable ["CWHUD_enable", false];
		[_player, false] call CWHUD_fnc_enableHUD;

		waitUntil {
			sleep 1;
			((cameraView == "INTERNAL") && (vehicle _player == _player)) && (isNull curatorCamera)
		};

		[_player, _hudenable] call CWHUD_fnc_enableHUD;
	};
};

cutRsc ["CloneWarsHUD", "PLAIN", 0, false, true];
[_player] call CWHUD_fnc_updateHUD;