class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Equipment {
                class GVAR(Interaction) {
                    displayName = CSTRING(Interaction);
                    condition = QUOTE([headgear _player] call EFUNC(hud,getHelmetType) != 'NONE');
                    class GVAR(Deactivate) {
                        displayName = CSTRING(Deactivate);
                        condition = QUOTE(_player getVariable [ARR_2(QQEGVAR(hud,active),EGVAR(hud,enableByDefault))]);
                        statement = QUOTE(_player setVariable [ARR_3(QQEGVAR(hud,active),false,true)];[] call EFUNC(hud,update););
                    };
                    class GVAR(Activate) {
                        displayName = CSTRING(Activate);
                        condition = QUOTE(!(_player getVariable [ARR_2(QQEGVAR(hud,active),EGVAR(hud,enableByDefault))]));
                        statement = QUOTE(_player setVariable [ARR_3(QQEGVAR(hud,active),true,true)];[] call EFUNC(hud,update););
                    };
                    class GVAR(DeactivateSunFilter) {
                        displayName = CSTRING(DeactivateSunFilter);
                        condition = QUOTE(_player getVariable [ARR_2(QQEGVAR(hud,enableSunFilter),EGVAR(hud,enableByDefault))]);
                        statement = QUOTE(_player setVariable [ARR_3(QQEGVAR(hud,enableSunFilter),false,true)];[] call EFUNC(hud,update););
                    };
                    class GVAR(ActivateSunFilter) {
                        displayName = CSTRING(ActivateSunFilter);
                        condition = QUOTE(!(_player getVariable [ARR_2(QQEGVAR(hud,enableSunFilter),EGVAR(hud,enableByDefault))]));
                        statement = QUOTE(_player setVariable [ARR_3(QQEGVAR(hud,enableSunFilter),true,true)];[] call EFUNC(hud,update););
                    };
                    class GVAR(Repair) {
                        displayName = CSTRING(Repair);
                        condition = QUOTE(_player getVariable [ARR_2(QQEGVAR(hud,broken),false)]);
                        statement = QUOTE([_player] call EFUNC(hud,repair));
                        icon = "\a3\ui_f\data\igui\cfg\simpletasks\types\repair_ca.paa";
                    };
                };
            };
        };
    };
};
