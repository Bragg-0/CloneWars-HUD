#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_getControls
Description:
    Returns a pool of HUD controls with consecutive idcs.

Parameters:
    0: _first - idc of the first control <NUMBER>
    1: _count - Number of controls <NUMBER>

Returns:
    Controls <ARRAY>

Author:
    Bragg
---------------------------------------------------------------------------- */

params ["_first", "_count"];

private _display = CWH_DISPLAY;
private _controls = [];
for "_idc" from _first to (_first + _count - 1) do {
    _controls pushBack (_display displayCtrl _idc);
};
_controls
