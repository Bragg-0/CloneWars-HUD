#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_init
Description:
    Initializes the HUD environment for the player.

Parameters:
    _player - The player object <OBJECT>

Returns:
    <NONE>

Examples
    (begin example)
        [player] call cwh_hud_fnc_init
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

params [
    ["_player", objNull, [objNull]]
];

TRACE_1("fnc_init",_this);

// Check if ACE mod is loaded to load ACE-specific
private _isACE = (configFile >> "CfgPatches" >> "ace_interact_menu") call BIS_fnc_getCfgIsClass;
if (_isACE) then {
    INFO("ACE mod detected, initializing ACE-specific HUD elements");
    [_player] call EFUNC(compat_ace,init);
};
