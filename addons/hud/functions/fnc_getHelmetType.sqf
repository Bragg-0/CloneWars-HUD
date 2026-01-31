#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_getHelmetType
Description:
    Checks the type of the helmet based on the configured lists. Uses caching and isKindOf for performance and proper inheritance support.

Parameters:
    _helmetClass - Classname of the helmet [String]

Returns:
    Type of the helmet (e.g., "ARF", "BARC", "P1", "P2") or "NONE" [String]

Examples
    (begin example)
        _type = (headgear player) call cwh_hud_fnc_getHelmetType;
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

params ["_helmetClass"];

if (_helmetClass == "") exitWith {"NONE"};

// Check cache first
private _type = GVAR(helmetCache) getOrDefault [_helmetClass, ""];
if (_type != "") exitWith {_type};

// Determine type
_type = "NONE";
{
    _x params ["_checkType", "_roots"];
    {
        if (_helmetClass == _x || {_helmetClass isKindOf [_x, configFile >> "CfgWeapons"]}) exitWith {
            _type = _checkType;
        };
    } forEach _roots;
    
    if (_type != "NONE") exitWith {};
} forEach GVAR(helmetRoots);

// Cache result
GVAR(helmetCache) set [_helmetClass, _type];

_type
