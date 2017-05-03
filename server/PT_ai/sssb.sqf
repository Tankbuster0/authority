/*
 SSSB - Sarogahtyps Simple Suicide Bomber

 Description:
	Function can be called wherever u want even in init line.
	It waits for player who is in range and follows him until reached and then BOOOOM!
	The bomber is walking if player can see the bomber. If there is no line of sight to player then the bomber will run.
	Works even if the bomber is driving a vehicle.
	If player is out of range before bomber can reach him then the bomber will just wait for the next player in range.
	You can pass a chance to get a bomber to the function.
	This is useful for implementing the script into COS - Civilian Occupation System.
	You can apply the script to all civilians and if u pass e.g. 1 % as chance then only every 100th civ will

become a bomber and wait for near players.
	Enjoy the boom. :-)
	Cheers Saro.

 Paramameters:
	object - the object of your unit which should become a bomber
	number (optional) - range to seek for players (default is 300 m)
	number (optional) - chance to turn the unit into a bomber. (default is 100 %)

Return values:
true if script has ended.
*/

params [["_civ", objNull,[objNull]], ["_act_range", 300, [0]], ["_chance", 100, [0]]];

if ((random 100 > _chance) || (isNull _civ)) exitWith {true};

[_civ, _act_range] spawn
{
 params ["_bomber", "_act_range"];
 private _melee_dist = 15;
 private _boom_dist = 5;
 private _target_players = [];
 private _grp_bomber = group _bomber;
 private _wp =[];
 private _dist_target = _act_range;
 private _lost_range = round (_act_range * 1.2);
 private _is_vec = if (isNull objectParent _bomber) then {false} else {true};

 while {(alive _bomber) && !(isNull _bomber) && (_dist_target > _boom_dist)} do
 {
  // wait until players are in range
  waitUntil
  {
   sleep (2 + random 1);
   _target_players = (allPlayers - entities "HeadlessClient_F") select {(alive _x) && ((_x distance _bomber) < _act_range)};
   ((count _target_players > 0) || !(alive _bomber) || (isNull _bomber))
  };

  // end everything if suicide bomber is already dead
  if (!(alive _bomber) || (isNull _bomber)) exitWith {};

   // follow nearest player as long as bomber lives, target is in range and target is not close enough to boom
  while {alive _bomber && !(isNull _bomber) && (_dist_target < _lost_range) && (_dist_target > _boom_dist)} do
  {
   _target_players = (allPlayers - entities "HeadlessClient_F") select {(alive _x) && ((_x distance _bomber) < _act_range)};
   // get nearest player
   _target_players = _target_players apply {[(_x distance _bomber), _x]};
   _target_players sort true;
   _target_plyr = _target_players select 0 select 1;

   // check distance and visibility
   _dist_target = _target_players select 0 select 0;
   _can_see = [_target_plyr, "VIEW", _bomber] checkVisibility [(eyePos _target_plyr), (eyePos _bomber)];

   // add waypoint and set bombers behavior
   if (count _wp > 0) then {_grp_bomber setCurrentWaypoint _wp;}
   else {_wp = _grp_bomber addWaypoint [position _target_plyr, 0];};

   _wp setWaypointPosition [position _target_plyr, 0];
   _wp setWaypointBehaviour "CARELESS";
   _wp setWaypointCombatMode "BLUE";
   _wp setWaypointCompletionRadius 0;

   _grp_bomber setBehaviour "CARELESS";
   _grp_bomber setCombatMode "BLUE";

   //run if close enough or if target cant see bomber
   if ( (_can_see < 0.3) ||
   ((_dist_target < _melee_dist) && !_is_vec) ||
   ((_dist_target < (2 * _melee_dist)) && _is_vec) ) then
   {
    _wp setWaypointSpeed "FULL";
   }
   else
   {
    _wp setWaypointSpeed "LIMITED";
   };
   sleep (0.5 + random 0.5);
  }; // end follow while
  _wp = [];
 }; // main while end
_playsound = mission_root + "client\sounds\allahu.ogg";
playsound3d [_playsound, _bomber,false, getposasl _bomber,10,1,50];
sleep 1.7;
 if (_is_vec) then
 {
  _boom = createVehicle ["Bo_GBU12_LGB", getPos _bomber, [], 0, "CAN_COLLIDE"];
 }
 else
 {
  _boom = createVehicle ["R_80mm_HE", getPos _bomber, [], 0, "CAN_COLLIDE"];
 };
 deleteVehicle _bomber;
}; //spawn end  \\\\
true