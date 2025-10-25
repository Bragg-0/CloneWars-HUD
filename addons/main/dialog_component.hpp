#include "\a3\ui_f\hpp\defineCommonColors.inc"

#include "\a3\ui_f\hpp\defineCommonGrids.inc"

#include "\a3\ui_f\hpp\defineResinclDesign.inc"

#define X_COORD(x) QUOTE((safezoneX + (safezoneW * x)))
#define Y_COORD(y) QUOTE((safezoneY + (safezoneH * y)))
#define W_COORD(w) QUOTE((safezoneW * w))
#define H_COORD(h) QUOTE((safezoneH * h))

#define FULLSCREEN_COORD \
    x = X_COORD(0); \
    y = Y_COORD(0); \
    w = W_COORD(1); \
    h = H_COORD(1)

// Define common dialog styles
#define ST_LEFT 0x00
#define ST_RIGHT 0x01
#define ST_CENTER 0x02
#define ST_DOWN 0x04
#define ST_UP 0x08
#define ST_VCENTER 0x0C
#define ST_SINGLE 0x00
#define ST_MULTI 0x10
#define ST_TITLE_BAR 0x20
#define ST_PICTURE 0x30
#define ST_FRAME 0x40
#define ST_BACKGROUND 0x50
#define ST_GROUP_BOX 0x60
#define ST_GROUP_BOX2 0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE 0x90
#define ST_WITH_RECT 0xA0
#define ST_LINE 0xB0
#define ST_UPPERCASE 0xC0
#define ST_LOWERCASE 0xD0
#define ST_ADDITIONAL_INFO 0x0F00
#define ST_SHADOW 0x0100
#define ST_NO_RECT 0x0200
#define ST_KEEP_ASPECT_RATIO 0x0800
#define ST_TITLE ST_TITLE_BAR + ST_CENTER
#define SL_VERT 0
#define SL_HORZ 0x400
#define SL_TEXTURES 0x10
#define ST_VERTICAL 0x01
#define ST_HORIZONTAL 0
#define LB_TEXTURES 0x10
#define LB_MULTI 0x20
#define TR_SHOWROOT 1
#define TR_AUTOCOLLAPSE 2
