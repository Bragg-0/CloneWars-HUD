#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_getGrenadeColor
Description:
    Returns the color of a throwable (smoke grenade, chemlight...) so that
    grenades sharing the same icon can be told apart on the HUD. Cached.

    Resolution order:
    1. A color word in the display name of the magazine ("Smoke Grenade (Green)")
    2. The smokeColor[] of the ammo (smoke grenades)

Parameters:
    0: _magazine - Throwable magazine classname <STRING>

Returns:
    Color [r, g, b, 1], [] if the throwable has no color (frag grenade...) <ARRAY>

Examples
    (begin example)
        ["SmokeShellGreen"] call cwh_hud_fnc_getGrenadeColor
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

params [["_magazine", "", [""]]];

private _color = GVAR(grenadeColorCache) get _magazine;
if (!isNil "_color") exitWith {_color};

_color = [];
private _cfgMagazine = configFile >> "CfgMagazines" >> _magazine;

// 1. Color word in the name (English and French): gives the expected color ("Green" is green,
//    while the smoke color of the green smoke grenade is a blue-green)
private _name = toLowerANSI getText (_cfgMagazine >> "displayName");
{
    _x params ["_words", "_rgb"];
    if (_words findIf {_x in _name} != -1) exitWith {
        _color = _rgb + [1];
    };
} forEach [
    [["red", "rouge"], [1, 0.2, 0.2]],
    [["green", "vert"], [0.3, 1, 0.3]],
    [["blue", "bleu"], [0.3, 0.55, 1]],
    [["yellow", "jaune"], [1, 0.95, 0.25]],
    [["orange"], [1, 0.55, 0.1]],
    [["purple", "violet"], [0.75, 0.35, 1]],
    [["white", "blanc", "blanche"], [1, 1, 1]]
];

// 2. Smoke color of the ammo
if (_color isEqualTo []) then {
    private _smokeColor = getArray (configFile >> "CfgAmmo" >> getText (_cfgMagazine >> "ammo") >> "smokeColor");
    if (count _smokeColor >= 3 && {(_smokeColor select [0, 3]) isEqualTypeAll 0}) then {
        // Brightened so that dark smoke colors stay readable on the HUD
        private _rgb = (_smokeColor select [0, 3]) apply {(_x max 0) min 1};
        private _max = selectMax _rgb;
        if (_max > 0) then {
            _color = (_rgb apply {_x / _max}) + [1];
        };
    };
};

GVAR(grenadeColorCache) set [_magazine, _color];

_color
