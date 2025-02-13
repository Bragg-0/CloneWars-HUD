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
            F(disableHUD);                     // ? CWHUD_fnc_disableHUD : Function to disable the HUD
            F(enableHUD);                      // ? CWHUD_fnc_enableHUD : Function to enable the HUD
            F(getHUDTexture);                  // ? CWHUD_fnc_getHUDTexture : Function to get the HUD texture path based on the HUD type return a array [frameTexture, colorTexture]
            F(getStateHUD);                    // ? CWHUD_fnc_stateHUD : Function to get the HUD state, returns true if the HUD is enabled
            F(initHUD);                        // ? CWHUD_fnc_initHUD : Function to initialize the HUD
            F(onSwitchExternalViewDisableHUD); // ? CWHUD_fnc_onSwitchExternalViewDisableHUD : Function to disable the HUD when switching to external view
            F(openHUD);                        // ? CWHUD_fnc_openHUD : Function to open the HUD
            F(setHUDColor);                    // ? CWHUD_fnc_setHUDColor : Function to set the HUD color
            F(setHUDType);                     // ? CWHUD_fnc_setHUDType : Function to set the HUD type
        };
        class Menu
        {
            file = "\CWHUD\functions\dialogsMenu";
            F(onSliderPosChanged); // ? : CWHUD_fnc_onSliderPosChanged : Function to change the color of the HUD on preview
            F(openMenu);           // ? : CWHUD_fnc_openMenu : Function to open the menu
        };
    };
};

#include "Dialogs\HUD.hpp"  // ? : class CWHUD_HUD { ... } - HUD Dialog
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
                    statement = "[_player] call CWHUD_fnc_openMenu";
                };
            };
        };
    };
};