	/*
	File: objectMapper.sqf
	Author: Joris-Jan van 't Land
	Edits: dixon13 aka D.Begay 71st Special Operations Group

	Description:
	Takes an array of data about a dynamic object template and creates the objects.

	Parameter(s):
	_this select 0: position of the template - Array [X, Y, Z]
	_this select 1: azimuth of the template in degrees - Number
	_this select 2: objects for the template - Array / composition class - String / tag list - Array
	_this select 3: (optional) randomizer value (how much chance each object has of being created. 0.0 is 100% chance) - Number
	(_this select 2) select 3: number - set the fuel of an object default: 1
	(_this select 2) select 4: number - set the damage of an object default: 0
	(_this select 2) select 5: array 2 elements - manually set the orientation of the object default: [0,0]
	(_this select 2) select 6: string - give an object a name in string format default: "" - empty string
	(_this select 2) select 7: string - type code inside a string that you want to be executed when the object spawns default: "" - empty string
	(_this select 2) select 8: boolean value - set to false if you want the object to not have simulation default: true
	(_this select 2) select 9: boolean value - set to true if you want the object to spawn and align to the ground default: false

	Returns:
	Created objects (Array)
*/

private ["_rdm"];

params[["_pos",[0,0]],["_azi",[-1]],["_objs",[[],""]]];

//Optionally pass a randomizer value
if ((count _this) > 3) then {
	_rdm = _this select 3;
} else { _rdm = 0; };

//Validate parameters
if (!((typeName _objs) in [(typeName ""), (typeName [])])) exitWith {debugLog "Log: [INS_mhq_fnc_objectMapper] Template objects (2) must be a String or Array!"; []};
if ((typeName _rdm) != (typeName 0)) exitWith {debugLog "Log: [INS_mhq_fnc_objectMapper] Randomizer value (3) must be a Number!"; []};
if ((_rdm < 0.0) || (_rdm > 1.0)) exitWith {debugLog "Log: [INS_mhq_fnc_objectMapper] Randomizer value (3) must be a Number between 0.0 and 1.0!"; []};

private ["_newObjs"];

//See if an object array, specific composition class or tag array was given
private ["_cfgObjectComps", "_script"];
_cfgObjectComps = configFile >> "CfgObjectCompositions";

if ((typeName _objs) == (typeName "")) then
{
	//Composition class was given
	_script = getText(_cfgObjectComps >> _objs >> "objectScript");
	_objs = [];
}
else
{
	private ["_testSample"];
	_testSample = _objs select 0;
	if ((typeName _testSample) != (typeName [])) then
	{
		//Tag list was given
		private ["_queryTags"];
		_queryTags = +_objs;
		_objs = [];

		//Make a list of candidates which match all given tags
		private ["_candidates"];
		_candidates = [];

		for "_i" from 0 to ((count _cfgObjectComps) - 1) do
		{
			private ["_candidate", "_candidateTags"];
			_candidate = _cfgObjectComps select _i;
			_candidateTags = getArray(_candidate >> "tags");

			//Are all tags in this candidate?
			if (({_x in _candidateTags} count _queryTags) == (count _queryTags)) then
			{
				_candidates = _candidates + [getText(_candidate >> "objectScript")];
			};
		};

		//Select a random candidate
		_script = _candidates select (floor (random (count _candidates)));
	};
};

//If the object array is in a script, call it
if (!isNil "_script") then
{
	_objs = call (compileFinal (preprocessFileLineNumbers _script));
};

//Make sure there are definitions in the final object array
if ((count _objs) == 0) exitWith {debugLog "Log: [INS_mhq_fnc_objectMapper] No elements in the object composition array!"; []};

_newObjs = [];

private ["_posX", "_posY"];
_posX = _pos select 0;
_posY = _pos select 1;

//Function to multiply a [2, 2] matrix by a [2, 1] matrix
private ["_multiplyMatrixFunc"];
_multiplyMatrixFunc =
{
	private ["_array1", "_array2", "_result"];
	_array1 = _this select 0;
	_array2 = _this select 1;

	_result =
	[
		(((_array1 select 0) select 0) * (_array2 select 0)) + (((_array1 select 0) select 1) * (_array2 select 1)),
		(((_array1 select 1) select 0) * (_array2 select 0)) + (((_array1 select 1) select 1) * (_array2 select 1))
	];

	_result
};
setVehicleVarNameGlobal = {
	private["_newObj","_varName"];
	_newObj = _this select 0;
	_varName = _this select 1;

	_newObj setVehicleVarName _varName;
	call (compileFinal (_varName + " = _newObj;"));
	_varName = _newObj;
	Vehicle_Var_Name = _varName;
	publicVariable "Vehicle_Var_Name";
};

{
	//Check randomizer for each object
	if ((random 1) > _rdm) then {
		private ["_type", "_relPos", "_azimuth", "_fuel", "_damage", "_orientation", "_varName", "_init", "_simulation", "_ATL", "_newObj","_surfaceNormal"];
		_type = _x select 0;
		_relPos = _x select 1;
		_azimuth = _x select 2;

		//Optionally map certain features for backwards compatibility
		if ((count _x) > 3) then {_fuel = _x select 3};
		if ((count _x) > 4) then {_damage = _x select 4};
		if ((count _x) > 5) then {_orientation = _x select 5};
		if ((count _x) > 6) then {_varName = _x select 6};
		if ((count _x) > 7) then {_init = _x select 7};
		if ((count _x) > 8) then {_simulation = _x select 8};
		if ((count _x) > 9) then {_ATL = _x select 9};

		//Rotate the relative position using a rotation matrix
		private ["_rotMatrix", "_newRelPos", "_newPos"];
		_rotMatrix =
		[
			[cos _azi, sin _azi],
			[-(sin _azi), cos _azi]
		];
		_newRelPos = [_rotMatrix, _relPos] call _multiplyMatrixFunc;

		//Backwards compatability causes for height to be optional
		private ["_z"];
		if ((count _relPos) > 2) then {_z = _relPos select 2} else {_z = 0};

		_newPos = [_posX + (_newRelPos select 0), _posY + (_newRelPos select 1), _z];

		//Create the object and make sure it's in the correct location
		_newObj = _type createVehicle [-30,-30,0];
		_newObj setDir (_azi + _azimuth);
		if (_ATL) then {_newObj setPos _newPos;} else {_newObj setPosATL _newPos;};
		if (!isNil "_orientation") then
		{
			if ((count _orientation) > 0) then
			{
				([_newObj] + _orientation) call BIS_fnc_setPitchBank;
			};
		};
		//EDITS HERE - Make sure objects are placed down level to the ground
		_surfaceNormal = surfaceNormal position _newObj;
		_newObj setVectorUp _surfaceNormal;
		//If fuel and damage were grabbed, map them
		if (!isNil "_fuel") then {_newObj setFuel _fuel;};
		if(!isNil "_damage") then {_newObj setDamage _damage;};
		if (!isNil "_varName") then {
			if (_varName != "") then
			{
				[[_newObj,_varName],"setVehicleVarNameGlobal",true,false] call BIS_fnc_MP;
			};
		};
		//if (!isNil "_init") then {_newObj call (compile ("this = _this; " + _init));}; //TODO: remove defining this hotfix?
		if (!isNil "_init") then {_newObj call _init;}; //TODO: remove defining this hotfix?
		if (!isNil "_simulation") then {_newObj enableSimulationGlobal _simulation};

		{
			_x addCuratorEditableObjects [[_newObj],false];
		} forEach allCurators;
		_newObjs pushBack _newObj;
		//_newObjs = _newObjs + [_newObj];
	};
} forEach _objs;

_newObjs;