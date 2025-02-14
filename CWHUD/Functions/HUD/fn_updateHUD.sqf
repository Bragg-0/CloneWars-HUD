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
	_enable = _player getVariable ["CWHUD_enable", false];
};

private _ui = uiNameSpace getVariable ["CloneWarsHUD", displayNull];

private _ctrlFrame = _ui displayCtrl 8842101;
private _ctrlColor = _ui displayCtrl 8842102;
private _ctrlSunfilter = _ui displayCtrl 8842103;

if (_enable) then {
	// Frame
	private _textureFrame = [_player, 0] call CWHUD_fnc_getHUDTexture;
	_ctrlFrame ctrlSetText _textureFrame;
	_ctrlSunfilter ctrlSetFade 0;

	// Color
	private _textureColor = [_player, 1] call CWHUD_fnc_getHUDTexture;
	private _color = profileNamespace getVariable ["CWHUD_color", [0.5, 0.5, 0.5, 1]];
	_ctrlColor ctrlSetText _textureColor;
	_ctrlColor ctrlSetTextColor _color;
	_ctrlSunfilter ctrlSetFade 0;

	// Sunfilter
	private _enableSunfilter = profileNamespace getVariable ["CWHUD_enableSunfilter", 0];
	_ctrlSunfilter ctrlSetFade 0;
} else {
	_ctrlFrame ctrlSetFade 1;
	_ctrlColor ctrlSetFade 1;
	_ctrlSunfilter ctrlSetFade 1;
};

_ctrlFrame ctrlCommit 1;
_ctrlColor ctrlCommit 1;
_ctrlSunfilter ctrlCommit 1;