#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_setup
Description:
    Sets up the HUD for the player.

Parameters:
    1: _unit - The unit to setup the HUD for (default: player)

Returns:
    <NONE>

Examples
    (begin example)
        [player] call cwh_hud_fnc_setup
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

params [["_unit", player]];

TRACE_1("fnc_setup",_this);

if (isNull _unit) exitWith {};
if (_unit != player) exitWith {};

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

// Check if already setup ON THIS UNIT to prevent duplication
if (_unit getVariable [QGVAR(isSetup), false]) exitWith {};
_unit setVariable [QGVAR(isSetup), true];

// Set the HUD setup variable to true
_unit setVariable [QGVAR(hudSetup), true, true];

// Add per-frame handler to update HUD
// Use a global variable for the handle to persist across respawns and avoid duplication
private _handle = uiNamespace getVariable [QGVAR(setupHandler), -1];

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

uiNamespace setVariable [QGVAR(setupHandler), _handle];

// Remove potential old event handlers to avoid duplication
private _oldDammagedEH = _unit getVariable [QGVAR(ehDammaged), -1];
if (_oldDammagedEH != -1) then { _unit removeEventHandler ["Dammaged", _oldDammagedEH]; };

private _oldRespawnEH = _unit getVariable [QGVAR(ehRespawn), -1];
if (_oldRespawnEH != -1) then { _unit removeEventHandler ["Respawn", _oldRespawnEH]; };

// Initially break the HUD to ensure it starts in a known state
private _idDammaged = _unit addEventHandler ["Dammaged", {
	_this call FUNC(break);
}];
_unit setVariable [QGVAR(ehDammaged), _idDammaged];

private _idRespawn = _unit addEventHandler ["Respawn", {
	params ["_newUnit"];
    _newUnit setVariable [QGVAR(broken), false, true];
    // Re-initialize setup for the new unit
    [_newUnit] call FUNC(setup);
}];
_unit setVariable [QGVAR(ehRespawn), _idRespawn];
