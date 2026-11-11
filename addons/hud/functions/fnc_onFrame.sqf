#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_onFrame
Description:
    Per-frame handler: decides whether the HUD is drawn and refreshes it.
    Cheap elements (compass, colors) are refreshed every frame, the others
    every CWH_SLOW_UPDATE_INTERVAL seconds.

Parameters:
    <NONE>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

// Mission start, respawn, team switch, selectPlayer...
if (player isNotEqualTo GVAR(unit)) then {
    [player, GVAR(unit)] call FUNC(onPlayerChanged);
};

private _type = [headgear player] call FUNC(getHelmetType);

// Power state: HUD enabled with a compatible helmet. Unlike the visibility, it does not change
// with the camera or the vehicle seat, so the on / off sounds are not played all the time.
private _powered = GVAR(enabled) && {_type != ""} && {alive player};
if (_powered isNotEqualTo GVAR(powered)) then {
    GVAR(powered) = _powered;
    if (GVAR(featureCamera) == "") then {
        [["shutdown", "boot"] select _powered] call FUNC(playSound);
    };
};

if !([_type] call FUNC(shouldShow)) exitWith {
    if (GVAR(visible)) then {
        [] call FUNC(hide);
    };
};

// (Re)creates the display if needed, e.g. after loading a savegame
if (isNull ([] call FUNC(getDisplay))) exitWith {};

if (!GVAR(visible) || {_type != GVAR(type)}) then {
    [_type] call FUNC(show);
};

[] call FUNC(updateCompass);

if (diag_tickTime >= GVAR(nextSlowUpdate)) then {
    GVAR(nextSlowUpdate) = diag_tickTime + CWH_SLOW_UPDATE_INTERVAL;

    // Screen resolution, interface size or HUD scale / opacity changed: recompute the layout
    private _layoutKey = [safeZoneW, safeZoneH, getResolution select 0, getResolution select 1, GVAR(scale), GVAR(opacity)];
    if (_layoutKey isNotEqualTo GVAR(layoutKey)) then {
        GVAR(layoutKey) = _layoutKey;
        [] call FUNC(layout);
    };

    [] call FUNC(updateWeapon);
    [] call FUNC(updateGrenade);
    [] call FUNC(updateHealth);
    [] call FUNC(updateSquad);

    {
        _x ctrlShow GVAR(showHeading);
    } forEach CWH_CTRL_DIR;

    CWH_CTRL_SUNFILTER ctrlShow GVAR(sunFilter);
    CWH_CTRL_CRACK ctrlShow (player getVariable [QGVAR(broken), false]);

    // Vanilla weapon info: hidden while our weapon block replaces it, in its original state otherwise.
    // Checked continuously as it can be changed behind our back (mission init, other scripts).
    private _shownHUD = shownHUD;
    private _showVanillaInfo = !GVAR(showWeapon) && {GVAR(savedInfo)};
    if ((_shownHUD select 1) isNotEqualTo _showVanillaInfo) then {
        _shownHUD set [1, _showVanillaInfo];
        showHUD _shownHUD;
    };
};

[] call FUNC(updateColor);

// Boot sequence, glitch
if (GVAR(animating)) then {
    [] call FUNC(animate);
};
