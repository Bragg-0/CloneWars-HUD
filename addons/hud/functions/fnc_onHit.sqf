#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_onHit
Description:
    Called when the local player is hit: glitches the HUD, and may crack it
    on a head hit. Fed by the "Dammaged" event handler and, when ACE medical
    is loaded, by the ACE wound event (see compat_ace).

Parameters:
    0: _unit - Unit hit <OBJECT>
    1: _isHeadHit - True if the head was hit <BOOL>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

params ["_unit", ["_isHeadHit", false, [false]]];

if (_unit != player || {!alive _unit}) exitWith {};

[] call FUNC(glitch);

if (!_isHeadHit) exitWith {};

// One roll per hit, even if several events fire in the same frame
if (GVAR(lastHeadHitFrame) == diag_frameNo) exitWith {};
GVAR(lastHeadHitFrame) = diag_frameNo;

if (_unit getVariable [QGVAR(broken), false]) exitWith {};
if ([headgear _unit] call FUNC(getHelmetType) == "") exitWith {};

if (random 1 < GVAR(brokenChance)) then {
    [_unit, true] call FUNC(setBroken);
};
