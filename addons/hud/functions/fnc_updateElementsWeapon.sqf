#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_updateElementsWeapon
Description:
    Updates the weapon indicator element of the HUD.

Parameters:
    <NONE>
    
Returns:
    <NONE>

Examples
    (begin example)
        [] call cwh_hud_fnc_updateElementsWeapon
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

// Get the current weapon selected
private _weaponState = weaponState player;

// If no weapon is selected, hide the weapon HUD element
if (_weaponState isEqualTo []) exitWith {
    {
        _x ctrlShow false;
    } forEach CWH_CTRL_WEAPON;
};

// Show the weapon HUD element
{
    _x ctrlShow true;
} forEach CWH_CTRL_WEAPON;

// Get weapon info
_weaponState params ["_weapon", "_muzzle", "_firemode", "_magazine", "_ammoCount", "_roundReloadPhase", "_magazineReloadPhase"];

// Get weapon icon and info text
private _icon = getText (configFile >> "CfgWeapons" >> _weapon >> "picture");
private _info = getText (configFile >> "CfgWeapons" >> _weapon >> "displayName");

// Update weapon icon and count
CWH_CTRL_WEAPON_ICON ctrlSetText _icon;
CWH_CTRL_WEAPON_INFO ctrlSetText _info;

// Update bullet count progress bar
if (_ammoCount == 0) then {
    CWH_CTRL_WEAPON_BULLET_COUNT progressSetPosition 1; // Full bar if empty
    CWH_CTRL_WEAPON_BULLET_COUNT ctrlSetTextColor [1,0,0,1]; // Red if empty
} else {
    CWH_CTRL_WEAPON_BULLET_COUNT progressSetPosition (_ammoCount / (getNumber (configFile >> "CfgMagazines" >> _magazine >> "count"))); // Set progress based on ammo count
    CWH_CTRL_WEAPON_BULLET_COUNT ctrlSetTextColor GVAR(color); // Normal color
};

// Get magazine icon and count
private _magazineIcon = getText (configFile >> "CfgMagazines" >> _magazine >> "picture");
private _magazinesCount = 0;
{
    if (_x isEqualTo _magazine) then {
        ADD(_magazinesCount,1);
    };
} forEach (magazines player);

// Update magazine icon and count
CWH_CTRL_WEAPON_MAGAZINE_ICON ctrlSetText _magazineIcon;
CWH_CTRL_WEAPON_MAGAZINE_COUNT ctrlSetText format ["%1", _magazinesCount];

// Update firemode
switch (_firemode) do {
    case "Single": {
        CWH_CTRL_WEAPON_FIREMODE_5 ctrlSetBackgroundColor [CWH_COLOR_DISABLED];
        CWH_CTRL_WEAPON_FIREMODE_4 ctrlSetBackgroundColor [CWH_COLOR_DISABLED];
        CWH_CTRL_WEAPON_FIREMODE_3 ctrlSetBackgroundColor [CWH_COLOR_DISABLED];
        CWH_CTRL_WEAPON_FIREMODE_2 ctrlSetBackgroundColor [CWH_COLOR_DISABLED];
        CWH_CTRL_WEAPON_FIREMODE_1 ctrlSetBackgroundColor GVAR(color);
    };
    case "FullAuto": {
        CWH_CTRL_WEAPON_FIREMODE_5 ctrlSetBackgroundColor GVAR(color);
        CWH_CTRL_WEAPON_FIREMODE_4 ctrlSetBackgroundColor GVAR(color);
        CWH_CTRL_WEAPON_FIREMODE_3 ctrlSetBackgroundColor GVAR(color);
        CWH_CTRL_WEAPON_FIREMODE_2 ctrlSetBackgroundColor GVAR(color);
        CWH_CTRL_WEAPON_FIREMODE_1 ctrlSetBackgroundColor GVAR(color);
    };
    case "Burst": {
        CWH_CTRL_WEAPON_FIREMODE_5 ctrlSetBackgroundColor [CWH_COLOR_DISABLED];
        CWH_CTRL_WEAPON_FIREMODE_4 ctrlSetBackgroundColor [CWH_COLOR_DISABLED];
        CWH_CTRL_WEAPON_FIREMODE_3 ctrlSetBackgroundColor GVAR(color);
        CWH_CTRL_WEAPON_FIREMODE_2 ctrlSetBackgroundColor GVAR(color);
        CWH_CTRL_WEAPON_FIREMODE_1 ctrlSetBackgroundColor GVAR(color);
    };
    default {
        CWH_CTRL_WEAPON_FIREMODE_5 ctrlSetBackgroundColor [CWH_COLOR_DISABLED];
        CWH_CTRL_WEAPON_FIREMODE_4 ctrlSetBackgroundColor [CWH_COLOR_DISABLED];
        CWH_CTRL_WEAPON_FIREMODE_3 ctrlSetBackgroundColor [CWH_COLOR_DISABLED];
        CWH_CTRL_WEAPON_FIREMODE_2 ctrlSetBackgroundColor [CWH_COLOR_DISABLED];
        CWH_CTRL_WEAPON_FIREMODE_1 ctrlSetBackgroundColor [CWH_COLOR_DISABLED];
    };
};
