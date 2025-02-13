[
	"CWHUD_classListType",
	"EDITBOX",
	[
		"Helmet Classname and Type List",
		"Add a helmet to the system without changing the config file. Format: ['classname', 'type'] (type: P1, P2, ARF, BARC)"
	],
	"Clone Wars HUD",
	"[]",
	0,
	{},
	true
] call CBA_fnc_addSetting;

[
	"CWHUD_enableByDefault",
	"CHECKBOX",
	[
		"Load hud by default",
		"Enable the HUD by default."
	],
	"Clone Wars HUD",
	true,
	0,
	{}
] call CBA_fnc_addSetting;