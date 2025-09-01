#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_init
Description:
    Initializes the HUD environment for the player.

Parameters:
    _player - The player object <OBJECT>

Returns:
    <NONE>

Examples
    (begin example)
        [player] call cwh_hud_fnc_init
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

params [
    ["_player", objNull, [objNull]]
];

TRACE_1("fnc_init",_this);

// Check if ACE mod is loaded to load ACE-specific
private _aceLoaded = (configFile >> "CfgPatches" >> "ace_interact_menu") call BIS_fnc_getCfgIsClass;
if (_aceLoaded) then {
    INFO("ACE mod detected, initializing ACE-specific elements");
    [_player] call EFUNC(compat_ace,init);
};

// Initialize list of all helmets
if (isNil QGVAR(listOfAllHelmets) || isNil QGVAR(listOfAllHelmetsWithType)) then {
    INFO("Initializing list of all helmets");
    GVAR(listOfAllHelmets) = [];
    GVAR(listOfAllHelmetsWithType) = [];

    private _helmetsByType = [["ARF", GVAR(listARFHelmet)],["BARC", GVAR(listBARCHelmet)],["P1", GVAR(listP1Helmet)],["P2", GVAR(listP2Helmet)]];

    {
        _x params ["_type", "_list"];
        private _compiledList = call (compile _list);
        if (IS_ARRAY(_compiledList)) then {
            {
                private _parent = _x;
                private _isClass = (configFile >> "CfgWeapons" >> _x) call BIS_fnc_getCfgIsClass;
                if (_isClass) then {
                    private _children = [configFile >> "CfgWeapons" >> _x, 5] call BIS_fnc_returnChildren;
                    {
                        private _class = configName _x;
                        GVAR(listOfAllHelmets) pushBackUnique _class;
                        GVAR(listOfAllHelmetsWithType) pushBackUnique [_class,_type];
                    } forEach _children;
                };
            } forEach _compiledList;
        } else {
            ERROR_1("fnc_init - Helmet list for type %1 is not an array, skipping",_type);
        };
    } forEach _helmetsByType;

    INFO_1("List of all helmets initialized: %1 helmets found",count GVAR(listOfAllHelmets));

    publicVariable GVAR(listOfAllHelmets);
    publicVariable GVAR(listOfAllHelmetsWithType);

} else {
    INFO("List of all helmets already initialized");
};

// Setup HUD for player
[_player] call FUNC(setup);
