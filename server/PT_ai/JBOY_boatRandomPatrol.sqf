 // Put this execVM call in _unit's init in editor:
//    dummy = [this, "ColorBlue",true,2000] execVM "Scripts\JBOY_boatRandomPatrol.sqf";
// In demo mission, the colored markers assigned to these boats:
// Blue= speedboat minigun
// Red= RHIB
// Green= Rubber boat (zodiac)
// Yellow= Civ motorboat (speedboat)
if (!isServer)  exitwith {};
params ["_boat","_color","_showMarkers","_maxRadius"];

_driver = driver (vehicle _boat);
//_driver setBehaviour "CARELESS";
_driver disableAI "FSM";
_moveToPos = [];
_startPos = [];

// Function to get random position that is water and not too close to shore to minimize chance of boat getting stuck.
_fnc_getRandomPos = {
    private["_obj","_centerPos","_radius"];
    _obj = _this select 0;
    _centerPos = _this select 1;
    _radius = _this select 2;
    _posFound = false;
    _randomPos = [];
    _z = 0;
    _distance = 0;
    _dir=0;
    //_dir = random 360;
    while {!_posFound} do
    {
        _z = _z + 1;
        _distance = 500 + random 1500;
        if (_z > 15) then  // Look for good pos radially if 5 random directions failed.  Hopefully cures random chance of trying positions forever.
        {
            _dir = _dir + 10;
            if (_z > 36) then {_z=0;};
        } else {
            _dir = random 360;
        };
        ////diag_log ["in func",_obj,_distance, _dir];
        _randomPos = [_obj, _distance, _dir] call BIS_fnc_relPos;
        _randomPos2 = [_obj, (_distance+50), _dir] call BIS_fnc_relPos;
        _randomPos3 = [_randomPos, (_distance+50), (_dir -90)] call BIS_fnc_relPos;
        _randomPos4 = [_randomPos, (_distance+50), (_dir +90)] call BIS_fnc_relPos;
       // _randomPos5 = [_randomPos, (_distance+50), (_dir -45)] call BIS_fnc_relPos;
        //_randomPos6 = [_randomPos, (_distance+50), (_dir +45)] call BIS_fnc_relPos;
        // Check that water extends in front of pos, left of pos, and right of pos,
        // which gives boat room to turnaround (i.e., move to pos is good, but boat turns left or right and grounds)
        if ( surfaceIsWater _randomPos and (getTerrainHeightASL _randomPos) < -3 and
             surfaceIsWater _randomPos2 and (getTerrainHeightASL _randomPos2) < -3 and
             surfaceIsWater _randomPos3 and (getTerrainHeightASL _randomPos3) < -3 and
             surfaceIsWater _randomPos4 and (getTerrainHeightASL _randomPos4) < -3 and
             //surfaceIsWater _randomPos5 and (getTerrainHeightASL _randomPos5) < -3 and
             //surfaceIsWater _randomPos6 and (getTerrainHeightASL _randomPos6) < -3 and
             (_centerPos distance _randomPos) < _radius
            ) then
        {
            _posFound = true;
        };
        sleep .2;
    };
    _randomPos
};
_startPos = getpos _boat;
//diag_log [_boat,_startPos,_maxRadius];
_moveToPos =  [_boat,_startPos,_maxRadius]  call _fnc_getRandomPos;
_boat commandMove _moveToPos;
_vel = [];
_dir = 0;
//_unit = objNull;
_grp = group _boat;
_speed = 15; // speed to move stuck vehicle
_y = 0;
_prevPos = [0,0,0];
_x = 1;
_continue = true;
_ticsSinceLastStall = 0;
//diag_log [_boat,_color,_showMarkers,_moveToPos,(getpos _boat), (_boat distance _moveToPos),"_x",_x];
while {alive _boat and alive (driver _boat) and _continue and _x < 500} do
{
    ////diag_log [_boat,_color,_moveToPos,(getpos _boat), _prevPos, (_boat distance _prevPos),"_x",_x];
    _boat setFuel 1;
    if ((_boat distance _moveToPos) < 30 ) then
    {
        //diag_log ["b4 func",_boat,str _startPos,str _maxRadius, "depth",(getTerrainHeightASL (getpos _boat)),"_x",_x];
        _boat commandMove (getpos _boat); // move to current pos hopefully "completes" that move and resets ai
        _moveToPos = [_boat,_startPos,_maxRadius] call _fnc_getRandomPos;
        _boat commandMove _moveToPos;
        ////diag_log [_boat,_color,"New POS!!!!!",_moveToPos,(getpos _boat), _prevPos, (_boat distance _prevPos)];
   };
    if ((_boat distance _prevPos) < 3 and _x > 30) then  // boats stop for no reason some time, maybe re-commanding move will fix it
    {
        _ticsSinceLastStall = _ticsSinceLastStall +1;
        if (_ticsSinceLastStall > 10) then
        {
            _boat commandMove (getpos _boat); // move to current pos hopefully "completes" that move and resets ai
            sleep .3;
            if (_ticsSinceLastStall > 20) then
            {
                if (getTerrainHeightASL (getpos _boat) > -2.5 ) then // if stuck because too shallow
                {
                    //diag_log [_boat,_color,"LONG STALL IN SHALLOW WATER, SO DO 180 FLIP, GIVE NEW MOVE COMMAND!",_moveToPos,(getpos _boat), _prevPos, (_boat distance _prevPos),"_x",_x];
                    _boat setdir ((getdir _boat) - 180); // Flip boat 180 if stuck for a long time.  Replace this later with a less ugly rotation/
                    _vel = velocity _boat;
                    _dir = getdir _boat;
                    _boat setVelocity [(_vel select 0)+(sin _dir*_speed),(_vel select 1)+ (cos _dir*_speed),(_vel select 2)];
                     _ticsSinceLastStall = 0;
                }
                else
                {
                    //diag_log [_boat,_color,"LONG STALL, AI is hopelessly confused, so lets replace him",_moveToPos,(getpos _boat), _prevPos, (_boat distance _prevPos), "depth",(getTerrainHeightASL (getpos _boat)),"_x",_x];
                    sleep .5;
                    // Create new _unit, and delete old driver.  Hopefully fresh AI will respond to move commands.
                    _type = typeOf _driver;
                    _gear = getUnitLoadout _driver;
                    unassignVehicle _driver;
                    deleteVehicle _driver;
                     _unit = objnull;
                    _unit = _grp createUnit [_type,[0,0,0],[],0,"NONE"];
                     sleep .1;
                    //[_unit] joinSilent (group _boat);
                    [_unit] allowGetIn true;
                    _unit setUnitLoadout _gear;
                    _unit moveInDriver _boat;
                    _driver = _unit;
                    _ticsSinceLastStall = 0;
                };
            };
            sleep 1;
            _moveToPos = [_boat,_startPos,_maxRadius] call _fnc_getRandomPos;
            _boat commandMove _moveToPos;
            //diag_log [_boat,_color,"BOAT STALLED, GIVE NEW MOVE COMMAND!",_moveToPos,(getpos _boat), _prevPos, (_boat distance _prevPos),"_x",_x];
        };
   }
   else
   {
        _ticsSinceLastStall = 0;
   };
   if (_showMarkers) then
   {
       if ((_x mod 6) == 0) then  // create marker every x iterations
       {
           _markerstr = createMarker [("Mrk_"+_color+ str _y+str (getpos _boat)),getpos _boat];
           _markerstr setMarkerShape "ICON";
           _markerstr setMarkerType "mil_dot";
           _markerstr setMarkerColor _color;
           _y = _y +1;
       };
   };
   _prevPos = getpos _boat;
   _driver = driver _boat;
    sleep 1;
    _x = _x + 1;
};
//diag_log format ["exited loop for %1, %2, %3",_boat,alive _boat, alive (driver _boat)];
// After about 800 iterations the script running on the blufor speedboat with minigun may stop or fail, no longer writing to //diag_log.
// So now I stop the above loop after 500 iterations, and re-executing same script on the boat.  This hopefully cures
// the script from stopping for no apparent reason.
if (alive _boat and alive (driver _boat)) then
{
    [_boat, _color, _showMarkers, _maxRadius] spawn
    {
        params ["_boat","_color","_showMarkers","_maxRadius"];
        dummy = [_boat, _color, _showMarkers, _maxRadius] execVM "Scripts\JBOY_boatRandomPatrol.sqf";
    };
};