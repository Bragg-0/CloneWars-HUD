#include "./macros.hpp"
#include "./functions/script_component.hpp"

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
            file = "\CWHUD\functions\HUD";
            F(checkAvailableHUD);
            F(enableHUD);
            F(enableSunFilter);
            F(getHUDTexture);
            F(setupHUD);
            F(updateHUD);
            F_PostInit(initHUD);
        };
        class Menu
        {
            file = "\CWHUD\functions\Menu";
            F(onLoadMenu);
            F(onSliderPosChanged);
        };
    };
};

class CfgRemoteExec
{
    class Functions
    {
        mode = 2;
        jip = 1;

        /* Client only functions */
        RemoteExec(CWHUD_fnc_checkAvailableHUD, CLIENT);
        RemoteExec(CWHUD_fnc_enableHUD, CLIENT);
        RemoteExec(CWHUD_fnc_enableSunFilter, CLIENT);
        RemoteExec(CWHUD_fnc_getHUDTexture, CLIENT);
        RemoteExec(CWHUD_fnc_onLoadMenu, CLIENT);
        RemoteExec(CWHUD_fnc_onSliderPosChanged, CLIENT);
        RemoteExec(CWHUD_fnc_setupHUD, CLIENT);
        RemoteExec(CWHUD_fnc_updateHUD, CLIENT);

        /* Server only functions */

        /* Functions for everyone */
        RemoteExec(CWHUD_fnc_initHUD, ANYONE);
    };
};

class RscTitles
{
#include "./Dialogs/HUD.hpp"
};

#include "./Dialogs/Menu.hpp"

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
                    displayName = "HUD";
                    icon = "\CWHUD\data\UI\logo_ca.paa";
                    class CWHUD_OPENMENU
                    {
                        condition = "[_player] call CWHUD_fnc_checkAvailableHUD";
                        displayName = "HUD Color";
                        icon = "\CWHUD\data\UI\button_menu_ca.paa";
                        statement = "createDialog ['CloneWarsHUD_MENU', true];";
                    };
                    class CWHUD_ENABLEHUD
                    {
                        condition = "[_player] call CWHUD_fnc_checkAvailableHUD && !(profileNamespace getVariable ['CWHUD_enable', false])";
                        displayName = "Enable HUD";
                        icon = "\CWHUD\data\UI\button_on_ca.paa";
                        statement = "[_player, true] call CWHUD_fnc_enableHUD";
                    };
                    class CWHUD_DISABLEHUD
                    {
                        condition = "[_player] call CWHUD_fnc_checkAvailableHUD && (profileNamespace getVariable ['CWHUD_enable', false])";
                        displayName = "Disable HUD";
                        icon = "\CWHUD\data\UI\button_off_ca.paa";
                        statement = "[_player, false] call CWHUD_fnc_enableHUD";
                    };
                    class CWHUD_ENABLESUNFILTER
                    {
                        condition = "[_player] call CWHUD_fnc_checkAvailableHUD && !(profileNamespace getVariable ['CWHUD_enableSunfilter', false]) && (profileNamespace getVariable ['CWHUD_enable', false])";
                        displayName = "Enable Sun Filter";
                        icon = "\CWHUD\data\UI\button_on_sunfilter_ca.paa";
                        statement = "[_player, true] call CWHUD_fnc_enableSunFilter";
                    };
                    class CWHUD_DISABLESUNFILTER
                    {
                        condition = "[_player] call CWHUD_fnc_checkAvailableHUD && (profileNamespace getVariable ['CWHUD_enableSunfilter', false]) && (profileNamespace getVariable ['CWHUD_enable', false])";
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
        init = "call compile preprocessFileLineNumbers '\CWHUD\functions\XEH_preInit.sqf'";
    };
};