class tky_missiondialog
{
	idd = 9999;
	movingEnabled = false;

	class controls
	{
		////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Tankbuster, v1.063, #Podydi)
////////////////////////////////////////////////////////

class tky_rscPicture: RscPicture
{
	idc = 1200;
	text = "#(argb,8,8,3)color(0,0,1,0.5)";
	x = 0.324712 * safezoneW + safezoneX;
	y = 0.246926 * safezoneH + safezoneY;
	w = 0.350577 * safezoneW;
	h = 0.385114 * safezoneH;
};
class tky_rscButton_1: RscButton
{
	idc = 1600;
	text = "equip"; //--- ToDo: Localize;
	x = 0.345334 * safezoneW + safezoneX;
	y = 0.511003 * safezoneH + safezoneY;
	w = 0.0412444 * safezoneW;
	h = 0.0550163 * safezoneH;
};
class rsc_button_2: RscButton
{
	idc = 1601;
	text = "close"; //--- ToDo: Localize;
	x = 0.613422 * safezoneW + safezoneX;
	y = 0.511003 * safezoneH + safezoneY;
	w = 0.0412444 * safezoneW;
	h = 0.0550163 * safezoneH;
	action = "closeDialog 0"
};
class tky_recListBox: RscListbox
{
	idc = 1500;
	x = 0.355645 * safezoneW + safezoneX;
	y = 0.279935 * safezoneH + safezoneY;
	w = 0.293866 * safezoneW;
	h = 0.187055 * safezoneH;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////



	};

};