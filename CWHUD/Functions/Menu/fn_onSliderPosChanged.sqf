/*
	Function: CWHUD_fnc_onSliderPosChanged
	Author: Bragg [CWHUD]
	Public: Yes
	
	Description: Function to change the color of the HUD preview when the slider position is changed
	
	Arguments:
	0: control <control> - control
	1: newValue <number> - new value of the slider
	
	Returns:
	None
	
	Exemple:
	[_control, _newValue] call CWHUD_fnc_onSliderPosChanged;
*/

#include "..\script_component.hpp"

params ["_control", "_newValue"];

private _sliderRed = sliderPosition ((findDisplay IDD_CWHUD_MENU) displayCtrl IDC_MENU_slider_red);
private _sliderGreen = sliderPosition ((findDisplay IDD_CWHUD_MENU) displayCtrl IDC_MENU_slider_green);
private _sliderBlue = sliderPosition ((findDisplay IDD_CWHUD_MENU) displayCtrl IDC_MENU_slider_blue);
private _sliderAlpha = sliderPosition ((findDisplay IDD_CWHUD_MENU) displayCtrl IDC_MENU_slider_alpha);
private _ctrltestHUDColor = (findDisplay IDD_CWHUD_MENU) displayCtrl IDC_MENU_TESTHUDColor;

_ctrltestHUDColor ctrlSetTextColor [_sliderRed, _sliderGreen, _sliderBlue, _sliderAlpha];

private _color = [_sliderRed, _sliderGreen, _sliderBlue, _sliderAlpha];
profileNamespace setVariable ["CWHUD_color", _color];