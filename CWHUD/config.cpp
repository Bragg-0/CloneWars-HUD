#include "macro.hpp"

class CfgPatches
{
    class CWHUD
    {
        name = "Clone Wars HUD";
        author = "Bragg [CWHUD]";
        requiRedAddons[] = {"A3_Functions_F", "ace_interact_menu"};
        units[] = {};
        weapons[] = {};
    };
};

class cfgFunctions
{
    class CloneWarsHUD
    {
        tag = "CWHUD";
        class HUD
        {
            file = "\CWHUD\functions\dialogsHUD";
            F(checkAvailableHUD);              // ? CWHUD_fnc_checkAvailableHUD : Function to check if the HUD is available, returns true if the HUD is available
            F(enableHUD);                      // ? CWHUD_fnc_enableHUD : Function to enable the HUD
            F(enableSunFilter);                // ? CWHUD_fnc_enableSunFilter : Function to enable the sun filter
            F(getHUDTexture);                  // ? CWHUD_fnc_getHUDTexture : Function to get the HUD texture path based on the HUD type return a array [frameTexture, colorTexture]
            F(onSwitchExternalViewDisableHUD); // ? CWHUD_fnc_onSwitchExternalViewDisableHUD : Function to disable the HUD when switching to external view
            F(updateHUD);                      // ? CWHUD_fnc_updateHUD : Function to update the HUD
            F(updateSunFilter);                // ? CWHUD_fnc_updateSunFilter : Function to update the sun filter
            F_PostInit(initHUD);               // ? CWHUD_fnc_initHUD : Function to initialize the HUD
        };
        class Menu
        {
            file = "\CWHUD\functions\dialogsMenu";
            F(onSliderPosChanged); // ? : CWHUD_fnc_onSliderPosChanged : Function to change the color of the HUD on preview
            F(openMenu);           // ? : CWHUD_fnc_openMenu : Function to open the menu
        };
    };
};

#include "Dialogs\HUD.hpp"  // ? : class CWHUD_HUD { ... } - HUD RscTitles
#include "Dialogs\Menu.hpp" // ? : class CWHUD_Menu { ... } - Menu Dialog

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
                    condition = "[_player] call CWHUD_fnc_checkAvailableHUD";
                    displayName = "HUD Color";
                    icon = "\CWHUD\data\UI\logo_ca.paa";
                    class CWHUD_OPENMENU
                    {
                        condition = "[_player] call CWHUD_fnc_checkAvailableHUD";
                        displayName = "HUD Color";
                        icon = "\CWHUD\data\UI\button_menu_ca.paa";
                        statement = "[_player] call CWHUD_fnc_openMenu";
                    };
                    class CWHUD_ENABLEHUD
                    {
                        condition = "[_player] call CWHUD_fnc_checkAvailableHUD && !(_player getVariable ['CWHUD_enable', false])";
                        displayName = "Enable HUD";
                        icon = "\CWHUD\data\UI\button_on_ca.paa";
                        statement = "[_player, true] call CWHUD_fnc_enableHUD";
                    };
                    class CWHUD_DISABLEHUD
                    {
                        condition = "[_player] call CWHUD_fnc_checkAvailableHUD && (_player getVariable ['CWHUD_enable', false])";
                        displayName = "Disable HUD";
                        icon = "\CWHUD\data\UI\button_off_ca.paa";
                        statement = "[_player, false] call CWHUD_fnc_enableHUD";
                    };
                    class CWHUD_ENABLESUNFILTER
                    {
                        condition = "[_player] call CWHUD_fnc_checkAvailableHUD && !(_player getVariable ['CWHUD_sunFilter', false])";
                        displayName = "Enable Sun Filter";
                        icon = "\CWHUD\data\UI\button_on_sunfilter_ca.paa";
                        statement = "[_player, true] call CWHUD_fnc_enableSunFilter";
                    };
                    class CWHUD_DISABLESUNFILTER
                    {
                        condition = "[_player] call CWHUD_fnc_checkAvailableHUD && (_player getVariable ['CWHUD_sunFilter', false])";
                        displayName = "Disable Sun Filter";
                        icon = "\CWHUD\data\UI\button_off_sunfilter_ca.paa";
                        statement = "[_player, false] call CWHUD_fnc_enableSunFilter";
                    };
                    class CWHUD_REFRESH
                    {
                        condition = "[_player] call CWHUD_fnc_checkAvailableHUD";
                        displayName = "Refresh HUD";
                        icon = "\CWHUD\data\UI\button_reload_ca.paa";
                        statement = "[_player] call CWHUD_fnc_updateHUD";
                    };
                };
            };
        };
    };
};

class Extended_PreInit_EventHandlers
{
    class CWHUD_PreInit
    {
        init = "call compile preprocessFileLineNumbers 'XEH_preInit.sqf'";
    };
};