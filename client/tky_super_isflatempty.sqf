//by tankbuster
_myscript = "tky_super_islflatempty";
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
diag_log format ["sie says area not flat %1", _deniednotflat];

_nobjs1 = fobveh nearObjects 10;
_nobjs2 = _nobjs1 - [fobveh]; //take out the vehicle
_nobjs3 = (_nobjs2 select { (sizeof (typeof _x) > 1.5)});
diag_log format ["sfe nearobjects finds %1 objects nearby, but has removed %2 of them becuase they are tiny", count _nobjs1, (count _nobjs3 - count _nobjs2) ];
if !(_nobjs3 isEqualTo []) then
	{
		{
			diag_log format ["sfe finds a nearby %1, %2", _x, typeOf _x];
		}foreach _nobjs3;
	}
	else
	{
		diag_log format ["sfe finds no nearby objects"];
	};
_dirs = [
[0,5,0.5],
[0,5,2], //forward low
[5,5,0.5],
[5,5,2], //45 deg
[5,0,0.5],
[5,0,2], // 90deg right
[5,-5,0.5],
[5,-5,2], //135 back right
[0,-5,0.5],
[0,-5,2], // back 180
[-5,-5,0.5],
[-5,-5,2], //back left 225
[-5,0,0.5], //left 270
[-5,0,2],
[-5,5,0.5],
[-5,5,2] // front left 305
];
_visiontotal = 0;
_cvscore = 0;
{
	_cvscore = [fobveh, "VIEW"] checkVisibility [(ATLToASL (position fobveh)), (ATLToASL (fobveh modelToWorld _x))]
	if (_cvscore < 1) then
		{
			diag_log format ["sfe finds a view geometry at %1"];
		};
	_visiontotal = _visiontotal + _cvscore; //add them all up
	_cvscore = 0;
} foreach _dirs;
if (_visiontotal isEqualTo 8) then
	{
		diag_log format ["sfe says no view gemoetry nearby!"];
	}
	 else
	{
	 	diag_log format ["sfe finds nearby view lods, score is %1", _visiontotal];
	};





diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];