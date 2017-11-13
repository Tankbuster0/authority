 #include "..\includes.sqf"
 #include "\a3\functions_f_mp_mark\Revive\defines.hpp"
_myscript = "playersetup.sqf";
__tky_starts;
// replace all of the many respawn ehs with a single one that calls this file

if ("PARAM_Fatigue" call BIS_fnc_getParamValue == 0) then
	{
		player enableStamina false;
	};

if !("PARAM_AimSway" call BIS_fnc_getParamValue == 100) then
	{
		private _coef = ("PARAM_AimSway" call BIS_fnc_getParamValue) / 10;
		player setCustomAimCoef _coef;
		player setUnitRecoilCoefficient 0.2 + _coef;
	};

[SupportReq, ArtySupport] call BIS_fnc_removeSupportLink;
BIS_supp_refresh = TRUE;
//systemChat "Respawning";
//systemChat format[ "state %1", GET_STATE_STR(GET_STATE( player )) ];

if ( GET_STATE( player ) == STATE_RESPAWNED ) then {
	//systemChat "Died or Respawned via menu";
	_templates = [];
	{
		{
			_nul = _templates pushBackUnique _x;
		}forEach ( getMissionConfigValue [ _x, [] ] );
	}forEach [ "respawntemplates", format[ "respawntemplates%1", str playerSide ] ];

	if ( { "menuInventory" == _x }count _templates > 0 ) then {
		//systemChat "Respawning - saving menu inventory";
		[ player, [ profileNamespace, "currentInventory" ] ] call BIS_fnc_saveInventory;
	}else
	{
		h = [] spawn
		{
			sleep playerRespawnTime;
			//systemChat "Respawning - loading last saved";
			[ player, [ profileNamespace, "currentInventory" ] ] call BIS_fnc_loadInventory;
			fobdeployactionid = player addaction ["Deploy/ Undeploy FOB", "remoteexec ['tky_fnc_fobvehicledeploymanager',2]", "", 0,false,true, "", "( (typeof (vehicle player) isEqualTo fobvehicleclassname )  and ((assignedVehicleRole player) isEqualTo ['cargo'] ) and (not (isEngineOn (vehicle player))) ) "];
			vehiclespawnerid1 = player addaction ["Make Quadbike", "client\fn_spawnrunabout.sqf","",0,false,true, "","(player distance2D blubasedataterminal) < 2"];
			vehiclespawnerid2 = player addaction ["Make Quadbike", "client\fn_spawnrunabout.sqf","",0,false,true, "","(player distance2D fobdataterminal) < 2"];
			bfboxactionid = player addaction ["Assemble Aircraft", "client\assembleaircraft.sqf", "", 0, false,false, "", "(player distance2d bfbox) < 3"];
			prizeboxactionid = player addaction ["Assemble Aircraft", "client\assembleaircraft.sqf", "", 0, false,false, "", "(player distance2D prizebox) < 3"];
		};
	};

}else{
	//systemChat "Incapacitated";
};

sepa = ["<t color='#ffff33'>Put on ear plugs</t>",{
	if (soundVolume == 1) then {
		1 fadeSound 0.3;
		_u setUserActionText [_i,"<t color='#ffff33'>Take off ear plugs</t>"]
	} else {
		1 fadeSound 1;
		_u setUserActionText [_i,"<t color='#ffff33'>Put on ear plugs</t>"]
	}
},[],-90,false,true,"","_target == vehicle player"];
player addAction sepa;


__tky_ends;