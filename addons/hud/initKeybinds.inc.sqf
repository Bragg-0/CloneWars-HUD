[
	_categoryGlobal,
	QGVAR(key_toggle),
	[
		LLSTRING(key_toggle),
		LLSTRING(key_toggle_description)
	],
	{
		if (player getVariable [QGVAR(active), false]) then {
			[player] call FUNC(deactivate);
		} else {
			[player] call FUNC(activate);
		};
	},
	{},
	[DIK_MULTIPLY, [false, true, false]]
] call CBA_fnc_addKeybind;

[
	_categoryGlobal,
	QGVAR(key_repair),
	[
		LLSTRING(key_repair),
		LLSTRING(key_repair_description)
	],
	{
		if (player getVariable [QGVAR(broken), false]) then {
			[player] call FUNC(repair);
		};
	}
] call CBA_fnc_addKeybind;

[
	_categoryGlobal,
	QGVAR(key_toggleSunfilter),
	[
		LLSTRING(key_toggleSunfilter),
		LLSTRING(key_toggleSunfilter_description)
	],
	{
		if (player getVariable [QGVAR(sunfilter), false]) then {
			[player] call FUNC(disableSunfilter);
		} else {
			[player] call FUNC(enableSunfilter);
		};
	}
] call CBA_fnc_addKeybind;
