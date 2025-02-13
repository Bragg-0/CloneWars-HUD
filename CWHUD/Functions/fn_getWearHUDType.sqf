/*
	Function: CWHUD_fnc_getWearHUDType
	Auteur: Bragg [CWHUD]
	Publique: Oui
	
	Description: Retourne le type de l'équipement porté par le joueur.
	
	Arguments:
	0: player <object> - Joueur à vérifier
	
	Retourne:
	<string> - Type de l'équipement porté par le joueur
	
	Exemple:
	[player] call CWHUD_fnc_getWearHUDType;
*/

params ["_player"];

private _type = "";

if ([_player] call CWHUD_fnc_checkWearHUD) then {
	private _gogglesInfo = (goggles _player) splitString "_";
	_type = _gogglesInfo select 1;
};

_type