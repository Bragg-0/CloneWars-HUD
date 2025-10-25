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
        class Frame : RscPicture { // Frame Image (depends of the helmet)
            idc = 1002;
            FULLSCREEN_COORD;
            text = QPATHTOEF(ui,data\hud\P2\frame_ca.paa); // set default frame
        };
        class Color : Frame { // Color Image (can be customized in CBA)
            idc = 1003;
            text = QPATHTOEF(ui,data\hud\P2\color_ca.paa); // set default color
            colorText[] = { CWH_COLOR_DEFAULT };
        };

        // Weapon
        class Weapon_Frame : RscPictureKeepAspect {
            idc = 1010;
            x = X_COORD(0.85104167);
            y = Y_COORD(-0.00925925);
            w = W_COORD(0.14895834);
            h = H_COORD(0.22222223);
            text = QPATHTOEF(ui,data\hud\weapon_frame_ca.paa);
            colorText[] = { CWH_COLOR_DEFAULT };
        };
        class Weapon_Icon : RscPictureKeepAspect {
            idc = 1011;
            x = X_COORD(0.87760417);
            y = Y_COORD(0.03981482);
            w = W_COORD(0.0859375);
            h = H_COORD(0.05);
            colorText[] = { CWH_COLOR_WHITE };
        };
        class Weapon_Bullet_Count : RscProgress {
            idc = 1012;
            x = X_COORD(0.87760417);
            y = Y_COORD(0.09537038);
            w = W_COORD(0.0859375);
            h = H_COORD(0.00740741);
            colorBar[] = { CWH_COLOR_DEFAULT };
        };
        class Weapon_Info : RscText {
            idc = 1013;
            style = ST_CENTER;
            x = X_COORD(0.87760417);
            y = Y_COORD(0.11388889);
            w = W_COORD(0.0859375);
            h = H_COORD(0.02222223);
        };
        class Weapon_Magazine_Icon : RscPictureKeepAspect {
            idc = 1014;
            x = X_COORD(0.946875);
            y = Y_COORD(0.14166667);
            w = W_COORD(0.01666667);
            h = H_COORD(0.03148149);
            colorText[] = { CWH_COLOR_WHITE };
        };
        class Weapon_Magazine_Count : RscText {
            idc = 1015;
            style = ST_CENTER;
            x = X_COORD(0.92708334);
            y = Y_COORD(0.14166667);
            w = W_COORD(0.01666667);
            h = H_COORD(0.03148149);
        };
        class Weapon_FireMode_5 : RscText {
            idc = 10165;
            x = X_COORD(0.88177084);
            y = Y_COORD(0.10462963);
            w = W_COORD(0.01145834);
            h = H_COORD(0.00740741);
            colorBackground[] = { CWH_COLOR_DISABLED };
        };
        class Weapon_FireMode_4 : Weapon_FireMode_5 {
            idc = 10164;
            x = X_COORD(0.8984375);
        };
        class Weapon_FireMode_3 : Weapon_FireMode_5 {
            idc = 10163;
            x = X_COORD(0.91458334);
        };
        class Weapon_FireMode_2 : Weapon_FireMode_5 {
            idc = 10162;
            x = X_COORD(0.93125);
        };
        class Weapon_FireMode_1 : Weapon_FireMode_5 {
            idc = 10161;
            x = X_COORD(0.94791667);
        };

        // Grenade
        class Grenade_Frame : RscPictureKeepAspect {
            idc = 1020;
            x = X_COORD(0.890625);
            y = Y_COORD(0.17592593);
            w = W_COORD(0.12916667);
            h = H_COORD(0.11111112);
            text = QPATHTOEF(ui,data\hud\grenade_frame_ca.paa);
            colorText[] = { CWH_COLOR_DEFAULT };
        };
        class Grenade_Icon : RscPictureKeepAspect {
            idc = 1021;
            x = X_COORD(0.9546875);
            y = Y_COORD(0.20555556);
            w = W_COORD(0.0265625);
            h = H_COORD(0.05);
            colorText[] = { CWH_COLOR_WHITE };
        };
        class Grenade_Count : RscText {
            idc = 1022;
            style = ST_CENTER;
            x = X_COORD(0.92864584);
            y = Y_COORD(0.21574075);
            w = W_COORD(0.01666667);
            h = H_COORD(0.03148149);
        };

        // Dir
        class Dir_Frame : RscPictureKeepAspect {
            idc = 1030;
            x = X_COORD(0.34635417);
            y = Y_COORD(0.01851852);
            w = W_COORD(0.0796875);
            h = H_COORD(0.07407408);
            text = QPATHTOEF(ui,data\hud\dir_frame_ca.paa);
            colorText[] = { CWH_COLOR_DEFAULT };
        };
        class Dir_Info : RscText {
            idc = 1031;
            style = ST_CENTER;
            x = X_COORD(0.3484375);
            y = Y_COORD(0.05092593);
            w = W_COORD(0.05);
            h = H_COORD(0.02222223);
        };

        class Crack : Frame { // Crack Image (when damaged)
            idc = 1100;
            text = QPATHTOEF(ui,data\hud\crack_ca.paa); // set default crack
        };
    };
};
