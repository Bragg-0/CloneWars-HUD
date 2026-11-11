#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_updateWeapon
Description:
    Updates the weapon element (icon, name, ammo, magazines, fire mode).
    Colors are applied by fnc_updateColor.

Parameters:
    <NONE>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

(weaponState player) params [["_weapon", ""], ["_muzzle", ""], ["_mode", ""], ["_magazine", ""], ["_ammo", 0]];

if (_weapon == "") exitWith {
    {
        _x ctrlShow false;
    } forEach CWH_CTRL_WEAPON;
    GVAR(fireModeLevel) = 0;
};

{
    _x ctrlShow true;
} forEach CWH_CTRL_WEAPON;

([_weapon, _muzzle, _mode, _magazine] call FUNC(getWeaponInfo)) params ["_icon", "_name", "_capacity", "_magazineIcon", "_fireModeLevel"];

CWH_CTRL_WEAPON_ICON ctrlSetText _icon;
CWH_CTRL_WEAPON_INFO ctrlSetText _name;

// Empty: full red bar
GVAR(ammoEmpty) = _ammo == 0;
CWH_CTRL_WEAPON_BULLET_COUNT progressSetPosition ([_ammo / _capacity, 1] select GVAR(ammoEmpty));

CWH_CTRL_WEAPON_MAGAZINE_ICON ctrlSetText _magazineIcon;
CWH_CTRL_WEAPON_MAGAZINE_COUNT ctrlSetText str ({_x == _magazine} count magazines player);

GVAR(fireModeLevel) = _fireModeLevel;
