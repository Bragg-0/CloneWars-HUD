#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_updateGrenade
Description:
    Updates the grenade element (icon and count of the selected throwable).

Parameters:
    <NONE>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

(currentThrowable player) params [["_magazine", ""]];

if (!GVAR(showGrenade) || {_magazine == ""}) exitWith {
    {
        _x ctrlShow false;
    } forEach CWH_CTRL_GRENADE;
};

{
    _x ctrlShow true;
} forEach CWH_CTRL_GRENADE;

CWH_CTRL_GRENADE_ICON ctrlSetText getText (configFile >> "CfgMagazines" >> _magazine >> "picture");

// Smoke / chemlight color: colored stripe under the icon (the icon keeps its own colors)
private _color = [_magazine] call FUNC(getGrenadeColor);
if (_color isEqualTo []) then {
    CWH_CTRL_GRENADE_COLOR ctrlShow false;
} else {
    CWH_CTRL_GRENADE_COLOR ctrlSetBackgroundColor _color;
};
// The selected throwable is loaded in the hand: "magazines" does not list it, "magazinesAmmoFull" does
CWH_CTRL_GRENADE_COUNT ctrlSetText str ({(_x select 0) == _magazine} count magazinesAmmoFull player);

CWH_CTRL_GRENADE_LABEL ctrlSetText ([_magazine] call FUNC(getGrenadeLabel));
