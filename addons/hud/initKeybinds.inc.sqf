[
	_categoryGlobal,
	QGVAR(key_toggle),
	[
		LLSTRING(key_toggle),
		LLSTRING(key_toggle_description)
	],
	{
		if (player getVariable [QGVAR(active), GVAR(enableByDefault)]) then {
			[] call FUNC(deactivate);
			player setVariable [QGVAR(active), false, true];
		} else {
			[] call FUNC(activate);
			player setVariable [QGVAR(active), true, true];
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

