//by tankbuster
 #include "..\includes.sqf"
_myscript = "fobgvstrigger";
__tky_starts;
private _pad =  _this select 0;
diag_log format ["***fgt gets %1", _pad];
[] spawn
	{// brute force for fob GVS broken trigger
	while {fobdeployed} do
		{
			sleep 2;
			_nro = (_pad nearEntities [["Land", "Air"], 6]);
			if (((count _nro) > 0 ) and {(!fobserviceinuse) and (((typeof (_nro select 0)) in allbluvehicles) or ((_nro select 0) in preservedvehicles)) and (isPlayer driver (_nro select 0))}) then
				{
				fobserviceinuse = true;
				publicVariable "fobserviceinuse";
				[['fobserviceinuse', _nro, getpos _pad], 'gvs\generic_vehicle_service.sqf'] remoteExec ['execVM', (driver (_nro select 0))];
				};
		};
	};
__tky_ends
/*
(isServer) and {(!fobserviceinuse) and ((count thislist) isEqualTo 1) and ((typeof (thislist select 0) in allbluvehicles ) or ((_thislist select 0) in preservedvehicles)) and (isplayer driver (thislist select 0)) and (FOBhelipad in (thistrigger nearobjects ['Helipad_base_F', 2]))}*/
fobserviceinuse