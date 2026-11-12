#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_getDisplay
Description:
    Returns the HUD display, creating it if it does not exist
    (first use, or after loading a savegame which destroys cutRsc displays).

Parameters:
    <NONE>

Returns:
    HUD display <DISPLAY>

Author:
    Bragg
---------------------------------------------------------------------------- */

private _display = CWH_DISPLAY;

if (isNull _display) then {
    TRACE_1("Creating HUD display",GVAR(layer));
    GVAR(layer) cutRsc [QGVAR(rscHUD), "PLAIN NOFADE", -1, false, false];
    _display = CWH_DISPLAY;

    // New display: start hidden, fnc_show will set it up
    {
        _x ctrlShow false;
    } forEach CWH_CTRL_ALL;
    GVAR(visible) = false;
    GVAR(layoutKey) = []; // Forces fnc_layout
};

_display
