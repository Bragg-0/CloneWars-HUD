#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_updateNotifications
Description:
    Draws the notifications queued by fnc_notify (called every frame while
    the HUD is shown): fade in, fade out, removal when expired.

Parameters:
    <NONE>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

#define FADE_IN 0.15
#define FADE_OUT 0.5

private _now = diag_tickTime;
GVAR(notifications) = GVAR(notifications) select {(_x select 3) > _now};

{
    _x params ["_frame", "_textControl"];
    private _notification = GVAR(notifications) param [_forEachIndex, []];

    if (_notification isEqualTo []) then {
        _frame ctrlShow false;
        _textControl ctrlShow false;
    } else {
        _notification params ["_text", "_color", "_start", "_end"];
        private _alpha = (((_now - _start) / FADE_IN) min ((_end - _now) / FADE_OUT)) min 1;
        private _fade = 1 - _alpha * GVAR(notificationFactor);

        _frame ctrlShow true;
        _frame ctrlSetTextColor ([_color, GVAR(currentColor)] select (_color isEqualTo []));
        _frame ctrlSetFade _fade;
        _frame ctrlCommit 0;

        _textControl ctrlShow true;
        _textControl ctrlSetText _text;
        _textControl ctrlSetFade _fade;
        _textControl ctrlCommit 0;
    };
} forEach CWH_CTRL_NOTIFICATIONS;
