class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Equipment {
                class GVAR(Interaction) {
                    displayName = CSTRING(Interaction);
                    condition = QUOTE([headgear _player] call EFUNC(hud,getHelmetType) != '');
                    icon = QPATHTOEF(ui,data\logo_ca.paa);
                    class GVAR(Deactivate) {
                        displayName = CSTRING(Deactivate);
                        condition = QUOTE(EGVAR(hud,enabled));
                        statement = QUOTE([false] call EFUNC(hud,setEnabled));
                        icon = QPATHTOEF(ui,data\on_ca.paa);
                    };
                    class GVAR(Activate) {
                        displayName = CSTRING(Activate);
                        condition = QUOTE(!EGVAR(hud,enabled));
                        statement = QUOTE([true] call EFUNC(hud,setEnabled));
                        icon = QPATHTOEF(ui,data\off_ca.paa);
                    };
                    class GVAR(DeactivateSunFilter) {
                        displayName = CSTRING(DeactivateSunFilter);
                        condition = QUOTE(EGVAR(hud,sunFilter));
                        statement = QUOTE([false] call EFUNC(hud,setSunFilter));
                        icon = QPATHTOEF(ui,data\on_ca.paa);
                    };
                    class GVAR(ActivateSunFilter) {
                        displayName = CSTRING(ActivateSunFilter);
                        condition = QUOTE(!EGVAR(hud,sunFilter));
                        statement = QUOTE([true] call EFUNC(hud,setSunFilter));
                        icon = QPATHTOEF(ui,data\off_ca.paa);
                    };
                    class GVAR(Repair) {
                        displayName = CSTRING(Repair);
                        condition = QUOTE([_player] call EFUNC(hud,canRepair));
                        statement = QUOTE([_player] call EFUNC(hud,repair));
                        icon = "\a3\ui_f\data\igui\cfg\simpletasks\types\repair_ca.paa";
                    };
                };
            };
        };
    };
};
