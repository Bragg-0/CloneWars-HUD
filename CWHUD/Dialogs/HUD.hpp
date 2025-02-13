class CloneWarsHUD
{
	idd = IDD_CWHUD_HUD;
	movingEnable = 0;
	fadein = 1;
	duration = 36000000;
	fadeout = 1;
	name = "CloneWarsHUD";
	class controls
	{
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
	};
};