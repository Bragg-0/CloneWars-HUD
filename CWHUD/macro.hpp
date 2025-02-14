#define F(NAME) \
    class NAME  \
    {           \
    }

#define F_PostInit(NAME) \
    class NAME           \
    {                    \
        postInit = 1;    \
    }

#define RemoteExec(NAME, TARGET) \
    class NAME                   \
    {                            \
        allowedTargets = TARGET; \
    }

#define ANYONE 0
#define CLIENT 1
#define SERVER 2

#define Transparent {0, 0, 0, 0}
#define White {1, 1, 1, 1}
#define Black {0, 0, 0, 1}
#define Black25 {0, 0, 0, 0.25}
#define Cyan {0, 0.5, 0.5, 1}
#define Green {0, 1, 0, 1}
#define Red {1, 0, 0, 1}
#define Blue {0, 0, 1, 1}
#define Gray {0.5, 0.5, 0.5, 1}

#define IDC_MENU_TESTHUDFrame 3142101
#define IDC_MENU_TESTHUDColor 3142102
#define IDC_MENU_slider_green 3142103
#define IDC_MENU_slider_red 3142104
#define IDC_MENU_slider_blue 3142105
#define IDC_MENU_slider_alpha 3142106

#define IDC_HUD_FRAME 8842101
#define IDC_HUD_COLOR 8842102
#define IDC_HUD_SUNFILTER 8842103

#define SliderStyle                                                \
    arrowEmpty = "\A3\ui_f\data\GUI\Cfg\Slider\arrowEmpty_ca.paa"; \
    arrowFull = "\A3\ui_f\data\GUI\Cfg\Slider\arrowFull_ca.paa";   \
    border = "\A3\ui_f\data\GUI\Cfg\Slider\border_ca.paa";         \
    thumb = "\A3\ui_f\data\GUI\Cfg\Slider\thumb_ca.paa"

#define SizeEx sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)

#define Font font = "PuristaMedium"

#define HUD_fullScreen             \
    x = safeZoneX + safeZoneW * 0; \
    y = safeZoneY + safeZoneH * 0; \
    w = safeZoneW * 1;             \
    h = safeZoneH * 1