class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Equipment {
                class GVAR(Interaction) {
                    displayName = CSTRING(Interaction);
                    condition = QUOTE([_player] call FUNC(canInteract));
                    class GVAR(Deactivate) {
                        displayName = CSTRING(Deactivate);
                        condition = QUOTE(_player getVariable [ARR_2(QQEGVAR(hud,active),false)]);
                        statement = QUOTE([_player] call EFUNC(hud,deactivate));
                    };
                    class GVAR(Activate) {
                        displayName = CSTRING(Activate);
                        condition = QUOTE(!(_player getVariable [ARR_2(QQEGVAR(hud,active),false)]));
                        statement = QUOTE([_player] call EFUNC(hud,activate));
                    };
                    class GVAR(Repair) {
                        displayName = CSTRING(Repair);
                        condition = QUOTE(_player getVariable [ARR_2(QQEGVAR(hud,broken),false)]);
                        statement = QUOTE([_player] call EFUNC(hud,repair));
                    };
                    class GVAR(DisableSunfilter) {
                        displayName = CSTRING(DisableSunfilter);
                        condition = QUOTE(_player getVariable [ARR_2(QQEGVAR(hud,sunfilter),false)]);
                        statement = QUOTE([_player] call EFUNC(hud,disableSunfilter));
                    };
                    class GVAR(EnableSunfilter) {
                        displayName = CSTRING(EnableSunfilter);
                        condition = QUOTE(!(_player getVariable [ARR_2(QQEGVAR(hud,sunfilter),false)]));
                        statement = QUOTE([_player] call EFUNC(hud,enableSunfilter));
                    };
                };
            };
        };
    };
};
