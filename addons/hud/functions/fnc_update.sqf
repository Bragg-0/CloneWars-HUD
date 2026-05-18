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

// Get helmet type (cached)
private _currentHelmetType = [headgear player] call FUNC(getHelmetType);
private _cameraView = cameraView;
private _currentWeapon = currentWeapon player;
private _shouldDraw = false;

// Determine if HUD should be drawn based on various conditions
private _isHudEnabled = player getVariable [QGVAR(active), GVAR(enableByDefault)]; // Check if HUD is enabled for the player
private _hasHudHelmet = _currentHelmetType != "NONE"; // Check if player is wearing a helmet that supports the HUD
private _isPassengerOrOnFoot = isNull objectParent player || {fullCrew [vehicle player, "cargo"] findIf {_x select 0 == player} != -1}; // Check if player is on foot or a passenger in a vehicle
private _isInZeus = !isNull curatorCamera; // Check if player is in Zeus mode
private _isInArsenal = !isNull (uiNamespace getVariable ["BIS_fnc_arsenal_cam", objNull]); // Check if player is in Arsenal
private _isUsingRemoteControl = isRemoteControlling player; // Check if player is using remote control (e.g., UAV)
private _isUsingBinocularOptic = (_cameraView == "GUNNER" && {_currentWeapon == binocular player || {getNumber (configFile >> "CfgWeapons" >> _currentWeapon >> "type") == 4096}}); // Check if player is using binoculars or a weapon with a binocular optic
private _isUsingAltVision = currentVisionMode player != 0; // Check if player is using any alternative vision mode (e.g., night vision, thermal)

if (
    _isHudEnabled
    && {_hasHudHelmet}
    && {_isPassengerOrOnFoot}
    && {!_isInZeus}
    && {!_isInArsenal}
    && {!_isUsingRemoteControl}
    && {!_isUsingBinocularOptic}
    && {!_isUsingAltVision}
) then {
    switch (_cameraView) do {
        case "INTERNAL";
        case "GUNNER": {
            _shouldDraw = true;
            };
        case "EXTERNAL": {
            if (GVAR(enableThirdPerson)) then {
                _shouldDraw = true;
            };
        };
        default {
            _shouldDraw = false;
        };
    };
};

if (GVAR(hudForceUpdate)) then {
    GVAR(hudForceUpdate) = false;
    GVAR(hudActive) = !_shouldDraw;
};

if (_shouldDraw) then {
    // Activate HUD if not already active
    if !(GVAR(hudActive)) then {
        [] call FUNC(activate);
        GVAR(hudActive) = true;
    };

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

    // Update SunFilter
    CWH_CTRL_SUNFILTER ctrlShow (player getVariable [QGVAR(enableSunFilter), GVAR(enableByDefault)]);
    
    // Update Crack
    CWH_CTRL_CRACK ctrlShow (player getVariable [QGVAR(broken), false]);

    // Update HUD type to adapt on helmet type
    CWH_CTRL_FRAME ctrlSetText FORMAT_1(QPATHTOEF(ui,data\hud\%1\frame_ca.paa),_currentHelmetType);
    CWH_CTRL_COLOR ctrlSetText FORMAT_1(QPATHTOEF(ui,data\hud\%1\color_ca.paa),_currentHelmetType);

    // Update colored elements to match HUD color
    {
        _x ctrlSetTextColor _hudColor;
    } forEach CWH_CTRL_COLORED;
} else {
    // Deactivate HUD if active
    if (GVAR(hudActive)) then {
        [] call FUNC(deactivate);
        GVAR(hudActive) = false;
    };
};
