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

if !(isPlayer _player) exitWith {
	private _errortext = format ["CWHUD_fnc_openMenu: %1 is not a player", _player];
	CreateError(_errortext);
	[0.5, 0.5, 0.5, 1]
};

private _color = GetVarHUDColor;

private _dialog = createDialog ["CWHUD_Menu", true];

ctrlSetText [IDC_MENU_TESTHUDFrame, ([_player] call CWHUD_fnc_getHUDTexture) select 0];
ctrlSetText [IDC_MENU_TESTHUDColor, ([_player] call CWHUD_fnc_getHUDTexture) select 1];

{
	private _idc = _x;
	sliderSetRange [_idc, 0, 1];
	sliderSetSpeed [_idc, 0.1, 0.01];
	sliderSetPosition [_idc, _color select (_forEachIndex - 1)];
} forEach [IDC_MENU_slider_green, IDC_MENU_slider_red, IDC_MENU_slider_blue, IDC_MENU_slider_alpha];