_myscript = "fn_fobvehicledeploymanager.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_candidatepos","_nul","_cobj","_veh"];
if not (fobdeployed) then
{
	diag_log format ["*** fdm says fob not deployed"];
	//fob deploy requested
	_candidatepos = (position fobveh) isFlatEmpty
	[5,// nothing within this distance
	-1,// biki says set this to -1
	0.75,// max gradient (upto about 27degrees)
	5,// how far to check gradient
	0,// cannot be water
	false,// ignore shoreline detection
	 objNull// ignore unit in object detection
	 ];
	if (_candidatepos isEqualTo []) then
		{
		diag_log "*** fdm deploy denied";
		//hint "Not enough space to make FOB here";
		"Not enough space or too steep to build FOB here." remoteexec ["hint", fobveh];
		[fobveh,1] remoteexec ["tky_fnc_setfuel"];
		sleep 4;
		}
		else
		{
		if not(isNull (driver fobveh)) then
			{
			diag_log "*** fdm refuses because there's a driver in fobveh";
			{"Can't deploy while there's a driver in the vehicle." remoteexec ["hint", _x];} foreach crew fobveh;
			}
			else
			{
			diag_log "*** fdm deploying";
			//hint "Deploying FOB";
			"Deploying FOB." remoteExec ["hint", fobveh];
			[fobveh, true] remoteexec ["lockdriver"];
			sleep 2;
			_handle22 = [position fobveh, direction fobveh] execVM "server\buildfob.sqf";
			waitUntil {scriptDone _handle22};
			sleep 0.5;
			fobbox setpos (position fobboxlocator);
			// Make editing area for curator
			(commander fobveh) assignCurator cur;
			[] remoteExec ["tky_fnc_resetCuratorBuildlist"];
			cur addCuratorEditingArea [1,(position fobveh),50];
			cur addCuratorCameraArea [1,(position fobveh),50];
			// Hint press button to get in zeus mode
			"Press Zeus Button (Default Y) to open buildmode when deployed." remoteExec ["hint", (commander fobveh)];
			fobrespawnpositionid = [west,"fobmarker", "FOB"] call BIS_fnc_addRespawnPosition;
			sleep 5;
			};
		};
}
else
{
	diag_log "*** fdm says fod is deployed";
	if (!(isNil "fobjects")) then
		{
		//hint "Removing FOB";
		diag_log "***removing fob";
		"Removing FOB" remoteexec ["hint", fobveh];
		sleep 2;
		{deleteVehicle _x} foreach fobjects;
		fobdeployed = false;
		[fobveh, false] remoteexec ["lockdriver"];
		fobveh setHitPointDamage ["HitEngine", 0 ];
		fobrespawnpositionid call BIS_fnc_removeRespawnPosition;
		publicVariable "fobdeployed";
		// Remove Editing Area and curator owner
		cur removeCuratorEditingArea 1;
		cur removeCuratorCameraArea  1;
		_cobj = curatorEditableObjects cur;
		{ deleteVehicle _x;} forEach _cobj;
		fobbox setpos (getpos fobboxsecretlocation);
		[[(position fobveh select 0),(position fobveh select 1),8],(position fobveh),2] call BIS_fnc_setCuratorCamera;
		unassignCurator cur;
		sleep 2;
		};
};
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];
