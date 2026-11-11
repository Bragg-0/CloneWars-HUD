#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_handleDamage
Description:
    "Dammaged" event handler: head hits may crack the HUD.

Parameters:
    https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#Dammaged

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

params ["_unit", "_selection", "_damage", "", "_hitPoint"];

if (_unit != player || {!alive _unit} || {_damage <= 0}) exitWith {};
if (toLowerANSI _selection != "head" && {toLowerANSI _hitPoint != "hithead"}) exitWith {};

// One roll per hit, even if the event fires several times in the same frame
if (GVAR(lastHeadHitFrame) == diag_frameNo) exitWith {};
GVAR(lastHeadHitFrame) = diag_frameNo;

if (_unit getVariable [QGVAR(broken), false]) exitWith {};
if ([headgear _unit] call FUNC(getHelmetType) == "") exitWith {};

if (random 1 < GVAR(brokenChance)) then {
    [_unit, true] call FUNC(setBroken);
};
