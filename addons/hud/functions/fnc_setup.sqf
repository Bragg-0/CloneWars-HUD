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

// Check if the HUD is already set up for the player and delete it if necessary
if (player getVariable [QGVAR(hudSetup), false]) then {
    (QGVAR(rscHUD) call BIS_fnc_rscLayer) cutText ["", "PLAIN NOFADE"];
};

// Create the HUD
(QGVAR(rscHUD) call BIS_fnc_rscLayer) cutRsc [QGVAR(rscHUD), "PLAIN NOFADE", -1, false, true];

// Set the HUD setup variable to true
player setVariable [QGVAR(hudSetup), true, true];

// Add per-frame handler to update HUD
private _handle = player getVariable [QGVAR(setupHandler), -1];

// Remove old event handlers if they exist
if (_handle != -1) then {
    [_handle] call CBA_fnc_removePerFrameHandler;
};

// Add new event handlers and store the IDs
private _handle = [
    {
        [] call FUNC(update);
    }
] call CBA_fnc_addPerFrameHandler;

player setVariable [QGVAR(setupHandler), _handle, true];

//TODO: Add Break logic to crack the hud when the player takes head damage
