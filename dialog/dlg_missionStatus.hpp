/*
	Code written by Haz
*/

#include "..\dlg_missionStatus_IDCs.hpp"

class dlg_missionStatus
{
	idd = 13579;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable [""disp_missionStatus"", (_this select 0)]; [] call tky_fnc_fixTextHeight; [] call tky_fnc_missionStatus;";
	onUnload = "uiNamespace setVariable [""disp_missionStatus"", nil];";
	class controls
	{
		class title : Haz_RscTitleBar
		{
			idc = idc_title;
			x = 0.3 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.4 * safezoneW;
			h = 0.04 * safezoneH;
			text = "";
			colorBackground[] = {0.56, 0.52, 0.42, 1};
		};
		class title_left : Haz_RscStructuredText
		{
			idc = idc_title_left;
			x = 0.3 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.04 * safezoneH;
			text = "<t size='1.0' align='left' color='#FFFFFF'>Authority Mission Status</t>";
			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.75)";
		};
		class title_right : Haz_RscStructuredText
		{
			idc = idc_title_right;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.04 * safezoneH;
			text = "<t size='1.0' align='right' color='#FFFFFF'><img size='1.0' color='#FFFFFF' image='\A3\ui_f\data\gui\cfg\ranks\corporal_gs.paa'/>Haz</t>";
			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.75)";
		};
		class background : Haz_RscPicture
		{
			idc = idc_background;
			x = 0.3 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.4 * safezoneW;
			h = 0.44 * safezoneH;
			// text = "#(argb,8,8,3)color(0.25,0.25,0.22,1)";
			text = "pics\bg2.paa";
		};
		class close : Haz_RscButton
		{
			idc = idc_close;
			x = 0.3 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.075 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Close";
			action = "closeDialog 0;";
			period = 0;
			periodFocus = 0;
			periodOver = 0;
			color[] = {0.25, 0.25, 0.22, 1};
			color2[] = {0.25, 0.25, 0.22, 1};
			colorFocused[] = {0.25, 0.25, 0.22, 1};
			colorFocusedSecondary[] = {0.25, 0.25, 0.22, 1};
			colorSecondary[] = {0.25, 0.25, 0.22, 1};
			color2Secondary[] = {0.25, 0.25, 0.22, 1};
			colorBackground[] = {0.56, 0.52, 0.42, 1};
			colorBackground2[] = {0.25, 0.25, 0.22, 1};
			colorBackgroundFocused[] = {0.25, 0.25, 0.22, 1};
			colorBackgroundActive[] = {0.25, 0.25, 0.22, 1};
		};
		class diagnostics : Haz_RscButton
		{
			idc = idc_diagnostics;
			x = 0.625 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.075 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Diagnostics";
			action = "closeDialog 0; createDialog ""dlg_missionStatus_diagnostics"";";
			period = 0;
			periodFocus = 0;
			periodOver = 0;
			color[] = {0.25, 0.25, 0.22, 1};
			color2[] = {0.25, 0.25, 0.22, 1};
			colorFocused[] = {0.25, 0.25, 0.22, 1};
			colorFocusedSecondary[] = {0.25, 0.25, 0.22, 1};
			colorSecondary[] = {0.25, 0.25, 0.22, 1};
			color2Secondary[] = {0.25, 0.25, 0.22, 1};
			colorBackground[] = {0.56, 0.52, 0.42, 1};
			colorBackground2[] = {0.25, 0.25, 0.22, 1};
			colorBackgroundFocused[] = {0.25, 0.25, 0.22, 1};
			colorBackgroundActive[] = {0.25, 0.25, 0.22, 1};
		};
		class primaryTargetFrame : Haz_RscFrame
		{
			idc = idc_primaryTargetFrame;
			x = 0.3125 * safezoneW + safezoneX;
			y = 0.3 * safezoneH + safezoneY;
			w = 0.2625 * safezoneW;
			h = 0.16 * safezoneH;
			text = "";
		};
		class primaryTargetLocation : Haz_RscStructuredText
		{
			idc = idc_primaryTargetLocation;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.2375 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Target Location:";
		};
		class radioTowerStatus : Haz_RscStructuredText
		{
			idc = idc_radioTowerStatus;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Radio Tower Status:";
		};
		class roadBlocksCleared : Haz_RscStructuredText
		{
			idc = idc_roadBlocksCleared;
			x = 0.43 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.1125 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Road Blocks Cleared:";
		};
		class sabotagedHQs : Haz_RscStructuredText
		{
			idc = idc_sabotagedHQs;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.1125 * safezoneW;
			h = 0.04 * safezoneH;
			text = "HQs Sabotaged: 6";
		};
		class enemyStrength : Haz_RscStructuredText
		{
			idc = idc_enemy_strength;
			x = 0.43 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.1150 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Enemy Strength:";
		};
		class secondaryTargetFrame : Haz_RscFrame
		{
			idc = idc_secondaryTargetFrame;
			x = 0.3125 * safezoneW + safezoneX;
			y = 0.48 * safezoneH + safezoneY;
			w = 0.375 * safezoneW;
			h = 0.22 * safezoneH;
			text = "";
		};
		class controlsGroup : Haz_RscControlsGroup2
		{
			idc = idc_controlsGroup;
			x = 0.3125 * safezoneW + safezoneX;
			y = 0.48 * safezoneH + safezoneY;
			w = 0.375 * safezoneW;
			h = 0.22 * safezoneH;
			class controls
			{
				class textBox : Haz_RscStructuredText
				{
					idc = idc_textBox;
					x = 0;
					y = 0;
					w = 0.375 * safezoneW;
					h = 0.2 * safezoneH;
					text = "<t size='1.0' color='#FFFF00'>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc consectetur odio vel turpis ornare, vitae consequat turpis tristique. Praesent mattis, erat quis mattis auctor, tortor ante fringilla nunc, a ullamcorper tellus orci euismod enim. Aliquam maximus eu lacus a venenatis. Vestibulum ac nisi quis nulla venenatis aliquam id sed ipsum. Donec fringilla scelerisque turpis, sed finibus dolor aliquet vel. Mauris ac dignissim diam, non condimentum elit. Integer congue mattis velit vel laoreet. Sed quis sodales nisi. Ut mollis massa nec lacus ornare ullamcorper. Sed in est sed sem gravida finibus eu fringilla orci. Ut ut arcu neque. In tempor elit felis, vel congue dolor suscipit in. Nunc ante elit, ultricies id rutrum eu, volutpat nec odio. Aenean ultrices auctor ipsum.</t>";
				};
			};
		};
		class logo : Haz_RscPictureKeepAspect
		{
			idc = idc_logo;
			x = 0.5875 * safezoneW + safezoneX;
			y = 0.3 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.16 * safezoneH;
			text = "pics\ctrglogo256.jpg";
		};
		class credits : Haz_RscText
		{
			idc = idc_credits;
			x = 0.375 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Mission by Tankbuster";
		};
	};
};