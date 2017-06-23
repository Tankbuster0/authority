//fn_smcleanup
 #include "..\includes.sqf"
params [["_cleanup",[]],["_pause", 0]];
sleep _pause;
private "_myelement";


	{
	_myelement = _x;
	if (typeName _myelement isEqualTo "GROUP") then
		{
		{deleteVehicle _x} foreach units group _myelement;
		deleteGroup _myelement;
		}
		else
		{
		if (isNull objectParent _myelement ) then
			{
			deleteVehicle _myelement;
			}
			else
			{
				{_myelement deleteVehicleCrew _x} foreach crew _myelement;
				deletevehicle _myelement;
			};
		};



	} foreach _cleanup;