[
	QGVAR(enable),
	"CHECKBOX",
	[
		LLSTRING(enable),
		LLSTRING(enable_Description)
	],
	_categoryGlobal,
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
	_categoryGlobal,
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
	_categoryGlobal,
	false,
	0
] call CBA_fnc_addSetting;

[
	QGVAR(brokenChance),
	"SLIDER",
	[
		LLSTRING(brokenChance),
		LLSTRING(brokenChance_Description)
	],
	_categoryGlobal,
	[0, 1, 0.1, 1, true],
	1,
	{},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(color),
	"COLOR",
	[
		LLSTRING(color),
		LLSTRING(color_Description)
	],
	_categoryColors,
	[0,0.447,0.741,1],
	0,
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
	_categoryListHelmets,
	_listDefaultARFHelmet,
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
	_categoryListHelmets,
	_listDefaultBARCHelmet,
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
	_categoryListHelmets,
	_listDefaultP1Helmet,
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
	_categoryListHelmets,
	_listDefaultP2Helmet,
	1,
	{},
	true
] call CBA_fnc_addSetting;
