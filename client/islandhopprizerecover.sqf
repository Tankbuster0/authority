// by tankbuster
 #include "..\includes.sqf"
_myscript = "islandhopprizevecrecover.sqf";
__tky_starts
diag_log format ["*** %1 starts %2, %3", _myscript, diag_tickTime, time];
// this script is called by the addaction on the fobdaterm and runs client side
if ((recoveryinuse) and {!(player getVariable "isusingprizerecovery") } )exitWith {hint "Another player is using the recovery system"};// reject if someone else has already started

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

	} foreach _pvna
// still need to check for a clear FOBhelipad << real object name but might be local to player who deployed it only

__tky_ends

