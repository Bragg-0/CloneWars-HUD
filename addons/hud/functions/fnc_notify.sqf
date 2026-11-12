#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_notify
Description:
    Shows a notification on the HUD of the local player, under the compass.
    Up to 3 notifications are stacked, the newest on top.
    If the HUD is not shown (no compatible helmet, HUD disabled...) or the
    notifications are disabled, a CBA notification is used instead.

    Other machines can send one with the CBA event "cwh_hud_notify":
        ["cwh_hud_notify", ["Text", "warning"], _unit] call CBA_fnc_targetEvent;

Parameters:
    0: _text - Text <STRING>
    1: _type - "info", "warning", "alert" or "success" <STRING> (default: "info")
    2: _duration - Duration in seconds, -1 for the setting value <NUMBER> (default: -1)

Returns:
    <NONE>

Examples
    (begin example)
        ["Extraction in 5 minutes", "warning"] call cwh_hud_fnc_notify
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

params [["_text", "", [""]], ["_type", "info", [""]], ["_duration", -1, [0]]];

if (_text == "") exitWith {};
if (_duration < 0) then {
    _duration = GVAR(notificationDuration);
};

private _color = switch (toLowerANSI _type) do {
    case "warning": {[CWH_COLOR_WARNING]};
    case "alert": {[CWH_COLOR_EMPTY]};
    case "success": {[CWH_COLOR_SUCCESS]};
    default {[]}; // HUD color, resolved when drawn (follows the RGB cycle)
};

private _sound = switch (toLowerANSI _type) do {
    case "warning": {"warning"};
    case "alert": {"alert"};
    case "success": {"confirm"};
    default {""};
};
if (_sound != "") then {
    [_sound] call FUNC(playSound);
};

if (!GVAR(showNotifications) || {!GVAR(visible)}) exitWith {
    private _line = [_text, 1.1];
    if (_color isNotEqualTo []) then {
        _line pushBack _color;
    };
    _line call CBA_fnc_notify;
};

GVAR(notifications) insert [0, [[_text, _color, diag_tickTime, diag_tickTime + _duration]]];
GVAR(notifications) resize ((count GVAR(notifications)) min CWH_NOTIFICATION_MAX);
