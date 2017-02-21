//by tankbuster
_myscript = "tky_super_islflatempty";
private ["_deniednotflat","_nobjs1","_nobjs2","_nobjs3","_visiontotal","_cvscorelow","_cvscorehigh","_begpos1","_begpos2","_endpos1","_endpos2","_objs","_foundobj"];
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
_deniednotflat = false;
sleep 1;
_deniednotflat =  !((position fobveh) isFlatEmpty
[-1,// min radius
-1, //mode, must be -1
0.35, //max grad
5, // max grad radius
0,// cannot be water
false, // shoreline mode off
objNull// ignore proximity //surely this should be player/ fobveh?
] isEqualTo []);
diag_log format ["###sfe says area flat %1", _deniednotflat];

_nobjs1 = fobveh nearObjects 10;
_nobjs2 = _nobjs1 - [fobveh]; //take out the vehicle
_nobjs3 = (_nobjs2 select { (sizeof (typeof _x) > 1.5)});
diag_log format ["###sfe nearobjects finds %1 objects nearby, but has removed %2 of them becuase they are tiny or are the fobveh itself", count _nobjs1, (count _nobjs1 - count _nobjs3) ];
if !(_nobjs3 isEqualTo []) then
	{
		{
			diag_log format ["###sife finds a nearby %1, %2", _x, typeOf _x];
		}foreach _nobjs3;
	}
	else
	{
		diag_log format ["###sife finds no nearby objects that might impede deployment"];
	};
	_begpos0 = getPos fobveh; //asl position of the fobveh.. pretty close to the ground
	_begpos1 = fobveh modelToWorld [0,-1,-0.5]; // move it back a little because the centre is too far forward and move it up off the ground a little
	//_begpos1 set [2,1];// lift it a meter
	_begpos2 = ATLToASL _begpos1;//convert it to asl

for "_i" from 0 to 359 step 15 do
{
	_endpos1 = _begpos1 getpos [6, _i];
	//_endpos1 set [2, 1];
	_endpos2 = ATLToASL _endpos1;
	_objs = [];
	//_objs = lineIntersectsObjs [_begpos2, _endpos2, objNull, fobveh, false , 32];
	_helperend = createVehicle ["Sign_Sphere10cm_F", _endpos1, [],0, "CAN_COLLIDE"];// note, createvehicle uses atl, not asl
		// create a helper object so we can visualise and confirm the endpos is working as expected
	if (_objs isEqualTo []) then
		{
		// nothing found
		}
		else
		{
		_foundobj = (_objs select 0);
		diag_log format ["### sife finds a %1, %2 at %3 which is %4 from the fob", _foundobj, typeOf _foundobj, getpos _foundobj, (_foundobj distance fobveh) ];
		};
};
	_helperbeg = createVehicle ["Sign_Sphere25cm_F", _begpos1, [],0, "CAN_COLLIDE"];



diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];