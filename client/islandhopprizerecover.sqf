// by tankbuster
 #include "..\includes.sqf"
_myscript = "islandhoppeizerecovery.sqf";
__tky_starts
diag_log format ["*** %1 starts %2, %3", _myscript, diag_tickTime, time];
private ["_vna","_friendlyname","_dirto","_dist"];
// this script is called by the addaction on the fobdaterm and runs client side
if ((recoveryinuse) and {!(player getVariable "isusingprizerecovery") } )exitWith {hint "Another player is using the recovery system"; __tky_ends};// reject if someone else has already started
if (!(FOBhelipad in fobjects)) exitWith {hint "You need a helipad at the FOB to use the prize vehicle recoery system, otherwise the prize vehicles have nowhere to go"; __tky_ends};// reject if there's no fobhelipad
if ((FOBhelipad in fobjects) and {count (FOBhelipad nearentities [["Car", "Tank", "Air"], 8]) > 0}) exitWith {hint "The FOB helipad needs to be clear of vehicles for this to work"; __tky_ends};// another vehicle already on the fobhelipad
_vna = blubasehelipad nearEntities ["LandVehicle", 20];// vehicle near airhead;
pvna = _vna select {not ((vehicleVarName _x) isEqualTo "")};// take only those with vehiclevarnames
diag_log format ["*** ihpr has %1 near the blubasehelipad but only wants %2", _vna, pvna];
if ((count pvna) < 1) exitWith {hint "There's no prize vehicles near the airhead helipad to be recovered"; __tky_ends};
// all conditions for recovery satisfied.
"The next target is on a different island. Bring your prize vehicles to the Airhead and airlift the FOB to the new island. Deploy it and make a helipad and you will be able to bring your prize vehicles to the new island by using the commands at the FOB data terminal." remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
player setvariable ["isusingprizerecovery", true, true];
recoveryinuse = true; publicVariable "recoveryinuse";

	{
		//make an addaction foreach landvehicle with a varname near the airhead that teleports it to fobhelipad
		_friendlyname = _x call tky_fnc_getscreenname;
		_dirto = [blubasehelipad getdir _x] call TKY_fnc_cardinaldirection;
		_dist = floor (_x distance2D blubasehelipad);
		diag_log format ["*** ihpr makes an addaction for %1", _x];
		myx = _x;
		call compile format ["prid%4 = player addaction ['Bring prize vehicle %1 %3m %2 Airhead to this FOB', {myx setpos  (getpos FOBhelipad); Public_Banned_Vehicle_Service_List pushback myx; publicVariable 'Public_Banned_Vehicle_Service_List'},'',0, false , true, '', '(player distance2d fobdataterminal) < 2']",_friendlyname,_dirto,_dist,_foreachindex];

	} foreach pvna;
prf = player addaction ["Finish prize vehicle recovery",
	{
		for "_i" from 0 to ((count pvna)-1) do
			{
			call compile format ["player removeAction prid%1", _i];
			player setVariable ["isusingprizerecovery", false, true];
			recoveryinuse = false; publicVariable "recoveryinuse";
			};
		player removeaction prf;
	}
	, "",0,false, true , "", "((player distance2d fobdataterminal) < 2)"
	];
__tky_ends
