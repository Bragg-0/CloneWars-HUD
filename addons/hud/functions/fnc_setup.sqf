#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_setup
Description:
    Sets up the HUD for the player.

Parameters:
    <NONE>

Returns:
    <NONE>

Examples
    (begin example)
        [] call cwh_hud_fnc_setup
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

TRACE_1("fnc_setup",_this);

// Initialize shownHUD variable
GVAR(shownHUD) = shownHUD;

// Initialize hud active variable
GVAR(hudActive) = false;

// Check if the HUD is already set up for the player and delete it if necessary
if (player getVariable [QGVAR(hudSetup), false]) then {
    (QGVAR(rscHUD) call BIS_fnc_rscLayer) cutText ["", "PLAIN NOFADE"];
};

// Create the HUD
(QGVAR(rscHUD) call BIS_fnc_rscLayer) cutRsc [QGVAR(rscHUD), "PLAIN NOFADE", -1, false];

// Set the HUD setup variable to true
player setVariable [QGVAR(hudSetup), true, true];

// Add per-frame handler to update HUD
// Use a global variable for the handle to persist across respawns and avoid duplication
private _handle = missionNamespace getVariable [QGVAR(setupHandler), -1];

// Remove old per-frame handler if it exists
if (_handle != -1) then {
    [_handle] call CBA_fnc_removePerFrameHandler;
};

// Add new per-frame handler and store the ID in global variable
_handle = [
    {
        [] call FUNC(update);
    }
] call CBA_fnc_addPerFrameHandler;

missionNamespace setVariable [QGVAR(setupHandler), _handle];

// Remove potential old event handlers to avoid duplication
private _oldDammagedEH = player getVariable [QGVAR(ehDammaged), -1];
if (_oldDammagedEH != -1) then { player removeEventHandler ["Dammaged", _oldDammagedEH]; };

private _oldRespawnEH = player getVariable [QGVAR(ehRespawn), -1];
if (_oldRespawnEH != -1) then { player removeEventHandler ["Respawn", _oldRespawnEH]; };

// Initially break the HUD to ensure it starts in a known state
private _idDammaged = player addEventHandler ["Dammaged", {
	_this call FUNC(break);
}];
player setVariable [QGVAR(ehDammaged), _idDammaged];

private _idRespawn = player addEventHandler ["Respawn", {
	params ["_unit"];
    _unit setVariable [QGVAR(broken), false, true];
    // Re-initialize setup for the new unit
    [] call FUNC(setup);
}];
player setVariable [QGVAR(ehRespawn), _idRespawn];
