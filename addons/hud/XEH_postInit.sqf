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
