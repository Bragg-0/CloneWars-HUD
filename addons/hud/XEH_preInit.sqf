#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// HUD types declared in config: type => [frame texture, color texture]
GVAR(types) = createHashMap;
{
    GVAR(types) set [configName _x, [getText (_x >> "frame"), getText (_x >> "color")]];
} forEach ("true" configClasses (configFile >> QGVAR(types)));

// Caches
GVAR(helmetCache) = createHashMap;     // helmet classname => HUD type ("" if none)
GVAR(helmetRoots) = nil;               // built lazily from the settings, see fnc_getHelmetType
GVAR(weaponInfoCache) = createHashMap; // weapon state => [icon, name, capacity, magazine icon, fire mode level]

// Runtime state
GVAR(unit) = objNull;          // Unit the HUD is currently attached to
GVAR(visible) = false;         // Is the HUD currently drawn
GVAR(type) = "";               // HUD type currently drawn
GVAR(featureCamera) = "";      // Active feature camera (Zeus, Arsenal, spectator...)
GVAR(nextSlowUpdate) = 0;
GVAR(fireModeLevel) = 0;
GVAR(ammoEmpty) = false;
GVAR(repairing) = false;
GVAR(lastHeadHitFrame) = -1;

#include "initSettings.inc.sqf"
#include "initKeybinds.inc.sqf"

ADDON = true;
