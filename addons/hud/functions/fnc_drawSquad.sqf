#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_drawSquad
Description:
    "Draw3D" handler: draws a small marker (icon only) above each member of
    the player's group while the HUD is shown.
    The marker takes the HUD color (or, if enabled in the settings, the color
    of the member's team: red, green, blue, yellow) and blinks orange if the
    member is unconscious. It fades out near the maximum distance.

Parameters:
    <NONE>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

if (!GVAR(visible) || {!GVAR(showSquad)}) exitWith {};

private _maxDistance = GVAR(squadMaxDistance);
private _fadeStart = _maxDistance * 0.7;
private _vehicle = vehicle player;
private _opacity = GVAR(opacity);
private _size = 0.5 * GVAR(scale);

{
    private _unit = _x;

    // Members sharing the player's vehicle are not marked
    if (alive _unit && {vehicle _unit != _vehicle}) then {
        private _distance = player distance _unit;
        if (_distance <= _maxDistance) then {
            private _position = if (isNull objectParent _unit) then {
                _unit modelToWorldVisual ((_unit selectionPosition "head") vectorAdd [0, 0, 0.45])
            } else {
                (ASLToAGL eyePos _unit) vectorAdd [0, 0, 0.45]
            };

            // HUD or team color, blinking orange if unconscious
            ([_unit] call FUNC(getSquadColor)) params ["_red", "_green", "_blue", ["_colorAlpha", 1]];
            private _alpha = _colorAlpha * _opacity * linearConversion [_fadeStart, _maxDistance, _distance, 1, 0, true];

            drawIcon3D [
                QPATHTOEF(ui,data\hud\squad_marker_ca.paa),
                [_red, _green, _blue, _alpha],
                _position,
                _size,
                _size,
                0,
                ""
            ];
        };
    };
} forEach GVAR(squadUnits);
