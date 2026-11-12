#include "script_component.hpp"

if (!hasInterface) exitWith {};

// Controls can't be serialized: the handled stamina bar control is kept in uiNamespace
uiNamespace setVariable [QGVAR(staminaBar), controlNull];
GVAR(staminaBarPosition) = [];      // Its original (ACE) position
GVAR(staminaBarTarget) = [];        // Where we last put it

// Move the ACE stamina bar out of the HUD weapon block while the HUD is shown
[QEGVAR(hud,visibilityChanged), LINKFUNC(updateStaminaBar)] call CBA_fnc_addEventHandler;

// ACE may recreate the bar (respawn, settings change), HUD settings may change: check it from time to time
[LINKFUNC(updateStaminaBar), 1] call CBA_fnc_addPerFrameHandler;

// ACE medical handles damage itself: feed the HUD hit effects (glitch, crack) from its wound event
["ace_medical_woundReceived", {
    params ["_unit", ["_allDamages", [], [[]]]];
    if (_unit != player) exitWith {};

    // _allDamages: [[damage, body part], ...]
    private _isHeadHit = _allDamages findIf {
        _x isEqualType [] && {count _x > 1} && {(_x select 1) isEqualType ""} && {toLowerANSI (_x select 1) == "head"}
    } != -1;

    [_unit, _isHeadHit] call EFUNC(hud,onHit);
}] call CBA_fnc_addEventHandler;
