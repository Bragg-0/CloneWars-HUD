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
GVAR(grenadeColorCache) = createHashMap; // throwable magazine => color ([] if none)

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
GVAR(powered) = false;         // HUD enabled with a compatible helmet (drives the on / off sounds)
GVAR(squadUnits) = [];         // Squad members to mark
GVAR(currentColor) = [CWH_COLOR_DEFAULT]; // HUD color currently displayed (RGB cycle included)
GVAR(squadStates) = createHashMap; // Squad member => 0 ok, 1 down, 2 killed (notifications)
GVAR(compassWaypoint) = [];    // Position marked on the compass
GVAR(layoutUnit) = [0, 0];     // UI units per design pixel [w, h], see fnc_layout
GVAR(notifications) = [];      // [[text, color, start, end], ...] newest first
GVAR(notificationFactor) = 1;  // Opacity of the notifications (setting and boot animation)
GVAR(radioProviders) = [];     // Code returning the radio info, see fnc_updateRadio
GVAR(radioStates) = [];        // State of each radio row: CWH_RADIO_IDLE / TRANSMITTING / RECEIVING
GVAR(animating) = false;      // An effect (boot sequence, glitch) is playing
GVAR(bootStart) = -1;          // Start time of the boot sequence, -1 if not playing
GVAR(glitchEnd) = 0;           // End time of the glitch
GVAR(repairing) = false;
GVAR(lastHeadHitFrame) = -1;
GVAR(layoutKey) = [];           // Screen + settings the current layout was computed for

#include "initSettings.inc.sqf"
#include "initKeybinds.inc.sqf"

ADDON = true;
