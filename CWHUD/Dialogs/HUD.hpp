class CloneWarsHUD
{
	idd = IDD_HUD;
	movingEnable = 0;
	fadein = 0;
	duration = 36000000;
	fadeout = 0;
	name = "CloneWarsHUD";
	onLoad = "uiNamespace setVariable ['CloneWarsHUD',_this select 0]";
	onUnLoad = "uinamespace setVariable ['CloneWarsHUD', nil]";
	class controls
	{
		class SunFilter
		{
			type = 0;
			idc = IDC_HUD_SUNFILTER;
			HUD_fullScreen;
			style = 0;
			text = "";
			colorBackground[] = Black25;
			colorText[] = Transparent;
			Font;
			SizeEx;
		};
		class Frame
		{
			type = 0;
			idc = IDC_HUD_FRAME;
			HUD_fullScreen;
			style = 48;
			text = "";
			colorBackground[] = Transparent;
			colorText[] = White;
			Font;
			SizeEx;
		};
		class Color
		{
			type = 0;
			idc = IDC_HUD_COLOR;
			HUD_fullScreen;
			style = 48;
			text = "";
			colorBackground[] = Transparent;
			colorText[] = White;
			Font;
			SizeEx;
		};
	};
};