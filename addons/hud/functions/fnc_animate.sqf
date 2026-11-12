#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_animate
Description:
    Plays the HUD effects, called every frame while GVAR(animating) is true:
    - Boot sequence: the blocks light up one after the other, flickering.
    - Glitch: the blocks shake and flicker for a short time.
    When no effect is left, restores the normal layout and stops.

Parameters:
    <NONE>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

private _now = diag_tickTime;
private _active = false;
private _offset = [0, 0];
private _factors = [];
_factors resize [CWH_BLOCK_COUNT, 1];
private _colorFade = 0;

// Boot sequence
if (GVAR(bootStart) >= 0) then {
    private _elapsed = _now - GVAR(bootStart);
    if (_elapsed > CWH_BOOT_STAGGER * 3 + CWH_BOOT_FADE) then {
        GVAR(bootStart) = -1;
    } else {
        _active = true;
        // Lighting order of each block (see CWH_BLOCK_*): weapon, grenade, heading, health, radio, notifications
        _factors = [0, 1, 2, 3, 1.5, 2] apply {
            private _progress = (((_elapsed - _x * CWH_BOOT_STAGGER) / CWH_BOOT_FADE) max 0) min 1;
            // Flicker while lighting up
            if (_progress < 1 && {random 1 < 0.35}) then {_progress * 0.3} else {_progress}
        };
        // The colored part of the visor lights up first
        private _colorProgress = (_elapsed / CWH_BOOT_FADE) min 1;
        _colorFade = 1 - ([_colorProgress, _colorProgress * 0.4] select (_colorProgress < 1 && {random 1 < 0.3}));
    };
};

// Glitch
if (_now < GVAR(glitchEnd)) then {
    _active = true;
    _offset = [(random 16) - 8, (random 6) - 3];
    _factors = _factors apply {
        if (random 1 < 0.4) then {_x * (0.2 + random 0.5)} else {_x}
    };
};

[_offset, _factors] call FUNC(layout);

CWH_CTRL_COLOR ctrlSetFade _colorFade;
CWH_CTRL_COLOR ctrlCommit 0;

// Nothing left to play: the call above restored the normal layout
if (!_active) then {
    GVAR(animating) = false;
};
