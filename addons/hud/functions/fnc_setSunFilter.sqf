#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_setSunFilter
Description:
    Enables or disables the sun filter for the local player (kept across respawns).

Parameters:
    0: _enabled - New state <BOOL> (default: toggle)

Returns:
    <NONE>

Examples
    (begin example)
        [true] call cwh_hud_fnc_setSunFilter
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

params [["_enabled", !GVAR(sunFilter), [false]]];

GVAR(sunFilter) = _enabled;
GVAR(nextSlowUpdate) = 0;
