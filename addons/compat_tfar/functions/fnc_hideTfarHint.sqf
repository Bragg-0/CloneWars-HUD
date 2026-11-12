#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_compat_tfar_fnc_hideTfarHint
Description:
    Hides the TFAR hint (transmitting, radio / channel change) while the HUD
    is shown and the setting is enabled: the HUD radio block replaces it.
    Done on the next frame, after TFAR has shown it.

Parameters:
    <NONE>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

if (!GVAR(hideTfarHint) || {!EGVAR(hud,visible)} || {!EGVAR(hud,showRadio)}) exitWith {};

[{
    if (!isNil "TFAR_fnc_hideHint") then {
        call TFAR_fnc_hideHint;
    };
}] call CBA_fnc_execNextFrame;
