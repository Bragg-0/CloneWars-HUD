#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_setEnabled
Description:
    Enables or disables the HUD for the local player (kept across respawns).
    Raises the local CBA event "cwh_hud_enabledChanged" [enabled].

Parameters:
    0: _enabled - New state <BOOL> (default: toggle)

Returns:
    <NONE>

Examples
    (begin example)
        [false] call cwh_hud_fnc_setEnabled
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

params [["_enabled", !GVAR(enabled), [false]]];

if (_enabled isEqualTo GVAR(enabled)) exitWith {};

GVAR(enabled) = _enabled;

[QGVAR(enabledChanged), [_enabled]] call CBA_fnc_localEvent;
