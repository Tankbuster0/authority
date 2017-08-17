scriptName "fn_inventory";

/*
	Code written by Haz
*/

#define __FILENAME "fn_inventory.sqf"

if ((isDedicated) || (!hasInterface)) exitWith {};

disableSerialization;

private _inventoryDisplay = findDisplay 602;

private _uniformLoadText = _inventoryDisplay ctrlCreate ["RscStructuredText", 7111];
_uniformLoadText ctrlSetPosition [(15.1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2)) / 2)), (5.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2)) / 2))];
_uniformLoadText ctrlCommit 0;

private _vestLoadText = _inventoryDisplay ctrlCreate ["RscStructuredText", 7333];
_vestLoadText ctrlSetPosition [(18.85 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2)) / 2)), (5.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2)) / 2))];
_vestLoadText ctrlCommit 0;

private _backpackLoadText = _inventoryDisplay ctrlCreate ["RscStructuredText", 7555];
_backpackLoadText ctrlSetPosition [(22.6 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2)) / 2)), (5.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2)) / 2))];
_backpackLoadText ctrlCommit 0;

while {(!isNull _inventoryDisplay)} do
{
	if ((uniform player != "")) then
	{
		_uniformLoadText ctrlSetStructuredText parseText format ["<t size='0.6' align='center' color='#FFFF00'>%1 / %2</t>", ((floor (loadUniform player)) * 100), ((getContainerMaxLoad uniform player) * 100)];
	} else
	{
		_uniformLoadText ctrlSetStructuredText parseText format ["<t size='0.6' align='center' color='#FF0000'>No uniform</t>"];
	};
	_uniformLoadText ctrlCommit 0;
	if ((vest player != "")) then
	{
		_vestLoadText ctrlSetStructuredText parseText format ["<t size='0.6' align='center' color='#FFFF00'>%1 / %2</t>", ((floor (loadVest player)) * 100), ((getContainerMaxLoad vest player) * 100)];
	} else
	{
		_vestLoadText ctrlSetStructuredText parseText format ["<t size='0.6' align='center' color='#FF0000'>No vest</t>"];
	};
	_vestLoadText ctrlCommit 0;
	if ((backpack player != "")) then
	{
		_backpackLoadText ctrlSetStructuredText parseText format ["<t size='0.6' align='center' color='#FFFF00'>%1 / %2</t>", ((floor (loadBackpack player)) * 100), ((getContainerMaxLoad backpack player) * 100)];
	} else
	{
		_backpackLoadText ctrlSetStructuredText parseText format ["<t size='0.6' align='center' color='#FF0000'>No backpack</t>"];
	};
	_backpackLoadText ctrlCommit 0;
	sleep 0.015;
};