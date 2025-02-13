/*
	Function: CWHUD_fnc_checkWearHUD
	Auteur: Bragg [CWHUD]
	Publique: Oui
	
	Description: Vérifie si le joueur porte un équipement CWHUD.
	
	Arguments:
	0: player <object> - Joueur à vérifier
	
	Retourne:
	<boolean> - true si le joueur porte un équipement CWHUD, false sinon
	
	Exemple:
	[player] call CWHUD_fnc_checkWearHUD;
*/

params ["_player"];

if ((goggles _player) == "") exitWith {
	false
};

if (((goggles _player) select [0, 5]) == "CWHUD") then {
	true
} else {
	false
};