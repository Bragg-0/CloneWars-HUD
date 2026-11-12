#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_updateHealth
Description:
    Updates the health block (two rows: label, bar, value).
    - Vanilla: health and stamina.
    - ACE medical: blood volume and pain.
    Colors are applied by fnc_updateColor.

Parameters:
    <NONE>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

if (!GVAR(showHealth)) exitWith {
    {
        _x ctrlShow false;
    } forEach CWH_CTRL_HEALTH;
};

{
    _x ctrlShow true;
} forEach CWH_CTRL_HEALTH;

private ["_label1", "_value1", "_label2", "_value2"];

if (GVAR(aceMedical)) then {
    // Blood volume: 6 l when healthy, fatal around 3.6 l
    _label1 = LLSTRING(health_blood);
    _value1 = ((((player getVariable ["ace_medical_bloodVolume", 6]) - 3.6) / 2.4) max 0) min 1;
    // Perceived pain (pain minus painkillers)
    _label2 = LLSTRING(health_pain);
    _value2 = (((player getVariable ["ace_medical_pain", 0]) - (player getVariable ["ace_medical_painSuppress", 0])) max 0) min 1;
    GVAR(healthRow2Warning) = _value2 > 0.5;
} else {
    _label1 = LLSTRING(health_health);
    _value1 = 1 - damage player;
    _label2 = LLSTRING(health_stamina);
    _value2 = 1 - getFatigue player;
    GVAR(healthRow2Warning) = _value2 < 0.25;
};

GVAR(healthRow1Low) = _value1 < 0.25;

CWH_CTRL_HEALTH_LABEL_1 ctrlSetText _label1;
CWH_CTRL_HEALTH_BAR_1 progressSetPosition _value1;
CWH_CTRL_HEALTH_VALUE_1 ctrlSetText format ["%1%2", round (_value1 * 100), "%"];

CWH_CTRL_HEALTH_LABEL_2 ctrlSetText _label2;
CWH_CTRL_HEALTH_BAR_2 progressSetPosition _value2;
CWH_CTRL_HEALTH_VALUE_2 ctrlSetText format ["%1%2", round (_value2 * 100), "%"];
