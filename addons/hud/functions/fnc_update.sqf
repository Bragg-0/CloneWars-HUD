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

// Display HUD elements based on player's hud status, helmet type, and isn't in a vehicle or is a passenger
if (((headgear player) in GVAR(listOfAllHelmets)) && (player getVariable [QGVAR(active), GVAR(enableByDefault)]) && (isNull objectParent player || ((fullCrew [vehicle player,"cargo"] findIf {_x select 0 == player}) != -1))) then {

    private _activeAndUpdateHUD = {
        if ((isNull curatorCamera) && (isNull (uiNamespace getVariable ["BIS_fnc_arsenal_cam", objNull]))) then {
            // Activate HUD
            [] call FUNC(activate);

            // Update HUD color based on CBA setting
            private _hudColor = GVAR(color);
            if (GVAR(enableRGB)) then {
                private _alpha = _hudColor select 3;
                private _hue = diag_tickTime % 6;
                private _r = 0;
                private _g = 0;
                private _b = 0;
                switch (floor _hue) do {
                    case 0: {_r = 1; _g = _hue - 0; _b = 0;};
                    case 1: {_r = 2 - _hue; _g = 1; _b = 0;};
                    case 2: {_r = 0; _g = 1; _b = _hue - 2;};
                    case 3: {_r = 0; _g = 4 - _hue; _b = 1;};
                    case 4: {_r = _hue - 4; _g = 0; _b = 1;};
                    case 5: {_r = 1; _g = 0; _b = 6 - _hue;};
                };

                _hudColor = [_r, _g, _b, _alpha];
            };

            // Update HUD elements
            [] call FUNC(updateElementsDir);
            [_hudColor] call FUNC(updateElementsWeapon);
            [] call FUNC(updateElementsGrenade);

            // Update HUD type to adapt on helmet type
            private _currentHelmetType = GVAR(listOfAllHelmetsWithType) getOrDefault [(headgear player), "NONE"];
            CWH_CTRL_FRAME ctrlSetText FORMAT_1(QPATHTOEF(ui,data\hud\%1\frame_ca.paa),_currentHelmetType);
            CWH_CTRL_COLOR ctrlSetText FORMAT_1(QPATHTOEF(ui,data\hud\%1\color_ca.paa),_currentHelmetType);

            // Update colored elements to match HUD color
            {
                _x ctrlSetTextColor _hudColor;
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
