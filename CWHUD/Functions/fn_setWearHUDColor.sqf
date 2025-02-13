/*
	Function: CWHUD_fnc_setWearHUDColor
	Auteur: Bragg [CWHUD]
	Publique: Oui
	
	Description: Définit la couleur de l'HUD en fonction de l'équipement porté par le joueur.
	
	Arguments:
	0: player <object> - Joueur à vérifier
	1: color <string> - Couleur de l'HUD à afficher
	
	Retourne:
	None
	
	Exemple:
	[player, "base"] spawn CWHUD_fnc_setWearHUDColor;
*/

params ["_player", "_color"];

if ([_player] call CWHUD_fnc_checkWearHUD) then {
	private _oldGoggles = goggles _player;

	private _gogglesSplit = _oldGoggles splitString "_";
	_gogglesSplit params ["_signatures", "_type", "_oldColor"];

	private _newGogglesClass = format ["%1_%2_%3", _signatures, _type, _color];

	removeGoggles _player;
	sleep 0.1;
	_player addGoggles _newGogglesClass;

	diag_log format ["[CWHUD] %1 changed his goggles from %2 to %3", name _player, _oldGoggles, _newGogglesClass];
};