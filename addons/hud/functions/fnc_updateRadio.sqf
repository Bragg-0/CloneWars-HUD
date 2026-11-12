#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_updateRadio
Description:
    Updates the radio block from the registered radio providers (TFAR
    compatibility addon, or other mods). The first provider returning data
    is used. Up to 3 radios are shown, one row each.

    A provider is code registered with:
        cwh_hud_radioProviders pushBack {...};
    returning the list of radios of the player ([] if none), each as:
        [
            radio name <STRING>,
            channel / frequency <STRING>,
            transmitting <BOOL>,
            additional channel <STRING> (optional, "" if none),
            receiving <BOOL> (optional)
        ]

Parameters:
    <NONE>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

private _radios = [];
if (GVAR(showRadio)) then {
    {
        private _result = call _x;
        if (_result isEqualType [] && {_result isNotEqualTo []}) exitWith {
            _radios = _result;
        };
    } forEach GVAR(radioProviders);
};

GVAR(radioStates) = [];

{
    private _controls = _x;
    private _radio = _radios param [_forEachIndex, []];

    if (_radio isEqualTo []) then {
        {
            _x ctrlShow false;
        } forEach _controls;
        GVAR(radioStates) pushBack CWH_RADIO_IDLE;
    } else {
        _radio params [
            ["_name", "", [""]],
            ["_channel", "", [""]],
            ["_transmitting", false, [false]],
            ["_additional", "", [""]],
            ["_receiving", false, [false]]
        ];
        _controls params ["", "_nameControl", "_channelControl", "", "_additionalControl"];

        {
            _x ctrlShow true;
        } forEach _controls;
        _nameControl ctrlSetText _name;
        _channelControl ctrlSetText _channel;
        _additionalControl ctrlSetText _additional;

        GVAR(radioStates) pushBack (switch (true) do {
            case _transmitting: {CWH_RADIO_TRANSMITTING};
            case _receiving: {CWH_RADIO_RECEIVING};
            default {CWH_RADIO_IDLE};
        });
    };
} forEach CWH_CTRL_RADIO_ROWS;
