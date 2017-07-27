/*
	Code written by Haz
*/

#define CT_STATIC 0
#define CT_BUTTON 1
#define CT_EDIT 2
#define CT_SLIDER 3
#define CT_COMBO 4
#define CT_LISTBOX 5
#define CT_PROGRESS 8
#define CT_ACTIVE_TEXT 11
#define CT_TREE 12
#define CT_STRUCTURED_TEXT 13
#define CT_CONTROLS_GROUP 15
#define CT_SHORTCUTBUTTON 16
#define CT_XLISTBOX 42
#define CT_XCOMBO 44
#define CT_LISTNBOX 102

#define ST_MULTI 16
#define ST_PICTURE 48
#define ST_FRAME 64
#define ST_LEFT 0x00
#define ST_RIGHT 0x01
#define ST_CENTER 0x02
#define ST_NO_RECT 0x200
#define SL_HORZ 0x400
#define ST_KEEP_ASPECT_RATIO 0x800
#define ST_UPPERCASE 0xC0
#define ST_LOWERCASE 0xD0

#define LB_TEXTURES 0x10

class Haz_RscScrollBar
{
	width = 0;
	height = 0;
	shadow = 0;
	autoScrollEnabled = 0;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	scrollSpeed = 0.060000;
	color[] = {1, 1, 1, 0.600000};
	colorActive[] = {1, 1, 1, 1};
	colorDisabled[] = {1, 1, 1, 0.300000};
	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
	thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
};

class Haz_RscShortcutButton
{
	idc = -1;
	type = CT_BUTTON;
	style = ST_CENTER + ST_UPPERCASE;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeExSecondary = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	font = "RobotoCondensed";
	fontSecondary = "RobotoCondensed";
	shadow = 1;
	period = 0.4;
	periodFocus = 1.2;
	periodOver = 0.8;
	color[] = {1, 1, 1, 1.000000};
	color2[] = {0.950000, 0.950000, 0.950000, 1};
	colorFocused[] = {1, 1, 1, 1.000000};
	colorFocusedSecondary[] = {1, 1, 1, 1.000000};
	colorDisabled[] = {1, 1, 1, 0.250000};
	colorDisabledSecondary[] = {1, 1, 1, 0.250000};
	colorSecondary[] = {1, 1, 1, 1.000000};
	color2Secondary[] = {0.950000, 0.950000, 0.950000, 1};
	colorBackground[] = {"(profileNamespace getVariable ['GUI_BCG_RGB_R', 0.13])", "(profileNamespace getVariable ['GUI_BCG_RGB_G', 0.54])", "(profileNamespace getVariable ['GUI_BCG_RGB_B', 0.21])", 1};
	colorBackground2[] = {1, 1, 1, 1};
	colorBackgroundFocused[] = {"(profileNamespace getVariable ['GUI_BCG_RGB_R', 0.13])", "(profileNamespace getVariable ['GUI_BCG_RGB_G', 0.54])", "(profileNamespace getVariable ['GUI_BCG_RGB_B', 0.21])", 1};
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.090000, 1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.090000, 1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.090000, 1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.090000, 1};
	class HitZone
	{
		left = 0.000000;
		top = 0.000000;
		right = 0.000000;
		bottom = 0.000000;
	};
	class ShortcutPos
	{
		w = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3 / 4)";
		h = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		left = 0;
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
	};
	class TextPos
	{
		left = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		right = 0.005000;
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		bottom = 0.000000;
	};
	class Attributes
	{
		font = "RobotoCondensed";
		color = "#E5E5E5";
		shadow = "true";
		align = "left";
	};
	class AttributesImage
	{
		font = "RobotoCondensed";
		color = "#E5E5E5";
		align = "left";
	};
};

class Haz_RscButton : Haz_RscShortcutButton
{
	idc = -1;
	shadow = 2;
	font = "RobotoCondensed";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	borderSize = 0.000000;
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0;
	offsetPressedY = 0;
	colorText[] = {1, 1, 1, 1.000000};
	colorFocused[] = {0, 0, 0, 1};
	colorShadow[] = {0, 0, 0, 0};
	colorDisabled[] = {1, 1, 1, 0.250000};
	colorBackground[] = {0, 0, 0, 0.500000};
	colorBackgroundActive[] = {0, 0, 0, 1};
	colorBackgroundDisabled[] = {0, 0, 0, 0.500000};
	colorBorder[] = {0, 0, 0, 1};
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.090000, 1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.090000, 1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.090000, 1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.090000, 1};
};

class Haz_RscStructuredText
{
	idc = -1;
	type = CT_STRUCTURED_TEXT;
	style = ST_LEFT;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = 1;
	colorText[] = {1, 1, 1, 1.000000};
	class Attributes
	{
		font = "RobotoCondensed";
		color = "#ffffff";
		colorLink = "#d09b43";
		shadow = 1;
		align = "left";
	};
};

class Haz_RscTextBox : Haz_RscScrollBar
{
	idc = -1;
	type = CT_STRUCTURED_TEXT;
	style = ST_LEFT;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	colorBackground[] = {0, 0, 0, 0};
	class Attributes
	{
		size = "1.2";
		font = "RobotoCondensed";
		color = "#FFFFFF";
		shadow = 1;
		shadowColor = "#FFFFFF";
		align = "center";
		valign = "middle";
	};
};

class Haz_RscTitleBar : Haz_RscText
{
	idc = -1;
	colorBackground[] = {"(profileNamespace getVariable ['GUI_BCG_RGB_R', 0.13])", "(profileNamespace getVariable ['GUI_BCG_RGB_G', 0.54])", "(profileNamespace getVariable ['GUI_BCG_RGB_B', 0.21])", 1};
};

class Haz_RscPicture
{
	idc = -1;
	type = CT_STATIC;
	style = ST_PICTURE;
	sizeEx = 0;
	font = "RobotoCondensed";
	shadow = 0;
	colorText[] = {1, 1, 1, 1};
	colorBackground[] = {0, 0, 0, 0};
	tooltipColorText[] = {1, 1, 1, 1};
	tooltipColorBox[] = {1, 1, 1, 1};
	tooltipColorShade[] = {0, 0, 0, 0.650000};
};

class Haz_RscPictureKeepAspect : Haz_RscPicture
{
	style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
};

class Haz_RscFrame
{
	idc = -1;
	type = CT_STATIC;
	style = ST_FRAME;
	sizeEx = 0.020000;
	font = "RobotoCondensed";
	shadow = 2;
	colorText[] = {1, 1, 1, 1};
	colorBackground[] = {0, 0, 0, 0};
};

class Haz_RscControlsGroup
{
	idc = -1;
	type = CT_CONTROLS_GROUP;
	style = ST_MULTI;
	shadow = 0;
	class VScrollbar: Haz_RscScrollBar
	{
		width = 0.021000;
		autoScrollEnabled = 1;
	};
	class HScrollbar: Haz_RscScrollBar
	{
		height = 0.028000;
	};
	class controls
	{
	};
};

class Haz_RscControlsGroup2 : Haz_RscControlsGroup
{
	class VScrollbar : Haz_RscScrollBar
	{
		width = 0.028;
		autoScrollEnabled = 1;
		color[] = {1, 1, 1, 1};
	};
	class HScrollbar : Haz_RscScrollBar
	{
		height = 0.028;
	};
	class controls
	{
	};
};