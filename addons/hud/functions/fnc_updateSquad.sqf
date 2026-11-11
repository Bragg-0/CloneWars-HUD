#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_updateSquad
Description:
    Refreshes the list of squad members drawn by fnc_drawSquad.

Parameters:
    <NONE>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

GVAR(squadUnits) = if (GVAR(showSquad)) then {
    (units group player) select {_x != player && {alive _x}}
} else {
    []
};
