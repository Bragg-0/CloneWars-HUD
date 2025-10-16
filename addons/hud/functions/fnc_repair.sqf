#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_repair
Description:
    Repairs the HUD if it is broken.

Parameters:
    <NONE>

Returns:
    <NONE>

Examples
    (begin example)
        [player] call cwh_hud_fnc_repair
    (end)

Author:
    bragg
---------------------------------------------------------------------------- */

TRACE_1("fnc_repair",_this);

[
    LLSTRING(repairing),
    5, 
    {true},
    {
        player setVariable [QGVAR(broken), false, true];
        hint LLSTRING(repaired);
    }
] call CBA_fnc_progressBar;

player playActionNow "MedicOther";
