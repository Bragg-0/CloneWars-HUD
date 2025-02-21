/*
	Function: CWHUD_fnc_onSliderPosChanged
	Author: Bragg [CWHUD]
	Public: Yes
	
	Description: Function to change the color of the HUD preview when the slider position is changed
	
	Arguments:
	None
	
	Returns:
	None
	
	Exemple:
	[] call CWHUD_fnc_onSliderPosChanged;
*/

#include "../script_component.hpp"

disableSerialization;

private _ui = uiNameSpace getVariable ["CloneWarsHUD_MENU", displayNull];

private _sliderPosRed = sliderPosition (_ui displayCtrl IDC_MENU_slider_red);
private _sliderPosGreen = sliderPosition (_ui displayCtrl IDC_MENU_slider_green);
private _sliderPosBlue = sliderPosition (_ui displayCtrl IDC_MENU_slider_blue);
private _sliderPosAlpha = sliderPosition (_ui displayCtrl IDC_MENU_slider_alpha);

private _color = [_sliderPosRed, _sliderPosGreen, _sliderPosBlue, _sliderPosAlpha];

(_ui displayCtrl IDC_MENU_TESTHUDColor) ctrlSetTextColor _color;

profileNamespace setVariable ["CWHUD_color", _color];