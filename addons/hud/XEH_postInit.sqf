#include "script_component.hpp"

if (!hasInterface) exitWith {};

// Player preferences, kept across respawns (settings are initialized at this point)
GVAR(enabled) = GVAR(enableByDefault);
GVAR(sunFilter) = GVAR(sunFilterByDefault);

GVAR(layer) = QGVAR(rscHUD) call BIS_fnc_rscLayer;

// Zeus, Arsenal (BI & ACE), spectators...
["featureCamera", {
    params ["", "_camera"];
    GVAR(featureCamera) = _camera;
}, true] call CBA_fnc_addPlayerEventHandler;

[LINKFUNC(onFrame)] call CBA_fnc_addPerFrameHandler;

// Squad markers
addMissionEventHandler ["Draw3D", {[] call FUNC(drawSquad)}];

// Remote control of the local player HUD (Zeus modules, mission scripts):
//   ["cwh_hud_notify", [text, type, duration], _unit] call CBA_fnc_targetEvent;
//   ["cwh_hud_setEnabled", [enabled], _unit] call CBA_fnc_targetEvent;
//   ["cwh_hud_setBroken", [_unit, broken], _unit] call CBA_fnc_targetEvent;
[QGVAR(notify), LINKFUNC(notify)] call CBA_fnc_addEventHandler;
[QGVAR(setEnabled), LINKFUNC(setEnabled)] call CBA_fnc_addEventHandler;
[QGVAR(setBroken), LINKFUNC(setBroken)] call CBA_fnc_addEventHandler;
