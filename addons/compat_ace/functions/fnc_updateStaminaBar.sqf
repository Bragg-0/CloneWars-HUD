#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_compat_ace_fnc_updateStaminaBar
Description:
    Moves the ACE advanced fatigue stamina bar to the top left corner while
    the HUD is shown (it overlaps the weapon block otherwise), under the
    health block if it is displayed. Puts it back to its original position
    when the HUD is hidden.

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
    GVAR(staminaBarTarget) = [];
};

// Same units as the HUD layout (design pixels on a 1920x1080 canvas, see cwh_hud_fnc_layout)
private _target = if (EGVAR(hud,visible)) then {
    getResolution params ["_resW", "_resH"];
    private _unitH = safeZoneH / 1080 * EGVAR(hud,scale);
    private _unitW = safeZoneW / (1080 * (_resW / _resH)) * EGVAR(hud,scale);
    private _posY = [STAMINA_BAR_Y, STAMINA_BAR_Y_UNDER_HEALTH] select EGVAR(hud,showHealth);
    [safeZoneX + STAMINA_BAR_X * _unitW, safeZoneY + _posY * _unitH]
} else {
    GVAR(staminaBarPosition) select [0, 2]
};

if (_target isEqualTo GVAR(staminaBarTarget)) exitWith {};

TRACE_1("fnc_updateStaminaBar",_target);

_control ctrlSetPosition _target;
_control ctrlCommit 0;

GVAR(staminaBarTarget) = _target;
