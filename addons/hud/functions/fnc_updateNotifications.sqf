#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_updateNotifications
Description:
    Draws the notifications queued by fnc_notify (called every frame while
    the HUD is shown): centered under the compass, box width adapted to the
    text, fade in, fade out, removal when expired.

Parameters:
    <NONE>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

#define FADE_IN 0.15
#define FADE_OUT 0.5
#define ROW_HEIGHT 26
#define ROW_STEP 32
#define PADDING 18
#define MIN_WIDTH 140
#define MAX_WIDTH 640
#define FONT_SIZE 16

private _now = diag_tickTime;
GVAR(notifications) = GVAR(notifications) select {(_x select 3) > _now};

GVAR(notificationLayout) params ["_centerX", "_top", "_unitW", "_unitH"];

{
    private _controls = _x;
    private _notification = GVAR(notifications) param [_forEachIndex, []];

    if (_notification isEqualTo []) then {
        {
            _x ctrlShow false;
        } forEach _controls;
    } else {
        _notification params ["_text", "_color", "_start", "_end"];
        _controls params ["_box", "_accent", "_line", "_textControl"];

        if (_color isEqualTo []) then {
            _color = GVAR(currentColor);
        };
        private _alpha = (((_now - _start) / FADE_IN) min ((_end - _now) / FADE_OUT)) min 1;
        private _fade = 1 - (_alpha max 0) * GVAR(notificationFactor);

        _textControl ctrlSetText _text;
        _textControl ctrlSetFontHeight (FONT_SIZE * _unitH);
        private _width = ((ctrlTextWidth _textControl) + 2 * PADDING * _unitW) max (MIN_WIDTH * _unitW) min (MAX_WIDTH * _unitW);
        private _height = ROW_HEIGHT * _unitH;
        private _posX = _centerX - _width / 2;
        private _posY = _top + _forEachIndex * ROW_STEP * _unitH;

        _box ctrlSetPosition [_posX, _posY, _width, _height];
        _accent ctrlSetPosition [_posX, _posY, 3 * _unitW, _height];
        _accent ctrlSetBackgroundColor _color;
        _line ctrlSetPosition [_posX, _posY + _height - 1.5 * _unitH, _width, 1.5 * _unitH];
        _line ctrlSetBackgroundColor _color;
        _textControl ctrlSetPosition [_posX, _posY, _width, _height];

        {
            _x ctrlShow true;
            _x ctrlSetFade _fade;
            _x ctrlCommit 0;
        } forEach _controls;
    };
} forEach CWH_CTRL_NOTIFICATIONS;
