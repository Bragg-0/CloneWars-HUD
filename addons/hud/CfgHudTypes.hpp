/*
    HUD types.

    Each class is a HUD type a helmet can use. Other mods can add their own types:

        class cwh_hud_types {
            class MyType {
                displayName = "My HUD";
                frame = "\my\addon\frame_ca.paa"; // Static part of the visor
                color = "\my\addon\color_ca.paa"; // Part tinted with the HUD color (white texture)
            };
        };

    A helmet is linked to a type either by adding  cwh_hudType = "MyType";  to its CfgWeapons class,
    or through the helmet lists in the CBA settings.
*/

#define HUD_TYPE(var1,var2) \
    class var1 { \
        displayName = var2; \
        frame = QPATHTOEF(ui,data\hud\var1\frame_ca.paa); \
        color = QPATHTOEF(ui,data\hud\var1\color_ca.paa); \
    }

class GVAR(types) {
    HUD_TYPE(P1,"Phase I");
    HUD_TYPE(P2,"Phase II");
    HUD_TYPE(ARF,"ARF");
    HUD_TYPE(BARC,"BARC");
};
