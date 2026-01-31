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
if (isNil QGVAR(helmetRoots) || isNil QGVAR(helmetCache)) then {
    INFO("Initializing helmet configuration");
    GVAR(helmetRoots) = [];
    GVAR(helmetCache) = createHashMap;

    private _helmetsByType = [["ARF", GVAR(listARFHelmet)],["BARC", GVAR(listBARCHelmet)],["P1", GVAR(listP1Helmet)],["P2", GVAR(listP2Helmet)]];

    {
        _x params ["_type", "_list"];
        private _compiledList = call (compile _list);
        if (IS_ARRAY(_compiledList)) then {
            GVAR(helmetRoots) pushBack [_type, _compiledList];
        } else {
            ERROR_1("fnc_init - Helmet list for type %1 is not an array, skipping",_type);
        };
    } forEach _helmetsByType;

    INFO("Helmet configuration initialized");
} else {
    INFO("Helmet configuration already initialized");
};

if (not isNull player) then {
    // Setup HUD for player
    [] call FUNC(setup);
};
