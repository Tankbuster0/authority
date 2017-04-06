
if !( isServer ) exitWith {};

_ammoBox = _this;

//JIPID =  [ _ammoBox, east, east ] call LARs_fnc_blacklistArsenal;
JIPID =  [ _ammoBox, [ east ], west, "EAST", { true } ] call LARs_fnc_blacklistArsenal;
JIPID =  [ _ammoBox, [ west ], west, "WEST", { true } ] call LARs_fnc_blacklistArsenal;
JIPID =  [ _ammoBox, [ independent ], west, "INDEP", { true } ] call LARs_fnc_blacklistArsenal;
JIPID =  [ _ammoBox, [ civilian ], west, "CIV", { true } ] call LARs_fnc_blacklistArsenal;