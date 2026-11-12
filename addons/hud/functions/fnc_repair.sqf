#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_repair
Description:
    Starts repairing the HUD of the local player (progress bar).
    Cancelled if the player dies, gets knocked out or removes the helmet.

Parameters:
    0: _unit - Unit <OBJECT> (default: player)

Returns:
    True if the repair started <BOOL>

Examples
    (begin example)
        [player] call cwh_hud_fnc_repair
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

params [["_unit", player, [objNull]]];

if (_unit != player || {!([_unit] call FUNC(canRepair))}) exitWith {false};

TRACE_1("fnc_repair",_unit);

GVAR(repairing) = true;

if (isNull objectParent _unit) then {
    _unit playActionNow "MedicOther";
};

[
    LLSTRING(repairing),
    GVAR(repairTime),
    {
        params ["_args"];
        _args params ["_unit"];
        _unit == player
        && {alive _unit}
        && {lifeState _unit != "INCAPACITATED"}
        && {[headgear _unit] call FUNC(getHelmetType) != ""}
    },
    {
        params ["_args"];
        _args params ["_unit"];
        GVAR(repairing) = false;
        [_unit, false] call FUNC(setBroken);
    },
    {
        GVAR(repairing) = false;
    },
    [_unit]
] call CBA_fnc_progressBar;

true
