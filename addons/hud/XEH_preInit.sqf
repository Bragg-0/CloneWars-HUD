#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

private _categoryGlobal = QUOTE(MOD_NAME);
private _categoryListHelmets = [QUOTE(MOD_NAME), "Helmets"];
private _categoryColors = [QUOTE(MOD_NAME), "Colors"];

#include "initSettings.inc.sqf"

ADDON = true;
