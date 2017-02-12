//by tankbuster
_myscript = "tky_super_islflatempty";
private ["_myscript","_deniednotflat","_nobjs1","_nobjs2","_nobjs3","_dirs","_visiontotal","_cvscore","_leftright","_forback","_updown","_desc"];
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
			diag_log format ["###sfe finds a nearby %1, %2", _x, typeOf _x];
		}foreach _nobjs3;
	}
	else
	{
		diag_log format ["###sfe finds no nearby objects that might impede deployment"];
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
	_cvscore = [fobveh, "VIEW"] checkVisibility [(ATLToASL (position fobveh)), (ATLToASL (fobveh modelToWorld _x))];
	diag_log format ["### checking %1 for view lods", _x];
	if (_cvscore < 1) then
		{
			switch (_x select 0) do
			{
				case -5: {_leftright = "left "};
				case 5: {_leftright = "right "};
				case 0: {_leftright = ""};
			};
			switch (_x select 1) do
			{
				case -5: {_forback = "behind "};
				case 5: {_forback = "forward "};
				case 0: {_forback = ""};
			};
			switch (_x select 2) do
			{
				case 0.5: {_updown = "low "};
				case 2: {_updown = "high "};
			};
			_desc = _leftright + _forback + _updown;
			diag_log format ["###sfe finds a view geometry at %1, score is %2", _desc, _cvscore ];
		};
	_visiontotal = _visiontotal + _cvscore; //add them all up
	_cvscore = 0;
} foreach _dirs;
if (_visiontotal isEqualTo (count _dirs)) then
	{
		diag_log format ["###sfe says no view gemoetry nearby!"];
	}
	 else
	{
	 	diag_log format ["###sfe finds nearby view lods, total score is %1", _visiontotal];
	};





diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];