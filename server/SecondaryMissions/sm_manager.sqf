//by tankbuster
 #include "..\includes.sqf"
_myscript = "sm_manager";
// execvmd by the assaultphasefinished
__tky_starts;
private ["_sm_required","_sm_hint","_pt_name","_smtypearray","_deepest","_deepestdepth","_wvecs","_whelivtols","_wairarmed","_fname","_smmanagerhandle", "_previousmission", "_engineercount"];
_previousmission = "none";
typeselected = "";
_sm_required = ((2 + ( floor (heartandmindscore / 2))) min 9);
_sm_hint = ceil (_sm_required /2);
diag_log format ["*** smm says h&M score is %1 and smreqd is %2", heartandmindscore, _sm_required];
_pt_name = primarytarget getVariable "targetname";
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
"runwaycraterclear",// clear some craters from mainbase runway
"stealaircraft",
"slingloaddelivercontainer",// steal an aircraft
"sinktrawler",
"blueconvoytoab",
"destroyradiotower",
"kill1man"// "repairlocalbuilding"
 ];// rmoved hostagerescue for now
//_sm_required = 1;//debug only
smcounter = 1;
while {smcounter < _sm_required} do
	{
	sleep 10;
	// custom exclusions ///////////////////////////////////////////////////////////////////////////////////////////////////////
	// #1 dont do navalmine clearance if theres no deep water nearby
	_deepest = 	(selectBestPlaces [cpt_position, 2500, "waterdepth", 100, 100]) select 0;
	_deepestdepth = _deepest select 1;
	if (_deepestdepth < 25) then
		{
		_smtypearray = _smtypearray - ["navalmineclear"];
		diag_log "***sm manager couldnt find deep enough sea nearby so removed naval mine cleareance from sm roster";
		};// if there's no deep ( > 25m) water within 1000m, remove navalmineclearance from possible missions)
	//#2 dont do crater clearance on Almyra as it lacks the runways objects the sm needs
	if (getMarkerPos "cpt_marker_1" isEqualTo [23145,18443.6,3.19]) then
		{
		_smtypearray = _smtypearray - ["runwaycraterclear"];
		diag_log "*** sm manager removes runwaycraterclear from the sm array because we're at Almyra";
		};
	//#3 dont do aircraft steal if airhead is at tuvanaka, but can do it there if west have a heli
	_wvecs = vehicles select {(([_x, true] call BIS_fnc_objectSide) isEqualTo west) and {(alive _x) and (canMove _x)}};
	_whelivtols = call tky_fnc_fleet_heli_vtols;
	if	( ((count _whelivtols) > 1) and {_pt_name == "Tuvanaka"} ) then
		 	{
		 	_smtypearray = _smtypearray - ["stealaircraft"];
		 	diag_log "***sm manager removes stealaircraft from the sm array because we're at tuvanaka";
		 	};
	//#4 dont do sinktrawler if theres no deep water within 10k or if they dont have attack aircraft
	_deepest = 	(selectBestPlaces [cpt_position, 2500, "waterdepth", 100, 100]) select 0;
	_deepestdepth = _deepest select 1;
	_wairarmed  = call tky_fnc_fleet_armed_aircraft;
	if ( (_deepestdepth < 25) or ((count _wairarmed) < 1 )) then
		{
		_smtypearray = _smtypearray - ["sinktrawler"];
		diag_log "***sm manager removes sinktrawler because there's no deep water nearby or blufor dont have attack aircraft in fleet";
		};
	if ((cpt_island isEqualTo 2) and ((toLower worldName) isEqualTo "tanoa")) then //tuvanaka island
		{_smtypearray = _smtypearray - ["blueconvoytoab"];};
	//#5 dont do repairbuilding if no engineer in squad
	if ((count (allplayers select {_x getUnitTrait isEqualTo "engineer"})) isEqualTo 0) then
		{_smtypearray - _smtypearray - ["repairlocalbuilding"];};
// end of exclusions///////////////////////////////////////////////////////////////////
	typeselected = selectRandom _smtypearray;
	while  {(typeselected isEqualTo _previousmission)} do
		{
		typeselected = selectRandom _smtypearray;
		diag_log format ["***smm says smarray is %1 and chooses %2, _previousmission is %3", _smtypearray, typeselected, _previousmission];
		};
	 publicVariable "typeselected";
	//_smtypearray = _smtypearray - [typeselected];
	_fname = format ["server\SecondaryMissions\do_%1.sqf", typeselected];
	diag_log format ["***current sm number is %1", smcounter];
	_smmanagerhandle = execVM _fname;
	waitUntil {sleep 1;scriptDone _smmanagerhandle};
	//succeed or fail?
	if not (missionsuccess) then
		{
		format ["%1", failtext] remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		diag_log format ["***smm after mission failure, smcounter is %1", smcounter];
		sleep 10;
		}
		else
		{
		_smtypearray = _smtypearray - [typeselected];// only remove selected mission if it's completed successfully
		if (smcounter < _sm_required) then
			{
			"Good work. Next mission incoming." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
			smmissionstring = "There are further Secondary Missions. Orders incomming soon";
			publicVariable "smmissionstring";
			smcounter = smcounter + 1;
			_previousmission = typeselected;
			};
		};
	};
"ALL MISSIONS COMPLETED" remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
smmissionstring = "You've completed all the Secondary Missions for this town. The locals are happy with our work. Next Primary Mission orders coming soon.";
publicVariable "smmissionstring";
sleep 10;

__tky_ends