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

// Ammo: red when empty, blinking orange when low
private _barColor = _color;
private _counterColor = [CWH_COLOR_WHITE];
if (GVAR(ammoEmpty)) then {
    _barColor = [CWH_COLOR_EMPTY];
    _counterColor = [CWH_COLOR_EMPTY];
} else {
    if (GVAR(ammoLow)) then {
        _barColor = [CWH_COLOR_WARNING];
        _counterColor = [[CWH_COLOR_WARNING_DIM], [CWH_COLOR_WARNING]] select CWH_BLINK_ON;
    };
};
CWH_CTRL_WEAPON_BULLET_COUNT ctrlSetTextColor _barColor;
CWH_CTRL_WEAPON_AMMO ctrlSetTextColor _counterColor;

// Health: red when critical, orange on warning (pain, exhaustion)
CWH_CTRL_HEALTH_BAR_1 ctrlSetTextColor ([_color, [CWH_COLOR_EMPTY]] select GVAR(healthRow1Low));
CWH_CTRL_HEALTH_VALUE_1 ctrlSetTextColor ([[CWH_COLOR_WHITE], [CWH_COLOR_EMPTY]] select GVAR(healthRow1Low));
CWH_CTRL_HEALTH_BAR_2 ctrlSetTextColor ([_color, [CWH_COLOR_WARNING]] select GVAR(healthRow2Warning));
CWH_CTRL_HEALTH_VALUE_2 ctrlSetTextColor ([[CWH_COLOR_WHITE], [CWH_COLOR_WARNING]] select GVAR(healthRow2Warning));

{
    _x ctrlSetBackgroundColor ([[CWH_COLOR_DISABLED], _color] select (_forEachIndex < GVAR(fireModeLevel)));
} forEach CWH_CTRL_FIREMODES;
