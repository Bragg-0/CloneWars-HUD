/*
	Function: CWHUD_fnc_updateHUD
	Author: Bragg [CWHUD]
	Public: Yes
	
	Description: Function to update the HUD
	
	Arguments:
	0: player <object> - player
	
	Returns:
	None
	
	Exemple:
	[_player] call CWHUD_fnc_updateHUD;
*/

params ["_player"];

disableSerialization;

private _enable = false;

if ([_player] call CWHUD_fnc_checkAvailableHUD) then {
	_enable = profileNameSpace getVariable ["CWHUD_enable", CWHUD_enableByDefault];
};

private _ui = uiNameSpace getVariable ["CloneWarsHUD", displayNull];
if (isNull _ui) exitWith {
	[_player] call CWHUD_fnc_setupHUD;
};

private _ctrlFrame = _ui displayCtrl 8842101;
private _ctrlColor = _ui displayCtrl 8842102;
private _ctrlSunfilter = _ui displayCtrl 8842103;

if (_enable) then {
	// Frame
	private _textureFrame = [_player, 0] call CWHUD_fnc_getHUDTexture;
	_ctrlFrame ctrlSetText _textureFrame;
	_ctrlFrame ctrlShow true;

	// Color
	private _textureColor = [_player, 1] call CWHUD_fnc_getHUDTexture;
	private _color = profileNamespace getVariable ["CWHUD_color", [0.5, 0.5, 0.5, 1]];
	_ctrlColor ctrlSetText _textureColor;
	_ctrlColor ctrlSetTextColor _color;
	_ctrlColor ctrlShow true;

	// Sunfilter
	private _enableSunfilter = profileNamespace getVariable ["CWHUD_enableSunfilter", true];
	_ctrlSunfilter ctrlShow _enableSunfilter;
} else {
	_ctrlFrame ctrlShow false;
	_ctrlColor ctrlShow false;
	_ctrlSunfilter ctrlShow false;
};