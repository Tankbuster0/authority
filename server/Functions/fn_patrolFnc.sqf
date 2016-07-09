_group=group (_this select 0);
_group setBehaviour "Combat";
_group setSpeedMode "Normal";

	if (side (_this select 0) == CIVILIAN)
		then {
	/*_index = currentWaypoint group player;
	deleteWaypoint [_group, _index];
	_group allowFleeing 1;
	*/
	_runto = selectRandom ([nearestBuilding (leader _group)] call BIS_fnc_buildingPositions);
	{_x domove _runto;} foreach (units _group);


		}else{
		deleteWaypoint [_group, _index];
			};

(_this select 0) removeAllEventHandlers "FiredNear";