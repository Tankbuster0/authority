//by tankbuster
params ["_unit", "_dummy", "_damage", "_shooter", "_ammo" ];
// system to save units loadout just before he is incapacitated so it can be given back to him after revive
// called by handledamage eh on player

if ((_damage > 0.9) and (time > (_unit getVariable "last_inventory_saved"))) then
	{
		_data1 = [player, [profileNamespace, "reviveloadout"]] call bis_fnc_saveInventory;
		_unit setVariable ["last_inventory_saved", time +2];
		diag_log _data1;
		diag_log "*** loadout saved to profile by fn_hd ";
	};


