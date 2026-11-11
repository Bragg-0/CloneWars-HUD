#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_compat_ace_fnc_updateStaminaBar
Description:
    Moves the ACE advanced fatigue stamina bar to the top left corner while
    the HUD is shown (it overlaps the weapon frame otherwise), and puts it
    back to its original position when the HUD is hidden.

Parameters:
    <NONE>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

private _control = uiNamespace getVariable ["ace_advanced_fatigue_staminaBarContainer", controlNull];
if (isNull _control) exitWith {};

// New control (first use or recreated by ACE): remember its original position
if (_control isNotEqualTo (uiNamespace getVariable [QGVAR(staminaBar), controlNull])) then {
    uiNamespace setVariable [QGVAR(staminaBar), _control];
    GVAR(staminaBarPosition) = ctrlPosition _control;
    GVAR(staminaBarMoved) = false;
};

private _shouldMove = EGVAR(hud,visible);
if (_shouldMove isEqualTo GVAR(staminaBarMoved)) exitWith {};

TRACE_1("fnc_updateStaminaBar",_shouldMove);

if (_shouldMove) then {
    _control ctrlSetPosition [
        safeZoneX + safeZoneW * 0.00677084,
        safeZoneY + safeZoneH * 0.01203704
    ];
} else {
    _control ctrlSetPosition GVAR(staminaBarPosition);
};
_control ctrlCommit 0;

GVAR(staminaBarMoved) = _shouldMove;
