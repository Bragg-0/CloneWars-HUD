// Positions and sizes are set by fnc_layout (aspect-ratio independent), not here
#define LAYOUT_BY_SCRIPT \
    x = 0; \
    y = 0; \
    w = 0; \
    h = 0

// Compass graduation (positioned every frame by fnc_updateCompass)
#define COMPASS_TICK(n,idcValue) \
    class Tick_##n : RscText { \
        idc = idcValue; \
        LAYOUT_BY_SCRIPT; \
        colorBackground[] = { CWH_COLOR_WHITE }; \
    }

// Compass label: cardinal point or degrees
#define COMPASS_LABEL(n,idcValue) \
    class Label_##n : RscText { \
        idc = idcValue; \
        style = ST_CENTER; \
        LAYOUT_BY_SCRIPT; \
    }

// Squad member marker on the compass
#define COMPASS_SQUAD(n,idcValue) \
    class Squad_##n : RscPictureKeepAspect { \
        idc = idcValue; \
        LAYOUT_BY_SCRIPT; \
        text = QPATHTOEF(ui,data\hud\squad_marker_ca.paa); \
    }

// Notification: background box, colored accent and underline, text. Width adapted to the text by fnc_updateNotifications.
#define NOTIFICATION(n,idcBox,idcAccent,idcLine,idcText) \
    class Notification_Box_##n : RscText { \
        idc = idcBox; \
        LAYOUT_BY_SCRIPT; \
        colorBackground[] = { 0, 0, 0, 0.6 }; \
    }; \
    class Notification_Accent_##n : RscText { \
        idc = idcAccent; \
        LAYOUT_BY_SCRIPT; \
        colorBackground[] = { CWH_COLOR_WHITE }; \
    }; \
    class Notification_Line_##n : RscText { \
        idc = idcLine; \
        LAYOUT_BY_SCRIPT; \
        colorBackground[] = { CWH_COLOR_WHITE }; \
    }; \
    class Notification_Text_##n : RscText { \
        idc = idcText; \
        style = ST_CENTER; \
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
        class Grenade_Label : RscText { // Short name, tells apart grenades sharing the same icon
            idc = 1024;
            style = ST_CENTER;
            LAYOUT_BY_SCRIPT;
        };

        // Compass: frame, heading value, and a clipping group in which graduations, labels and markers are placed
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
                COMPASS_TICK(0,1300);
                COMPASS_TICK(1,1301);
                COMPASS_TICK(2,1302);
                COMPASS_TICK(3,1303);
                COMPASS_TICK(4,1304);
                COMPASS_TICK(5,1305);
                COMPASS_TICK(6,1306);
                COMPASS_TICK(7,1307);
                COMPASS_TICK(8,1308);
                COMPASS_TICK(9,1309);
                COMPASS_TICK(10,1310);
                COMPASS_TICK(11,1311);
                COMPASS_TICK(12,1312);
                COMPASS_TICK(13,1313);
                COMPASS_TICK(14,1314);
                COMPASS_TICK(15,1315);
                COMPASS_TICK(16,1316);
                COMPASS_TICK(17,1317);
                COMPASS_TICK(18,1318);
                COMPASS_TICK(19,1319);
                COMPASS_TICK(20,1320);
                COMPASS_TICK(21,1321);
                COMPASS_TICK(22,1322);
                COMPASS_TICK(23,1323);
                COMPASS_TICK(24,1324);
                COMPASS_TICK(25,1325);
                COMPASS_LABEL(0,1330);
                COMPASS_LABEL(1,1331);
                COMPASS_LABEL(2,1332);
                COMPASS_LABEL(3,1333);
                COMPASS_LABEL(4,1334);
                COMPASS_LABEL(5,1335);
                COMPASS_LABEL(6,1336);
                COMPASS_LABEL(7,1337);
                COMPASS_LABEL(8,1338);
                COMPASS_LABEL(9,1339);
                COMPASS_SQUAD(0,1350);
                COMPASS_SQUAD(1,1351);
                COMPASS_SQUAD(2,1352);
                COMPASS_SQUAD(3,1353);
                COMPASS_SQUAD(4,1354);
                COMPASS_SQUAD(5,1355);
                COMPASS_SQUAD(6,1356);
                COMPASS_SQUAD(7,1357);
                COMPASS_SQUAD(8,1358);
                COMPASS_SQUAD(9,1359);
                COMPASS_SQUAD(10,1360);
                COMPASS_SQUAD(11,1361);
                class Waypoint : RscPictureKeepAspect {
                    idc = 1034;
                    LAYOUT_BY_SCRIPT;
                    text = QPATHTOEF(ui,data\hud\compass_waypoint_ca.paa);
                    colorText[] = { CWH_COLOR_WAYPOINT };
                };
            };
        };

        // Notifications: up to 3 stacked under the compass
        NOTIFICATION(0,1200,1201,1202,1203);
        NOTIFICATION(1,1204,1205,1206,1207);
        NOTIFICATION(2,1208,1209,1210,1211);

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
