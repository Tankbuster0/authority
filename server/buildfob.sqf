// by tankbuster
// note sometimes this runs aon client, sometimes it doesnt. grrr.
_myscript = "buildfob.sqf";
diag_log format ["*** %1 starts %2, %3", _myscript, diag_tickTime, time];
private ["_pos","_dir","_mypos","_testradius","_droppos","_hpad"];
params [
["_pos", ""],
["_dir", ""]];

fobjects = [_pos, _dir,
/*
Grab data:
Mission: fobtemplate
World: VR
Anchor position: [3650.27, 2360.49]
Area size: 20
Using orientation of objects: yes
*/
[
	["Flag_White_F",[0.554688,4.36157,0],0,1,0,[0,0],"fobflagpole","",true,false],
	["FirePlace_burning_F",[-2.9187,-3.90112,-0.0307665],0,1,0,[0,0],"","",true,false],
	["Land_ToiletBox_F",[-2.83838,-4.35571,1.7643e-005],0.0349144,1,0,[-0.000674493,-0.000603045],"","",true,false],
	["Land_FireExtinguisher_F",[-4.06494,-4.20898,0.000127792],359.79,1,0,[-0.0478408,0.0883972],"","",true,false],
	["Sign_Sphere25cm_F",[6.32104,-4.87207,0],0,1,0,[0,0],"fobboxlocator","",true,false],
	["Land_DataTerminal_01_F", [8, -6 ,0], 0,1,0, [0,0], "fobdataterminal", "", true, false],
	["Land_TTowerSmall_2_F",[0.859131,-12.6907,0],0,1,0,[0,0],"","",true,false]
],0.0] call tky_fnc_t_objectsmapper;
fobflagpole setFlagTexture "pics\wasp-inc_dirty_flag.paa";
fobdeployed = true;
publicVariable "fobdeployed";
previousmission = [missionNamespace, "previousmission", nil] call BIS_fnc_getServerVariable;
sleep 0.5;

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];

