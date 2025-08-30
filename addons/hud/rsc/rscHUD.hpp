class GVAR(rscHUD) {
    idd = -1;
    movingEnable = 0;
    fadein = 0;
    duration = 36000000;
    fadeout = 0;
    name = "CloneWarsHUD";
    onLoad = QUOTE(call FUNC(onLoadHUD));
    onUnLoad = QUOTE(call FUNC(onUnloadHUD));
    class controlsBackground {
        class SunFilter : RscText {
            idc = 1001;
            FULLSCREEN_COORD;
            colorBackground[] = {0,0,0,0.25};
        };
        class Frame : RscPicture { // Frame Image (depends of the helmet)
            idc = 1002;
            FULLSCREEN_COORD;
            text = QPATHTOEF(ui,data\hud\P2\frame_ca.paa); // set default frame
        };
        class Color : Frame { // Color Image (can be customized in CBA)
            idc = 1003;
            text = QPATHTOEF(ui,data\hud\P2\color_ca.paa); // set default color
            colorText[] = {0,0.447,0.741,1}; // default blue
        };
        class Weapon_Image : RscPictureKeepAspect { // Weapon Image
            idc = 1004;
            x = X_COORD(0.89739584);
            y = Y_COORD(0.0212963);
            w = W_COORD(0.0859375);
            h = H_COORD(0.04074075);
        };
        class Grenade_Image : Weapon_Image { // Grenade Image
            idc = 1005;
            x = X_COORD(0.86770834);
            w = W_COORD(0.0265625);
        };
        class Weapon_Ammo : RscProgress { // Weapon Ammo count
            idc = 1006;
            x = X_COORD(0.89739584);
            y = Y_COORD(0.01203704);
            w = W_COORD(0.0859375);
            h = H_COORD(0.00370371);
        };
        class Grenade_Ammo : Weapon_Ammo { // Grenade Ammo count
            idc = 1007;
            x = X_COORD(0.86770834);
            y = Y_COORD(0.01203704);
            w = W_COORD(0.0265625);
        };
        class Weapon_Info : RscText { // Weapon Info
            idc = 1008;
            style = ST_CENTER;
            x = X_COORD(0.89739584);
            y = Y_COORD(0.0675926);
            w = W_COORD(0.0859375);
            h = H_COORD(0.02222223);
        };
        class Grenade_Info : Weapon_Info { // Grenade Info
            idc = 1009;
            x = X_COORD(0.86770834);
            w = W_COORD(0.0265625);
        };
        class Direction : RscText { // Direction Info (azimuth)
            idc = 1010;
            style = ST_CENTER;
            x = X_COORD(0.45208334);
            y = Y_COORD(0.08611112);
            w = W_COORD(0.09583334);
            h = H_COORD(0.02222223);
        };
        class Crack : Frame { // Crack Image (when damaged)
            idc = 1011;
            text = QPATHTOEF(ui,data\hud\crack_ca.paa); // set default crack
        };
    };
};
