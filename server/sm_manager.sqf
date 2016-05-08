//by tankbuster
_myscript = "sm_manager";
// execvmd by the assaultphasefinished
_myscript = "sm_manager";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_sm_required","_sm_hint","_smtypearray","_typeselected","_smmanagerhandle"];

_sm_required = ((2 + ( floor (heartandmindscore / 2))) min 9);
_sm_hint = ceil (_sm_required /2);
switch (_sm_hint) do
	{
	case 1: {
			format ["Your team did very little damage during the assault and the locals are happy with your actions. You have just a few things to finish up before the town will be ours."] remoteexec ["hint", -2];
			};
	case 2: {
			format ["Your team did some damage during the assault. The population are fairly happy with your actions, so now you and your team must make amends by doing some small missions and jobs for them. Then the town will be ours and the enemy banished."] remoteexec ["hint", -2];
			};
	case 3: {
			format ["Your team have done considerable damage to the area, including killing civilians and damaging their infrastructure. They aren't happy. Your team will have to complete a series of missions to make amends."] remoteexec ["hint", -2];
			};
	case 4: {
			format ["Your team have done a lot of damage to the town. Many buildings are destroyed, much infrastructure has been smashed and a number of civilians killed. The populace are very unhappy. Your team will now complete a number of restorative tasks to win back the hearts and minds of the populace."] remoteexec ["hint", -2];
			};
	case 5: {
			format ["There's a lot of destroyed buildings here, not to mention many killed civilians. We don't make war on civilians. Let's rebuild their faith in us and the town. You will now complete a number of reconstruction and reparation tasks. Try not to do any more damage. Hearts and minds, soldier, not blood and guts."] remoteexec ["hint", -2];
			};
	};
_smtypearray = [
"nvmcle",// naval mine clearance in the nearest marine (that doesn't have the frigate in it)
"vipesc",// escort ai vip from pt to another town for a meeting, then back again, opfor in theatre
"medvac",// get an injured ai civ from pt to hospital (in base or elsewhere?)
"alsupl",// if they have a lift chopper, airlift a container from remote pos to pt to help reconstruction
"lnmcle",// clear a nearby minefield
"patrol",// patrol a nearby (not blue) town that has civs and some insurgents in it
"rebild",// if they have an engineer, with other units, find ruins , use engineering foo to remove ruin model and bring back proper building model to surface
"blcnvy",// from a remote location, drive a number of supply trucks to pt (use must stay close code), opfor on map
"radtwr"// find and destroy a radiotower on a hilltop
 ];


for "smcounter" from 0 to _sm_required do
	{
	//_typeselected = selectRandom _smtypearray;
	_typeselected = "lnmcle";
	_smtypearray = _smtypearray - [_typeselected];
	_fname = format ["server\sm\do_%1.sqf", _typeselected];
	diag_log format ["***fname = %1", _fname];
	_smmanagerhandle = execVM _fname;
	waitUntil {sleep 1;scriptDone _smmanagerhandle};


	};








diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];