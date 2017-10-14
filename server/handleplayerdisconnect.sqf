//by tankbuster
//execvmd by assaultphasefinished
 #include "..\includes.sqf"
_myscript = "handleplayerdisconnect";
__tky_starts;
_who = param [0];
//cleanup deads, wrecks and dropped weapons and magazines

if (count (allPlayers - (entities "HeadlessClient_F")) < 1) then
{
	{deleteVehicle _x } foreach allDeadMen;
	sleep 1;
	{deletegroup _x} foreach allGroups;
	{if (!(alive _x)) then {deleteVehicle _x}} foreach entities [[fobvehicleclassname, forwardpointvehicleclassname, "groundWeaponHolderSimulated", "WeaponHolderSimulated", "GroundWeaponHolder"], [], false, false];
	{deletevehicle _x} foreach entities [["WeaponHolderSimulated"], [], false, false];
};

if (typeselected isEqualTo "hostagerescue") then
{// used by followleader2 in the hostage rescue sm
	pdflag = true;
	whodiscd = _who;
};
__tky_ends