//ARMA3Alpha function LV_fnc_ACskills v0.8 - by SPUn / lostvar
//adjusts AI skills
private ["_group","_skills","_skillArray"];
_group = _this select 0;
_skills = _this select 1;

if(typeName _skills isEqualTo "SCALAR")then{
	_skillArray = [_skills,_skills,_skills,_skills,_skills,_skills,_skills,_skills,_skills,_skills];
}else{
	_skillArray = [(_skills select 0),(_skills select 1),(_skills select 2),(_skills select 3),(_skills select 4),(_skills select 5),(_skills select 6),(_skills select 7),(_skills select 8),(_skills select 9)];
};
//current ai skills 0.25,0.25,0.8,0.45,0.6,0.45,0.45,0.55,1,0.55
//rdx random skill system
		_aac_adjust = random -0.1;
		_ash_adjust = random -0.5;
		_asp_adjust = random -0.5;
		_cou_adjust = random -0.15;

/*{
	_x setSkill ["aimingAccuracy",(_skillArray select 0 + _aac_adjust)];// rdx;
	_x setSkill ["aimingShake",(_skillArray select 1 + _ash_adjust)];// rdx
    _x setSkill ["aimingSpeed",(_skillArray select 2 + _asp_adjust)];//rdx
    _x setSkill ["endurance",(_skillArray select 3)];
	_x setSkill ["spotDistance",(_skillArray select 4)];
    _x setSkill ["spotTime",(_skillArray select 5)];
    _x setSkill ["courage",(_skillArray select 6 + _cou_adjust)];//rdx
    _x setSkill ["reloadspeed",(_skillArray select 7)];
	_x setSkill ["commanding",(_skillArray select 8)];
    _x setSkill ["general",(_skillArray select 9)];

}forEach units group _group;
*/
[ _group, true, true] call d_fnc_tc_setskill;