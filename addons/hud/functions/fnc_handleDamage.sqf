#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_handleDamage
Description:
    "Dammaged" event handler of the player unit, forwards the hit to fnc_onHit.

Parameters:
    https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#Dammaged

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

params ["_unit", "_selection", "_damage", "", "_hitPoint"];

if (_damage <= 0) exitWith {};

[_unit, toLowerANSI _selection == "head" || {toLowerANSI _hitPoint == "hithead"}] call FUNC(onHit);
