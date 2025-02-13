class CWHUD_Menu
{
	idd = IDD_CWHUD_MENU;
	movingEnable = 0;
	enableSimulation = 1;
	class ControlsBackground
	{
		class Background
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.3484375;
			y = safeZoneY + safeZoneH * 0.24351852;
			w = safeZoneW * 0.303125;
			h = safeZoneH * 0.50370371;
			style = 0;
			text = "";
			colorBackground[] = Black25;
			colorText[] = White;
			Font;
			SizeEx;
		};
		class Title
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.3484375;
			y = safeZoneY + safeZoneH * 0.24351852;
			w = safeZoneW * 0.303125;
			h = safeZoneH * 0.025;
			style = 2;
			text = "HUD Menu";
			colorBackground[] = Cyan;
			colorText[] = White;
			Font;
			SizeEx;
		};
		class Frame
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.3484375;
			y = safeZoneY + safeZoneH * 0.24351852;
			w = safeZoneW * 0.303125;
			h = safeZoneH * 0.50370371;
			style = 64;
			text = "";
			colorBackground[] = Transparent;
			colorText[] = Cyan;
			Font;
			SizeEx;
		};
		class TestBackground
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.35364584;
			y = safeZoneY + safeZoneH * 0.275;
			w = safeZoneW * 0.29270834;
			h = safeZoneH * 0.275;
			style = 48;
			text = "..\Data\BackgroundExemple_co.paa";
			colorBackground[] = Transparent;
			colorText[] = White;
			Font;
			SizeEx;
		};
		class TESTHUDBlackBox
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.35364584;
			y = safeZoneY + safeZoneH * 0.275;
			w = safeZoneW * 0.29270834;
			h = safeZoneH * 0.275;
			style = 0;
			text = "";
			colorBackground[] = {0, 0, 0, 0.15};
			colorText[] = Black;
			Font;
			SizeEx;
		};
		class TESTHUDFrame
		{
			type = 0;
			idc = IDC_MENU_TESTHUDFrame;
			x = safeZoneX + safeZoneW * 0.35364584;
			y = safeZoneY + safeZoneH * 0.275;
			w = safeZoneW * 0.29270834;
			h = safeZoneH * 0.275;
			style = 48;
			text = "..\Data\Resources\P2\frame_ca.png";
			colorBackground[] = Transparent;
			colorText[] = White;
			Font;
			SizeEx;
		};
		class TESTHUDColor
		{
			type = 0;
			idc = IDC_MENU_TESTHUDColor;
			x = safeZoneX + safeZoneW * 0.35364584;
			y = safeZoneY + safeZoneH * 0.275;
			w = safeZoneW * 0.29270834;
			h = safeZoneH * 0.275;
			style = 48;
			text = "..\Data\Resources\P2\color_ca.png";
			colorBackground[] = Transparent;
			colorText[] = White;
			Font;
			SizeEx;
		};
		class TESTFrame
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.35364584;
			y = safeZoneY + safeZoneH * 0.275;
			w = safeZoneW * 0.29270834;
			h = safeZoneH * 0.275;
			style = 64;
			text = "";
			colorBackground[] = Transparent;
			colorText[] = White;
			Font;
			SizeEx;
		};
		class ParamsBackgroundColor
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.35364584;
			y = safeZoneY + safeZoneH * 0.55648149;
			w = safeZoneW * 0.29270834;
			h = safeZoneH * 0.18425926;
			style = 64;
			text = "";
			colorBackground[] = {0, 0, 0, 0.75};
			colorText[] = Black;
			Font;
			SizeEx;
		};
		class ParamsTitleColor
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.35364584;
			y = safeZoneY + safeZoneH * 0.55648149;
			w = safeZoneW * 0.29270834;
			h = safeZoneH * 0.025;
			style = 0;
			text = "Update Colors :";
			colorBackground[] = Transparent;
			colorText[] = White;
			Font;
			SizeEx;
		};
		class ParamsFrameColor
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.35364584;
			y = safeZoneY + safeZoneH * 0.55648149;
			w = safeZoneW * 0.29270834;
			h = safeZoneH * 0.18425926;
			style = 64;
			text = "";
			colorBackground[] = Transparent;
			colorText[] = White;
			Font;
			SizeEx;
		};
		class ParamsFrame1Color
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.35364584;
			y = safeZoneY + safeZoneH * 0.55648149;
			w = safeZoneW * 0.29270834;
			h = safeZoneH * 0.02685186;
			style = 64;
			text = "";
			colorBackground[] = Transparent;
			colorText[] = White;
			Font;
			SizeEx;
		};
	};
	class Controls
	{
		class slider_green
		{
			type = 43;
			idc = IDC_MENU_slider_green;
			x = safeZoneX + safeZoneW * 0.36302084;
			y = safeZoneY + safeZoneH * 0.63240741;
			w = safeZoneW * 0.27395834;
			h = safeZoneH * 0.02685186;
			style = 1024;
			SliderStyle;
			color[] = Green;
			colorActive[] = Green;
			onSliderPosChanged = "[player] call CWHUD_fnc_onSliderPosChanged;";
		};
		class slider_red
		{
			type = 43;
			idc = IDC_MENU_slider_red;
			x = safeZoneX + safeZoneW * 0.36302084;
			y = safeZoneY + safeZoneH * 0.59537038;
			w = safeZoneW * 0.27395834;
			h = safeZoneH * 0.02685186;
			style = 1024;
			SliderStyle;
			color[] = Red;
			colorActive[] = Red;
			onSliderPosChanged = "[player] call CWHUD_fnc_onSliderPosChanged;";
		};
		class slider_blue
		{
			type = 43;
			idc = IDC_MENU_slider_blue;
			x = safeZoneX + safeZoneW * 0.36302084;
			y = safeZoneY + safeZoneH * 0.66944445;
			w = safeZoneW * 0.27395834;
			h = safeZoneH * 0.02685186;
			style = 1024;
			SliderStyle;
			color[] = Blue;
			colorActive[] = Blue;
			onSliderPosChanged = "[player] call CWHUD_fnc_onSliderPosChanged;";
		};
		class slider_alpha
		{
			type = 43;
			idc = IDC_MENU_slider_alpha;
			x = safeZoneX + safeZoneW * 0.36302084;
			y = safeZoneY + safeZoneH * 0.70648149;
			w = safeZoneW * 0.27395834;
			h = safeZoneH * 0.02685186;
			style = 1024;
			SliderStyle;
			color[] = Gray;
			colorActive[] = Gray;
			onSliderPosChanged = "[player] call CWHUD_fnc_onSliderPosChanged;";
		};
	};
};
