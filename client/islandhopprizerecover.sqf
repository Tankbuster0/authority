// by tankbuster
 #include "..\includes.sqf"
_myscript = "islandhopprizerecover.sqf";
__tky_starts
diag_log format ["*** %1 starts %2, %3", _myscript, diag_tickTime, time];
// this script is called by the addaction on the fobdaterm and runs client side
if ((recoveryinuse) and {!(player getVariable "isusingprizerecovery") } )exitWith {hint "Another player is using the recovery system"};// reject if someone else has already started
if (!(FOBhelipad in fobjects)) exitWith {hint "You need a helipad at the FOB to use the prize vehicle recoery system, otherwise the prize vehicles have nowhere to go"};// reject if there's no fobhelipad
if ((FOBhelipad in fobjects) and {count (FOBhelipad nearentities [["Car", "Tank", "Air"], 8]) > 0}) exitWith {hint "The FOB helipad needs to be clear of vehicles for this to work"};// another vehicle already on the fobhelipad
//waitUntil {sleep 10; islandhop};

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
_pvna = _vna select {not ((vehicleVarName _x)isEqualTo "")};// take only those with vehiclevarnames
//make an addaction that says 'end vehicle recovery' that sets islandhop to false, recoveryinuse to false and isusingprizerecovery to false. ie, ending the recovery process for good.
	{
		//make an addaction foreach landvehicle with a varname near the airhead that teleports it to fobhelipad
		_friendlyname = _x call tky_tky_fnc_getscreenname;
		_dirto = cardinaldirs select (  ([(FOBhelipad getdir _x), 45] call BIS_fnc_rounddir) /45);
		_dist = floor (_x distance2D FOBhelipad);
		_randomid = player addaction [format ["Bring prize vehicle %1 %3m %2 Airhead to this FOB", _friendlyname, _dirto, _dist ], {setpos _x (getpos FOBhelipad)}];


	} foreach _pvna
player addaction ["Finish prize vehicle recovery", {/* reset all variables and end script, i guess */}]
// still need to check for a clear FOBhelipad << real object name but might be local to player who deployed it only

__tky_ends

