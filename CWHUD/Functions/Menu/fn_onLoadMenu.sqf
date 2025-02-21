/*
	Function: CWHUD_fnc_onLoadMenu
	Author: Bragg [CWHUD]
	Public: Yes
	
	Description: Function to load the menu
	
	Arguments:
	None
	
	Returns:
	None
	
	Exemple:
	[] call CWHUD_fnc_onLoadMenu;
*/

#include "../script_component.hpp"

disableSerialization;

private _ui = uiNameSpace getVariable ["CloneWarsHUD_MENU", displayNull];

private _color = profileNamespace getVariable ["CWHUD_color", [ 0.5, 0.5, 0.5, 1 ]];

private _textureFrame = [player, 0] call CWHUD_fnc_getHUDTexture;
private _textureColor = [player, 1] call CWHUD_fnc_getHUDTexture;

(_ui displayCtrl IDC_MENU_TESTHUDFrame) ctrlSetText _textureFrame;
(_ui displayCtrl IDC_MENU_TESTHUDColor) ctrlSetText _textureColor;
(_ui displayCtrl IDC_MENU_TESTHUDColor) ctrlSetTextColor _color;

{
	private _ctrl = _ui displayCtrl _x;
	_ctrl sliderSetRange [0, 1];
	_ctrl sliderSetSpeed [0.1, 0.1];
	_ctrl sliderSetPosition (_color select (_forEachIndex));
} forEach [IDC_MENU_slider_red, IDC_MENU_slider_green, IDC_MENU_slider_blue, IDC_MENU_slider_alpha];