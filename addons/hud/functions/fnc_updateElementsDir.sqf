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
private _point = switch true do {
    case (_dir >= 337.5 || _dir < 22.5): {"N"};
    case (_dir >= 22.5 && _dir < 67.5): {"NE"};
    case (_dir >= 67.5 && _dir < 112.5): {"E"};
    case (_dir >= 112.5 && _dir < 157.5): {"SE"};
    case (_dir >= 157.5 && _dir < 202.5): {"S"};
    case (_dir >= 202.5 && _dir < 247.5): {"SW"};
    case (_dir >= 247.5 && _dir < 292.5): {"W"};
    case (_dir >= 292.5 && _dir < 337.5): {"NW"};
    default {"N"};
};

// Update the direction
CWH_CTRL_DIR_INFO ctrlSetText FORMAT_2("%1° | %2",round _dir,_point);
