#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_activate
Description:
    Activates the HUD for the player.

Parameters:
    <NONE>

Returns:
    <NONE>

Examples
    (begin example)
        [] call cwh_hud_fnc_activate
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

{
    if (isNull _x) then { continue };
    
    switch (_x) do {
        case CWH_CTRL_SUNFILTER;
        case CWH_CTRL_CRACK: {
            continue;
        };
        default {
            _x ctrlShow true;
        };
    };
} forEach CWH_CTRL_ALL;

// Hide default HUD
showHUD [(GVAR(shownHUD) select 0), false];
