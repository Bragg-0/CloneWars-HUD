#include "script_component.hpp"

if (!hasInterface) exitWith {};

GVAR(transmittingRadio) = []; // Radio the player is transmitting with: SR classname or LR [object, settings name]
GVAR(transmissions) = [];     // Transmissions of the other players: [[unit, frequency, code], ...]

// TFAR also raises its events as CBA events. Tangent pressed / released:
// [unit, radio, radio type, additional channel, pressed]
["TFAR_event_OnTangent", {
    params ["_unit", "_radio", "", ["_additional", false, [false]], ["_pressed", false, [false]]];
    if (_unit != player) exitWith {};

    GVAR(transmittingRadio) = [[], _radio] select _pressed;
    [] call FUNC(hideTfarHint);

    // Tell the other players which frequency is used, so their HUD can show the reception
    private _info = [_radio] call FUNC(getRadioInfo);
    if (_info isEqualTo []) exitWith {};
    _info params ["", "", "_frequency", "", "_additionalFrequency", "_code"];
    [QGVAR(transmission), [player, [_frequency, _additionalFrequency] select _additional, _code, _pressed]] call CBA_fnc_remoteEvent;
}] call CBA_fnc_addEventHandler;

// Transmission of another player started / stopped
[QGVAR(transmission), {
    params ["_unit", "_frequency", "_code", "_pressed"];
    GVAR(transmissions) = GVAR(transmissions) select {(_x select 0) != _unit};
    if (_pressed) then {
        GVAR(transmissions) pushBack [_unit, _frequency, _code];
    };
}] call CBA_fnc_addEventHandler;

// TFAR shows its own hint when switching radio or channel
{
    [_x, {[] call FUNC(hideTfarHint)}] call CBA_fnc_addEventHandler;
} forEach ["TFAR_event_OnSWchannelSet", "TFAR_event_OnLRchannelSet", "TFAR_event_OnSWChange", "TFAR_event_OnLRChange"];

// The TFAR transmitting hint is disabled while the HUD is shown, and restored when it is hidden
[QEGVAR(hud,visibilityChanged), {
    params ["_visible"];
    if (_visible && {GVAR(hideTfarHint)}) then {
        if (isNil QGVAR(savedTransmittingHint)) then {
            GVAR(savedTransmittingHint) = missionNamespace getVariable ["TFAR_showTransmittingHint", true];
        };
        TFAR_showTransmittingHint = false;
        [] call FUNC(hideTfarHint);
    } else {
        if (!isNil QGVAR(savedTransmittingHint)) then {
            TFAR_showTransmittingHint = GVAR(savedTransmittingHint);
            GVAR(savedTransmittingHint) = nil;
        };
    };
}] call CBA_fnc_addEventHandler;

// Radio block of the HUD: every short range radio (active one first), then the active long range radio
EGVAR(hud,radioProviders) pushBack {
    // Transmissions of players who left or died are dropped
    GVAR(transmissions) = GVAR(transmissions) select {alive (_x select 0)};

    private _list = [];
    if (call TFAR_fnc_haveSWRadio) then {
        private _active = call TFAR_fnc_activeSwRadio;
        // radiosList takes the unit whose radios are listed (TFAR_currentUnit: player or remote controlled unit)
        _list = [_active] + (((missionNamespace getVariable ["TFAR_currentUnit", player]) call TFAR_fnc_radiosList) - [_active]);
    };
    if (call TFAR_fnc_haveLRRadio) then {
        _list pushBack (call TFAR_fnc_activeLrRadio);
    };
    // The long range radio is kept when there are more radios than rows
    if (count _list > 3) then {
        _list = (_list select [0, 2]) + [_list select -1];
    };

    private _radios = [];
    {
        private _radio = _x;
        private _info = [_radio] call FUNC(getRadioInfo);
        if (_info isNotEqualTo []) then {
            _info params ["_name", "_channel", "_frequency", "_additionalChannel", "_additionalFrequency", "_code"];
            private _receiving = GVAR(transmissions) findIf {
                _x params ["", "_txFrequency", "_txCode"];
                _txCode == _code && {_txFrequency == _frequency || {_additionalFrequency >= 0 && {_txFrequency == _additionalFrequency}}}
            } != -1;
            _radios pushBack [
                _name,
                format ["CH %1 | %2 MHz", _channel, _frequency],
                _radio isEqualTo GVAR(transmittingRadio),
                ["", format ["+CH %1 | %2", _additionalChannel, _additionalFrequency]] select (_additionalChannel > 0),
                _receiving
            ];
        };
    } forEach _list;
    _radios
};
