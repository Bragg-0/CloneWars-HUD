/*
	Function: CWHUD_fnc_onSliderPosChanged
	Author: Bragg [CWHUD]
	Public: Yes
	
	Description: Function to change the color of the HUD preview when the slider position is changed
	
	Arguments:
	0: player <object> - player
	
	Returns:
	<array> - [R, G, B, A] color of the HUD
	
	Exemple:
	[_player] call CWHUD_fnc_onSliderPosChanged;
*/

#include "..\script_component.hpp"

params ["_player"];

if !(isPlayer _player) exitWith {
	private _errortext = format ["CWHUD_fnc_onSliderPosChanged: %1 is not a player", _player];
	CreateError(_errortext);
	[0.5, 0.5, 0.5, 1]
};

private _Color = [sliderPosition IDC_MENU_slider_red, sliderPosition IDC_MENU_slider_green, sliderPosition IDC_MENU_slider_blue, sliderPosition IDC_MENU_slider_alpha];

ctrlSetTextColor [IDC_MENU_TESTHUDColor, _Color];

SetVarHUDColor(_color);

_color