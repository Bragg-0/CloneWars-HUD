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

    The optional parameters are used by fnc_animate (boot sequence, glitch).

Parameters:
    0: _offset - Offset applied to the info elements, in design pixels <ARRAY> (default: [0, 0])
    1: _factors - Opacity factor (0..1) of each block: [weapon, grenade, heading, health] <ARRAY> (default: all 1)

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

params [["_offset", [0, 0], [[]], 2], ["_factors", [1, 1, 1, 1], [[]], 4]];
_offset params ["_offsetX", "_offsetY"];

private _display = CWH_DISPLAY;
if (isNull _display) exitWith {};

getResolution params ["_resW", "_resH"];

// UI units per design pixel (1080 design pixels = screen height)
private _pxH = safeZoneH / CWH_DESIGN_H;
private _pxW = safeZoneW / (CWH_DESIGN_H * (_resW / _resH));

// Visor: full height, real proportions, centered (cropped or letterboxed on the sides)
private _visorW = CWH_DESIGN_H * CWH_VISOR_RATIO * _pxW;
{
    _x ctrlSetPosition [safeZoneX + (safeZoneW - _visorW) / 2, safeZoneY, _visorW, safeZoneH];
    _x ctrlCommit 0;
} forEach [CWH_CTRL_FRAME, CWH_CTRL_COLOR, CWH_CTRL_CRACK];

// Info elements
private _scale = GVAR(scale);
private _opacity = GVAR(opacity);
private _unitW = _pxW * _scale;
private _unitH = _pxH * _scale;

{
    _x params ["_idc", "_block", "_anchorH", "_anchorV", "_posX", "_posY", "_width", "_height", ["_fontSize", 0]];

    private _control = _display displayCtrl _idc;
    _posX = _posX + _offsetX;
    _posY = _posY + _offsetY;

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
    _control ctrlSetFade (1 - _opacity * (_factors select _block));
    _control ctrlCommit 0;
} forEach [
    // idc, block, anchor H, anchor V, x, y, width, height, font size (design pixels, 1920x1080 canvas)

    // Weapon (top right): 320x160 block at 1576,24
    [1010, CWH_BLOCK_WEAPON, "R", "T", 1576, 24, 320, 160],     // Frame
    [1013, CWH_BLOCK_WEAPON, "R", "T", 1612, 33, 250, 22, 18],  // Name
    [1011, CWH_BLOCK_WEAPON, "R", "T", 1590, 64, 140, 60],      // Icon
    [1016, CWH_BLOCK_WEAPON, "R", "T", 1736, 60, 146, 64, 56],  // Rounds left
    [1012, CWH_BLOCK_WEAPON, "R", "T", 1590, 132, 292, 6],      // Ammo bar
    [10161, CWH_BLOCK_WEAPON, "R", "T", 1590, 148, 20, 6],      // Fire mode bars
    [10162, CWH_BLOCK_WEAPON, "R", "T", 1615, 148, 20, 6],
    [10163, CWH_BLOCK_WEAPON, "R", "T", 1640, 148, 20, 6],
    [10164, CWH_BLOCK_WEAPON, "R", "T", 1665, 148, 20, 6],
    [10165, CWH_BLOCK_WEAPON, "R", "T", 1690, 148, 20, 6],
    [1015, CWH_BLOCK_WEAPON, "R", "T", 1792, 142, 42, 28, 22],  // Magazines left
    [1014, CWH_BLOCK_WEAPON, "R", "T", 1838, 142, 26, 26],      // Magazine icon

    // Grenade (under the weapon): 128x64 block at 1768,194
    [1020, CWH_BLOCK_GRENADE, "R", "T", 1768, 194, 128, 64],     // Frame
    [1022, CWH_BLOCK_GRENADE, "R", "T", 1776, 204, 50, 44, 30],  // Count
    [1021, CWH_BLOCK_GRENADE, "R", "T", 1834, 203, 50, 46],      // Icon

    // Heading (top center, under the visor top piece): 192x48 block at 864,100
    [1030, CWH_BLOCK_HEADING, "C", "T", 864, 100, 192, 48],      // Frame
    [1031, CWH_BLOCK_HEADING, "C", "T", 884, 110, 152, 28, 22],  // Text

    // Health (top left): 256x64 block at 24,24, two rows (label, bar, value)
    [1040, CWH_BLOCK_HEALTH, "L", "T", 24, 24, 256, 64],         // Frame
    [1041, CWH_BLOCK_HEALTH, "L", "T", 38, 35, 76, 20, 14],      // Row 1 label
    [1042, CWH_BLOCK_HEALTH, "L", "T", 116, 42, 104, 6],         // Row 1 bar
    [1043, CWH_BLOCK_HEALTH, "L", "T", 220, 35, 50, 20, 15],     // Row 1 value
    [1044, CWH_BLOCK_HEALTH, "L", "T", 38, 57, 76, 20, 14],      // Row 2 label
    [1045, CWH_BLOCK_HEALTH, "L", "T", 116, 64, 104, 6],         // Row 2 bar
    [1046, CWH_BLOCK_HEALTH, "L", "T", 220, 57, 50, 20, 15]      // Row 2 value
];
