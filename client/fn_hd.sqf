//by tankbuster
params ["_unit", "_dummy", "_damage", "_shooter", "_ammo" ];
// system to save units loadout just before he is incapacitated so it can be given back to him after revive
// called by handledamage eh on player
if not (isPlayer _unit) exitWith {diag_log format ["*** fn_hd quits because %1 isn't a player"]};
if ((_damage > 0.9) and (time > (_unit getVariable "last_inventory_saved"))) then
	{
		_data1 = [player, [profileNamespace, "reviveloadout"]] call bis_fnc_saveInventory;
		_unit setVariable ["last_inventory_saved", time +2];

	};


