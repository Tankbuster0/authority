//debug_counthousetypes
 #include "..\includes.sqf"
private _data4 = [];
private _data3 = [];
private _data2 = [];
private _data1 = alpha_1 nearobjects ["house", 350];
{

	if ((count (_x buildingPos -1)> 4) and {(gettext (configfile/"CfgVehicles"/typeOf _x/"UserActions"/"CloseDoor_1"/"actionNamedSel")) != ""}) then
	{
		_data2 pushback (typeof _x);
	};
} foreach _data1;
_data3 = _data2 call BIS_fnc_consolidateArray;
diag_log "unsorted";
{
	diag_log format ["%1", _x];
} foreach _data3;
diag_log "sorted";
{
	_data4 pushback [(_x select 1), (_x select 0)];
} foreach _data3;
_data4 sort true;
{
	diag_log format ["%1", _x];
} foreach _data4;
