/*
	Function: CWHUD_fnc_openMenu
	Author: Bragg [CWHUD]
	Public: Yes
	
	Description: Function to open the menu to change the color of the HUD
	
	Arguments:
	0: player <object> - player
	
	Returns:
	None
	
	Exemple:
	[player] call CWHUD_fnc_openMenu;
*/

#include "..\script_component.hpp"

params ["_player"];

private _color = profileNamespace getVariable ["CWHUD_color", [ 0.5, 0.5, 0.5, 1 ]];

private _dialog = createDialog ["CloneWarsHUD_MENU", true];

private _ctrltestHUDFrame = (findDisplay IDD_CWHUD_HUD) displayCtrl IDC_MENU_TESTHUDFrame;
private _ctrltestHUDColor = (findDisplay IDD_CWHUD_HUD) displayCtrl IDC_MENU_TESTHUDColor;

private _textureFrame = [_player, 0] call CWHUD_fnc_getHUDTexture;
private _textureColor = [_player, 1] call CWHUD_fnc_getHUDTexture;

_ctrltestHUDFrame ctrlSetText _textureFrame;
_ctrltestHUDColor ctrlSetText _textureColor;

private _sliderRed = (findDisplay IDD_CWHUD_HUD) displayCtrl IDC_MENU_slider_red;
private _sliderGreen = (findDisplay IDD_CWHUD_HUD) displayCtrl IDC_MENU_slider_green;
private _sliderBlue = (findDisplay IDD_CWHUD_HUD) displayCtrl IDC_MENU_slider_blue;
private _sliderAlpha = (findDisplay IDD_CWHUD_HUD) displayCtrl IDC_MENU_slider_alpha;

_sliderRed sliderSetRange [0, 1];
_sliderRed sliderSetSpeed [0.1, 0.1];
_sliderRed sliderSetPosition (_color select 0);

_sliderGreen sliderSetRange [0, 1];
_sliderGreen sliderSetSpeed [0.1, 0.1];
_sliderGreen sliderSetPosition (_color select 1);

_sliderBlue sliderSetRange [0, 1];
_sliderBlue sliderSetSpeed [0.1, 0.1];
_sliderBlue sliderSetPosition (_color select 2);

_sliderAlpha sliderSetRange [0, 1];
_sliderAlpha sliderSetSpeed [0.1, 0.1];
_sliderAlpha sliderSetPosition (_color select 3);