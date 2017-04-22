//[this, 10, 0.01, 2] execVM "heal.sqf";
//heal.sqf by coding and tankbuster
private["_obj","_radius","_healPerSleep","_damage","_sleepTime", "_actualheal"];
_obj = _this select 0;
_radius = _this select 1;
_healPerSleep = _this select 2;
_sleepTime = _this select 3;
if (isServer) then
{
	while {true} do
	{
		{
			if ((alive _x) and (speed _x < 0.5) and (damage _x < 0.9)) then
			{
				if ({(_x getUnitTrait "medic") and (alive _x) and (incapacitatedstate _x == "")} count (_obj nearentities [["SoldierWB"], 4]) > 0)then
					{_actualheal = _healPerSleep * 2;}
					 else
					 {_actualheal = _healPerSleep;};
				_damage = damage _x;
				_damage = _damage - _actualheal;
				if (_damage < 0) then
				{
					_damage = 0;
				};

				_x setDamage _damage;
				if (_damage > 0 ) then
				{
					"You are healing at the medic tent. Please wait." remoteExec ["hint", _x];
				}
				 else
				{
					"You have finished healing. Soldier on!" remoteExec ["hint", _x];
					sleep 4;
					"" remoteExec ["hint", _x];
				}
			};
		}
		forEach ((getPos _obj) nearEntities [["Man"], _radius]);
		sleep _sleepTime;
	};
};