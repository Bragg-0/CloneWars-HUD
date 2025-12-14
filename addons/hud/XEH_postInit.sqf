#include "script_component.hpp"

if (!hasInterface) exitWith {};

// Wait until the player is not null, then initialize the HUD
[{
    not isNull player
}, {
    [] call FUNC(init);
}] call CBA_fnc_waitUntilAndExecute;
