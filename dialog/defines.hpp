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

class Haz_RscPlayerIcon
{
	idc = 100;
	type = CT_STRUCTURED_TEXT;
	style = CT_SHORTCUTBUTTON + ST_NO_RECT;
	x = -1;
	y = -1;
	w = 0.4;
	h = 0.2;
	size = 0.020;
	sizeEx = 0.020;
	font = "RobotoCondensed";
	shadow = 0;
	lineSpacing = 1;
	colorText[] = {1, 1, 1, 1};
	colorBackground[] = {0, 0, 0, 0};
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

class Haz_RscListBox
{
	idc = -1;
	type = CT_LISTBOX;
	style = ST_MULTI;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	rowHeight = 0.04;
	font = "RobotoCondensed";
	shadow = 0;
	period = 1.2;
	maxHistoryDelay = 1.000000;
	colorSelect[] = {1, 1, 1, 1};
	colorSelectRight[] = {1, 1, 1, 1};
	colorSelect2[] = {1, 1, 1, 1};
	colorSelect2Right[] = {1, 1, 1, 1};
	colorText[] = {1, 1, 1, 1.000000};
	colorTextRight[] = {1, 1, 1, 1};
	colorShadow[] = {0, 0, 0, 0.500000};
	colorDisabled[] = {1, 1, 1, 0.250000};
	colorPicture[] = {1, 1, 1, 1};
	colorPictureRight[] = {1, 1, 1, 1};
	colorPictureSelected[] = {1, 1, 1, 1};
	colorPictureRightSelected[] = {1, 1, 1, 1};
	colorPictureDisabled[] = {1, 1, 1, 0.250000};
	colorPictureRightDisabled[] = {1, 1, 1, 0.250000};
	colorBackground[] = {0, 0, 0, 0.300000};
	colorSelectBackground[] = {0.950000, 0.950000, 0.950000, 1};
	colorSelectBackground2[] = {1, 1, 1, 0.500000};
	colorScrollbar[] = {1, 0, 0, 0};
	tooltipColorText[] = {1, 1, 1, 1};
	tooltipColorBox[] = {1, 1, 1, 1};
	tooltipColorShade[] = {0, 0, 0, 0.650000};
	soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect", 0.090000, 1};
	class ListScrollBar : Haz_RscScrollBar
	{
		autoScrollEnabled = 1;
		color[] = {1, 1, 1, 1};
	};
};

class Haz_RscListNBox
{
	idc = -1;
	idcLeft = -1;
	idcRight = -1;
	type = CT_LISTNBOX;
	style = CT_SHORTCUTBUTTON;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	rowHeight = 0.06;
	font = "RobotoCondensed";
	shadow = 0;
	period = 1.2;
	maxHistoryDelay = 1;
	drawSideArrows = 1;
	colorSelect[] = {0, 0, 0, 1};
	colorSelectRight[] = {0, 0, 0, 1};
	colorSelect2[] = {0, 0, 0, 1};
	colorSelect2Right[] = {0, 0, 0, 1};
	colorText[] = {1, 1, 1, 1.000000};
	colorDisabled[] = {1, 1, 1, 0.250000};
	colorPicture[] = {1, 1, 1, 1};
	colorPictureSelected[] = {1, 1, 1, 1};
	colorPictureDisabled[] = {1, 1, 1, 0.250000};
	colorSelectBackground[] = {0.950000, 0.950000, 0.950000, 1};
	colorSelectBackground2[] = {1, 1, 1, 0.500000};
	soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect", 0.090000, 1};
	class ListScrollBar : Haz_RscScrollBar
	{
		autoScrollEnabled = 1;
		color[] = {1, 1, 1, 1};
	};
};

class Haz_RscTree
{
	idc = -1;
	type = CT_TREE;
	style = ST_LEFT;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	rowHeight = 0.04;
	font = "RobotoCondensed";
	shadow = 0;
	maxHistoryDelay = 1;
	multiSelectEnabled = 0;
	expandOnDoubleclick = 1;
	colorSelect[] = {1, 1, 1, 0.7};
	colorText[] = {1, 1, 1, 1};
	colorSelectText[] = {0, 0, 0, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	colorMarked[] = {0.2, 0.3, 0.7, 1};
	colorMarkedText[] = {0, 0, 0, 1};
	colorMarkedSelected[] = {0, 0.5, 0.5, 1};
	colorSearch[] = {"(profileNamespace getVariable ['GUI_BCG_RGB_R', 0])", "(profileNamespace getVariable ['GUI_BCG_RGB_G', 0.35])", "(profileNamespace getVariable ['GUI_BCG_RGB_B', 0.07])", 1};
	colorArrow[] = {1, 1, 1, 1};
	colorLines[] = {0, 0, 0, 0};
	colorPicture[] = {1, 1, 1, 1};
	colorPictureRight[] = {1, 1, 1, 1};
	colorPictureSelected[] = {0, 0, 0, 1};
	colorPictureRightSelected[] = {0, 0, 0, 1};
	colorPictureDisabled[] = {1, 1, 1, 0.25};
	colorPictureRightDisabled[] = {1, 1, 1, 0.25};
	colorBackground[] = {0, 0, 0, 0};
	colorSelectBackground[] = {0, 0, 0, 0.5};
	colorBorder[] = {0, 0, 0, 0};
	expandedTexture = "A3\ui_f\data\gui\rsccommon\rsctree\expandedTexture_ca.paa";
	hiddenTexture = "A3\ui_f\data\gui\rsccommon\rsctree\hiddenTexture_ca.paa";
	class ScrollBar : Haz_RscScrollBar
	{
		autoScrollEnabled = 1;
		color[] = {1, 1, 1, 1};
	};
};

class Haz_RscCombo
{
	idc = -1;
	type = CT_COMBO;
	style = ST_CENTER;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	font = "RobotoCondensed";
	rowHeight = 0.04;
	wholeHeight = 0.48;
	maxHistoryDelay = 0;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	color[] = {0, 0, 0, 0};
	colorSelect[] = {0, 0, 0, 1};
	colorText[] = {1, 1, 1, 1};
	colorDisabled[] = {};
	colorBackground[] = {0, 0, 0, 1};
	colorSelectBackground[] = {"(profileNamespace getVariable ['GUI_BCG_RGB_R', 0.69])", "(profileNamespace getVariable ['GUI_BCG_RGB_G', 0.75])", "(profileNamespace getVariable ['GUI_BCG_RGB_B', 0.5])", 1};
	colorSelectBackground2[] = {"(profileNamespace getVariable ['GUI_BCG_RGB_R', 0.69])", "(profileNamespace getVariable ['GUI_BCG_RGB_G', 0.75])", "(profileNamespace getVariable ['GUI_BCG_RGB_B', 0.5])", 1};
	colorScrollbar[] = {"(profileNamespace getVariable ['GUI_BCG_RGB_R', 0.69])", "(profileNamespace getVariable ['GUI_BCG_RGB_G', 0.75])", "(profileNamespace getVariable ['GUI_BCG_RGB_B', 0.5])", 1};
	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect", 0.090000, 1};
	soundExpand[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect", 0.090000, 1};
	soundCollapse[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect", 0.090000, 1};
	class ComboScrollBar : Haz_RscScrollBar
	{
		autoScrollEnabled = 1;
		color[] = {1, 1, 1, 1};
		colorActive[] = {0, 0, 0, 1};
		colorDisabled[] = {0, 0, 0, 0};
		arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
		arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
};

class Haz_RscText
{
	idc = -1;
	type = CT_STATIC;
	style = ST_LEFT;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	font = "RobotoCondensed";
	shadow = 1;
	lineSpacing = 1;
	colorText[] = {1, 1, 1, 1.000000};
	colorShadow[] = {0, 0, 0, 0.500000};
	colorBackground[] = {0, 0, 0, 0};
	tooltipColorText[] = {1, 1, 1, 1};
	tooltipColorBox[] = {1, 1, 1, 1};
	tooltipColorShade[] = {0, 0, 0, 0.650000};
};

class Haz_RscStructuredText
{
	idc = -1;
	type = CT_STRUCTURED_TEXT;
	style = ST_LEFT;
	size = "0.02 / (getResolution select 5)";
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

class Haz_RscActiveText
{
	idc = -1;
	type = CT_ACTIVE_TEXT;
	style = ST_PICTURE;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	font = "RobotoCondensed";
	shadow = 2;
	color[] = {1, 1, 1, 0.35};
	colorText[] = {0.75, 0.78, 0, 1};
	colorActive[] = {1, 1, 1, 1};
	colorDisabled[] = {0, 0, 0, 0};
	colorBackground[] = {1, 1, 1, 1};
	tooltipColorText[] = {1, 1, 1, 1};
	tooltipColorBox[] = {1, 1, 1, 1};
	tooltipColorShade[] = {0, 0, 0, 0.650000};
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.090000, 1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.090000, 1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.090000, 1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.090000, 1};
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

class Haz_RscProgressBar
{
	idc = -1;
	type = CT_PROGRESS;
	style = CT_STATIC;
	colorFrame[] = {0.25, 0.25, 0.25, 1};
	colorBar[] = {0.4, 0, 0.5, 1};
	texture = "#(argb,8,8,3)color(1,1,1,1)";
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

class Haz_RscEdit
{
	idc = -1;
	type = CT_EDIT;
	style = ST_CENTER;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	font = "RobotoCondensed";
	shadow = 2;
	autoComplete = 1;
	colorText[] = {0.950000, 0.950000, 0.950000, 1};
	colorSelection[] = {"(profileNamespace getVariable ['GUI_BCG_RGB_R', 0.13])", "(profileNamespace getVariable ['GUI_BCG_RGB_G', 0.54])", "(profileNamespace getVariable ['GUI_BCG_RGB_B', 0.21])", 1};
	colorDisabled[] = {1, 1, 1, 0.250000};
	colorBackground[] = {0, 0, 0, 0};
	tooltipColorText[] = {1, 1, 1, 1};
	tooltipColorBox[] = {1, 1, 1, 1};
	tooltipColorShade[] = {0, 0, 0, 0.650000};
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