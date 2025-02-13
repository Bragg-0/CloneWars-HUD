#include "macro.hpp"

class CfgPatches
{
    class CWHUD
    {
        name = "Clone Wars HUD";
        Author;
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
            F(initHUD);                        // ? CWHUD_fnc_initHUD : Function to initialize the HUD
            F(onSwitchExternalViewDisableHUD); // ? CWHUD_fnc_onSwitchExternalViewDisableHUD : Function to disable the HUD when switching to external view
            F(openHUD);                        // ? CWHUD_fnc_openHUD : Function to open the HUD
            F(setHUDColor);                    // ? CWHUD_fnc_setHUDColor : Function to set the HUD color
            F(setHUDType);                     // ? CWHUD_fnc_setHUDType : Function to set the HUD type
            F(getStateHUD);                    // ? CWHUD_fnc_stateHUD : Function to get the HUD state, returns true if the HUD is enabled
        };
        class Menu
        {
            file = "\CWHUD\functions\dialogsMenu";
            F(loadParams); // ? : CWHUD_fnc_loadParams : Function to load the parameters
            F(openMenu);   // ? : CWHUD_fnc_openMenu : Function to open the menu
            F(saveParams); // ? : CWHUD_fnc_saveParams : Function to save the parameters
        };
    };
};

#include "Dialogs\HUD.hpp"
#include "Dialogs\Menu.hpp"

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