/*
	Code written by Haz
*/

#include "..\dlg_missionStatus_diagnostics_IDCs.hpp"

class dlg_missionStatus_diagnostics
{
	idd = 13579;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable [""disp_missionStatus_diagnostics"", (_this select 0)]; showHUD [false, false, false, false, false, false, false, false]; [] call tky_fnc_missionStatus_diagnostics;";
	onUnload = "uiNamespace setVariable [""disp_missionStatus_diagnostics"", nil]; showHUD [true, true, true, true, true, true, true, true];";
	class controls
	{
		class title : Haz_RscTitleBar
		{
			idc = idc_title;
			x = 0.05 * safezoneW + safezoneX;
			y = 0.08 * safezoneH + safezoneY;
			w = 0.9 * safezoneW;
			h = 0.04 * safezoneH;
			text = "";
			colorBackground[] = {0.56, 0.52, 0.42, 1};
		};
		class background : Haz_RscPicture
		{
			idc = idc_background;
			x = 0.05 * safezoneW + safezoneX;
			y = 0.12 * safezoneH + safezoneY;
			w = 0.9 * safezoneW;
			h = 0.76 * safezoneH;
			text = "#(argb,8,8,3)color(0.25,0.25,0.22,1)";
		};
		class back : Haz_RscButton
		{
			idc = idc_back;
			x = 0.05 * safezoneW + safezoneX;
			y = 0.88 * safezoneH + safezoneY;
			w = 0.075 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Back";
			action = "closeDialog 0; [] spawn tky_fnc_showmissiondialog;";
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
		class close : Haz_RscButton
		{
			idc = idc_close;
			x = 0.875 * safezoneW + safezoneX;
			y = 0.88 * safezoneH + safezoneY;
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
		class leftFrame : Haz_RscFrame
		{
			idc = idc_leftFrame;
			x = 0.0625 * safezoneW + safezoneX;
			y = 0.14 * safezoneH + safezoneY;
			w = 0.625 * safezoneW;
			h = 0.72 * safezoneH;
			text = "";
		};
		class rightFrame : Haz_RscFrame
		{
			idc = idc_rightFrame;
			x = 0.7 * safezoneW + safezoneX;
			y = 0.14 * safezoneH + safezoneY;
			w = 0.2375 * safezoneW;
			h = 0.72 * safezoneH;
			text = "";
		};
		class bluforFaction : Haz_RscText
		{
			idc = idc_bluforFaction;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.16 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "BLUFOR";
		};
		class opforFaction : Haz_RscText
		{
			idc = idc_opforFaction;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.16 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "OPFOR";
		};
		class independentFaction : Haz_RscText
		{
			idc = idc_independentFaction;
			x = 0.45 * safezoneW + safezoneX;
			y = 0.16 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "INDEPENDENT";
		};
		class civilianFaction : Haz_RscText
		{
			idc = idc_civilianFaction;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.16 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "CIVILIAN";
		};
		class aliveMen : Haz_RscText
		{
			idc = idc_aliveMen;
			x = 0.075 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Alive Men:";
		};
		class deadMen : Haz_RscText
		{
			idc = idc_deadMen;
			x = 0.075 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Dead Men:";
		};
		class aliveCars : Haz_RscText
		{
			idc = idc_aliveCars;
			x = 0.075 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Cars:";
		};
		class aliveTanks : Haz_RscText
		{
			idc = idc_aliveTanks;
			x = 0.075 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Tanks:";
		};
		class aliveHelicopters : Haz_RscText
		{
			idc = idc_aliveHelicopters;
			x = 0.075 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Helicopters:";
		};
		class alivePlanes : Haz_RscText
		{
			idc = idc_alivePlanes;
			x = 0.075 * safezoneW + safezoneX;
			y = 0.44 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Planes:";
		};
		class aliveWatercraft : Haz_RscText
		{
			idc = idc_aliveWatercraft;
			x = 0.075 * safezoneW + safezoneX;
			y = 0.48 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Watercraft:";
		};
		class aliveAutonomous : Haz_RscText
		{
			idc = idc_aliveAutonomous;
			x = 0.075 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Autonomous:";
		};
		class deadVehicles : Haz_RscText
		{
			idc = idc_deadVehicles;
			x = 0.075 * safezoneW + safezoneX;
			y = 0.56 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Dead Vehicles:";
		};
		class bluforAliveMen : Haz_RscText
		{
			idc = idc_bluforAliveMen;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class opforAliveMen : Haz_RscText
		{
			idc = idc_opforAliveMen;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class independentAliveMen : Haz_RscText
		{
			idc = idc_independentAliveMen;
			x = 0.45 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class civilianAliveMen : Haz_RscText
		{
			idc = idc_civilianAliveMen;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class bluforDeadMen : Haz_RscText
		{
			idc = idc_bluforDeadMen;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class opforDeadMen : Haz_RscText
		{
			idc = idc_opforDeadMen;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class independentDeadMen : Haz_RscText
		{
			idc = idc_independentDeadMen;
			x = 0.45 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class civilianDeadMen : Haz_RscText
		{
			idc = idc_civilianDeadMen;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class bluforCars : Haz_RscText
		{
			idc = idc_bluforCars;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class opforCars : Haz_RscText
		{
			idc = idc_opforCars;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class independentCars : Haz_RscText
		{
			idc = idc_independentCars;
			x = 0.45 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class civilianCars : Haz_RscText
		{
			idc = idc_civilianCars;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class bluforTanks : Haz_RscText
		{
			idc = idc_bluforTanks;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class opforTanks : Haz_RscText
		{
			idc = idc_opforTanks;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class independentTanks : Haz_RscText
		{
			idc = idc_independentTanks;
			x = 0.45 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class civilianTanks : Haz_RscText
		{
			idc = idc_civilianTanks;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class bluforHelicopters : Haz_RscText
		{
			idc = idc_bluforHelicopters;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class opforHelicopters : Haz_RscText
		{
			idc = idc_opforHelicopters;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class independentHelicopters : Haz_RscText
		{
			idc = idc_independentHelicopters;
			x = 0.45 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class civilianHelicopters : Haz_RscText
		{
			idc = idc_civilianHelicopters;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class bluforPlanes : Haz_RscText
		{
			idc = idc_bluforPlanes;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.44 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class opforPlanes : Haz_RscText
		{
			idc = idc_opforPlanes;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.44 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class independentPlanes : Haz_RscText
		{
			idc = idc_independentPlanes;
			x = 0.45 * safezoneW + safezoneX;
			y = 0.44 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class civilianPlanes : Haz_RscText
		{
			idc = idc_civilianPlanes;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.44 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class bluforWatercraft : Haz_RscText
		{
			idc = idc_bluforWatercraft;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.48 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class opforWatercraft : Haz_RscText
		{
			idc = idc_opforWatercraft;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.48 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class independentWatercraft : Haz_RscText
		{
			idc = idc_independentWatercraft;
			x = 0.45 * safezoneW + safezoneX;
			y = 0.48 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class civilianWatercraft : Haz_RscText
		{
			idc = idc_civilianWatercraft;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.48 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class bluforAutonomous : Haz_RscText
		{
			idc = idc_bluforAutonomous;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class opforAutonomous : Haz_RscText
		{
			idc = idc_opforAutonomous;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class independentAutonomous : Haz_RscText
		{
			idc = idc_independentAutonomous;
			x = 0.45 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class civilianAutonomous : Haz_RscText
		{
			idc = idc_civilianAutonomous;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class bluforDeadVehicles : Haz_RscText
		{
			idc = idc_bluforDeadVehicles;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.56 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class opforDeadVehicles : Haz_RscText
		{
			idc = idc_opforDeadVehicles;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.56 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class independentDeadVehicles : Haz_RscText
		{
			idc = idc_independentDeadVehicles;
			x = 0.45 * safezoneW + safezoneX;
			y = 0.56 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class civilianDeadVehicles : Haz_RscText
		{
			idc = idc_civilianDeadVehicles;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.56 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "----";
		};
		class nameShort : Haz_RscText
		{
			idc = idc_nameShort;
			x = 0.7125 * safezoneW + safezoneX;
			y = 0.16 * safezoneH + safezoneY;
			w = 0.2125 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Name Short:";
		};
		class versionNumber : Haz_RscText
		{
			idc = idc_versionNumber;
			x = 0.7125 * safezoneW + safezoneX;
			y = 0.2 * safezoneH + safezoneY;
			w = 0.2125 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Version Number:";
		};
		class buildNumber : Haz_RscText
		{
			idc = idc_buildNumber;
			x = 0.7125 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.2125 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Build Number:";
		};
		class branch : Haz_RscText
		{
			idc = idc_branch;
			x = 0.7125 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.2125 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Branch:";
		};
		class platform : Haz_RscText
		{
			idc = idc_platform;
			x = 0.7125 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.2125 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Platform:";
		};
		class OS : Haz_RscText
		{
			idc = idc_OS;
			x = 0.7125 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.2125 * safezoneW;
			h = 0.04 * safezoneH;
			text = "OS:";
		};
		class missionTime : Haz_RscText
		{
			idc = idc_missionTime;
			x = 0.7125 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.2125 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Mission Time:";
		};
		class serverTime : Haz_RscText
		{
			idc = idc_serverTime;
			x = 0.7125 * safezoneW + safezoneX;
			y = 0.44 * safezoneH + safezoneY;
			w = 0.2125 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Server Time:";
		};
		class serverFPS : Haz_RscText
		{
			idc = idc_serverFPS;
			x = 0.7125 * safezoneW + safezoneX;
			y = 0.48 * safezoneH + safezoneY;
			w = 0.2125 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Server FPS:";
		};
	};
};