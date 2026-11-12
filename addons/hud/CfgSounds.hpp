// HUD sounds, synthesized by tools/generate_sounds.ps1. Played by fnc_playSound.

#define HUD_SOUND(var1) \
    class GVAR(var1) { \
        name = QGVAR(var1); \
        sound[] = { QPATHTOEF(ui,data\sounds\var1.ogg), 1, 1 }; \
        titles[] = {}; \
    }

class CfgSounds {
    HUD_SOUND(boot);     // HUD turned on
    HUD_SOUND(shutdown); // HUD turned off
    HUD_SOUND(glitch);   // Player hit
    HUD_SOUND(warning);  // Low ammo
    HUD_SOUND(alert);    // Empty magazine, cracked HUD
    HUD_SOUND(confirm);  // HUD repaired
};
