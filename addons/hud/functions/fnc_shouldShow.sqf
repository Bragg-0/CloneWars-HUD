#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_shouldShow
Description:
    Checks whether the HUD must be drawn for the local player.

Parameters:
    0: _type - HUD type of the current helmet <STRING>

Returns:
    True if the HUD must be drawn <BOOL>

Author:
    Bragg
---------------------------------------------------------------------------- */

params ["_type"];

// Player choice and helmet
if (!GVAR(enabled) || {_type == ""}) exitWith {false};

// Dead or unconscious
if (!alive player || {lifeState player == "INCAPACITATED"} || {player getVariable ["ACE_isUnconscious", false]}) exitWith {false};

// Zeus, Arsenal, spectator...
if (GVAR(featureCamera) != "" || {!isNull curatorCamera}) exitWith {false};

// Remote controlling a unit, drone or turret
if (isRemoteControlling player || {cameraOn != player && {cameraOn != objectParent player}}) exitWith {false};

// In a vehicle: only as passenger (cargo or FFV seat)
private _vehicle = objectParent player;
if (!isNull _vehicle && {
    fullCrew [_vehicle, "", false] findIf {(_x select 0) == player && {(_x select 1) == "cargo" || {_x select 4}}} == -1
}) exitWith {false};

// Night vision / thermal
if (GVAR(hideInVisionModes) && {currentVisionMode player != 0}) exitWith {false};

private _view = cameraView;

// Binoculars, laser designators, rangefinders
if (_view == "GUNNER" && {
    private _weapon = currentWeapon player;
    _weapon != "" && {_weapon == binocular player || {getNumber (configFile >> "CfgWeapons" >> _weapon >> "type") == 4096}}
}) exitWith {false};

switch (_view) do {
    case "INTERNAL";
    case "GUNNER": {true};
    case "EXTERNAL": {GVAR(enableThirdPerson)};
    default {false};
}
