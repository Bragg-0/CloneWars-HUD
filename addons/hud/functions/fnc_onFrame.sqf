#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_onFrame
Description:
    Per-frame handler: decides whether the HUD is drawn and refreshes it.
    Cheap elements (compass, colors) are refreshed every frame, the others
    every CWH_SLOW_UPDATE_INTERVAL seconds.

Parameters:
    <NONE>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

// Mission start, respawn, team switch, selectPlayer...
if (player isNotEqualTo GVAR(unit)) then {
    [player, GVAR(unit)] call FUNC(onPlayerChanged);
};

private _type = [headgear player] call FUNC(getHelmetType);

if !([_type] call FUNC(shouldShow)) exitWith {
    if (GVAR(visible)) then {
        [] call FUNC(hide);
    };
};

// (Re)creates the display if needed, e.g. after loading a savegame
if (isNull ([] call FUNC(getDisplay))) exitWith {};

if (!GVAR(visible) || {_type != GVAR(type)}) then {
    [_type] call FUNC(show);
};

[] call FUNC(updateCompass);

if (diag_tickTime >= GVAR(nextSlowUpdate)) then {
    GVAR(nextSlowUpdate) = diag_tickTime + CWH_SLOW_UPDATE_INTERVAL;

    [] call FUNC(updateWeapon);
    [] call FUNC(updateGrenade);

    CWH_CTRL_SUNFILTER ctrlShow GVAR(sunFilter);
    CWH_CTRL_CRACK ctrlShow (player getVariable [QGVAR(broken), false]);
};

[] call FUNC(updateColor);
