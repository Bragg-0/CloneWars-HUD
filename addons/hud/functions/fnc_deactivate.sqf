#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_deactivate
Description:
    Deactivates the HUD for the player.

Parameters:
    <NONE>

Returns:
    <NONE>

Examples
    (begin example)
        [] call cwh_hud_fnc_deactivate
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

{
    if (isNull _x) then { continue };
    _x ctrlShow false;
} forEach CWH_CTRL_ALL;

// Display default HUD
showHUD GVAR(shownHUD);
