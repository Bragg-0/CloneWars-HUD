#include "script_component.hpp"

if (!hasInterface) exitWith {};

// Controls can't be serialized: the handled stamina bar control is kept in uiNamespace
uiNamespace setVariable [QGVAR(staminaBar), controlNull];
GVAR(staminaBarPosition) = [];      // Its original (ACE) position
GVAR(staminaBarMoved) = false;

// Move the ACE stamina bar out of the HUD weapon frame while the HUD is shown
[QEGVAR(hud,visibilityChanged), LINKFUNC(updateStaminaBar)] call CBA_fnc_addEventHandler;

// ACE may recreate the bar (respawn, settings change): check it from time to time
[LINKFUNC(updateStaminaBar), 1] call CBA_fnc_addPerFrameHandler;
