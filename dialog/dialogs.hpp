class tky_missiondialog
{
	idd = 9999;
	movingEnabled = false;

	class controls
	{
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Tankbuster, v1.063, #Syhoce)
////////////////////////////////////////////////////////

class tky_pt_txt_desc: RscText
{
	idc = 1004;
	x = 0.324712 * safezoneW + safezoneX;
	y = 0.46699 * safezoneH + safezoneY;
	w = 0.0979553 * safezoneW;
	h = 0.110033 * safezoneH;
};
class tky_frame: RscFrame
{
	idc = 1800;
	text = "tky_frame"; //--- ToDo: Localize;
	x = 0.298934 * safezoneW + safezoneX;
	y = 0.268932 * safezoneH + safezoneY;
	w = 0.402132 * safezoneW;
	h = 0.495147 * safezoneH;
};
class tky_text: RscText
{
	idc = 1000;
	x = 0.3144 * safezoneW + safezoneX;
	y = 0.268932 * safezoneH + safezoneY;
	w = 0.108266 * safezoneW;
	h = 0.165049 * safezoneH;
};
class tky_pic: RscPicture
{
	idc = 1200;
	text = "pics\ctrglogo256.jpg";
	x = 0.335023 * safezoneW + safezoneX;
	y = 0.290938 * safezoneH + safezoneY;
	w = 0.0721776 * safezoneW;
	h = 0.110033 * safezoneH;
};
class tky_title_text: RscText
{
	idc = 1001;
	text = "Authority Mission Status"; //--- ToDo: Localize;
	x = 0.463911 * safezoneW + safezoneX;
	y = 0.301941 * safezoneH + safezoneY;
	w = 0.180444 * safezoneW;
	h = 0.0660196 * safezoneH;
	sizeEx = 2 * GUI_GRID_H;
};
class tky_pt_title_txt: RscText
{
	idc = 1002;
	text = "Primary Target"; //--- ToDo: Localize;
	x = 0.319556 * safezoneW + safezoneX;
	y = 0.43398 * safezoneH + safezoneY;
	w = 0.0721776 * safezoneW;
	h = 0.0330098 * safezoneH;
};
class tky_pt_frame: RscFrame
{
	idc = 1801;
	x = 0.309245 * safezoneW + safezoneX;
	y = 0.422977 * safezoneH + safezoneY;
	w = 0.38151 * safezoneW;
	h = 0.176052 * safezoneH;
};
class tky_sm_frame: RscFrame
{
	idc = 1802;
	text = "tky_sm_frame"; //--- ToDo: Localize;
	x = 0.309245 * safezoneW + safezoneX;
	y = 0.621036 * safezoneH + safezoneY;
	w = 0.38151 * safezoneW;
	h = 0.132039 * safezoneH;
};
class tky_sm_text: RscText
{
	idc = 1003;
	text = "Secondary  Mission"; //--- ToDo: Localize;
	x = 0.309245 * safezoneW + safezoneX;
	y = 0.632039 * safezoneH + safezoneY;
	w = 0.0773332 * safezoneW;
	h = 0.0550163 * safezoneH;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////



	};

};