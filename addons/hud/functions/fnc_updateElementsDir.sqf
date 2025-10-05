#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_updateElementsDir
Description:
    Updates the directional indicator element of the HUD.

Parameters:
    <NONE>
    
Returns:
    <NONE>

Examples
    (begin example)
        [] call cwh_hud_fnc_updateElementsDir
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

// Get player's current direction
private _dir = getDir player;

// Update the direction
CWH_CTRL_DIR_INFO ctrlSetText FORMAT_1("%1°", round _dir);
