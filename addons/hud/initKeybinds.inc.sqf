[
	_categoryGlobal,
	QGVAR(key_toggle),
	[
		LLSTRING(key_toggle),
		LLSTRING(key_toggle_description)
	],
	{
		private _isActive = player getVariable [QGVAR(active), GVAR(enableByDefault)];
		player setVariable [QGVAR(active), !_isActive, true];
		[] call FUNC(update);
	},
	{},
	[DIK_MULTIPLY, [false, true, false]]
] call CBA_fnc_addKeybind;

[
	_categoryGlobal,
	QGVAR(key_toggleSunFilter),
	[
		LLSTRING(key_toggleSunFilter),
		LLSTRING(key_toggleSunFilter_description)
	],
	{
		private _isSunFilterEnabled = player getVariable [QGVAR(enableSunFilter), GVAR(enableByDefault)];
		player setVariable [QGVAR(enableSunFilter), !_isSunFilterEnabled, true];
		[] call FUNC(update);
	},
	{},
	[DIK_DIVIDE, [false, true, false]]
] call CBA_fnc_addKeybind;

[
	_categoryGlobal,
	QGVAR(key_repair),
	[
		LLSTRING(key_repair),
		LLSTRING(key_repair_description)
	],
	{
		if (player getVariable [QGVAR(broken), false] && ([headgear player] call FUNC(getHelmetType) != 'NONE')) then {
			[] call FUNC(repair);
		};
	}
] call CBA_fnc_addKeybind;

