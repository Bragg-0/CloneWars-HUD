#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_compat_ace_fnc_canInteract
Description:
    Checks if the player can interact with the hud.

Parameters:
    _player - The player object <OBJECT>

Returns:
    <BOOL> True if the player can interact with the hud, false otherwise.

Examples
    (begin example)
        [player] call cwh_compat_ace_fnc_canInteract
    (end)

Author:
    You
---------------------------------------------------------------------------- */

params [
    ["_player",objNull,[objNull]]
];

TRACE_1("fnc_canInteract",_this);

true; // Always allow interaction for now

// TODO: Implement interaction checks
