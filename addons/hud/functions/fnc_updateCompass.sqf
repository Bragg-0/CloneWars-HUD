#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_updateCompass
Description:
    Updates the compass, following where the player looks: graduations,
    labels, squad members and waypoint are placed in the window (480x30
    design px, 4 px per degree, 120 degrees visible) and fade out near its
    edges instead of being cut.

Parameters:
    <NONE>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

#define PX_PER_DEGREE 4
#define WINDOW_CENTER 240
#define VISIBLE 62    // Degrees from the center beyond which nothing is drawn
#define FADE_START 40 // Degrees from the center where elements start fading out
#define WAYPOINT_EDGE 54

if (!GVAR(showHeading)) exitWith {};

GVAR(compassUnit) params ["_unitW", "_unitH"];
// Layout not computed yet
if (_unitW <= 0 || {_unitH <= 0}) exitWith {};

private _vector = (positionCameraToWorld [0, 0, 1]) vectorDiff (positionCameraToWorld [0, 0, 0]);
private _heading = (((_vector select 0) atan2 (_vector select 1)) + 360) % 360;
// Camera not ready (mission start, loading)
if !(finite _heading) exitWith {};

CWH_CTRL_DIR_INFO ctrlSetText format ["%1°", (round _heading) % 360];

private _baseAlpha = GVAR(compassAlpha); // Opacity setting and boot animation, see fnc_layout
private _font = GVAR(font);

// Signed angle from the center of the compass, -180..180
private _fnc_delta = {
    ((_this - _heading + 540) % 360) - 180
};

// Hides a control. Also fully faded: showing the compass group again (HUD turned on) shows every control inside it.
private _fnc_hide = {
    _this ctrlShow false;
    _this ctrlSetFade 1;
    _this ctrlCommit 0;
};

// Places a control centered on an angle from the center; hidden out of the window, faded near its edges
private _fnc_place = {
    params ["_control", "_delta", "_width", "_height", "_posY", ["_alpha", 1]];
    if (abs _delta > VISIBLE) exitWith {
        _control call _fnc_hide;
    };
    private _edge = linearConversion [FADE_START, VISIBLE, abs _delta, 1, 0, true];
    _control ctrlShow true;
    _control ctrlSetPosition [
        (WINDOW_CENTER + _delta * PX_PER_DEGREE - _width / 2) * _unitW,
        _posY * _unitH,
        _width * _unitW,
        _height * _unitH
    ];
    _control ctrlSetFade (1 - _baseAlpha * _edge * _alpha);
    _control ctrlCommit 0;
};

// Graduations every 5 degrees
private _first = (ceil ((_heading - VISIBLE) / 5)) * 5;
{
    private _degree = _first + 5 * _forEachIndex;
    private _normalized = ((_degree % 360) + 360) % 360;
    switch (true) do {
        case (_normalized % 45 == 0): {[_x, _degree - _heading, 2, 11, 19] call _fnc_place};
        case (_normalized % 15 == 0): {[_x, _degree - _heading, 1.5, 7, 23, 0.85] call _fnc_place};
        default {[_x, _degree - _heading, 1, 4, 26, 0.6] call _fnc_place};
    };
} forEach CWH_CTRL_COMPASS_TICKS;

// Labels every 15 degrees: cardinal points, or degrees
_first = (ceil ((_heading - VISIBLE) / 15)) * 15;
{
    private _degree = _first + 15 * _forEachIndex;
    private _normalized = ((_degree % 360) + 360) % 360;
    _x ctrlSetFont _font;
    if (_normalized % 45 == 0) then {
        _x ctrlSetText (["N", "NE", "E", "SE", "S", "SW", "W", "NW"] select (_normalized / 45));
        _x ctrlSetFontHeight (13 * _unitH);
        [_x, _degree - _heading, 40, 16, 0] call _fnc_place;
    } else {
        _x ctrlSetText str _normalized;
        _x ctrlSetFontHeight (10 * _unitH);
        [_x, _degree - _heading, 40, 14, 3, 0.8] call _fnc_place;
    };
} forEach CWH_CTRL_COMPASS_LABELS;

// Waypoint: kept at the edge of the compass, dimmed, when it is out of view
private _waypoint = CWH_CTRL_COMPASS_WAYPOINT;
if (GVAR(compassWaypoint) isEqualTo []) then {
    _waypoint call _fnc_hide;
} else {
    private _delta = (player getDir GVAR(compassWaypoint)) call _fnc_delta;
    if (abs _delta > WAYPOINT_EDGE) then {
        [_waypoint, [-WAYPOINT_EDGE, WAYPOINT_EDGE] select (_delta > 0), 12, 12, 9, 0.5] call _fnc_place;
        // Not faded by the edge: always visible
        _waypoint ctrlSetFade (1 - _baseAlpha * 0.5);
        _waypoint ctrlCommit 0;
    } else {
        [_waypoint, _delta, 12, 12, 9] call _fnc_place;
    };
};

// Squad members: colored chevrons
private _squad = [[], GVAR(squadUnits)] select GVAR(compassSquad);
private _vehicle = vehicle player;
{
    private _unit = _squad param [_forEachIndex, objNull];
    if (isNull _unit || {!alive _unit} || {lifeState _unit in ["DEAD", "DEAD-RESPAWN", "DEAD-SWITCHING"]} || {vehicle _unit == _vehicle}) then {
        _x call _fnc_hide;
    } else {
        _x ctrlSetTextColor ([_unit] call FUNC(getSquadColor));
        [_x, (player getDir _unit) call _fnc_delta, 10, 10, 10] call _fnc_place;
    };
} forEach CWH_CTRL_COMPASS_SQUAD;
