#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_hide
Description:
    Hides the HUD and restores the vanilla weapon info.

Parameters:
    <NONE>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

TRACE_1("fnc_hide",GVAR(type));

{
    _x ctrlShow false;
} forEach CWH_CTRL_ALL;

if (!isNil QGVAR(savedInfo)) then {
    private _shownHUD = shownHUD;
    _shownHUD set [1, GVAR(savedInfo)];
    showHUD _shownHUD;
    GVAR(savedInfo) = nil;
};

GVAR(visible) = false;

[QGVAR(visibilityChanged), [false]] call CBA_fnc_localEvent;
