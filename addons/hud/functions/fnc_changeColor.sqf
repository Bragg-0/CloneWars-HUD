#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_changeColor
Description:
    Changes the color of the HUD elements.

Parameters:
    _color - The new color value RGBA <ARRAY>
Returns:
    <NONE>

Examples
    (begin example)
        [color] call cwh_hud_fnc_changeColor
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

params [
    ["_color", [0, 0, 0, 0], [array]]
];

TRACE_1("fnc_changeColor",_this);

//TODO: Implement color change logic
