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
    1: _factors - Opacity factor (0..1) of each block (see CWH_BLOCK_*) <ARRAY> (default: all 1)

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

params [["_offset", [0, 0], [[]], 2], ["_factors", [], [[]]]];
if (count _factors != CWH_BLOCK_COUNT) then {
    _factors = [];
    _factors resize [CWH_BLOCK_COUNT, 1];
};
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
private _opacity = GVAR(opacity);
private _unitW = _pxW * GVAR(scale);
private _unitH = _pxH * GVAR(scale);
private _font = GVAR(font);

// --- Elements positioned by script every frame -----------------------------------------

// Compass: its own size setting on top of the HUD scale, reduced if it would overlap the side blocks
// (narrow screens, big HUD scale): the side blocks take 312 design px (weapon), the compass half is 256.
private _screenHalf = CWH_DESIGN_H * (_resW / _resH) / 2;
private _maxCompassScale = ((_screenHalf / GVAR(scale)) - 312 - 12) / 256;
private _compassScale = (GVAR(compassScale) min _maxCompassScale) max 0.5;
GVAR(compassUnit) = [_unitW * _compassScale, _unitH * _compassScale];
GVAR(compassAlpha) = _opacity * (_factors select CWH_BLOCK_HEADING);

// Notifications: stacked under the compass, centered, width adapted to the text by fnc_updateNotifications
GVAR(notificationFactor) = _opacity * (_factors select CWH_BLOCK_NOTIFICATIONS);
GVAR(notificationLayout) = [
    safeZoneX + safeZoneW / 2 + _offsetX * _unitW,
    safeZoneY + (8 + 64 * _compassScale + 8 + _offsetY) * _unitH,
    _unitW,
    _unitH
];
{
    (_x select 3) ctrlSetFont _font;
} forEach CWH_CTRL_NOTIFICATIONS;

// --- Elements positioned here --------------------------------------------------------------
// [idc, block, anchor H, anchor V, x, y, width, height, font size] (design pixels, 1920x1080 canvas)

private _elements = [
    // Weapon (top right): 288x120 block at 1608,24 (texture 288x144)
    [1010, CWH_BLOCK_WEAPON, "R", "T", 1608, 24, 288, 144],      // Frame
    [1013, CWH_BLOCK_WEAPON, "R", "T", 1638, 31, 220, 20, 16],   // Name
    [1011, CWH_BLOCK_WEAPON, "R", "T", 1622, 58, 130, 50],       // Icon
    [1016, CWH_BLOCK_WEAPON, "R", "T", 1754, 54, 128, 54, 44],   // Rounds left
    [1012, CWH_BLOCK_WEAPON, "R", "T", 1622, 114, 260, 5],       // Ammo bar
    [10161, CWH_BLOCK_WEAPON, "R", "T", 1622, 126, 18, 5],       // Fire mode bars
    [10162, CWH_BLOCK_WEAPON, "R", "T", 1644, 126, 18, 5],
    [10163, CWH_BLOCK_WEAPON, "R", "T", 1666, 126, 18, 5],
    [10164, CWH_BLOCK_WEAPON, "R", "T", 1688, 126, 18, 5],
    [10165, CWH_BLOCK_WEAPON, "R", "T", 1710, 126, 18, 5],
    [1015, CWH_BLOCK_WEAPON, "R", "T", 1794, 119, 40, 20, 16],   // Magazines left
    [1014, CWH_BLOCK_WEAPON, "R", "T", 1838, 118, 22, 22],       // Magazine icon

    // Grenade (under the weapon): 128x64 block at 1768,154
    [1020, CWH_BLOCK_GRENADE, "R", "T", 1768, 154, 128, 64],     // Frame
    [1022, CWH_BLOCK_GRENADE, "R", "T", 1774, 158, 54, 30, 26],  // Count
    [1024, CWH_BLOCK_GRENADE, "R", "T", 1772, 188, 58, 18, 12],  // Short name
    [1021, CWH_BLOCK_GRENADE, "R", "T", 1834, 160, 50, 42],      // Icon
    [1023, CWH_BLOCK_GRENADE, "R", "T", 1840, 206, 38, 3],       // Smoke / chemlight color

    // Compass (top center, at the top of the screen): 512x64 design scaled by the compass size setting
    [1030, CWH_BLOCK_HEADING, "C", "T", 960 - 256 * _compassScale, 8, 512 * _compassScale, 64 * _compassScale],
    [1032, CWH_BLOCK_HEADING, "C", "T", 960 - 240 * _compassScale, 8 + 3 * _compassScale, 480 * _compassScale, 30 * _compassScale],
    [1031, CWH_BLOCK_HEADING, "C", "T", 960 - 40 * _compassScale, 8 + 34 * _compassScale, 80 * _compassScale, 22 * _compassScale, 18 * _compassScale],

    // Health (top left): 256x64 block at 24,24, two rows (label, bar, value)
    [1040, CWH_BLOCK_HEALTH, "L", "T", 24, 24, 256, 64],         // Frame
    [1041, CWH_BLOCK_HEALTH, "L", "T", 38, 35, 76, 20, 14],      // Row 1 label
    [1042, CWH_BLOCK_HEALTH, "L", "T", 116, 42, 104, 6],         // Row 1 bar
    [1043, CWH_BLOCK_HEALTH, "L", "T", 220, 35, 50, 20, 15],     // Row 1 value
    [1044, CWH_BLOCK_HEALTH, "L", "T", 38, 57, 76, 20, 14],      // Row 2 label
    [1045, CWH_BLOCK_HEALTH, "L", "T", 116, 64, 104, 6],         // Row 2 bar
    [1046, CWH_BLOCK_HEALTH, "L", "T", 220, 57, 50, 20, 15]      // Row 2 value
];

// Radio: up to 3 rows of 192x48, 54 px apart, where chosen in the settings
// Row content: frame, name, channel, transmit / receive indicator, additional channel (right of the name)
{
    private _first = CWH_RADIO_IDC + 5 * _forEachIndex;
    _x params ["_anchorH", "_anchorV", "_rowX", "_rowY"];
    _elements append [
        [_first, CWH_BLOCK_RADIO, _anchorH, _anchorV, _rowX, _rowY, 192, 48],
        [_first + 1, CWH_BLOCK_RADIO, _anchorH, _anchorV, _rowX + 14, _rowY + 4, 146, 18, 14],
        [_first + 2, CWH_BLOCK_RADIO, _anchorH, _anchorV, _rowX + 14, _rowY + 24, 146, 22, 17],
        [_first + 3, CWH_BLOCK_RADIO, _anchorH, _anchorV, _rowX + 166, _rowY + 16, 8, 18],
        [_first + 4, CWH_BLOCK_RADIO, _anchorH, _anchorV, _rowX + 14, _rowY + 4, 146, 18, 14]
    ];
} forEach (switch (GVAR(radioPosition)) do {
    // Bottom right corner, first radio at the bottom
    case "bottomRight": {[0, 1, 2] apply {["R", "B", 1704, 1080 - 24 - 48 - 54 * _x]}};
    // Left, under the health block (and the ACE stamina bar)
    case "left": {[0, 1, 2] apply {["L", "T", 24, 120 + 54 * _x]}};
    // Top right, under the grenade block
    default {[0, 1, 2] apply {["R", "T", 1704, 228 + 54 * _x]}};
});

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
        _control ctrlSetFont _font;
        _control ctrlSetFontHeight (_fontSize * _unitH);
    };
    _control ctrlSetFade (1 - _opacity * (_factors select _block));
    _control ctrlCommit 0;
} forEach _elements;
