/*
	Function: CWHUD_fnc_getWearHUDColor
	Auteur: Bragg [CWHUD]
	Publique: Oui
	
	Description: Retourne la couleur de l'équipement porté par le joueur.
	
	Arguments:
	0: player <object> - Joueur à vérifier
	
	Retourne:
	<string> - Couleur de l'équipement porté par le joueur
	
	Exemple:
	[player] call CWHUD_fnc_getWearHUDColor;
*/

params ["_player"];

private _color = "Base";

if ([_player] call CWHUD_fnc_checkWearHUD) then {
	private _gogglesInfo = (goggles _player) splitString "_";
	_color = _gogglesInfo select 2;
};

_color