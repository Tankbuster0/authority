//by tankbuster
 #include "..\includes.sqf"
_myscript = "sm_manager";
// execvmd by the assaultphasefinished
__tky_starts;
private ["_sm_required","_sm_hint","_smtypearray","_posplaces","_deepest","_deepestdepth","_typeselected","_fname","_smmanagerhandle"];
_sm_required = ((2 + ( floor (heartandmindscore / 2))) min 9);
_sm_hint = ceil (_sm_required /2);
switch (_sm_hint) do
	{
	case 1: {
			format ["Your guys did very little damage during the assault and the locals are happy with your actions. You have just a few things to finish up before the town will be ours."] remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
			};
	case 2: {
			format ["Your team did some damage during the assault. The population are fairly happy with your actions, so now you and your team must make amends by doing some small missions and jobs for them. Then the town will be ours and the enemy banished."] remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
			};
	case 3: {
			format ["Your team have done considerable damage to the area, including killing civilians and damaging their infrastructure. They aren't happy. Your team will have to complete a series of missions to make amends."] remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
			};
	case 4: {
			format ["Your team have done a lot of damage to the town. Many buildings are destroyed, much infrastructure has been smashed and a number of civilians killed. The populace are very unhappy. Your team will now complete a number of restorative tasks to win back the hearts and minds of the populace."] remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
			};
	case 5: {
			format ["There's a lot of destroyed buildings here, not to mention many killed civilians. We don't make war on civilians. Let's rebuild their faith in us and the town. You will now complete a number of reconstruction and reparation tasks. Try not to do any more damage. Hearts and minds, soldier, not blood and guts."] remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
			};
	};
_smtypearray = [
"navalmineclear",// naval mine clearance in the nearest marine (that doesn't have the frigate in it)
"landmineclear",// clear a nearby minefield
"runwaycraterclear"// clear some craters from mainbase runway
"stealaircraft"// steal an aircraft
 ];

//_sm_required = 1;//debug only
for "mycounter" from 1 to _sm_required do
	{
	smcounter = mycounter;
	sleep 1;
	_deepest = 	(selectBestPlaces [cpt_position, 2500, "waterdepth", 50, 100]) select 0;
	_deepestdepth = _deepest select 1;
	if (_deepestdepth < 25) then 	{	_smtypearray = _smtypearray - ["navalmineclear"];
		diag_log "***sm manager couldnt find deep enough see nearby so removed naval mine cleareance from sm roster";
		};// if there's no deep ( > 25m) water within 1000m, remove navalmineclearance from possible missions)
	if (getMarkerPos "cpt_marker_1" isEqualTo [23145,18443.6,3.19]) then {	_smtypearray = _smtypearray - ["runwaycraterclear"];};// runway crater clear doesnt work on almyra (it needs runway objects to work)
	_typeselected = selectRandom _smtypearray;
	_typeselected = "runwaycraterclear";

	_smtypearray = _smtypearray - [_typeselected];
	_fname = format ["server\SecondaryMissions\do_%1.sqf", _typeselected];
	_smmanagerhandle = execVM _fname;
	waitUntil {sleep 1;scriptDone _smmanagerhandle};

	//succeed or fail?

	if not (missionsuccess) then
		{
		format ["%1", failtext] remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		mycounter = mycounter -1;
		sleep 10;

		}else
		{
		if (mycounter < _sm_required) then
			{
			"Good work. Next mission incoming." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
			};
		};


	};




		"ALL MISSIONS COMPLETED" remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];



__tky_ends