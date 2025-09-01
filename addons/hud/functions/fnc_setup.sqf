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
[_player] call FUNC(update);

// Set the HUD setup variable to true
_player setVariable [QGVAR(hudSetup), true, true];

// List of events to monitor
private _eventsCBA = ["loadout", "weapon", "weaponMode", "vehicle", "featureCamera", "cameraView"];

// Remove old event handlers if they exist
private _ehIds = _player getVariable [QGVAR(setupHandler), []];
if (_ehIds isEqualType [] && {count _ehIds == count _eventsCBA}) then {
    {
        [_eventsCBA select _forEachIndex, _x] call CBA_fnc_removePlayerEventHandler;
    } forEach _ehIds;
};

// Add new event handlers and store the IDs
private _newEhIds = _eventsCBA apply {
    [_x, { params ["_player"]; [_player] call FUNC(update); }] call CBA_fnc_addPlayerEventHandler
};
_player setVariable [QGVAR(setupHandler), _newEhIds, true];
