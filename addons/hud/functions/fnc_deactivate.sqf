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

private _allHUDControls = CWH_CTRL_ALL;

{
    if (isNull _x) then { continue };
    _x ctrlShow false;
} forEach _allHUDControls;

// Display default HUD
showHUD [false, false, false];
