/*
	Function: CWHUD_fnc_getHUDTexture
	Author: Bragg [CWHUD]
	Public: Yes
	
	Description: Function to get the texture of the HUD
	
	Arguments:
	0: player <object> - player
	
	Returns:
	<array> - [textureFrame, textureColor]
	
	Exemple:
	[_player] call CWHUD_fnc_getHUDTexture;
*/

#include "..\script_component.hpp"

params ["_player"];

private _textures = ["", ""];

if !(isPlayer _player) exitWith {
	private _errortext = format ["CWHUD_fnc_getHUDTexture: %1 is not a player", _player];
	CreateError(_errortext);
	_textures
};

if (isNil "CWHUD_HUDParms") exitWith {
	private _errortext = "CWHUD_fnc_getHUDTexture: CWHUD_HUDParms is not defined";
	CreateError(_errortext);
	_textures
};

private _listOfAllHelmetP1 = CWHUD_HUDParms select 0;
private _listOfAllHelmetP2 = CWHUD_HUDParms select 1;
private _listOfAllHelmetARF = CWHUD_HUDParms select 2;
private _listOfAllHelmetBARC = CWHUD_HUDParms select 3;

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
		private _errortext = format ["CWHUD_fnc_getHUDTexture: %1 is not a valid helmet", _helmet];
		CreateError(_errortext);
	};
};

_textures