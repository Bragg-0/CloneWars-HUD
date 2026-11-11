#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_show
Description:
    Shows the HUD with the visor of the given type.
    Also used to switch type while the HUD is shown.

Parameters:
    0: _type - HUD type <STRING>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

params ["_type"];

TRACE_1("fnc_show",_type);

(GVAR(types) get _type) params ["_frame", "_color"];
CWH_CTRL_FRAME ctrlSetText _frame;
CWH_CTRL_COLOR ctrlSetText _color;
GVAR(type) = _type;

if (GVAR(visible)) exitWith {};

{
    _x ctrlShow true;
} forEach [CWH_CTRL_FRAME, CWH_CTRL_COLOR];

// Remember the state of the vanilla weapon info to restore it later (it is hidden by fnc_onFrame)
if (isNil QGVAR(savedInfo)) then {
    GVAR(savedInfo) = shownHUD select 1;
};

GVAR(visible) = true;
GVAR(nextSlowUpdate) = 0; // Info blocks, crack, vanilla info... updated this frame

if (GVAR(enableBootAnimation)) then {
    GVAR(bootStart) = diag_tickTime;
    GVAR(animating) = true;
};

[QGVAR(visibilityChanged), [true]] call CBA_fnc_localEvent;
