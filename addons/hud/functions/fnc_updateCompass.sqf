#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_updateCompass
Description:
    Updates the compass, following where the player looks: scrolls the
    graduated strip, writes the heading value and places the markers
    (squad members, waypoint) on the strip.

    The strip covers -60 to 420 degrees at 4 design px per degree and the
    window shows 120 degrees (480 design px), see tools/generate_textures.ps1.

Parameters:
    <NONE>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

#define PX_PER_DEGREE 4
#define WINDOW_W 480
#define WINDOW_H 30
#define HALF_FOV 58 // Markers are hidden a bit before the edge of the window

if (!GVAR(showHeading)) exitWith {};

private _vector = (positionCameraToWorld [0, 0, 1]) vectorDiff (positionCameraToWorld [0, 0, 0]);
private _heading = (((_vector select 0) atan2 (_vector select 1)) + 360) % 360;

GVAR(layoutUnit) params ["_unitW", "_unitH"];
// The compass is drawn smaller than the other blocks
_unitW = _unitW * CWH_COMPASS_SCALE;
_unitH = _unitH * CWH_COMPASS_SCALE;

// Strip: heading h is at strip x = (h + 60) * 4, the center of the window is at 240
private _strip = CWH_CTRL_COMPASS_STRIP;
_strip ctrlSetPosition [-_heading * PX_PER_DEGREE * _unitW, 0, 1920 * _unitW, WINDOW_H * _unitH];
_strip ctrlCommit 0;

CWH_CTRL_DIR_INFO ctrlSetText format ["%1°", (round _heading) % 360];

// Places a marker at a bearing, hides it if out of the window. Returns true if visible.
private _fnc_place = {
    params ["_control", "_bearing", "_width", "_height", "_posY"];
    private _delta = ((_bearing - _heading + 540) % 360) - 180;
    if (abs _delta > HALF_FOV) exitWith {
        _control ctrlShow false;
        false
    };
    _control ctrlShow true;
    _control ctrlSetPosition [
        (WINDOW_W / 2 + _delta * PX_PER_DEGREE - _width / 2) * _unitW,
        _posY * _unitH,
        _width * _unitW,
        _height * _unitH
    ];
    _control ctrlCommit 0;
    true
};

// Waypoint (position chosen by fnc_updateSquad)
private _waypoint = CWH_CTRL_COMPASS_WAYPOINT;
if (GVAR(compassWaypoint) isEqualTo []) then {
    _waypoint ctrlShow false;
} else {
    [_waypoint, player getDir GVAR(compassWaypoint), 12, 12, 16] call _fnc_place;
};

// Squad members: small bars at the bottom of the strip
private _hudColor = GVAR(currentColor);
private _squad = [[], GVAR(squadUnits)] select GVAR(compassSquad);
{
    private _unit = _squad param [_forEachIndex, objNull];
    if (isNull _unit || {vehicle _unit == vehicle player}) then {
        _x ctrlShow false;
    } else {
        if ([_x, player getDir _unit, 3, 9, 19] call _fnc_place) then {
            private _color = _hudColor;
            if (lifeState _unit == "INCAPACITATED" || {_unit getVariable ["ACE_isUnconscious", false]}) then {
                _color = [[CWH_COLOR_WARNING_DIM], [CWH_COLOR_WARNING]] select CWH_BLINK_ON;
            };
            _x ctrlSetBackgroundColor _color;
        };
    };
} forEach CWH_CTRL_COMPASS_SQUAD;
