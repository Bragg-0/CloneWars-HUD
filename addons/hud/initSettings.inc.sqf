private _categoryGlobal = QUOTE(MOD_NAME);
private _categoryColors = [QUOTE(MOD_NAME), "Colors"];
private _categoryDisplay = [QUOTE(MOD_NAME), "Display"];
private _categoryDamage = [QUOTE(MOD_NAME), "Damage"];
private _categoryListHelmets = [QUOTE(MOD_NAME), "Helmets"];

// Changing a helmet list rebuilds the helmet cache, no restart needed
private _fnc_resetHelmets = {
    GVAR(helmetRoots) = nil;
};

// General
[
    QGVAR(enableByDefault),
    "CHECKBOX",
    [LLSTRING(enableByDefault), LLSTRING(enableByDefault_Description)],
    _categoryGlobal,
    true
] call CBA_fnc_addSetting;

[
    QGVAR(sunFilterByDefault),
    "CHECKBOX",
    [LLSTRING(sunFilterByDefault), LLSTRING(sunFilterByDefault_Description)],
    _categoryGlobal,
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enableThirdPerson),
    "CHECKBOX",
    [LLSTRING(enableThirdPerson), LLSTRING(enableThirdPerson_Description)],
    _categoryGlobal,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(hideInVisionModes),
    "CHECKBOX",
    [LLSTRING(hideInVisionModes), LLSTRING(hideInVisionModes_Description)],
    _categoryGlobal,
    true
] call CBA_fnc_addSetting;

// Display
[
    QGVAR(scale),
    "SLIDER",
    [LLSTRING(scale), LLSTRING(scale_Description)],
    _categoryDisplay,
    [0.5, 1.5, 1, 0, true]
] call CBA_fnc_addSetting;

[
    QGVAR(opacity),
    "SLIDER",
    [LLSTRING(opacity), LLSTRING(opacity_Description)],
    _categoryDisplay,
    [0.2, 1, 1, 0, true]
] call CBA_fnc_addSetting;

// Colors
[
    QGVAR(color),
    "COLOR",
    [LLSTRING(color), LLSTRING(color_Description)],
    _categoryColors,
    [CWH_COLOR_DEFAULT]
] call CBA_fnc_addSetting;

[
    QGVAR(enableRGB),
    "CHECKBOX",
    [LLSTRING(enableRGB), LLSTRING(enableRGB_Description)],
    _categoryColors,
    false
] call CBA_fnc_addSetting;

// Damage
[
    QGVAR(brokenChance),
    "SLIDER",
    [LLSTRING(brokenChance), LLSTRING(brokenChance_Description)],
    _categoryDamage,
    [0, 1, 0.1, 0, true],
    1
] call CBA_fnc_addSetting;

[
    QGVAR(repairTime),
    "SLIDER",
    [LLSTRING(repairTime), LLSTRING(repairTime_Description)],
    _categoryDamage,
    [1, 30, 5, 0],
    1
] call CBA_fnc_addSetting;

// Helmet lists. Format: ["class1", "class2"] or class1, class2. Inherited helmets are included.
[
    QGVAR(listARFHelmet),
    "EDITBOX",
    [LLSTRING(listARFHelmet), LLSTRING(listARFHelmet_Description)],
    _categoryListHelmets,
    str ["ls_gar_phase1Arf_helmet", "ls_gar_scout_helmet", "ls_gar_engineer_helmet", "ls_gar_phase2Arf_helmet", "ls_cloneHelmet_arf"],
    1,
    _fnc_resetHelmets
] call CBA_fnc_addSetting;

[
    QGVAR(listBARCHelmet),
    "EDITBOX",
    [LLSTRING(listBARCHelmet), LLSTRING(listBARCHelmet_Description)],
    _categoryListHelmets,
    str ["JLTS_CloneHelmetAB", "JLTS_CloneHelmetBARC", "ls_gar_barc_helmet", "ls_gar_airborne_helmet", "ls_cloneHelmet_airborne", "ls_gar_phase2Insulated_helmet"],
    1,
    _fnc_resetHelmets
] call CBA_fnc_addSetting;

[
    QGVAR(listP1Helmet),
    "EDITBOX",
    [LLSTRING(listP1Helmet), LLSTRING(listP1Helmet_Description)],
    _categoryListHelmets,
    str ["ls_gar_phase1_helmet", "ls_gar_phase1Pilot_helmet", "ls_sob_phase1SpecOp_helmet", "ls_gar_rex_helmet", "ls_sob_commando_helmet"],
    1,
    _fnc_resetHelmets
] call CBA_fnc_addSetting;

[
    QGVAR(listP2Helmet),
    "EDITBOX",
    [LLSTRING(listP2Helmet), LLSTRING(listP2Helmet_Description)],
    _categoryListHelmets,
    str ["JLTS_CloneHelmetP2", "JLTS_CloneHelmetP2MC", "JLTS_CloneHelmetP2_rework", "ls_gar_phase2_helmet", "ls_gar_phase2Pilot_helmet", "ls_sob_phase2SpecOp_helmet", "ls_cloneHelmet_phase2", "ls_cloneHelmet_phase2Pilot", "ls_cloneHelmet_arc", "ls_gar_arc_helmet"],
    1,
    _fnc_resetHelmets
] call CBA_fnc_addSetting;
