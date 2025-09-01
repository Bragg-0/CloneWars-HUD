#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_setup
Description:
    Sets up the HUD for the player.

Parameters:
    _player - The player object <OBJECT>

Returns:
    <NONE>

Examples
    (begin example)
        [_player] call cwh_hud_fnc_setup
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

params [
    ["_player", objNull, [objNull]]
];

TRACE_1("fnc_setup",_this);

// Check if the HUD is already set up for the player and delete it if necessary
if (_player getVariable [QGVAR(hudSetup), false]) then {
    (QGVAR(rscHUD) call BIS_fnc_rscLayer) cutText ["", "PLAIN NOFADE"];
};

// Create the HUD
(QGVAR(rscHUD) call BIS_fnc_rscLayer) cutRsc [QGVAR(rscHUD), "PLAIN NOFADE", -1, false, true];
[_player] call FUNC(update);

// Set the HUD setup variable to true
_player setVariable [QGVAR(hudSetup), true, true];

// Check if the variable exists and delete old event handlers
private _ehIds = _player getVariable [QGVAR(setupHandler), []];
if (_ehIds != []) then {
    ["loadout", _ehIds#0] call CBA_fnc_removePlayerEventHandler;
    ["weapon", _ehIds#1] call CBA_fnc_removePlayerEventHandler;
    ["weaponMode", _ehIds#2] call CBA_fnc_removePlayerEventHandler;
    ["vehicle", _ehIds#3] call CBA_fnc_removePlayerEventHandler;
    ["featureCamera", _ehIds#4] call CBA_fnc_removePlayerEventHandler;
    ["cameraView", _ehIds#5] call CBA_fnc_removePlayerEventHandler;
};

// Add event handler for loadout changes
private _ehLoadout = [
    "loadout",
    {
        params ["_player"];
        [_player] call FUNC(update);
    }
] call CBA_fnc_addPlayerEventHandler;

// Add event handler for weapon changes
private _ehWeapon = [
    "weapon",
    {
        params ["_player"];
        [_player] call FUNC(update);
    }
] call CBA_fnc_addPlayerEventHandler;

// Add event handler for weapon mode changes
private _ehWeaponMode = [
    "weaponMode",
    {
        params ["_player"];
        [_player] call FUNC(update);
    }
] call CBA_fnc_addPlayerEventHandler;

// Add event handler for vehicle changes
private _ehVehicle = [
    "vehicle",
    {
        params ["_player"];
        [_player] call FUNC(update);
    }
] call CBA_fnc_addPlayerEventHandler;

// Add event handler for feature camera changes
private _ehFeatureCamera = [
    "featureCamera",
    {
        params ["_player"];
        [_player] call FUNC(update);
    }
] call CBA_fnc_addPlayerEventHandler;

// Add event handler for camera view changes
private _ehCameraView = [
    "cameraView",
    {
        params ["_player"];
        [_player] call FUNC(update);
    }
] call CBA_fnc_addPlayerEventHandler;

// Store the event handler IDs
_player setVariable [QGVAR(setupHandler), [_ehLoadout, _ehWeapon, _ehWeaponMode, _ehVehicle, _ehFeatureCamera, _ehCameraView], true];
