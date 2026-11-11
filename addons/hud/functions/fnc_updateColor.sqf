#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_updateColor
Description:
    Applies the HUD color (or the RGB cycle) to the colored elements.

Parameters:
    <NONE>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

private _color = GVAR(color);

if (GVAR(enableRGB)) then {
    private _hue = diag_tickTime % 6; // Full cycle in 6 seconds
    _color = [
        ((abs (_hue - 3) - 1) max 0) min 1,
        ((2 - abs (_hue - 2)) max 0) min 1,
        ((2 - abs (_hue - 4)) max 0) min 1,
        _color select 3
    ];
};

{
    _x ctrlSetTextColor _color;
} forEach CWH_CTRL_COLORED;

CWH_CTRL_WEAPON_BULLET_COUNT ctrlSetTextColor ([_color, [CWH_COLOR_EMPTY]] select GVAR(ammoEmpty));

{
    _x ctrlSetBackgroundColor ([[CWH_COLOR_DISABLED], _color] select (_forEachIndex < GVAR(fireModeLevel)));
} forEach CWH_CTRL_FIREMODES;
