#define CWH_DISPLAY (uiNamespace getVariable [QGVAR(rscHUD), displayNull])

#define CWH_CTRL_SUNFILTER (CWH_DISPLAY displayCtrl 1001)
#define CWH_CTRL_FRAME (CWH_DISPLAY displayCtrl 1002)
#define CWH_CTRL_COLOR (CWH_DISPLAY displayCtrl 1003)

#define CWH_CTRL_WEAPON_FRAME (CWH_DISPLAY displayCtrl 1010)
#define CWH_CTRL_WEAPON_ICON (CWH_DISPLAY displayCtrl 1011)
#define CWH_CTRL_WEAPON_BULLET_COUNT (CWH_DISPLAY displayCtrl 1012)
#define CWH_CTRL_WEAPON_INFO (CWH_DISPLAY displayCtrl 1013)
#define CWH_CTRL_WEAPON_MAGAZINE_ICON (CWH_DISPLAY displayCtrl 1014)
#define CWH_CTRL_WEAPON_MAGAZINE_COUNT (CWH_DISPLAY displayCtrl 1015)
#define CWH_CTRL_WEAPON_AMMO (CWH_DISPLAY displayCtrl 1016)
#define CWH_CTRL_WEAPON_FIREMODE_1 (CWH_DISPLAY displayCtrl 10161)
#define CWH_CTRL_WEAPON_FIREMODE_2 (CWH_DISPLAY displayCtrl 10162)
#define CWH_CTRL_WEAPON_FIREMODE_3 (CWH_DISPLAY displayCtrl 10163)
#define CWH_CTRL_WEAPON_FIREMODE_4 (CWH_DISPLAY displayCtrl 10164)
#define CWH_CTRL_WEAPON_FIREMODE_5 (CWH_DISPLAY displayCtrl 10165)

#define CWH_CTRL_GRENADE_FRAME (CWH_DISPLAY displayCtrl 1020)
#define CWH_CTRL_GRENADE_ICON (CWH_DISPLAY displayCtrl 1021)
#define CWH_CTRL_GRENADE_COUNT (CWH_DISPLAY displayCtrl 1022)

#define CWH_CTRL_DIR_FRAME (CWH_DISPLAY displayCtrl 1030)
#define CWH_CTRL_DIR_INFO (CWH_DISPLAY displayCtrl 1031)

#define CWH_CTRL_HEALTH_FRAME (CWH_DISPLAY displayCtrl 1040)
#define CWH_CTRL_HEALTH_LABEL_1 (CWH_DISPLAY displayCtrl 1041)
#define CWH_CTRL_HEALTH_BAR_1 (CWH_DISPLAY displayCtrl 1042)
#define CWH_CTRL_HEALTH_VALUE_1 (CWH_DISPLAY displayCtrl 1043)
#define CWH_CTRL_HEALTH_LABEL_2 (CWH_DISPLAY displayCtrl 1044)
#define CWH_CTRL_HEALTH_BAR_2 (CWH_DISPLAY displayCtrl 1045)
#define CWH_CTRL_HEALTH_VALUE_2 (CWH_DISPLAY displayCtrl 1046)

#define CWH_CTRL_CRACK (CWH_DISPLAY displayCtrl 1100)

// Groups of controls
#define CWH_CTRL_FIREMODES ([CWH_CTRL_WEAPON_FIREMODE_1, CWH_CTRL_WEAPON_FIREMODE_2, CWH_CTRL_WEAPON_FIREMODE_3, CWH_CTRL_WEAPON_FIREMODE_4, CWH_CTRL_WEAPON_FIREMODE_5])
#define CWH_CTRL_WEAPON ([CWH_CTRL_WEAPON_FRAME, CWH_CTRL_WEAPON_ICON, CWH_CTRL_WEAPON_BULLET_COUNT, CWH_CTRL_WEAPON_INFO, CWH_CTRL_WEAPON_MAGAZINE_ICON, CWH_CTRL_WEAPON_MAGAZINE_COUNT, CWH_CTRL_WEAPON_AMMO] + CWH_CTRL_FIREMODES)
#define CWH_CTRL_GRENADE ([CWH_CTRL_GRENADE_FRAME, CWH_CTRL_GRENADE_ICON, CWH_CTRL_GRENADE_COUNT])
#define CWH_CTRL_DIR ([CWH_CTRL_DIR_FRAME, CWH_CTRL_DIR_INFO])
#define CWH_CTRL_HEALTH ([CWH_CTRL_HEALTH_FRAME, CWH_CTRL_HEALTH_LABEL_1, CWH_CTRL_HEALTH_BAR_1, CWH_CTRL_HEALTH_VALUE_1, CWH_CTRL_HEALTH_LABEL_2, CWH_CTRL_HEALTH_BAR_2, CWH_CTRL_HEALTH_VALUE_2])
#define CWH_CTRL_ALL ([CWH_CTRL_SUNFILTER, CWH_CTRL_FRAME, CWH_CTRL_COLOR, CWH_CTRL_CRACK] + CWH_CTRL_WEAPON + CWH_CTRL_GRENADE + CWH_CTRL_DIR + CWH_CTRL_HEALTH)
#define CWH_CTRL_COLORED ([CWH_CTRL_COLOR, CWH_CTRL_WEAPON_FRAME, CWH_CTRL_GRENADE_FRAME, CWH_CTRL_DIR_FRAME, CWH_CTRL_HEALTH_FRAME])

// Blocks of info elements, index in the opacity factors of fnc_layout
#define CWH_BLOCK_WEAPON 0
#define CWH_BLOCK_GRENADE 1
#define CWH_BLOCK_HEADING 2
#define CWH_BLOCK_HEALTH 3

// Colors
#define CWH_COLOR_DEFAULT 0,0.447,0.741,1 // Default blue
#define CWH_COLOR_DISABLED 0.5,0.5,0.5,1 // Grey
#define CWH_COLOR_WHITE 1,1,1,1 // White
#define CWH_COLOR_EMPTY 1,0,0,1 // Red (empty magazine, critical health)
#define CWH_COLOR_WARNING 1,0.55,0,1 // Orange (low ammo, pain, exhaustion)
#define CWH_COLOR_WARNING_DIM 1,0.55,0,0.35 // Orange, off phase of the blink

// Effects
#define CWH_BOOT_STAGGER 0.18 // Delay between two blocks lighting up (seconds)
#define CWH_BOOT_FADE 0.5 // Time for a block to light up (seconds)
#define CWH_GLITCH_DURATION 0.35
#define CWH_BLINK_ON ((diag_tickTime * 2) % 1 < 0.5) // 2 Hz

// Interval (seconds) between updates of the slow-changing elements (weapon, grenade, crack, sun filter)
#define CWH_SLOW_UPDATE_INTERVAL 0.1

// Fire mode indicator levels (number of lit bars)
#define CWH_FIREMODE_SINGLE 1
#define CWH_FIREMODE_BURST 3
#define CWH_FIREMODE_AUTO 5

// Config attribute a helmet (CfgWeapons) can define to declare its HUD type, e.g. cwh_hudType = "P2";
#define CWH_HELMET_ATTRIBUTE QUOTE(DOUBLES(PREFIX,hudType))

// Layout: the info elements are described on a 1920x1080 canvas, see fnc_layout
#define CWH_DESIGN_W 1920
#define CWH_DESIGN_H 1080
// Width / height ratio of the visor textures (frame, color, crack)
#define CWH_VISOR_RATIO 2
