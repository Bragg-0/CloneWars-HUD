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

#include "..\script_component.hpp"

params ["_player"];

if !([_player] call CWHUD_fnc_checkAvailableHUD) exitWith {};

private _enable = _player getVariable ["CWHUD_enable", false];

// Frame
private _frame = (findDisplay IDD_CWHUD_HUD) displayCtrl IDC_HUD_FRAME;
_frame ctrlCommit 0;
_frame ctrlShow _enable;
private _textureFrame = [_player, 0] call CWHUD_fnc_getHUDTexture;
_frame ctrlSetText _textureFrame;

// Color
private _color = (findDisplay IDD_CWHUD_HUD) displayCtrl IDC_HUD_COLOR;
_color ctrlCommit 0;
_color ctrlShow _enable;
private _textureColor = [_player, 1] call CWHUD_fnc_getHUDTexture;
_color ctrlSetText _textureColor;

// Sunfilter
private _enableSunfilter = _player getVariable ["CWHUD_enableSunfilter", false];
private _sunfilter = (findDisplay IDD_CWHUD_HUD) displayCtrl IDC_HUD_SUNFILTER;
_sunfilter ctrlCommit 0;
if (_enable) then {
	_sunfilter ctrlShow _enableSunfilter;
} else {
	_sunfilter ctrlShow _enable;
};