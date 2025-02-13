#include "macro.hpp"

class CfgPatches
{
    class CWHUD
    {
        name = "Clone Wars HUD";
        Author;
        requiRedAddons[] = {"A3_Functions_F", "ace_goggles", "ace_interact_menu"};
        units[] = {};
        weapons[] = {"CWHUD_P1_Base", "CWHUD_P2_Base", "CWHUD_ARF_Base", "CWHUD_BARC_Base", "CWHUD_Airborne_Base"};
    };
};

class cfgFunctions
{
    class CloneWarsHUD
    {
        tag = "CWHUD";
        class functions
        {
            file = "\CWHUD\functions";
            F(checkWearHUD);
            F(getWearHUDColor);
            F(getWearHUDType);
            F(setWearHUDColor);
        };
    };
};

class CfgVehicles
{
    class Man;
    class CAManBase : Man
    {
        class ACE_SelfActions
        {
            class ACE_Equipment
            {
                class CWHUD
                {
                    condition = "[_player] call CWHUD_fnc_checkWearHUD";
                    displayName = "HUD Color";
                    icon = "\CWHUD\data\UI\HUD_ca.paa";
                    statement = "";
                    class CWHUD_Base
                    {
                        displayName = "Basic (No Color)";
                        icon = "\CWHUD\data\UI\white_dot_ca.paa";
                        condition = "[_player] call CWHUD_fnc_getWearHUDColor != 'Base'";
                        statement = "[_player, 'Base'] spawn CWHUD_fnc_setWearHUDColor";
                    };
                    class CWHUD_Blue
                    {
                        displayName = "Blue";
                        icon = "\CWHUD\data\UI\blue_dot_ca.paa";
                        condition = "[_player] call CWHUD_fnc_getWearHUDColor != 'Blue'";
                        statement = "[_player, 'Blue'] spawn CWHUD_fnc_setWearHUDColor";
                    };
                    class CWHUD_Green
                    {
                        displayName = "Green";
                        icon = "\CWHUD\data\UI\green_dot_ca.paa";
                        condition = "[_player] call CWHUD_fnc_getWearHUDColor != 'Green'";
                        statement = "[_player, 'Green'] spawn CWHUD_fnc_setWearHUDColor";
                    };
                    class CWHUD_Purple
                    {
                        displayName = "Purple";
                        icon = "\CWHUD\data\UI\purple_dot_ca.paa";
                        condition = "[_player] call CWHUD_fnc_getWearHUDColor != 'Purple'";
                        statement = "[_player, 'Purple'] spawn CWHUD_fnc_setWearHUDColor";
                    };
                    class CWHUD_Red
                    {
                        displayName = "Red";
                        icon = "\CWHUD\data\UI\red_dot_ca.paa";
                        condition = "[_player] call CWHUD_fnc_getWearHUDColor != 'Red'";
                        statement = "[_player, 'Red'] spawn CWHUD_fnc_setWearHUDColor";
                    };
                };
            };
        };
    };
};

class CfgGlasses
{
    class G_Combat; // External class reference

    class CWHUD_Base : G_Combat
    {
        ACE_DustPath = "\z\ace\addons\goggles\textures\fx\dust\%1.paa";
        ACE_Overlay = "";
        ACE_OverlayCracked = "";
        ACE_OverlayDirt = "A3\Ui_f\data\igui\rsctitles\HealthTextures\dust_upper_ca.paa";
        ACE_Protection = 1;
        ACE_Resistance = 1;
        ACE_TintAmount = 0;
        Author;
        ScopePrivate;
        displayName = "HUD Base";
        identityTypes[] = {};
        mass = 1;
        model = "\A3\Weapons_f\DummyNVG";
        picture = "";
    };

    class CWHUD_P1_Base : CWHUD_base
    {
        ACE_Overlay = "\CWHUD\data\P1\Base_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\P1\Base_Cracked_ca.paa";
        Author;
        ScopePublic;
        displayName = "HUD Clone P1";
        picture = "\CWHUD\data\UI\P1_ca.paa";
    };
    class CWHUD_P1_Blue : CWHUD_P1_Base
    {
        ACE_Overlay = "\CWHUD\data\P1\Blue_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\P1\Blue_Cracked_ca.paa";
        Author;
        ScopeProtected;
        displayName = "HUD Clone P1 (Blue)";
        picture = "\CWHUD\data\UI\P1_ca.paa";
    };
    class CWHUD_P1_Green : CWHUD_P1_Base
    {
        ACE_Overlay = "\CWHUD\data\P1\Green_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\P1\Green_Cracked_ca.paa";
        Author;
        ScopeProtected;
        displayName = "HUD Clone P1 (Green)";
        picture = "\CWHUD\data\UI\P1_ca.paa";
    };
    class CWHUD_P1_Purple : CWHUD_P1_Base
    {
        ACE_Overlay = "\CWHUD\data\P1\Purple_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\P1\Purple_Cracked_ca.paa";
        Author;
        ScopeProtected;
        displayName = "HUD Clone P1 (Purple)";
        picture = "\CWHUD\data\UI\P1_ca.paa";
    };
    class CWHUD_P1_Red : CWHUD_P1_Base
    {
        ACE_Overlay = "\CWHUD\data\P1\Red_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\P1\Red_Cracked_ca.paa";
        Author;
        ScopeProtected;
        displayName = "HUD Clone P1 (Red)";
        picture = "\CWHUD\data\UI\P1_ca.paa";
    };

    class CWHUD_P2_Base : CWHUD_base
    {
        ACE_Overlay = "\CWHUD\data\P2\Base_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\P2\Base_Cracked_ca.paa";
        Author;
        ScopePublic;
        displayName = "HUD Clone P2";
        picture = "\CWHUD\data\UI\P2_ca.paa";
    };
    class CWHUD_P2_Blue : CWHUD_P2_Base
    {
        ACE_Overlay = "\CWHUD\data\P2\Blue_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\P2\Blue_Cracked_ca.paa";
        Author;
        ScopeProtected;
        displayName = "HUD Clone P2 (Blue)";
        picture = "\CWHUD\data\UI\P2_ca.paa";
    };
    class CWHUD_P2_Green : CWHUD_P2_Base
    {
        ACE_Overlay = "\CWHUD\data\P2\Green_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\P2\Green_Cracked_ca.paa";
        Author;
        ScopeProtected;
        displayName = "HUD Clone P2 (Green)";
        picture = "\CWHUD\data\UI\P2_ca.paa";
    };
    class CWHUD_P2_Purple : CWHUD_P2_Base
    {
        ACE_Overlay = "\CWHUD\data\P2\Purple_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\P2\Purple_Cracked_ca.paa";
        Author;
        ScopeProtected;
        displayName = "HUD Clone P2 (Purple)";
        picture = "\CWHUD\data\UI\P2_ca.paa";
    };
    class CWHUD_P2_Red : CWHUD_P2_Base
    {
        ACE_Overlay = "\CWHUD\data\P2\Red_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\P2\Red_Cracked_ca.paa";
        Author;
        ScopeProtected;
        displayName = "HUD Clone P2 (Red)";
        picture = "\CWHUD\data\UI\P2_ca.paa";
    };

    class CWHUD_ARF_Base : CWHUD_base
    {
        ACE_Overlay = "\CWHUD\data\ARF\Base_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\ARF\Base_Cracked_ca.paa";
        Author;
        ScopePublic;
        displayName = "HUD Clone ARF";
        picture = "\CWHUD\data\UI\ARF_ca.paa";
    };
    class CWHUD_ARF_Blue : CWHUD_ARF_Base
    {
        ACE_Overlay = "\CWHUD\data\ARF\Blue_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\ARF\Blue_Cracked_ca.paa";
        Author;
        ScopeProtected;
        displayName = "HUD Clone ARF (Blue)";
        picture = "\CWHUD\data\UI\ARF_ca.paa";
    };
    class CWHUD_ARF_Green : CWHUD_ARF_Base
    {
        ACE_Overlay = "\CWHUD\data\ARF\Green_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\ARF\Green_Cracked_ca.paa";
        Author;
        ScopeProtected;
        displayName = "HUD Clone ARF (Green)";
        picture = "\CWHUD\data\UI\ARF_ca.paa";
    };
    class CWHUD_ARF_Purple : CWHUD_ARF_Base
    {
        ACE_Overlay = "\CWHUD\data\ARF\Purple_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\ARF\Purple_Cracked_ca.paa";
        Author;
        ScopeProtected;
        displayName = "HUD Clone ARF (Purple)";
        picture = "\CWHUD\data\UI\ARF_ca.paa";
    };
    class CWHUD_ARF_Red : CWHUD_ARF_Base
    {
        ACE_Overlay = "\CWHUD\data\ARF\Red_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\ARF\Red_Cracked_ca.paa";
        Author;
        ScopeProtected;
        displayName = "HUD Clone ARF (Red)";
        picture = "\CWHUD\data\UI\ARF_ca.paa";
    };

    class CWHUD_BARC_Base : CWHUD_base
    {
        ACE_Overlay = "\CWHUD\data\BARC\Base_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\BARC\Base_Cracked_ca.paa";
        Author;
        ScopePublic;
        displayName = "HUD Clone BARC";
        picture = "\CWHUD\data\UI\BARC_ca.paa";
    };
    class CWHUD_BARC_Blue : CWHUD_BARC_Base
    {
        ACE_Overlay = "\CWHUD\data\BARC\Blue_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\BARC\Blue_Cracked_ca.paa";
        Author;
        ScopeProtected;
        displayName = "HUD Clone BARC (Blue)";
        picture = "\CWHUD\data\UI\BARC_ca.paa";
    };
    class CWHUD_BARC_Green : CWHUD_BARC_Base
    {
        ACE_Overlay = "\CWHUD\data\BARC\Green_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\BARC\Green_Cracked_ca.paa";
        Author;
        ScopeProtected;
        displayName = "HUD Clone BARC (Green)";
        picture = "\CWHUD\data\UI\BARC_ca.paa";
    };
    class CWHUD_BARC_Purple : CWHUD_BARC_Base
    {
        ACE_Overlay = "\CWHUD\data\BARC\Purple_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\BARC\Purple_Cracked_ca.paa";
        Author;
        ScopeProtected;
        displayName = "HUD Clone BARC (Purple)";
        picture = "\CWHUD\data\UI\BARC_ca.paa";
    };
    class CWHUD_BARC_Red : CWHUD_BARC_Base
    {
        ACE_Overlay = "\CWHUD\data\BARC\Red_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\BARC\Red_Cracked_ca.paa";
        Author;
        ScopeProtected;
        displayName = "HUD Clone BARC (Red)";
        picture = "\CWHUD\data\UI\BARC_ca.paa";
    };

    class CWHUD_Airborne_Base : CWHUD_base
    {
        ACE_Overlay = "\CWHUD\data\Airborne\Base_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\Airborne\Base_Cracked_ca.paa";
        Author;
        ScopePublic;
        displayName = "HUD Clone Airborne";
        picture = "\CWHUD\data\UI\Airborne_ca.paa";
    };
    class CWHUD_Airborne_Blue : CWHUD_Airborne_Base
    {
        ACE_Overlay = "\CWHUD\data\Airborne\Blue_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\Airborne\Blue_Cracked_ca.paa";
        Author;
        ScopeProtected;
        displayName = "HUD Clone Airborne (Blue)";
        picture = "\CWHUD\data\UI\Airborne_ca.paa";
    };
    class CWHUD_Airborne_Green : CWHUD_Airborne_Base
    {
        ACE_Overlay = "\CWHUD\data\Airborne\Green_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\Airborne\Green_Cracked_ca.paa";
        Author;
        ScopeProtected;
        displayName = "HUD Clone Airborne (Green)";
        picture = "\CWHUD\data\UI\Airborne_ca.paa";
    };
    class CWHUD_Airborne_Purple : CWHUD_Airborne_Base
    {
        ACE_Overlay = "\CWHUD\data\Airborne\Purple_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\Airborne\Purple_Cracked_ca.paa";
        Author;
        ScopeProtected;
        displayName = "HUD Clone Airborne (Purple)";
        picture = "\CWHUD\data\UI\Airborne_ca.paa";
    };
    class CWHUD_Airborne_Red : CWHUD_Airborne_Base
    {
        ACE_Overlay = "\CWHUD\data\Airborne\Red_ca.paa";
        ACE_OverlayCracked = "\CWHUD\data\Airborne\Red_Cracked_ca.paa";
        Author;
        ScopeProtected;
        displayName = "HUD Clone Airborne (Red)";
        picture = "\CWHUD\data\UI\Airborne_ca.paa";
    };
};