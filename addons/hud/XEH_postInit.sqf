#include "script_component.hpp"

// Wait until the player is not null, then initialize the HUD
[{
    not isNull player
}, {
    [] call FUNC(init);
}] call CBA_fnc_waitUntilAndExecute;
