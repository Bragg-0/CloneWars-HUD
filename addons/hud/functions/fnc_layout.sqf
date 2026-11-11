#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_layout
Description:
    Positions every HUD control. Nothing is stretched, whatever the aspect
    ratio of the screen:
    - The visor textures (2:1) fill the screen height and are centered.
    - The info elements are described in "design pixels" on a 1920x1080
      canvas and anchored to a side of the screen (left / center / right,
      top / middle / bottom). They keep their proportions and are scaled by
      the HUD scale setting around their anchor.

Parameters:
    <NONE>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

private _display = CWH_DISPLAY;
if (isNull _display) exitWith {};

getResolution params ["_resW", "_resH"];

// UI units per design pixel (1080 design pixels = screen height)
private _pxH = safeZoneH / CWH_DESIGN_H;
private _pxW = safeZoneW / (CWH_DESIGN_H * (_resW / _resH));

TRACE_4("fnc_layout",_resW,_resH,GVAR(scale),GVAR(opacity));

// Visor: full height, real proportions, centered (cropped or letterboxed on the sides)
private _visorW = CWH_DESIGN_H * CWH_VISOR_RATIO * _pxW;
{
    _x ctrlSetPosition [safeZoneX + (safeZoneW - _visorW) / 2, safeZoneY, _visorW, safeZoneH];
    _x ctrlCommit 0;
} forEach [CWH_CTRL_FRAME, CWH_CTRL_COLOR, CWH_CTRL_CRACK];

// Info elements
private _scale = GVAR(scale);
private _fade = 1 - GVAR(opacity);
private _unitW = _pxW * _scale;
private _unitH = _pxH * _scale;

{
    _x params ["_idc", "_anchorH", "_anchorV", "_posX", "_posY", "_width", "_height", ["_fontSize", 0]];

    private _control = _display displayCtrl _idc;

    private _screenX = switch (_anchorH) do {
        case "L": {safeZoneX + _posX * _unitW};
        case "R": {safeZoneX + safeZoneW - (CWH_DESIGN_W - _posX) * _unitW};
        default {safeZoneX + safeZoneW / 2 + (_posX - CWH_DESIGN_W / 2) * _unitW};
    };
    private _screenY = switch (_anchorV) do {
        case "T": {safeZoneY + _posY * _unitH};
        case "B": {safeZoneY + safeZoneH - (CWH_DESIGN_H - _posY) * _unitH};
        default {safeZoneY + safeZoneH / 2 + (_posY - CWH_DESIGN_H / 2) * _unitH};
    };

    _control ctrlSetPosition [_screenX, _screenY, _width * _unitW, _height * _unitH];
    if (_fontSize > 0) then {
        _control ctrlSetFontHeight (_fontSize * _unitH);
    };
    _control ctrlSetFade _fade;
    _control ctrlCommit 0;
} forEach [
    // idc, anchor H, anchor V, x, y, width, height, font size (design pixels, 1920x1080 canvas)

    // Weapon (top right)
    [1010, "R", "T", 1634, -10, 286, 240],
    [1011, "R", "T", 1685, 43, 165, 54],
    [1012, "R", "T", 1685, 103, 165, 8],
    [1013, "R", "T", 1685, 123, 165, 24, 20],
    [1014, "R", "T", 1818, 153, 32, 34],
    [1015, "R", "T", 1780, 153, 32, 34, 22],
    [10165, "R", "T", 1693, 113, 22, 8],
    [10164, "R", "T", 1725, 113, 22, 8],
    [10163, "R", "T", 1756, 113, 22, 8],
    [10162, "R", "T", 1788, 113, 22, 8],
    [10161, "R", "T", 1820, 113, 22, 8],

    // Grenade (top right, under the weapon)
    [1020, "R", "T", 1710, 190, 248, 120],
    [1021, "R", "T", 1833, 222, 51, 54],
    [1022, "R", "T", 1783, 233, 32, 34, 22],

    // Heading (top center)
    [1030, "C", "T", 665, 20, 153, 80],
    [1031, "C", "T", 669, 55, 96, 24, 20]
];
