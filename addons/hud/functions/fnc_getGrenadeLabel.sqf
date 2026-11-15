#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_getGrenadeLabel
Description:
    Short label of a throwable, shown in the grenade block to tell apart
    grenades sharing the same icon (e.g. thermal detonator classes). Cached.

    Resolution order:
    1. The text between parentheses in the display name: "Thermal Detonator (Class-A)" => "Class-A"
    2. The short display name (displayNameShort)
    3. Nothing

Parameters:
    0: _magazine - Throwable magazine classname <STRING>

Returns:
    Label, at most 12 characters <STRING>

Author:
    Bragg
---------------------------------------------------------------------------- */

#define MAX_LENGTH 12

params [["_magazine", "", [""]]];

private _label = GVAR(grenadeLabelCache) get _magazine;
if (!isNil "_label") exitWith {_label};

private _config = configFile >> "CfgMagazines" >> _magazine;
private _name = getText (_config >> "displayName");

_label = "";
private _open = _name find "(";
private _close = _name find ")";
if (_open >= 0 && {_close > _open + 1}) then {
    _label = trim (_name select [_open + 1, _close - _open - 1]);
};
if (_label == "") then {
    _label = trim getText (_config >> "displayNameShort");
};
if (count _label > MAX_LENGTH) then {
    _label = _label select [0, MAX_LENGTH];
};

GVAR(grenadeLabelCache) set [_magazine, _label];

_label
