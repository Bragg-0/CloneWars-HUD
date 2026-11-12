#include "script_component.hpp"

if (!hasInterface) exitWith {};

// Zeus Enhanced modules, category "Clone Wars HUD". The HUD modules must be placed on a player.

private _category = LLSTRING(category);
private _icon = QPATHTOEF(ui,data\logo_ca.paa);

// Checks that a module was placed on a player, shows a message otherwise
GVAR(fnc_isPlayer) = {
    params ["_unit"];
    if (!isNull _unit && {_unit isKindOf "CAManBase"} && {isPlayer _unit}) exitWith {true};
    [LLSTRING(selectPlayer)] call zen_common_fnc_showMessage;
    false
};

[_category, LLSTRING(break), {
    params ["", "_unit"];
    if !([_unit] call GVAR(fnc_isPlayer)) exitWith {};
    [QEGVAR(hud,setBroken), [_unit, true], _unit] call CBA_fnc_targetEvent;
}, _icon] call zen_custom_modules_fnc_register;

[_category, LLSTRING(repair), {
    params ["", "_unit"];
    if !([_unit] call GVAR(fnc_isPlayer)) exitWith {};
    [QEGVAR(hud,setBroken), [_unit, false], _unit] call CBA_fnc_targetEvent;
}, _icon] call zen_custom_modules_fnc_register;

[_category, LLSTRING(enable), {
    params ["", "_unit"];
    if !([_unit] call GVAR(fnc_isPlayer)) exitWith {};
    [QEGVAR(hud,setEnabled), [true], _unit] call CBA_fnc_targetEvent;
}, _icon] call zen_custom_modules_fnc_register;

[_category, LLSTRING(disable), {
    params ["", "_unit"];
    if !([_unit] call GVAR(fnc_isPlayer)) exitWith {};
    [QEGVAR(hud,setEnabled), [false], _unit] call CBA_fnc_targetEvent;
}, _icon] call zen_custom_modules_fnc_register;

// Notification, with a recipients choice. Placed on a player, "this player" is selected by default.
[_category, LLSTRING(notify), {
    params ["", "_unit"];
    private _onPlayer = !isNull _unit && {isPlayer _unit};
    [
        LLSTRING(notify),
        [
            ["EDIT", LLSTRING(message), ""],
            ["COMBO", LLSTRING(type), [
                ["info", "warning", "alert", "success"],
                [LLSTRING(typeInfo), LLSTRING(typeWarning), LLSTRING(typeAlert), LLSTRING(typeSuccess)],
                0
            ]],
            ["COMBO", LLSTRING(recipients), [
                ["everyone", "west", "east", "independent", "civilian", "group", "player"],
                [
                    LLSTRING(toEveryone), LLSTRING(toBlufor), LLSTRING(toOpfor), LLSTRING(toIndependent),
                    LLSTRING(toCivilian), LLSTRING(toGroup), LLSTRING(toPlayer)
                ],
                [0, 6] select _onPlayer
            ]]
        ],
        {
            params ["_values", "_unit"];
            _values params ["_text", "_type", "_recipients"];
            if (_text == "") exitWith {};

            private _players = allPlayers select {!(_x isKindOf "HeadlessClient_F")};
            private _targets = switch (_recipients) do {
                case "west": {_players select {side group _x == west}};
                case "east": {_players select {side group _x == east}};
                case "independent": {_players select {side group _x == independent}};
                case "civilian": {_players select {side group _x == civilian}};
                case "group": {[[], (units group _unit) select {isPlayer _x}] select (!isNull _unit)};
                case "player": {[[], [_unit]] select (!isNull _unit && {isPlayer _unit})};
                default {_players};
            };

            if (_targets isEqualTo []) exitWith {
                [LLSTRING(noRecipient)] call zen_common_fnc_showMessage;
            };
            [QEGVAR(hud,notify), [_text, _type], _targets] call CBA_fnc_targetEvent;
        },
        {},
        _unit
    ] call zen_dialog_fnc_create;
}, _icon] call zen_custom_modules_fnc_register;
