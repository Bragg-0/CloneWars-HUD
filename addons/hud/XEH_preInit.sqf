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
GVAR(ammoLow) = false;
GVAR(healthRow1Low) = false;
GVAR(healthRow2Warning) = false;
GVAR(aceMedical) = isClass (configFile >> "CfgPatches" >> "ace_medical"); // Health block shows blood and pain
GVAR(animating) = false;       // An effect (boot sequence, glitch) is playing
GVAR(bootStart) = -1;          // Start time of the boot sequence, -1 if not playing
GVAR(glitchEnd) = 0;           // End time of the glitch
GVAR(repairing) = false;
GVAR(lastHeadHitFrame) = -1;
GVAR(layoutKey) = [];           // Screen + settings the current layout was computed for

#include "initSettings.inc.sqf"
#include "initKeybinds.inc.sqf"

ADDON = true;
