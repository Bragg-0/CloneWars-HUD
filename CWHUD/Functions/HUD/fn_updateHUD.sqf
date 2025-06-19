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

#include "../script_component.hpp"

params ["_player"];

disableSerialization;

private _enable = false;
private _checkAvailable = [_player] call CWHUD_fnc_checkAvailableHUD;

private _ui = uiNameSpace getVariable ["CloneWarsHUD", displayNull];
if (isNull _ui) exitWith {
	[_player] call CWHUD_fnc_setupHUD;
};

if (_checkAvailable) then {
	_enable = _player getVariable ["CWHUD_enable", CWHUD_enableByDefault];
};

private _ctrlFrame = _ui displayCtrl IDC_HUD_FRAME;
private _ctrlColor = _ui displayCtrl IDC_HUD_COLOR;
private _ctrlSunfilter = _ui displayCtrl IDC_HUD_SUNFILTER;

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
	private _enableSunfilter = _player getVariable ["CWHUD_enableSunfilter", false];
	_ctrlSunfilter ctrlShow _enableSunfilter;
} else {
	_ctrlFrame ctrlShow false;
	_ctrlColor ctrlShow false;
	_ctrlSunfilter ctrlShow false;
};