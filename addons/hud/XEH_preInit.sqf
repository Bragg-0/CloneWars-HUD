#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// Categories for the settings
private _categoryGlobal = QUOTE(MOD_NAME);
private _categoryListHelmets = [QUOTE(MOD_NAME), "Helmets"];
private _categoryColors = [QUOTE(MOD_NAME), "Colors"];

// Default helmet lists
private _listDefaultARFHelmet = str [];
private _listDefaultBARCHelmet = str [];
private _listDefaultP1Helmet = str [];
private _listDefaultP2Helmet = str [];

#include "initSettings.inc.sqf"

ADDON = true;
