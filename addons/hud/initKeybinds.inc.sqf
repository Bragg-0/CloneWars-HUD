// Keep the same category as v3 so saved keybinds still apply
private _categoryKeybinds = QUOTE(MOD_NAME);

[
    _categoryKeybinds,
    QGVAR(key_toggle),
    [LLSTRING(key_toggle), LLSTRING(key_toggle_description)],
    {
        [] call FUNC(setEnabled);
        true
    },
    {},
    [DIK_MULTIPLY, [false, true, false]]
] call CBA_fnc_addKeybind;

[
    _categoryKeybinds,
    QGVAR(key_toggleSunFilter),
    [LLSTRING(key_toggleSunFilter), LLSTRING(key_toggleSunFilter_description)],
    {
        [] call FUNC(setSunFilter);
        true
    },
    {},
    [DIK_DIVIDE, [false, true, false]]
] call CBA_fnc_addKeybind;

[
    _categoryKeybinds,
    QGVAR(key_repair),
    [LLSTRING(key_repair), LLSTRING(key_repair_description)],
    {
        [player] call FUNC(repair)
    }
] call CBA_fnc_addKeybind;
