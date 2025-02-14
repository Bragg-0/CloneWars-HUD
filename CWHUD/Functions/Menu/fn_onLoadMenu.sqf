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

disableSerialization;

private _ui = uiNameSpace getVariable ["CloneWarsHUD_MENU", displayNull];

private _color = profileNamespace getVariable ["CWHUD_color", [ 0.5, 0.5, 0.5, 1 ]];

private _textureFrame = [player, 0] call CWHUD_fnc_getHUDTexture;
private _textureColor = [player, 1] call CWHUD_fnc_getHUDTexture;

(_ui displayCtrl 3142101) ctrlSetText _textureFrame;
(_ui displayCtrl 3142102) ctrlSetText _textureColor;
(_ui displayCtrl 3142102) ctrlSetTextColor _color;

(_ui displayCtrl 3142104) sliderSetRange [0, 1];
(_ui displayCtrl 3142104) sliderSetSpeed [0.1, 0.1];
(_ui displayCtrl 3142104) sliderSetPosition (_color select 0);

(_ui displayCtrl 3142103) sliderSetRange [0, 1];
(_ui displayCtrl 3142103) sliderSetSpeed [0.1, 0.1];
(_ui displayCtrl 3142103) sliderSetPosition (_color select 1);

(_ui displayCtrl 3142105) sliderSetRange [0, 1];
(_ui displayCtrl 3142105) sliderSetSpeed [0.1, 0.1];
(_ui displayCtrl 3142105) sliderSetPosition (_color select 2);

(_ui displayCtrl 3142106) sliderSetRange [0, 1];
(_ui displayCtrl 3142106) sliderSetSpeed [0.1, 0.1];
(_ui displayCtrl 3142106) sliderSetPosition (_color select 3);