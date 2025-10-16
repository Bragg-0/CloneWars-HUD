#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_break
Description:
    Breaks the HUD for the player.

Parameters:
    https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#Dammaged

Returns:
    <NONE>

Examples
    (begin example)
        [] call cwh_hud_fnc_break
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

params ["_unit", "_hitSelection", "_damage", "_hitPartIndex", "_hitPoint", "_shooter", "_projectile"];

TRACE_1("fnc_break",_this);

if (_hitSelection isEqualTo "head") then {
    private _random = random 1;
    if (_random < GVAR(brokenChance)) then {
        player setVariable [QGVAR(broken), true, true];
        hint LLSTRING(broken);
    };
};
