#include "..\includes.sqf"
_myscript = "fn_fobvehicledeploymanager.sqf";
__tky_starts;
private ["_allowed_nearobjs","_allowed_notflat","_allowed_outdoors","_allowed_lineintersects","_allowed_deploy","_buildingobjs","_house","_nobjs1","_nobjs2","_nobjs3","_nobjs4","_begpos0","_begpos1","_begpos2","_intersectobjectscount","_objs1","_objs2","_objs","_endpos1","_endpos2","_endpos3","_endpos4","_foundobj","_tc","_reasonstring","_reasonstring2","_handle22","_nrobjs","_nrtrgs","_cobj"];
if not (fobdeployed) then
{
	//new code starts
	_allowed_nearobjs = false;_allowed_notflat = false;_allowed_outdoors = true;_allowed_lineintersects =false;_allowed_deploy = false;
	_allowed_notflat =  !((position fobveh) isFlatEmpty
	[-1,// min radius
	-1, //mode, must be -1
	0.4, //max grad
	6, // max grad radius
	0,// cannot be water
	false, // shoreline mode off
	objNull// ignore proximity //surely this should be player/ fobveh?
	] isEqualTo []);
	//diag_log format ["###sfe says area flat %1", _allowed_notflat];
	// is inside a house check by killzonekid
	_buildingobjs = [];
	_buildingobjs = (lineIntersectsSurfaces [(getPosWorld fobveh), (getPosWorld fobveh vectorAdd [0,0,50]), fobveh, objNull, true,1, "GEOM", "NONE"] ) select 0 params ["","","", "_house"];
	if !(isNil "_house") then
		{
		if (_house isKindOf "House") then
			{
			_allowed_outdoors = false;
			};
		};
	// nearobjects tests, removes insects, pollen, fish and other small objects
	_nobjs1 = fobveh nearObjects 9;
	_nobjs2 = _nobjs1 - [fobveh]; //take out the vehicle
	_nobjs3 = (_nobjs2 select { ((sizeof (typeof _x) > 1.5))});// remove tiny objects,helipads and runway small lights
	_nobjs4 = [];
	{
		if !((_x isKindOf  "HeliH") or (_x isKindOf "Land_NavigLight")) then {_nobjs4 pushback _x};
	} forEach _nobjs3;
	if (_nobjs4 isEqualTo []) then
		{
			_allowed_nearobjs = true;
		};
		_begpos0 = getPos fobveh; //asl position of the fobveh.. pretty close to the ground
		_begpos1 = fobveh modelToWorld [0,-1,-1]; // move it back a little because the centre is too far forward and move it up off the ground a little
		_begpos2 = ATLToASL _begpos1;//convert it to asl
	_intersectobjectscount = 0;
	for "_i" from 0 to 359 step 10 do
	{
		_objs1 = []; _objs2 = []; _objs =  [];
		_endpos1 = _begpos1 getpos [7, _i];
		_endpos1 set [2, 0.6];
		_endpos2 = ATLToASL _endpos1;
		_objs1 = lineIntersectsObjs [_begpos2, _endpos2, objNull, fobveh, false , 32];
		_endpos3 = _endpos1;
		_endpos3 set [2, 2.2];
		_endpos4 = ATLToASL _endpos3;
		_objs2 = lineIntersectsObjs [_begpos2, _endpos4, objNull, fobveh, false , 32];
		_objs = _objs1 + _objs2;
		if !(_objs isEqualTo []) then
			{
			_foundobj = (_objs select 0);
			_intersectobjectscount = _intersectobjectscount + 1;
			};
	};
	if (_intersectobjectscount isEqualTo 0 ) then {_allowed_lineintersects = true};
	// bring all the check together for a final decision
	if ((_allowed_outdoors) and (_allowed_lineintersects) and (_allowed_notflat) and (_allowed_nearobjs)) then {_allowed_deploy = true};
	if !(_allowed_deploy) then
		{
		_tc = {_x} count [_allowed_outdoors, _allowed_lineintersects, _allowed_notflat, _allowed_nearobjs];
		_reasonstring =  "";
		if !(_allowed_outdoors) then {_reasonstring = _reasonstring + " Can't deploy in a building "};
		if (!(_allowed_lineintersects) or !(_allowed_nearobjs)) then {_reasonstring = _reasonstring + "Too close to other objects "};
		if !(_allowed_notflat) then {_reasonstring = _reasonstring + "Ground isn't flat enough or is in water "};
		_reasonstring2 = "Can't deploy here, " + _reasonstring;
		(format ["%1", _reasonstring2]) remoteexec ["hint", fobveh];
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
			"Deploying FOB." remoteExec ["hint", fobveh];
			[fobveh, true] remoteexec ["lockdriver"];
			sleep 2;
			handle_bf_finished = false;
			_handle22 = [position fobveh, direction fobveh] execVM "server\buildfob.sqf";
			waitUntil {handle_bf_finished};

			sleep 0.5;
			// Make editing area for curator
			(effectiveCommander fobveh) assignCurator cur;
			[] remoteExec ["tky_fnc_resetCuratorBuildlist"];
			cur addCuratorEditingArea [1,(position fobveh),30];
			cur addCuratorCameraArea [1,(position fobveh),30];
			// Hint press button to get in zeus mode
			"Press Zeus Button (Default Y) to open buildmode when deployed." remoteExec ["hint", (effectiveCommander fobveh)];
			fobrespawnpositionid = [west,"fobmarker", "FOB"] call BIS_fnc_addRespawnPosition;
			sleep 2;
			waitUntil {sleep 1; (fobboxlocator distance2d fobveh) < 10};
			fobbox setpos getpos fobboxlocator;
			nul = execVM "server\Functions\fn_cleanupoldprimary.sqf";
			"The FOB has been built. There is a Virtual Arsenal and spawnpoint." remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
			};
		};

}
else
{
	if (!(isNil "fobjects")) then
		{
		"Removing FOB" remoteexec ["hint", fobveh];
		sleep 1;
		fobdeployed = false;
		_nrobjs = fobflagpole nearObjects 32;
		_nrtrgs = _nrobjs select {((typeof _x) isEqualTo "EmptyDetector") and {((getdir _x) < 334) or ((getDir _x) > 332)} };
		// gvs triggers are setdir 333 to distinguish them from other triggers. dont want to delete those by accident
		if ((count _nrtrgs) > 0) then
			{
				deleteVehicle (_nrtrgs select 0);
				diag_log format ["*** fvdm found a trigger and is deleting it!"];
			};
		[fobveh, false] remoteexec ["lockdriver"];
		fobveh setHitPointDamage ["HitEngine", 0 ];
		fobrespawnpositionid call BIS_fnc_removeRespawnPosition;
		publicVariable "fobdeployed";
		blueflags = blueflags - [fobflagpole];
		// Remove Editing Area and curator owner
		cur removeCuratorEditingArea 1;
		cur removeCuratorCameraArea  1;
		_cobj = curatorEditableObjects cur;
		{ deleteVehicle _x;} forEach _cobj;
		fobbox setpos (getpos fobboxsecretlocation);
		[[(position fobveh select 0),(position fobveh select 1),8],(position fobveh),2] call BIS_fnc_setCuratorCamera;
		unassignCurator cur;
		{
			diag_log format ["*** fvdm about to delete %1 which is at %2 and is a %3 / %4", _x, getpos _x, typeOf _x, (getModelInfo _x) select 0];
			deleteVehicle _x;
			diag_log format ["*** fvdm has deleted it, should be nul now %1", _x];
		} foreach fobjects;
		fobjects = [];
		publicVariable "fobjects";
		sleep 1;
		"The FOB has been packed into the Hunter FOB vehicle. You cannot spawn there until the FOB is deployed" remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
		};
};
__tky_ends
