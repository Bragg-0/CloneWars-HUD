#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_init
Description:
    Initializes the HUD environment for the player.

Parameters:
    <NONE>

Returns:
    <NONE>

Examples
    (begin example)
        [] call cwh_hud_fnc_init
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

TRACE_1("fnc_init",_this);

// Check if ACE mod is loaded to load ACE-specific
private _aceLoaded = (configFile >> "CfgPatches" >> "ace_interact_menu") call BIS_fnc_getCfgIsClass;
if (_aceLoaded) then {
    INFO("ACE mod detected, initializing ACE-specific elements");
    [] call EFUNC(compat_ace,init);
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
                private _isClass = (configFile >> "CfgWeapons" >> _parent) call BIS_fnc_getCfgIsClass;
                if (_isClass) then {
                    private _children = format ["configName (inheritsFrom _x) == '%1'", _parent] configClasses (configFile >> "CfgWeapons");
                    {
                        private _class = configName _x;
                        GVAR(listOfAllHelmets) pushBackUnique _class;
                        GVAR(listOfAllHelmetsWithType) pushBackUnique [_class,_type];
                    } forEach ([(configFile >> "CfgWeapons" >> _parent)] + _children);
                };
            } forEach _compiledList;
        } else {
            ERROR_1("fnc_init - Helmet list for type %1 is not an array, skipping",_type);
        };
    } forEach _helmetsByType;

    INFO_1("List of all helmets initialized: %1 helmets found",count GVAR(listOfAllHelmets));

    GVAR(listOfAllHelmetsWithType) = createHashMapFromArray GVAR(listOfAllHelmetsWithType);

    publicVariable QGVAR(listOfAllHelmets); // Array of all helmet class names
    publicVariable QGVAR(listOfAllHelmetsWithType); // HashMap of helmet class names to their types

} else {
    INFO("List of all helmets already initialized");
};

// Setup HUD for player
[] call FUNC(setup);
