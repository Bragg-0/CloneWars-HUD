#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_compat_tfar_fnc_getRadioInfo
Description:
    Reads the state of a TFAR radio from its settings.

Parameters:
    0: _radio - Short range radio classname <STRING>, or long range radio [object, settings name] <ARRAY>

Returns:
    [] if the settings can't be read, otherwise:
    [
        name <STRING>,
        active channel (1 based) <NUMBER>, frequency <NUMBER>,
        additional channel (1 based, 0 if none) <NUMBER>, frequency (-1 if none) <NUMBER>,
        encryption code <STRING>
    ]

Author:
    Bragg
---------------------------------------------------------------------------- */

params ["_radio"];

private _isLR = _radio isEqualType [];
private _settings = if (_isLR) then {
    _radio call TFAR_fnc_getLrSettings
} else {
    _radio call TFAR_fnc_getSwSettings
};

// TFAR settings: [active channel, volume, frequencies, stereo, code, additional channel, ...]
if !(_settings isEqualType [] && {count _settings > 5}) exitWith {[]};
_settings params [["_active", 0, [0]], "", ["_frequencies", [], [[]]], "", ["_code", "", [""]], ["_additional", -1, [0]]];

private _name = if (_isLR) then {
    getText (configOf (_radio select 0) >> "displayName")
} else {
    getText (configFile >> "CfgWeapons" >> _radio >> "displayName")
};

private _fnc_frequency = {
    params ["_channel"];
    private _frequency = _frequencies param [_channel, ""];
    [parseNumber _frequency, _frequency] select (_frequency isEqualType 0)
};

[
    _name,
    _active + 1,
    [_active] call _fnc_frequency,
    [0, _additional + 1] select (_additional >= 0),
    [-1, [_additional] call _fnc_frequency] select (_additional >= 0),
    _code
]
