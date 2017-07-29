/*
	Code written by Haz
*/

#define idc_title 100
#define idc_title_left 200
#define idc_title_right 300
#define idc_background 400
#define idc_close 500
#define idc_settings 600
#define idc_primaryTargetFrame 700
#define idc_primaryTargetLocation 800
#define idc_sabotagedHQs 900
#define idc_radioTowerStatus 1000
#define idc_roadBlocksCleared 1001
#define idc_secondaryTargetFrame 1002
#define idc_controlsGroup 1003
#define idc_textBox 100
#define idc_logo 1004

class dlg_missionStatus
{
	idd = 13579;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable [""disp_missionStatus"", (_this select 0)]; [] call tky_fnc_fixTextHeight;";
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
			text = "#(argb,8,8,3)color(0.25,0.25,0.22,1)";
		};
		class close : Haz_RscButton
		{
			idc = idc_close;
			x = 0.3 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.075 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Close";
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
			action = "closeDialog 0";
		};
		class settings : Haz_RscButton
		{
			idc = idc_settings;
			x = 0.625 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.075 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Settings";
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
			x = 0.325 * safezoneW + safezoneX;
			y = 0.3 * safezoneH + safezoneY;
			w = 0.275 * safezoneW;
			h = 0.1 * safezoneH;
			text = "";
		};
		class primaryTargetLocation : Haz_RscStructuredText
		{
			idc = idc_primaryTargetLocation;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.12 * safezoneW;
			h = 0.02 * safezoneH;
			text = "";
		};
		class sabotagedHQs : Haz_RscStructuredText
		{
			idc = idc_sabotagedHQs;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.02 * safezoneH;
			text = "";
		};
		class radioTowerStatus : Haz_RscStructuredText
		{
			idc = idc_radioTowerStatus;
			x = 0.475 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.02 * safezoneH;
			text = "Radio Tower Status: Active";
		};
		class roadBlocksCleared : Haz_RscStructuredText
		{
			idc = idc_roadBlocksCleared;
			x = 0.475 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.02 * safezoneH;
			text = "Road Blocks Cleared: 2";
		};
		class secondaryTargetFrame : Haz_RscFrame
		{
			idc = idc_secondaryTargetFrame;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.35 * safezoneW;
			h = 0.28 * safezoneH;
			text = "";
		};
		class controlsGroup  : Haz_RscControlsGroup2
		{
			idc = idc_controlsGroup;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.35 * safezoneW;
			h = 0.28 * safezoneH;
			class controls
			{
				class textBox  : Haz_RscStructuredText
				{
					idc = idc_textBox;
					x = 0;
					y = 0;
					w = 0.35 * safezoneW;
					h = 0.3 * safezoneH;
					text = "<t size='1.0' color='#FFFF00'>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc consectetur odio vel turpis ornare, vitae consequat turpis tristique. Praesent mattis, erat quis mattis auctor, tortor ante fringilla nunc, a ullamcorper tellus orci euismod enim. Aliquam maximus eu lacus a venenatis. Vestibulum ac nisi quis nulla venenatis aliquam id sed ipsum. Donec fringilla scelerisque turpis, sed finibus dolor aliquet vel. Mauris ac dignissim diam, non condimentum elit. Integer congue mattis velit vel laoreet. Sed quis sodales nisi. Ut mollis massa nec lacus ornare ullamcorper. Sed in est sed sem gravida finibus eu fringilla orci. Ut ut arcu neque. In tempor elit felis, vel congue dolor suscipit in. Nunc ante elit, ultricies id rutrum eu, volutpat nec odio. Aenean ultrices auctor ipsum. In ultrices aliquam imperdiet. Cras commodo mi in bibendum commodo.<br/><br/>Cras sed tempor ligula. In id sodales nibh. Aliquam in turpis id odio vestibulum dapibus ac quis urna. Fusce pretium congue eros vitae sagittis. Sed non placerat ante. Vestibulum lobortis maximus est quis ultrices. Vestibulum vitae vulputate tellus.<br/><br/>Proin eu odio purus. Phasellus et dui non ante feugiat hendrerit. Etiam ut dui a ante venenatis mollis non at nisi. Donec semper ex sit amet sapien blandit feugiat. Nam viverra justo in quam rhoncus commodo. Aenean id elementum est, id ornare massa. In lectus mauris, pulvinar nec suscipit in, elementum eu augue. Curabitur a augue viverra, venenatis risus vitae, vulputate neque. In rhoncus eleifend volutpat. Ut vestibulum pulvinar nulla, a rhoncus ante porta quis. Sed fringilla tortor eget diam finibus viverra. Maecenas elementum cursus arcu ut facilisis. Phasellus vitae erat et nisl sagittis ornare non et arcu. Vivamus id auctor purus, nec accumsan tellus. Duis malesuada ornare est, sed sagittis erat feugiat a.</t>";
				};
			};
		};
		class logo : Haz_RscPictureKeepAspect
		{
			idc = idc_logo;
			x = 0.6125 * safezoneW + safezoneX;
			y = 0.3 * safezoneH + safezoneY;
			w = 0.0625 * safezoneW;
			h = 0.1 * safezoneH;
			text = "#(argb,8,8,3)color(1,1,1,1)";
		};
	};
};