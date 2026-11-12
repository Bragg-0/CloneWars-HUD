#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
    QGVAR(hideTfarHint),
    "CHECKBOX",
    [LLSTRING(hideTfarHint), LLSTRING(hideTfarHint_Description)],
    [QUOTE(MOD_NAME), "Elements"],
    true
] call CBA_fnc_addSetting;

ADDON = true;
