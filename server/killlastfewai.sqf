//by tankbuster
 #include "..\includes.sqf"
_myscript = "killlastfewai";
__tky_starts;
while {not (triggerActivated trg3)} do
{
	sleep 5;
	_lrai = (allunits inAreaArray trg3);
	if ((east countside _lrai) < 3) then
	{
		diag_log format ["klfa finds %1 ai left and kills them", (east countside _lrai)];
		{
		if (([_x, true] call BIS_fnc_objectSide) isEqualTo east) then
			{
			_x setdamage 1;
			diag_log format ["*** klfa kills a %1", ([ gettext  (configFile >> "cfgVehicles" >> (typeof _x) >> "displayname");_x] call BIS_fnc_displayName)];
			};
		}foreach _lrai;

	};

};
__tky_ends