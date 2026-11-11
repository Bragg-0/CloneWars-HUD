#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_getHelmetType
Description:
    Returns the HUD type of a helmet. Results are cached.

    Resolution order:
    1. The helmet config attribute  cwh_hudType = "P2";  (inherited)
    2. The helmet lists of the CBA settings (the helmet or one of its parents)

Parameters:
    0: _helmet - Helmet classname <STRING>

Returns:
    HUD type (e.g. "P1", "P2", "ARF", "BARC"), "" if the helmet has no HUD <STRING>

Examples
    (begin example)
        [headgear player] call cwh_hud_fnc_getHelmetType
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

params [["_helmet", "", [""]]];

if (_helmet == "") exitWith {""};

// Build the helmet roots from the settings (reset when a list setting changes)
if (isNil QGVAR(helmetRoots)) then {
    GVAR(helmetRoots) = [];
    GVAR(helmetCache) = createHashMap;
    {
        _x params ["_type", "_setting"];
        private _raw = trim (missionNamespace getVariable [_setting, ""]);
        private _list = if (_raw select [0, 1] == "[") then {
            parseSimpleArray _raw
        } else {
            _raw splitString ", "
        };
        _list = _list select {_x isEqualType "" && {_x != ""}};
        GVAR(helmetRoots) pushBack [_type, _list];
    } forEach [
        ["ARF", QGVAR(listARFHelmet)],
        ["BARC", QGVAR(listBARCHelmet)],
        ["P1", QGVAR(listP1Helmet)],
        ["P2", QGVAR(listP2Helmet)]
    ];
    TRACE_1("Helmet roots built",GVAR(helmetRoots));
};

private _type = GVAR(helmetCache) get _helmet;
if (!isNil "_type") exitWith {_type};

private _cfgWeapons = configFile >> "CfgWeapons";
_type = getText (_cfgWeapons >> _helmet >> CWH_HELMET_ATTRIBUTE);

if !(_type in GVAR(types)) then {
    _type = "";
    {
        _x params ["_listType", "_roots"];
        if (_roots findIf {_helmet == _x || {_helmet isKindOf [_x, _cfgWeapons]}} != -1) exitWith {
            _type = _listType;
        };
    } forEach GVAR(helmetRoots);
};

GVAR(helmetCache) set [_helmet, _type];

_type
