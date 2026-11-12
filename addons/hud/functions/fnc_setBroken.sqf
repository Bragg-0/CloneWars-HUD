#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_setBroken
Description:
    Breaks or repairs the HUD of a unit.
    Raises the local CBA event "cwh_hud_brokenChanged" [unit, broken].

Parameters:
    0: _unit - Unit <OBJECT> (default: player)
    1: _broken - True to break, false to repair <BOOL> (default: true)

Returns:
    <NONE>

Examples
    (begin example)
        [player, true] call cwh_hud_fnc_setBroken
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

params [["_unit", player, [objNull]], ["_broken", true, [false]]];

if ((_unit getVariable [QGVAR(broken), false]) isEqualTo _broken) exitWith {};

TRACE_2("fnc_setBroken",_unit,_broken);

_unit setVariable [QGVAR(broken), _broken, true];

if (_unit == player) then {
    GVAR(nextSlowUpdate) = 0;
    [[LLSTRING(repaired), LLSTRING(broken)] select _broken, ["success", "alert"] select _broken] call FUNC(notify);
};

[QGVAR(brokenChanged), [_unit, _broken]] call CBA_fnc_localEvent;
