#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_playSound
Description:
    Plays a HUD sound (only heard by the local player), if sounds are enabled
    in the settings.

Parameters:
    0: _sound - Sound name: "boot", "shutdown", "glitch", "warning", "alert" or "confirm" <STRING>

Returns:
    <NONE>

Examples
    (begin example)
        ["alert"] call cwh_hud_fnc_playSound
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

params [["_sound", "", [""]]];

if (!GVAR(enableSounds) || {GVAR(soundVolume) <= 0}) exitWith {};

playSoundUI [format [QGVAR(%1), _sound], GVAR(soundVolume)];
