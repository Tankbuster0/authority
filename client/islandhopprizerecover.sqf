// by tankbuster
 #include "..\includes.sqf"
_myscript = "islandhopprizerecover.sqf";
__tky_starts
diag_log format ["*** %1 starts %2, %3", _myscript, diag_tickTime, time];
private ["_vna","_friendlyname","_dirto","_dist"];
// this script is called by the addaction on the fobdaterm and runs client side
if ((recoveryinuse) and {!(player getVariable "isusingprizerecovery") } )exitWith {hint "Another player is using the recovery system"};// reject if someone else has already started
if (!(FOBhelipad in fobjects)) exitWith {hint "You need a helipad at the FOB to use the prize vehicle recoery system, otherwise the prize vehicles have nowhere to go"};// reject if there's no fobhelipad
if ((FOBhelipad in fobjects) and {count (FOBhelipad nearentities [["Car", "Tank", "Air"], 8]) > 0}) exitWith {hint "The FOB helipad needs to be clear of vehicles for this to work"};// another vehicle already on the fobhelipad
// message all players something to the effect of
// you've island hopped and can get all of your land prize vehicles here if
// 1. have a helipad at the deployed fob
// 2. put the vehicles you want to bring here near (but not on) the airhead helipad
// 3. use the options at the dataterminal
if (hasInterface) then {diag_log "runs on client because has interface"};
if (isDedicated) then {diag_log "runs on server because isdedicated"};
//"" remoteexecCall ["tky_fnc_t_usefirstemptyinhintqueue",2,false];
"The next target is on a different island. Bring your prize vehicles to the Airhead and airlift the FOB to the new island. Deploy it and make a helipad and you will be able to bring your prize vehicles to the new island." remoteexecCall ["tky_fnc_t_usefirstemptyinhintqueue",2,false];
player setvariable ["isusingprizerecovery", true, true];
recoveryinuse = true; publicVariable "recoveryinuse";

_vna = blubasehelipad nearEntities ["LandVehicle", 20];// vehicle near airhead;

pvna = _vna select {not ((vehicleVarName _x) isEqualTo "")};// take only those with vehiclevarnames
diag_log format ["*** ihpr has %1 near the blubasehelipad but only wants %2", _vna, pvna];
//make an addaction that says 'end vehicle recovery' that sets islandhop to false, recoveryinuse to false and isusingprizerecovery to false. ie, ending the recovery process for good.
	{
		//make an addaction foreach landvehicle with a varname near the airhead that teleports it to fobhelipad
		_friendlyname = _x call tky_fnc_getscreenname;
		_dirto = cardinaldirs select (  ([(blubasehelipad getdir _x), 45] call BIS_fnc_rounddir) /45);
		_dist = floor (_x distance2D blubasehelipad);
		diag_log format ["*** ihpr makes an addaction for %1", _x];
		myx = _x;
		//(format ["prid%1", _foreachindex]) = player addaction [(format ["Bring prize vehicle %1 %3m %2 Airhead to this FOB", _friendlyname, _dirto, _dist ]), {_x setpos (getpos blubasehelipad)}];
		call compile format ["prid%4 = player addaction ['Bring prize vehicle %1 %3m %2 Airhead to this FOB', {myx setpos  (getpos FOBhelipad); Public_Banned_Vehicle_Service_List pushback myx;}, false , true]",_friendlyname,_dirto,_dist,_foreachindex];

	} foreach _pvna;
prf = player addaction ["Finish prize vehicle recovery",
	{
		for "_i" from 0 to (count pvna) do
			{
			player removeAction format ["prid%1", _i];
			player removeAction prf;
			};
	}];

__tky_ends

