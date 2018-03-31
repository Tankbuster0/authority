//fn_client_texttiles
params [
	["_mytext", ""],
	["_where", -2],
	["_shift", objNull],
	["_ctrl", objNull],
	["_alt", objNull]
];

[parseText "<t font='PuristaBold' size='1.6'>text blahblah</t>", true, nil, 7, 0.7, 0] spawn BIS_fnc_textTiles;