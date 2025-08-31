#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_compat_ace_fnc_init
Description:
    Initializes the ACE compatibility layer.

Parameters:
    _player - The player object to initialize for <OBJECT>

Returns:
    <NONE>

Examples
    (begin example)
        [player] call cwh_compat_ace_fnc_init
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

params [
    ["_player", objNull, [objNull]]
];

TRACE_1("fnc_init",_this);
