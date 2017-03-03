//by tankbuster
_myscript = "tky_super_islflatempty";
private ["_allowed_nearobjs","_allowed_notflat","_allowed_outdoors","_allowed_lineintersects","_allowed_deploy","_buildingobjs","_house","_nobjs1","_nobjs2","_nobjs3","_begpos0","_begpos1","_begpos2","_intersectobjectscount","_objs1","_objs2","_objs","_endpos1","_endpos2","_endpos3","_endpos4","_foundobj","_tc","_reasonstring"];
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
_allowed_nearobjs = false;_allowed_notflat = false;_allowed_outdoors = true;_allowed_lineintersects =false;_allowed_deploy = false;
_allowed_notflat =  !((position fobveh) isFlatEmpty
[-1,// min radius
-1, //mode, must be -1
0.4, //max grad
6, // max grad radius
0,// cannot be water
false, // shoreline mode off
objNull// ignore proximity //surely this should be player/ fobveh?
] isEqualTo []);
//diag_log format ["###sfe says area flat %1", _allowed_notflat];
// is inside a house check by killzonekid
_buildingobjs = [];
_buildingobjs = (lineIntersectsSurfaces [(getPosWorld fobveh), (getPosWorld fobveh vectorAdd [0,0,50]), fobveh, objNull, true,1, "GEOM", "NONE"] ) select 0 params ["","","", "_house"];
if !(isNil "_house") then
	{
	if (_house isKindOf "House") then
		{
		_allowed_outdoors = false;
		};
	};
// nearobjects tests, removes insects, pollen, fish and other small objects
_nobjs1 = fobveh nearObjects 9;
_nobjs2 = _nobjs1 - [fobveh]; //take out the vehicle
_nobjs3 = (_nobjs2 select { (sizeof (typeof _x) > 1.5)});// remove tiny objects
if (_nobjs3 isEqualTo []) then
	{
		_allowed_nearobjs = true;
	};
	_begpos0 = getPos fobveh; //asl position of the fobveh.. pretty close to the ground
	_begpos1 = fobveh modelToWorld [0,-1,-1]; // move it back a little because the centre is too far forward and move it up off the ground a little
	_begpos2 = ATLToASL _begpos1;//convert it to asl
_intersectobjectscount = 0;
for "_i" from 0 to 359 step 10 do
{
	_objs1 = []; _objs2 = []; _objs =  [];
	_endpos1 = _begpos1 getpos [7, _i];
	_endpos1 set [2, 0.6];
	_endpos2 = ATLToASL _endpos1;
	_objs1 = lineIntersectsObjs [_begpos2, _endpos2, objNull, fobveh, false , 32];
	_endpos3 = _endpos1;
	_endpos3 set [2, 2.2];
	_endpos4 = ATLToASL _endpos3;
	_objs2 = lineIntersectsObjs [_begpos2, _endpos4, objNull, fobveh, false , 32];
	_objs = _objs1 + _objs2;
	if !(_objs isEqualTo []) then
		{
		_foundobj = (_objs select 0);
		_intersectobjectscount = _intersectobjectscount + 1;
		};
};
if (_intersectobjectscount isEqualTo 0 ) then {_allowed_lineintersects = true};
// bring all the check together for a final decision
if ((_allowed_outdoors) and (_allowed_lineintersects) and (_allowed_notflat) and (_allowed_nearobjs)) then {_allowed_deploy = true};
if !(_allowed_deploy) then
	{
	 _tc = {_x} count [_allowed_outdoors, _allowed_lineintersects, _allowed_notflat, _allowed_nearobjs];
	 _reasonstring =  "";
	 if !(_allowed_outdoors) then {_reasonstring = _reasonstring + " Can't deploy in a building "};
	 if (!(_allowed_lineintersects) or !(_allowed_nearobjs)) then {_reasonstring = _reasonstring + "Too close to other objects "};
	 if !(_allowed_notflat) then {_reasonstring = _reasonstring + "Ground isn't flat enough or is in water "};
	 hint format ["Can't deploy here, %1", _reasonstring];
	}
	else
	{hint "Deploy allowed"};
//diag_log format ["### final: flat %1, outdoors %2, nearObjs %3, interects %4, overall %5 ", _allowed_notflat, _allowed_outdoors, _allowed_nearobjs, _allowed_lineintersects, _allowed_deploy];
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];