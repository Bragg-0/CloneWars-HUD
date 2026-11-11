#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_glitch
Description:
    Makes the HUD glitch (shake and flicker) for a short time.
    Does nothing if the HUD is hidden or the effect is disabled in the settings.

Parameters:
    0: _duration - Duration in seconds <NUMBER> (default: 0.35)

Returns:
    <NONE>

Examples
    (begin example)
        [1] call cwh_hud_fnc_glitch
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

params [["_duration", CWH_GLITCH_DURATION, [0]]];

if (!GVAR(enableGlitch) || {!GVAR(visible)}) exitWith {};

GVAR(glitchEnd) = diag_tickTime + _duration;
GVAR(animating) = true;
