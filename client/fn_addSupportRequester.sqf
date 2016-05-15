// Add requester to Support Module

diag_log format ["***Linking Arty"];
//hint format ["%1 is linked now with %2 and %3",_this,SupportReq, ArtySupport];
[_this, SupportReq, ArtySupport] call BIS_fnc_addSupportLink;
BIS_supp_refresh = TRUE;