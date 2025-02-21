/*
	Function: CWHUD_fnc_getHUDTexture
	Author: Bragg [CWHUD]
	Public: Yes
	
	Description: Function to get the texture of the HUD
	
	Arguments:
	0: player <object> - player
	1: selection <int> - 0 for frame, 1 for color
	
	Returns:
	<array> - [textureFrame, textureColor]
	
	Exemple:
	[_player] call CWHUD_fnc_getHUDTexture;
*/

params ["_player", ["_selection", 0]];

private _textures = [];

private _listOfAllHelmetP1 = CWHUD_HelmetList select 0;
private _listOfAllHelmetP2 = CWHUD_HelmetList select 1;
private _listOfAllHelmetARF = CWHUD_HelmetList select 2;
private _listOfAllHelmetBARC = CWHUD_HelmetList select 3;

private _listOfAllHelmetAvailable = [_listOfAllHelmetP1, _listOfAllHelmetP2, _listOfAllHelmetARF, _listOfAllHelmetBARC];

private _helmet = headgear _player;

switch (true) do {
	case (_helmet in _listOfAllHelmetP1): {
		_textures = ["\CWHUD\Data\Resources\P1\frame_ca.paa", "\CWHUD\Data\Resources\P1\color_ca.paa"];
	};
	case (_helmet in _listOfAllHelmetP2): {
		_textures = ["\CWHUD\Data\Resources\P2\frame_ca.paa", "\CWHUD\Data\Resources\P2\color_ca.paa"];
	};
	case (_helmet in _listOfAllHelmetARF): {
		_textures = ["\CWHUD\Data\Resources\ARF\frame_ca.paa", "\CWHUD\Data\Resources\ARF\color_ca.paa"];
	};
	case (_helmet in _listOfAllHelmetBARC): {
		_textures = ["\CWHUD\Data\Resources\BARC\frame_ca.paa", "\CWHUD\Data\Resources\BARC\color_ca.paa"];
	};
	default {
		_textures = ["", ""];
	};
};

_texture = _textures select _selection;

_texture