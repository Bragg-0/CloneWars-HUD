#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_onPlayerChanged
Description:
    Moves the HUD event handlers from the previous player unit to the new one.
    Called on mission start, respawn, team switch, selectPlayer...

Parameters:
    0: _newUnit - New player unit <OBJECT>
    1: _oldUnit - Previous player unit <OBJECT>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

params ["_newUnit", "_oldUnit"];

TRACE_2("fnc_onPlayerChanged",_newUnit,_oldUnit);

// Detach from the previous unit (e.g. the corpse after a respawn)
if (!isNull _oldUnit) then {
    private _id = _oldUnit getVariable [QGVAR(ehDammaged), -1];
    if (_id != -1) then {
        _oldUnit removeEventHandler ["Dammaged", _id];
        _oldUnit setVariable [QGVAR(ehDammaged), nil];
    };
};

GVAR(unit) = _newUnit;
GVAR(repairing) = false;

if (isNull _newUnit) exitWith {};

if (_newUnit getVariable [QGVAR(ehDammaged), -1] == -1) then {
    _newUnit setVariable [QGVAR(ehDammaged), _newUnit addEventHandler ["Dammaged", LINKFUNC(handleDamage)]];
};
