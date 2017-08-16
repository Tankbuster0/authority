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
		class title : Haz_RscTitlebar
		{
			idc = idc_title;
			x = 0.3 * safezoneW + safezoneX;
			y = 0.2 * safezoneH + safezoneY;
			w = 0.4 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Diagnostics Panel";
			colorBackground[] = {0.56, 0.52, 0.42, 1};
		};
		class background : Haz_RscPicture
		{
			idc = idc_background;
			x = 0.3 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.4 * safezoneW;
			h = 0.52 * safezoneH;
			text = "#(argb,8,8,3)color(0.25,0.25,0.22,1)";
		};
		class back : Haz_RscButton
		{
			idc = idc_back;
			x = 0.3 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
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
			x = 0.625 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
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
			x = 0.3125 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.2375 * safezoneW;
			h = 0.48 * safezoneH;
			text = "";
		};
		class rightFrame : Haz_RscFrame
		{
			idc = idc_rightFrame;
			x = 0.5625 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.48 * safezoneH;
			text = "";
		};
		class bluforFaction : Haz_RscPicture
		{
			idc = idc_bluforFaction;
			x = 0.4 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "#(argb,8,8,3)color(0,0.3,0.6,1)";
		};
		class opforFaction : Haz_RscPicture
		{
			idc = idc_opforFaction;
			text = "#(argb,8,8,3)color(0.5,0,0,1)";
			x = 0.4375 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class independentFaction : Haz_RscPicture
		{
			idc = idc_independentFaction;
			text = "#(argb,8,8,3)color(0,0.5,0,1)";
			x = 0.475 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class civilianFaction : Haz_RscPicture
		{
			idc = idc_civilianFaction;
			text = "#(argb,8,8,3)color(0.4,0,0.5,1)";
			x = 0.5125 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class aliveMen : Haz_RscText
		{
			idc = idc_aliveMen;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.0625 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Alive Men:";
		};
		class deadMen : Haz_RscText
		{
			idc = idc_deadMen;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.0625 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Dead Men:";
		};
		class aliveCars : Haz_RscText
		{
			idc = idc_aliveCars;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.44 * safezoneH + safezoneY;
			w = 0.0625 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Cars:";
		};
		class aliveTanks : Haz_RscText
		{
			idc = idc_aliveTanks;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.48 * safezoneH + safezoneY;
			w = 0.0625 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Tanks:";
		};
		class aliveHelicopters : Haz_RscText
		{
			idc = idc_aliveHelicopters;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.0625 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Helicopters:";
		};
		class alivePlanes : Haz_RscText
		{
			idc = idc_alivePlanes;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.56 * safezoneH + safezoneY;
			w = 0.0625 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Planes:";
		};
		class aliveWatercraft : Haz_RscText
		{
			idc = idc_aliveWatercraft;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.0625 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Watercraft:";
		};
		class aliveAutonomous : Haz_RscText
		{
			idc = idc_aliveAutonomous;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = 0.0625 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Autonomous:";
		};
		class deadVehicles : Haz_RscText
		{
			idc = idc_deadVehicles;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.68 * safezoneH + safezoneY;
			w = 0.0625 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Dead Vehicles:";
		};
		class nameShort : Haz_RscText
		{
			idc = idc_nameShort;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Name Short:";
		};
		class versionNumber : Haz_RscText
		{
			idc = idc_versionNumber;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Version Number:";
		};
		class buildNumber : Haz_RscText
		{
			idc = idc_buildNumber;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Build Number:";
		};
		class branch : Haz_RscText
		{
			idc = idc_branch;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Branch:";
		};
		class platform : Haz_RscText
		{
			idc = idc_platform;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.44 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Platform:";
		};
		class OS : Haz_RscText
		{
			idc = idc_OS;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.48 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "OS:";
		};
		class missionTime : Haz_RscText
		{
			idc = idc_missionTime;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Mission Time:";
		};
		class serverTime : Haz_RscText
		{
			idc = idc_serverTime;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.56 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Server Time:";
		};
		class serverFPS : Haz_RscText
		{
			idc = idc_serverFPS;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			text = "Server FPS:";
		};
		class bluforAliveMen : Haz_RscText
		{
			idc = idc_bluforAliveMen;
			x = 0.4 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class opforAliveMen : Haz_RscText
		{
			idc = idc_opforAliveMen;
			x = 0.4375 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class independentAliveMen : Haz_RscText
		{
			idc = idc_independentAliveMen;
			x = 0.475 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class civilianAliveMen : Haz_RscText
		{
			idc = idc_civilianAliveMen;
			x = 0.5125 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class bluforDeadMen : Haz_RscText
		{
			idc = idc_bluforDeadMen;
			x = 0.4 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class opforDeadMen : Haz_RscText
		{
			idc = idc_opforDeadMen;
			x = 0.4375 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class independentDeadMen : Haz_RscText
		{
			idc = idc_independentDeadMen;
			x = 0.475 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class civilianDeadMen : Haz_RscText
		{
			idc = idc_civilianDeadMen;
			x = 0.5125 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class bluforAliveCars : Haz_RscText
		{
			idc = idc_bluforAliveCars;
			x = 0.4 * safezoneW + safezoneX;
			y = 0.44 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class opforAliveCars : Haz_RscText
		{
			idc = idc_opforAliveCars;
			x = 0.4375 * safezoneW + safezoneX;
			y = 0.44 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class independentAliveCars : Haz_RscText
		{
			idc = idc_independentAliveCars;
			x = 0.475 * safezoneW + safezoneX;
			y = 0.44 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class civilianAliveCars : Haz_RscText
		{
			idc = idc_civilianAliveCars;
			x = 0.5125 * safezoneW + safezoneX;
			y = 0.44 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class bluforAliveTanks : Haz_RscText
		{
			idc = idc_bluforAliveTanks;
			x = 0.4 * safezoneW + safezoneX;
			y = 0.48 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class opforAliveTanks : Haz_RscText
		{
			idc = idc_opforAliveTanks;
			x = 0.4375 * safezoneW + safezoneX;
			y = 0.48 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class independentAliveTanks : Haz_RscText
		{
			idc = idc_independentAliveTanks;
			x = 0.475 * safezoneW + safezoneX;
			y = 0.48 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class civilianAliveTanks : Haz_RscText
		{
			idc = idc_civilianAliveTanks;
			x = 0.5125 * safezoneW + safezoneX;
			y = 0.48 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class bluforAliveHelicopters : Haz_RscText
		{
			idc = idc_bluforAliveHelicopters;
			x = 0.4 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class opforAliveHelicopters : Haz_RscText
		{
			idc = idc_opforAliveHelicopters;
			x = 0.4375 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class independentAliveHelicopters : Haz_RscText
		{
			idc = idc_independentAliveHelicopters;
			x = 0.475 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class civilianAliveHelicopters : Haz_RscText
		{
			idc = idc_civilianAliveHelicopters;
			x = 0.5125 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class bluforAlivePlanes : Haz_RscText
		{
			idc = idc_bluforAlivePlanes;
			x = 0.4 * safezoneW + safezoneX;
			y = 0.56 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class opforAlivePlanes : Haz_RscText
		{
			idc = idc_opforAlivePlanes;
			x = 0.4375 * safezoneW + safezoneX;
			y = 0.56 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class independentAlivePlanes : Haz_RscText
		{
			idc = idc_independentAlivePlanes;
			x = 0.475 * safezoneW + safezoneX;
			y = 0.56 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class civilianAlivePlanes : Haz_RscText
		{
			idc = idc_civilianAlivePlanes;
			x = 0.5125 * safezoneW + safezoneX;
			y = 0.56 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class bluforAliveWatercraft : Haz_RscText
		{
			idc = idc_bluforAliveWatercraft;
			x = 0.4 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class opforAliveWatercraft : Haz_RscText
		{
			idc = idc_opforAliveWatercraft;
			x = 0.4375 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class independentAliveWatercraft : Haz_RscText
		{
			idc = idc_independentAliveWatercraft;
			x = 0.475 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class civilianAliveWatercraft : Haz_RscText
		{
			idc = idc_civilianAliveWatercraft;
			x = 0.5125 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class bluforAliveAutonomous : Haz_RscText
		{
			idc = idc_bluforAliveAutonomous;
			x = 0.4 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class opforAliveAutonomous : Haz_RscText
		{
			idc = idc_opforAliveAutonomous;
			x = 0.4375 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class independentAliveAutonomous : Haz_RscText
		{
			idc = idc_independentAliveAutonomous;
			x = 0.475 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class civilianAliveAutonomous : Haz_RscText
		{
			idc = idc_civilianAliveAutonomous;
			x = 0.5125 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class bluforDeadVehicles : Haz_RscText
		{
			idc = idc_bluforDeadVehicles;
			x = 0.4 * safezoneW + safezoneX;
			y = 0.68 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class opforDeadVehicles : Haz_RscText
		{
			idc = idc_opforDeadVehicles;
			x = 0.4375 * safezoneW + safezoneX;
			y = 0.68 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class independentDeadVehicles : Haz_RscText
		{
			idc = idc_independentDeadVehicles;
			x = 0.475 * safezoneW + safezoneX;
			y = 0.68 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
		class civilianDeadVehicles : Haz_RscText
		{
			idc = idc_civilianDeadVehicles;
			x = 0.5125 * safezoneW + safezoneX;
			y = 0.68 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.04 * safezoneH;
			text = "------";
		};
	};
};