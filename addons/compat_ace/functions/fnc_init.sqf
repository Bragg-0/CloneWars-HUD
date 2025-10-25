#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_compat_ace_fnc_init
Description:
    Initializes the ACE compatibility layer.

Parameters:
    <NONE>

Returns:
    <NONE>

Examples
    (begin example)
        [] call cwh_compat_ace_fnc_init
    (end)

Author:
    Bragg
---------------------------------------------------------------------------- */

TRACE_1("fnc_init",_this);

// Move ACE stamina bar when HUD is active
[
    {
        params ["_param", "_handle"];
        if (isNull player) exitWith {
            [_handle] call CBA_fnc_removePerFrameHandler;
            TRACE_1("fnc_init - Exiting perFrameHandler (Move ACE stamina bar when HUD is active) as player is null",_this);
        };
        private _control = uiNamespace getVariable "ace_advanced_fatigue_staminaBarContainer";
        if (player getVariable [QEGVAR(hud,active), false]) then {
            // is disabled
			_control ctrlSetPosition [
                (profileNamespace getVariable ["IGUI_GRID_STAMINA_X", ((safeZoneX + safeZoneW) - (10 * (((safeZoneW / safeZoneH) min 1.2) / 40)) - 4.3 * (((safeZoneW / safeZoneH) min 1.2) / 40))]),
                (profileNamespace getVariable ["IGUI_GRID_STAMINA_Y", (safeZoneY + 4.05 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25))])
            ];
            _control ctrlCommit 0;
		} else {
			// is enabled
            _control ctrlSetPosition [
                safeZoneX + safeZoneW * 0.00677084,
                safeZoneY + safeZoneH * 0.01203704
            ];
            _control ctrlCommit 0;
		};
    },
    1
] call CBA_fnc_addPerFrameHandler;
