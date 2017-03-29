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
		{_X setdamage 1;}foreach _lrai;

	};

};
__tky_ends