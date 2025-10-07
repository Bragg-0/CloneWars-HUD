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

private _allHUDControls = CWH_CTRL_ALL;

{
    if (isNull _x) then { continue };
    _x ctrlShow true;
} forEach _allHUDControls;

// Hide default HUD
showHUD [false, false, false];
