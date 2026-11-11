// Positions and sizes are set by fnc_layout (aspect-ratio independent), not here
#define LAYOUT_BY_SCRIPT \
    x = 0; \
    y = 0; \
    w = 0; \
    h = 0

class GVAR(rscHUD) {
    idd = -1;
    movingEnable = 0;
    fadein = 0;
    duration = 36000000;
    fadeout = 0;
    name = "CloneWarsHUD";
    onLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(rscHUD),_this#0)]);
    onUnLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(rscHUD),displayNull)]);
    class controlsBackground {
        class SunFilter : RscText {
            idc = 1001;
            FULLSCREEN_COORD;
            colorBackground[] = { 0,0,0,0.25 };
        };

        // Visor
        class Frame : RscPicture { // Frame image (depends on the helmet)
            idc = 1002;
            LAYOUT_BY_SCRIPT;
            text = "";
        };
        class Color : Frame { // Color image (tinted with the HUD color)
            idc = 1003;
            colorText[] = { CWH_COLOR_DEFAULT };
        };

        // Weapon
        class Weapon_Frame : RscPictureKeepAspect {
            idc = 1010;
            LAYOUT_BY_SCRIPT;
            text = QPATHTOEF(ui,data\hud\weapon_frame_ca.paa);
            colorText[] = { CWH_COLOR_DEFAULT };
        };
        class Weapon_Icon : RscPictureKeepAspect {
            idc = 1011;
            LAYOUT_BY_SCRIPT;
            colorText[] = { CWH_COLOR_WHITE };
        };
        class Weapon_Bullet_Count : RscProgress {
            idc = 1012;
            LAYOUT_BY_SCRIPT;
            colorBar[] = { CWH_COLOR_DEFAULT };
        };
        class Weapon_Info : RscText {
            idc = 1013;
            style = ST_LEFT;
            LAYOUT_BY_SCRIPT;
        };
        class Weapon_Magazine_Icon : RscPictureKeepAspect {
            idc = 1014;
            LAYOUT_BY_SCRIPT;
            colorText[] = { CWH_COLOR_WHITE };
        };
        class Weapon_Magazine_Count : RscText {
            idc = 1015;
            style = ST_RIGHT;
            LAYOUT_BY_SCRIPT;
        };
        class Weapon_Ammo : RscText { // Rounds left in the magazine
            idc = 1016;
            style = ST_RIGHT;
            font = "RobotoCondensedBold";
            LAYOUT_BY_SCRIPT;
        };
        class Weapon_FireMode_5 : RscText {
            idc = 10165;
            LAYOUT_BY_SCRIPT;
            colorBackground[] = { CWH_COLOR_DISABLED };
        };
        class Weapon_FireMode_4 : Weapon_FireMode_5 {
            idc = 10164;
        };
        class Weapon_FireMode_3 : Weapon_FireMode_5 {
            idc = 10163;
        };
        class Weapon_FireMode_2 : Weapon_FireMode_5 {
            idc = 10162;
        };
        class Weapon_FireMode_1 : Weapon_FireMode_5 {
            idc = 10161;
        };

        // Grenade
        class Grenade_Frame : RscPictureKeepAspect {
            idc = 1020;
            LAYOUT_BY_SCRIPT;
            text = QPATHTOEF(ui,data\hud\grenade_frame_ca.paa);
            colorText[] = { CWH_COLOR_DEFAULT };
        };
        class Grenade_Icon : RscPictureKeepAspect {
            idc = 1021;
            LAYOUT_BY_SCRIPT;
            colorText[] = { CWH_COLOR_WHITE };
        };
        class Grenade_Count : RscText {
            idc = 1022;
            style = ST_CENTER;
            LAYOUT_BY_SCRIPT;
        };

        // Heading
        class Dir_Frame : RscPictureKeepAspect {
            idc = 1030;
            LAYOUT_BY_SCRIPT;
            text = QPATHTOEF(ui,data\hud\dir_frame_ca.paa);
            colorText[] = { CWH_COLOR_DEFAULT };
        };
        class Dir_Info : RscText {
            idc = 1031;
            style = ST_CENTER;
            LAYOUT_BY_SCRIPT;
        };

        class Crack : Frame { // Crack image (when damaged)
            idc = 1100;
            text = QPATHTOEF(ui,data\hud\crack_ca.paa);
        };
    };
};
