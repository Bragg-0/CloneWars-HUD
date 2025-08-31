#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_activate
Description:
    Activates the HUD for the player.

Parameters:
    _player  - The player object <OBJECT>

Returns:
    <NONE>

Examples
    (begin example)
        [player] call cwh_hud_fnc_activate
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

params [
    ["_player", objNull, [objNull]]
];

TRACE_1("fnc_activate",_this);

//TODO: Implement HUD activation logic