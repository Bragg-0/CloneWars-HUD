#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_setup
Description:
    Sets up the HUD for the player.

Parameters:
    _player - The player object <OBJECT>

Returns:
    <NONE>

Examples
    (begin example)
        [_player] call cwh_hud_fnc_setup
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

params [
    ["_player", objNull, [objNull]]
];

TRACE_1("fnc_setup",_this);

// Check if the HUD is already set up for the player and delete it if necessary
if (_player getVariable [QGVAR(hudSetup), false]) then {
    (QGVAR(rscHUD) call BIS_fnc_rscLayer) cutText ["", "PLAIN NOFADE"];
};

// Create the HUD
(QGVAR(rscHUD) call BIS_fnc_rscLayer) cutRsc [QGVAR(rscHUD), "PLAIN NOFADE", -1, false, true];

// Set the HUD setup variable to true
_player setVariable [QGVAR(hudSetup), true, true];

// Add per-frame handler to update HUD
private _handle = _player getVariable [QGVAR(setupHandler), -1];

// Remove old event handlers if they exist
if (_handle != -1) then {
    [_handle] call CBA_fnc_removePerFrameHandler;
};

// Add new event handlers and store the IDs
private _handle = [
    {
        _this#1 params ["_player"];
        [_player] call FUNC(update);
    },
    0,
    [_player]
] call CBA_fnc_addPerFrameHandler;

_player setVariable [QGVAR(setupHandler), _handle, true];
