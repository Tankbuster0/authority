// by tankbuster
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
	["Flag_White_F",[0.554688,3.36157,0],0,1,0,[0,0],"","",true,false],
	["FirePlace_burning_F",[-2.9187,-3.90112,-0.0307665],0,1,0,[0,0],"","",true,false],
	["Land_ToiletBox_F",[-2.83838,-4.35571,1.7643e-005],0.0349144,1,0,[-0.000674493,-0.000603045],"","",true,false],
	["Land_FireExtinguisher_F",[-4.06494,-4.20898,0.000127792],359.79,1,0,[-0.0478408,0.0883972],"","",true,false],
	["Sign_Sphere25cm_F",[6.32104,-4.87207,0],0,1,0,[0,0],"fobboxlocator","",true,false],
	["Land_TTowerSmall_2_F",[0.859131,-12.6907,0],0,1,0,[0,0],"","",true,false]
],0.0] call bis_fnc_ObjectsMapper;

// find a good place nearby for helipad
/*
_mypos = [0,0,0]; _testradius = 20;
while {_mypos in [[0,0,0], islandcentre]} do // findsafepos not found a good place yet. we use a small radius to start with because it's important to get the droppos close to reauested pos
	{
		_mypos = [_pos, 15,_testradius, 10, 0,10,0] call bis_fnc_findSafePos;
		diag_log format ["*** buildfob looking for helipad suggests %1 using radius %2 which is blacklisted %3", _mypos, _testradius, (_mypos in [[0,0,0], islandcentre])];
		_testradius = _testradius + 4;
	};
_mypos set [2,0];
_hpad = createVehicle ["Land_HelipadCircle_F", _mypos,[],0,"NONE"];
fobjects pushback _hpad;
*/
fobdeployed = true;
publicVariable "fobdeployed";

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];

