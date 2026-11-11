#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_canRepair
Description:
    Checks whether a unit can repair its HUD now.

Parameters:
    0: _unit - Unit <OBJECT> (default: player)

Returns:
    True if the HUD can be repaired <BOOL>

Author:
    Bragg
---------------------------------------------------------------------------- */

params [["_unit", player, [objNull]]];

!GVAR(repairing)
&& {alive _unit}
&& {_unit getVariable [QGVAR(broken), false]}
&& {[headgear _unit] call FUNC(getHelmetType) != ""}
