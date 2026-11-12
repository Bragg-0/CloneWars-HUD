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

// Smoke / chemlight color: icon tinted and a colored stripe under it
private _color = [_magazine] call FUNC(getGrenadeColor);
if (_color isEqualTo []) then {
    CWH_CTRL_GRENADE_ICON ctrlSetTextColor [CWH_COLOR_WHITE];
    CWH_CTRL_GRENADE_COLOR ctrlShow false;
} else {
    CWH_CTRL_GRENADE_ICON ctrlSetTextColor _color;
    CWH_CTRL_GRENADE_COLOR ctrlSetBackgroundColor _color;
};
CWH_CTRL_GRENADE_COUNT ctrlSetText str ({_x == _magazine} count magazines player);
