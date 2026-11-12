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
private _hudColor = GVAR(currentColor) select [0, 3]; // Includes the RGB cycle
private _teamColors = GVAR(squadTeamColors);
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

            private _color = _hudColor;
            if (_teamColors) then {
                _color = switch (assignedTeam _unit) do {
                    case "RED": {[1, 0.25, 0.25]};
                    case "GREEN": {[0.35, 1, 0.35]};
                    case "BLUE": {[0.35, 0.55, 1]};
                    case "YELLOW": {[1, 0.95, 0.3]};
                    default {_hudColor};
                };
            };
            private _alpha = _opacity * linearConversion [_fadeStart, _maxDistance, _distance, 1, 0, true];

            // Unconscious (vanilla or ACE): blinking orange
            if (lifeState _unit == "INCAPACITATED" || {_unit getVariable ["ACE_isUnconscious", false]}) then {
                _color = [CWH_COLOR_WARNING] select [0, 3];
                if (CWH_BLINK_OFF) then {
                    _alpha = _alpha * 0.35;
                };
            };

            drawIcon3D [
                QPATHTOEF(ui,data\hud\squad_marker_ca.paa),
                _color + [_alpha],
                _position,
                _size,
                _size,
                0,
                ""
            ];
        };
    };
} forEach GVAR(squadUnits);
