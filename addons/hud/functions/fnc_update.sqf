#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_update
Description:
    Updates the HUD elements for the player.

Parameters:
    <NONE>

Returns:
    <NONE>

Examples
    (begin example)
        [] call cwh_hud_fnc_update
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

// Display HUD elements based on player's hud status and headgear
if (((headgear player) in GVAR(listOfAllHelmets)) && (player getVariable [QGVAR(active), GVAR(enableByDefault)])) then {

    private _activeAndUpdateHUD = {
        if ((isNull curatorCamera) && (isNull (uiNamespace getVariable ["BIS_fnc_arsenal_cam", objNull]))) then {
            // Activate HUD
            [] call FUNC(activate);

            // Update HUD elements
            [] call FUNC(updateElementsDir);
            [] call FUNC(updateElementsWeapon);
            [] call FUNC(updateElementsGrenade);

            // Update HUD type to adapt on helmet type
            private _currentHelmetType = GVAR(listOfAllHelmetsWithType) getOrDefault [(headgear player), "NONE"];
            CWH_CTRL_FRAME ctrlSetText FORMAT_1(QPATHTOEF(ui,data\hud\%1\frame_ca.paa),_currentHelmetType);
            CWH_CTRL_COLOR ctrlSetText FORMAT_1(QPATHTOEF(ui,data\hud\%1\color_ca.paa),_currentHelmetType);

            // Update HUD color based on CBA setting
            { 
                _x ctrlSetTextColor GVAR(color);
            } forEach CWH_CTRL_COLORED;
        } else {
            // Deactivate HUD
            [] call FUNC(deactivate);
        };
    };

    // Check if third person is disabled to show HUD only in first person
    switch (cameraView) do {
        case "INTERNAL";
        case "GUNNER": {
            // Activate and update HUD
            [] call _activeAndUpdateHUD
        };
        case "EXTERNAL": {
            if (GVAR(enableThirdPerson)) then {
                // Activate and update HUD
                [] call _activeAndUpdateHUD
            } else {
                // Deactivate HUD
                [] call FUNC(deactivate);
            };
        };
        default {
            // Deactivate HUD
            [] call FUNC(deactivate);
        };
    };

} else {
    // Deactivate HUD
    [] call FUNC(deactivate);
};
