// Positions and sizes are set by fnc_layout (aspect-ratio independent), not here
#define LAYOUT_BY_SCRIPT \
    x = 0; \
    y = 0; \
    w = 0; \
    h = 0

// Squad member marker on the compass strip
#define COMPASS_SQUAD(n,idcValue) \
    class Squad_##n : RscText { \
        idc = idcValue; \
        LAYOUT_BY_SCRIPT; \
        colorBackground[] = { CWH_COLOR_WHITE }; \
    }

// Notification frame + text
#define NOTIFICATION(n,idcFrame,idcText) \
    class Notification_Frame_##n : RscPicture { \
        idc = idcFrame; \
        LAYOUT_BY_SCRIPT; \
        text = QPATHTOEF(ui,data\hud\notification_frame_ca.paa); \
    }; \
    class Notification_Text_##n : RscText { \
        idc = idcText; \
        style = ST_LEFT; \
        LAYOUT_BY_SCRIPT; \
    }

// Radio row: frame, radio name, channel / frequency, transmit / receive indicator, additional channel
#define RADIO_ROW(n,idcFrame,idcName,idcChannel,idcTransmit,idcAdditional) \
    class Radio_Frame_##n : RscPictureKeepAspect { \
        idc = idcFrame; \
        LAYOUT_BY_SCRIPT; \
        text = QPATHTOEF(ui,data\hud\radio_frame_ca.paa); \
        colorText[] = { CWH_COLOR_DEFAULT }; \
    }; \
    class Radio_Name_##n : RscText { \
        idc = idcName; \
        style = ST_LEFT; \
        LAYOUT_BY_SCRIPT; \
    }; \
    class Radio_Channel_##n : RscText { \
        idc = idcChannel; \
        style = ST_LEFT; \
        font = "RobotoCondensedBold"; \
        LAYOUT_BY_SCRIPT; \
    }; \
    class Radio_Transmit_##n : RscText { \
        idc = idcTransmit; \
        LAYOUT_BY_SCRIPT; \
        colorBackground[] = { CWH_COLOR_DISABLED }; \
    }; \
    class Radio_Additional_##n : RscText { \
        idc = idcAdditional; \
        style = ST_RIGHT; \
        LAYOUT_BY_SCRIPT; \
    }

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
        class Grenade_Color : RscText { // Smoke / chemlight color
            idc = 1023;
            LAYOUT_BY_SCRIPT;
            colorBackground[] = { CWH_COLOR_WHITE };
        };

        // Compass: frame, heading value, and a clipping group in which the graduated strip scrolls
        class Dir_Frame : RscPictureKeepAspect {
            idc = 1030;
            LAYOUT_BY_SCRIPT;
            text = QPATHTOEF(ui,data\hud\compass_frame_ca.paa);
            colorText[] = { CWH_COLOR_DEFAULT };
        };
        class Dir_Info : RscText {
            idc = 1031;
            style = ST_CENTER;
            LAYOUT_BY_SCRIPT;
        };
        class Compass_Group : RscControlsGroupNoScrollbars {
            idc = 1032;
            LAYOUT_BY_SCRIPT;
            class controls {
                class Strip : RscPicture {
                    idc = 1033;
                    LAYOUT_BY_SCRIPT;
                    text = QPATHTOEF(ui,data\hud\compass_strip_ca.paa);
                    colorText[] = { CWH_COLOR_WHITE };
                };
                class Waypoint : RscPictureKeepAspect {
                    idc = 1034;
                    LAYOUT_BY_SCRIPT;
                    text = QPATHTOEF(ui,data\hud\compass_waypoint_ca.paa);
                    colorText[] = { CWH_COLOR_WAYPOINT };
                };
                COMPASS_SQUAD(0,1050);
                COMPASS_SQUAD(1,1051);
                COMPASS_SQUAD(2,1052);
                COMPASS_SQUAD(3,1053);
                COMPASS_SQUAD(4,1054);
                COMPASS_SQUAD(5,1055);
                COMPASS_SQUAD(6,1056);
                COMPASS_SQUAD(7,1057);
                COMPASS_SQUAD(8,1058);
                COMPASS_SQUAD(9,1059);
                COMPASS_SQUAD(10,1060);
                COMPASS_SQUAD(11,1061);
            };
        };

        // Notifications: up to 3 stacked under the compass
        NOTIFICATION(0,1070,1073);
        NOTIFICATION(1,1071,1074);
        NOTIFICATION(2,1072,1075);

        // Radio: up to 3 rows, one per radio
        RADIO_ROW(0,1080,1081,1082,1083,1084);
        RADIO_ROW(1,1085,1086,1087,1088,1089);
        RADIO_ROW(2,1090,1091,1092,1093,1094);

        // Health: two rows (label, bar, value)
        class Health_Frame : RscPictureKeepAspect {
            idc = 1040;
            LAYOUT_BY_SCRIPT;
            text = QPATHTOEF(ui,data\hud\health_frame_ca.paa);
            colorText[] = { CWH_COLOR_DEFAULT };
        };
        class Health_Label_1 : RscText {
            idc = 1041;
            style = ST_LEFT;
            LAYOUT_BY_SCRIPT;
        };
        class Health_Bar_1 : RscProgress {
            idc = 1042;
            LAYOUT_BY_SCRIPT;
            colorBar[] = { CWH_COLOR_DEFAULT };
        };
        class Health_Value_1 : RscText {
            idc = 1043;
            style = ST_RIGHT;
            LAYOUT_BY_SCRIPT;
        };
        class Health_Label_2 : Health_Label_1 {
            idc = 1044;
        };
        class Health_Bar_2 : Health_Bar_1 {
            idc = 1045;
        };
        class Health_Value_2 : Health_Value_1 {
            idc = 1046;
        };

        class Crack : Frame { // Crack image (when damaged)
            idc = 1100;
            text = QPATHTOEF(ui,data\hud\crack_ca.paa);
        };
    };
};
