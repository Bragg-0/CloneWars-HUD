#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_updateElementsGrenade
Description:
    Updates the grenade indicator element of the HUD.

Parameters:
    <NONE>
    
Returns:
    <NONE>

Examples
    (begin example)
        [] call cwh_hud_fnc_updateElementsGrenade
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

// Get the current grenade selected
private _grenade = currentThrowable player;

// If no grenade is selected, hide the grenade HUD element
if (_grenade isEqualTo []) exitWith {
    {
        _x ctrlShow false;
    } forEach CWH_CTRL_GRENADE;
};

// Show the grenade HUD element
{
    _x ctrlShow true;
} forEach CWH_CTRL_GRENADE;

// Get grenade info
_grenade params ["_magazineName", "_muzzleName", "_id", "_ammoCount"];

// Get grenade icon from config
private _icon = getText (configFile >> "CfgMagazines" >> _magazineName >> "picture");

// Update grenade icon and count
CWH_CTRL_GRENADE_ICON ctrlSetText _icon;
CWH_CTRL_GRENADE_COUNT ctrlSetText FORMAT_1("%1",_ammoCount);
