#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_getWeaponInfo
Description:
    Returns the static (config) info needed to draw a weapon state. Cached.
    The fire mode is read from the mode config (autoFire / burst) so that
    modded weapons with custom mode names are supported.

Parameters:
    0: _weapon - Weapon classname <STRING>
    1: _muzzle - Muzzle name <STRING>
    2: _mode - Fire mode name <STRING>
    3: _magazine - Magazine classname <STRING>

Returns:
    [icon, display name, magazine capacity, magazine icon, fire mode level] <ARRAY>

Author:
    Bragg
---------------------------------------------------------------------------- */

params ["_weapon", "_muzzle", "_mode", "_magazine"];

private _key = [_weapon, _muzzle, _mode, _magazine] joinString "|";
private _info = GVAR(weaponInfoCache) get _key;
if (!isNil "_info") exitWith {_info};

private _cfgWeapon = configFile >> "CfgWeapons" >> _weapon;
private _cfgMuzzle = _cfgWeapon >> _muzzle;
if (!isClass _cfgMuzzle) then {_cfgMuzzle = _cfgWeapon};
private _cfgMode = _cfgMuzzle >> _mode;
if (!isClass _cfgMode) then {_cfgMode = _cfgMuzzle};

private _fireModeLevel = switch (true) do {
    case (getNumber (_cfgMode >> "autoFire") > 0): {CWH_FIREMODE_AUTO};
    case (getNumber (_cfgMode >> "burst") > 1): {CWH_FIREMODE_BURST};
    default {CWH_FIREMODE_SINGLE};
};

private _cfgMagazine = configFile >> "CfgMagazines" >> _magazine;

_info = [
    getText (_cfgWeapon >> "picture"),
    getText (_cfgWeapon >> "displayName"),
    getNumber (_cfgMagazine >> "count") max 1,
    getText (_cfgMagazine >> "picture"),
    _fireModeLevel
];

GVAR(weaponInfoCache) set [_key, _info];

_info
