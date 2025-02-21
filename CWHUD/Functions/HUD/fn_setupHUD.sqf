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

_player addEventHandler ["SlotItemChanged", {
	params ["_unit", "_name", "_slot", "_assigned", "_weapon"];
	[_unit] call CWHUD_fnc_updateHUD;
}];

_player addEventHandler ["InventoryOpened", {
	params ["_unit", "_container"];
	[_unit] call CWHUD_fnc_updateHUD;
}];

_player addEventHandler ["Respawn", {
	params ["_unit", "_corpse"];
	[_unit] call CWHUD_fnc_updateHUD;
}];

[_player] spawn {
	private _player = _this select 0;
	while { !isNull _player } do {
		waitUntil {
			((cameraView == "EXTERNAL") || (vehicle _player != _player) || !(isNull curatorCamera))
		};

		private _hudenable = profileNameSpace getVariable ["CWHUD_enable", CWHUD_enableByDefault];
		[_player, false] call CWHUD_fnc_enableHUD;

		waitUntil {
			((cameraView == "INTERNAL") && (vehicle _player == _player) && (isNull curatorCamera))
		};

		[_player, _hudenable] call CWHUD_fnc_enableHUD;
	};
};

cutRsc ["CloneWarsHUD", "PLAIN NOFADE", -1, false, true];
[_player] call CWHUD_fnc_updateHUD;