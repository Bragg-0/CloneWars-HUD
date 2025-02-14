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

disableSerialization;

private _ui = uiNameSpace getVariable ["CloneWarsHUD_MENU", displayNull];

private _sliderPosRed = sliderPosition (_ui displayCtrl 3142104);
private _sliderPosGreen = sliderPosition (_ui displayCtrl 3142103);
private _sliderPosBlue = sliderPosition (_ui displayCtrl 3142105);
private _sliderPosAlpha = sliderPosition (_ui displayCtrl 3142106);

private _color = [_sliderPosRed, _sliderPosGreen, _sliderPosBlue, _sliderPosAlpha];

(_ui displayCtrl 3142102) ctrlSetTextColor _color;

profileNamespace setVariable ["CWHUD_color", _color];