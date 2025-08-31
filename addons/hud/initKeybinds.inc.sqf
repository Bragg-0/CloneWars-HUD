[
	_categoryGlobal,
	QGVAR(key_toggleHud),
	[
		LLSTRING(key_toggleHud),
		LLSTRING(key_toggleHud_description)
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