#define filename "missionsetup.sqf"
_thisscript = "missionsetup.sqf";
//by tankbuster
private ["_foundairfields","_mapsize","_mapcentre","_locs","_airfield","_drypos","_1pos","_y","_postest"];
diag_log format ["*** %1 starts %2,%3", _thisscript, diag_tickTime, time];
// find all airfields
	_foundairfields = [];
	_mapsize  = worldSize;
	_mapcentre = [_mapsize / 2, _mapsize / 2 ,0];
	_locs = nearestLocations [_mapcentre ,["NameVillage", "NameLocal"], _mapsize / 2];
		{
		if ((["airfield", text _x] call BIS_fnc_instring) or (["airbase", text _x] call BIS_fnc_instring)) then
			{ _foundairfields pushback _x}
		} foreach _locs;
	//diag_log format ["***foundairfields %1 is typename %1",_foundairfields, typeName _foundairfields];

_airfield = _foundairfields call bis_fnc_selectRandom;
//diag_log format [" ***airfield chosen is %1 at %2", text _airfield, locationPosition _airfield];
_drypos =[];
_1pos = locationPosition _airfield;

//drypos finder by cool=azroul13
For "_i" from 0 to 2000 step 100 do
{
	For "_y" from 0 to 360 step 45 do
	{
             _postest = [(_1pos select 0) + (sin _y) * _i, (_1pos  select 1) + (cos _y) * _i, 0];
             If (surfaceIsWater _postest) exitwith
             {
                 _drypos = _postest;
             };
    };
       If (!(_drypos isequalto [])) exitwith {};
};
_newdrypos = [_drypos,20,50, 5, 0, 10, 1] call bis_fnc_findSafePos;
_newdrypos set [2,0];
"respawn_west" setmarkerpos _newdrypos;
ammobox setpos _newdrypos;
diag_log format ["*** %1 ends %2,%3", _thisscript, diag_tickTime, time];