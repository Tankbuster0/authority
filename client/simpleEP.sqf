//simpleep.sqf by 654wak654 and tankbuster
sepa = ["<t color='#ffff33'>Put on ear plugs</t>",{
	_i = _this select 2;
	if (soundVolume == 1) then {
		1 fadeSound 0.3;
		player setUserActionText [_i,"<t color='#ffff33'>Take off ear plugs</t>"];
	} else {
		1 fadeSound 1;
		player setUserActionText [_i,"<t color='#ffff33'>Put on ear plugs</t>"];
	}
},[],-90,false,true,"","_target == vehicle player"];
_this addAction sepa;
