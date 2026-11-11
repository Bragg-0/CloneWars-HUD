#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_updateCompass
Description:
    Updates the heading indicator, following where the player looks.

Parameters:
    <NONE>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

private _vector = (positionCameraToWorld [0, 0, 1]) vectorDiff (positionCameraToWorld [0, 0, 0]);
private _dir = (round ((_vector select 0) atan2 (_vector select 1)) + 360) % 360;
private _point = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"] select (round (_dir / 45) % 8);

CWH_CTRL_DIR_INFO ctrlSetText format ["%1° | %2", _dir, _point];
