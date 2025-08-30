[
	QGVAR(enable),
	"CHECKBOX",
	[
		LLSTRING(enable),
		LLSTRING(enable_Description)
	],
	_category,
	true,
	2,
	{}
] call CBA_fnc_addSetting;

[
	QGVAR(enableByDefault),
	"CHECKBOX",
	[
		LLSTRING(enableByDefault),
		LLSTRING(enableByDefault_Description)
	],
	_category,
	true,
	1,
	{},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(enableThirdPerson),
	"CHECKBOX",
	[
		LLSTRING(enableThirdPerson),
		LLSTRING(enableThirdPerson_Description)
	],
	_category,
	false,
	0
] call CBA_fnc_addSetting;

[
	QGVAR(brokenHUDChance),
	"SLIDER",
	[
		LLSTRING(brokenChance),
		LLSTRING(brokenChance_Description)
	],
	_category,
	[0, 1, 0.2, 1, true],
	1,
	{},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(listARFHelmet),
	"EDITBOX",
	[
		LLSTRING(listARFHelmet),
		LLSTRING(listARFHelmet_Description)
	],
	_category,
	"[]",
	1,
	{},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(listBARCHelmet),
	"EDITBOX",
	[
		LLSTRING(listBARCHelmet),
		LLSTRING(listBARCHelmet_Description)
	],
	_category,
	"[]",
	1,
	{},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(listP1Helmet),
	"EDITBOX",
	[
		LLSTRING(listP1Helmet),
		LLSTRING(listP1Helmet_Description)
	],
	_category,
	"[]",
	1,
	{},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(listP2Helmet),
	"EDITBOX",
	[
		LLSTRING(listP2Helmet),
		LLSTRING(listP2Helmet_Description)
	],
	_category,
	"[]",
	1,
	{},
	true
] call CBA_fnc_addSetting;