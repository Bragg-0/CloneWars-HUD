#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_getSquadColor
Description:
    Color of a squad member marker (3D marker and compass): HUD color, or
    the color of the member's team if enabled in the settings. Blinking
    red if the member is in cardiac arrest (ACE medical), blinking orange
    if unconscious.

Parameters:
    0: _unit - Squad member <OBJECT>

Returns:
    Color [r, g, b, a] <ARRAY>

Author:
    Bragg
---------------------------------------------------------------------------- */

params ["_unit"];

// ACE medical: still alive, but dies if nobody performs CPR in time
if (_unit getVariable ["ace_medical_inCardiacArrest", false]) exitWith {
    [[CWH_COLOR_EMPTY_DIM], [CWH_COLOR_EMPTY]] select CWH_BLINK_ON
};

if (lifeState _unit == "INCAPACITATED" || {_unit getVariable ["ACE_isUnconscious", false]}) exitWith {
    [[CWH_COLOR_WARNING_DIM], [CWH_COLOR_WARNING]] select CWH_BLINK_ON
};

if (GVAR(squadTeamColors)) then {
    switch (assignedTeam _unit) do {
        case "RED": {[1, 0.25, 0.25, 1]};
        case "GREEN": {[0.35, 1, 0.35, 1]};
        case "BLUE": {[0.35, 0.55, 1, 1]};
        case "YELLOW": {[1, 0.95, 0.3, 1]};
        default {GVAR(currentColor)};
    }
} else {
    GVAR(currentColor)
}
