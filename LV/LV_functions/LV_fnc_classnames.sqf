//Load classnames for all AISSP scripts. Updated 2016/8/9
/*
	0: filters (array) : classes from config_aissp.hpp ("ALL" includes all default presets)
	1: request (array)
		0: side = 
			1 = blufor
			2 = opfor
			3 = independent
			4 = civilian
		1: type =
			1 = Cars
			2 = Tanks
			3 = Helis
			4 = Planes
			5 = Ships
			6 = Men
			7 = Divers
*/
private ["_CIVtanks","_CIVdivers","_i","_filters","_request","_results","_BLU_CTRG_F_Cars","_BLU_CTRG_F_Helis","_BLU_CTRG_F_Men","_BLU_F_Cars","_BLU_F_Tanks","_BLU_F_Helis","_BLU_F_Planes","_BLU_F_Ships","_BLU_F_Men","_BLU_F_Men_SpecialForces","_BLU_F_Divers","_BLU_G_F_Cars","_BLU_G_F_Ships","_BLU_G_F_Men","_BLU_GEN_F_Cars","_BLU_GEN_F_Men","_BLU_T_F_Cars","_BLU_T_F_Tanks","_BLU_T_F_Helis","_BLU_T_F_Planes","_BLU_T_F_Ships","_BLU_T_F_Men","_BLU_T_F_Men_SpecialForces","_BLU_T_F_Divers","_IND_C_F_Cars","_IND_C_F_Helis","_IND_C_F_Planes","_IND_C_F_Ships","_IND_C_F_Men_Bandits","_IND_C_F_Men_Paramilitarity","_IND_F_Cars","_IND_F_Tanks","_IND_F_Helis","_IND_F_Planes","_IND_F_Ships","_IND_F_Men","_IND_F_Divers","_IND_G_F_Cars","_IND_G_F_Ships","_IND_G_F_Men","_OPF_F_Cars","_OPF_F_Tanks","_OPF_F_Helis","_OPF_F_Planes","_OPF_F_Ships","_OPF_F_Men","_OPF_F_Men_Urban","_OPF_F_Men_SpecialForces","_OPF_F_Men_Viper","_OPF_F_Divers","_OPF_G_F_Cars","_OPF_G_F_Ships","_OPF_G_F_Men","_OPF_T_F_Cars","_OPF_T_F_Tanks","_OPF_T_F_Planes","_OPF_T_F_Ships","_OPF_T_F_Men","_OPF_T_F_Men_SpecialForces","_OPF_T_F_Men_Viper","_OPF_T_F_Divers","_BLU_CTRG_Cars","_BLU_CTRG_Helis","_BLU_CTRG_Men","_BLU_NATO_Cars","_BLU_NATO_Tanks","_BLU_NATO_Helis","_BLU_NATO_Planes","_BLU_NATO_Ships","_BLU_NATO_Men","_BLU_NATO_Men_SpecialForces","_BLU_NATO_Divers","_BLU_FIA_Cars","_BLU_FIA_Ships","_BLU_FIA_Men","_BLU_GEN_Cars","_BLU_GEN_Men","_BLU_T_Cars","_BLU_T_Tanks","_BLU_T_Helis","_BLU_T_Planes","_BLU_T_Ships","_BLU_T_Men","_BLU_T_Men_SpecialForces","_BLU_T_Divers","_IND_SYN_Cars","_IND_SYN_Helis","_IND_SYN_Planes","_IND_SYN_Ships","_IND_SYN_Men_Bandits","_IND_SYN_Men_Paramilitarity","_IND_AAF_Cars","_IND_AAF_Tanks","_IND_AAF_Helis","_IND_AAF_Planes","_IND_AAF_Ships","_IND_AAF_Men","_IND_AAF_Divers","_IND_FIA_Cars","_IND_FIA_Ships","_IND_FIA_Men","_OPF_CSAT_Cars","_OPF_CSAT_Tanks","_OPF_CSAT_Helis","_OPF_CSAT_Planes","_OPF_CSAT_Ships","_OPF_CSAT_Men","_OPF_CSAT_Men_Urban","_OPF_CSAT_Men_SpecialForces","_OPF_CSAT_Men_Viper","_OPF_CSAT_Divers","_OPF_FIA_Cars","_OPF_FIA_Ships","_OPF_FIA_Men","_OPF_T_Cars","_OPF_T_Tanks","_OPF_T_Planes","_OPF_T_Ships","_OPF_T_Men","_OPF_T_Men_SpecialForces","_OPF_T_Men_Viper","_OPF_T_Divers","_BLUcars","_BLUhelis","_BLUmen","_BLUtanks","_BLUplanes","_BLUships","_BLUdivers","_INDcars","_INDhelis","_INDmen","_INDtanks","_INDplanes","_INDships","_INDdivers","_OPFcars","_OPFhelis","_OPFmen","_OPFtanks","_OPFplanes","_OPFships","_OPFdivers","_CIV_Cars","_CIV_Helis","_CIV_Planes","_CIV_Ships","_CIV_Men","_CIVcars","_CIVhelis","_CIVplanes","_CIVships","_CIVmen","_CIV_P_Cars","_CIV_P_Helis","_CIV_P_Planes","_CIV_P_Ships","_P_CIV_Men"];

_filters = param [0,["ALL"],[]];
_request = param [1,[],[]];
_results = [];

_side = _request param [0,0,[1,2,3]];
_type = _request param [1,0,[1,2,3,4,5,6,7]]; 

_BLUcars = [];
_BLUhelis = [];
_BLUmen = [];
_BLUtanks = [];
_BLUplanes = [];
_BLUships = [];
_BLUdivers = [];

_INDcars = [];
_INDhelis = [];
_INDmen = [];
_INDtanks = [];
_INDplanes = [];
_INDships = [];
_INDdivers = [];

_OPFcars = [];
_OPFhelis = [];
_OPFmen = [];
_OPFtanks = [];
_OPFplanes = [];
_OPFships = [];
_OPFdivers = [];

_CIVcars = [];
_CIVhelis = [];
_CIVplanes = [];
_CIVships = [];
_CIVmen = [];
_CIVdivers = [];
_CIVtanks = [];

_i = 0;
for "_i" from 0 to (count _filters - 1) do {
    if(_filters select _i == "ALL")then{
        _BLUcars set[count _BLUcars, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_F" >> "cars")];
        _BLUcars set[count _BLUcars, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_CTRG" >> "cars")];
        _BLUcars set[count _BLUcars, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_G_F" >> "cars")];
        _BLUcars set[count _BLUcars, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_GEN_F" >> "cars")];
        _BLUcars set[count _BLUcars, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_T_F" >> "cars")];

        _BLUtanks set[count _BLUtanks, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_F" >> "tanks")];
        _BLUtanks set[count _BLUtanks, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_T_F" >> "tanks")];

        _BLUhelis set[count _BLUhelis, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_F" >> "helicopters")];
        _BLUhelis set[count _BLUhelis, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_CTRG" >> "helicopters")];
        _BLUhelis set[count _BLUhelis, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_T_F" >> "helicopters")];

        _BLUplanes set[count _BLUplanes, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_F" >> "planes")];
        _BLUplanes set[count _BLUplanes, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_T_F" >> "planes")];

        _BLUships set[count _BLUships, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_F" >> "ships")];
        _BLUships set[count _BLUships, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_G_F" >> "ships")];
        _BLUships set[count _BLUships, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_T_F" >> "ships")];

        _BLUdivers set[count _BLUdivers, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_F" >> "divers")];
        _BLUdivers set[count _BLUdivers, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_T_F" >> "divers")];

        _BLUmen set[count _BLUmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_F" >> "men")];
        _BLUmen set[count _BLUmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_CTRG" >> "men")];
        _BLUmen set[count _BLUmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_G_F" >> "men")];
        _BLUmen set[count _BLUmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_GEN_F" >> "men")];
        _BLUmen set[count _BLUmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_T_F" >> "men")];
        _BLUmen set[count _BLUmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_F" >> "menSF")];
        _BLUmen set[count _BLUmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "BLU_T_F" >> "menSF")];

        _INDcars set[count _INDcars, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "IND_F" >> "cars")];
        _INDcars set[count _INDcars, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "IND_C_F" >> "cars")];
        _INDcars set[count _INDcars, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "IND_G_F" >> "cars")];

        _INDtanks set[count _INDtanks, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "IND_F" >> "tanks")];

        _INDhelis set[count _INDhelis, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "IND_F" >> "helicopters")];
        _INDhelis set[count _INDhelis, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "IND_C_F" >> "helicopters")];

        _INDplanes set[count _INDplanes, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "IND_F" >> "planes")];
        _INDplanes set[count _INDplanes, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "IND_C_F" >> "planes")];

        _INDships set[count _INDships, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "IND_F" >> "ships")];
        _INDships set[count _INDships, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "IND_C_F" >> "ships")];
        _INDships set[count _INDships, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "IND_G_F" >> "ships")];

        _INDmen set[count _INDmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "IND_F" >> "men")];
        _INDmen set[count _INDmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "IND_G_F" >> "men")];
        _INDmen set[count _INDmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "IND_C_F" >> "men2")];
        _INDmen set[count _INDmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "IND_C_F" >> "men3")];

        _INDdivers set[count _INDdivers, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "IND_F" >> "divers")];

        _OPFcars set[count _OPFcars, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "OPF_F" >> "cars")];
        _OPFcars set[count _OPFcars, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "OPF_G_F" >> "cars")];
        _OPFcars set[count _OPFcars, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "OPF_T_F" >> "cars")];

        _OPFtanks set[count _OPFtanks, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "OPF_F" >> "tanks")];
        _OPFtanks set[count _OPFtanks, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "OPF_T_F" >> "tanks")];

        _OPFhelis set[count _OPFhelis, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "OPF_F" >> "helicopters")];

        _OPFplanes set[count _OPFplanes, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "OPF_F" >> "planes")];
        _OPFplanes set[count _OPFplanes, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "OPF_T_F" >> "planes")];

        _OPFships set[count _OPFships, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "OPF_F" >> "ships")];
        _OPFships set[count _OPFships, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "OPF_G_F" >> "ships")];
        _OPFships set[count _OPFships, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "OPF_T_F" >> "ships")];

        _OPFmen set[count _OPFmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "OPF_F" >> "men")];
        _OPFmen set[count _OPFmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "OPF_G_F" >> "men")];
        _OPFmen set[count _OPFmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "OPF_T_F" >> "men")];
        _OPFmen set[count _OPFmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "OPF_F" >> "men2")];
        _OPFmen set[count _OPFmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "OPF_F" >> "men3")];
        _OPFmen set[count _OPFmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "OPF_F" >> "menSF")];
        _OPFmen set[count _OPFmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "OPF_T_F" >> "men2")];
        _OPFmen set[count _OPFmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "OPF_T_F" >> "menSF")];

        _OPFdivers set[count _OPFdivers, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "OPF_F" >> "divers")];
        _OPFdivers set[count _OPFdivers, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "OPF_T_F" >> "divers")];

        _CIVcars set [count _CIVcars, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "CIV" >> "cars")];
        _CIVhelis set [count _CIVhelis, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "CIV" >> "helicopters")];
        _CIVplanes set [count _CIVplanes, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "CIV" >> "planes")];
        _CIVships set [count _CIVships, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "CIV" >> "ships")];
        _CIVmen set [count _CIVmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> "CIV" >> "men")];
    }else{
        switch(getNumber (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "side"))do{
            case 0:{
                _CIVdivers set [count _CIVdivers, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "divers")];
                _CIVcars set [count _CIVcars, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "cars")];
                _CIVtanks set [count _CIVcars, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "tanks")];
                _CIVhelis set [count _CIVhelis, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "helicopters")];
                _CIVplanes set [count _CIVplanes, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "planes")];
                _CIVships set [count _CIVships, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "ships")];
                _CIVmen set [count _CIVmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "men")];
                _CIVmen set [count _CIVmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "men2")];
                _CIVmen set [count _CIVmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "men3")];
                _CIVmen set [count _CIVmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "menSF")];
            };
            case 1:{
                _BLUdivers set [count _BLUdivers, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "divers")];
                _BLUcars set [count _BLUcars, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "cars")];
                _BLUtanks set [count _BLUcars, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "tanks")];
                _BLUhelis set [count _BLUhelis, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "helicopters")];
                _BLUplanes set [count _BLUplanes, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "planes")];
                _BLUships set [count _BLUships, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "ships")];
                _BLUmen set [count _BLUmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "men")];
                _BLUmen set [count _BLUmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "men2")];
                _BLUmen set [count _BLUmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "men3")];
                _BLUmen set [count _BLUmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "menSF")];
            };
            case 2:{
                _OPFdivers set [count _OPFdivers, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "divers")];
                _OPFcars set [count _OPFcars, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "cars")];
                _OPFtanks set [count _OPFcars, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "tanks")];
                _OPFhelis set [count _OPFhelis, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "helicopters")];
                _OPFplanes set [count _OPFplanes, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "planes")];
                _OPFships set [count _OPFships, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "ships")];
                _OPFmen set [count _OPFmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "men")];
                _OPFmen set [count _OPFmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "men2")];
                _OPFmen set [count _OPFmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "men3")];
                _OPFmen set [count _OPFmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "menSF")];
            };
            case 3:{
                _INDdivers set [count _INDdivers, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "divers")];
                _INDcars set [count _INDcars, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "cars")];
                _INDtanks set [count _INDcars, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "tanks")];
                _INDhelis set [count _INDhelis, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "helicopters")];
                _INDplanes set [count _INDplanes, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "planes")];
                _INDships set [count _INDships, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "ships")];
                _INDmen set [count _INDmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "men")];
                _INDmen set [count _INDmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "men2")];
                _INDmen set [count _INDmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "men3")];
                _INDmen set [count _INDmen, getArray (getMissionConfig "aissp_configs" >> "config_aissp" >> "classPresets" >> (_filters select _i) >> "menSF")];
            };
        };
    };
};
			
switch(_side)do{
	case 1:{
		switch(_type)do{
			case 1:{
				_results = _BLUcars;
			};
			case 2:{
				_results = _BLUtanks;
			};
			case 3:{
				_results = _BLUhelis;
			};
			case 4:{
				_results = _BLUplanes;
			};
			case 5:{
				_results = _BLUships;
			};
			case 6:{
				_results = _BLUmen;
			};
			case 7:{
				_results = _BLUdivers;
			};
		};
	};
	case 2:{
		switch(_type)do{
			case 1:{
				_results = _OPFcars;
			};
			case 2:{
				_results = _OPFtanks;
			};
			case 3:{
				_results = _OPFhelis;
			};
			case 4:{
				_results = _OPFplanes;
			};
			case 5:{
				_results = _OPFships;
			};
			case 6:{
				_results = _OPFmen;
			};
			case 7:{
				_results = _OPFdivers;
			};
		};
	};
	case 3:{
		switch(_type)do{
			case 1:{
				_results = _INDcars;
			};
			case 2:{
				_results = _INDtanks;
			};
			case 3:{
				_results = _INDhelis;
			};
			case 4:{
				_results = _INDplanes;
			};
			case 5:{
				_results = _INDships;
			};
			case 6:{
				_results = _INDmen;
			};
			case 7:{
				_results = _INDdivers;
			};
		};
	};
	case 0:{
		switch(_type)do{
			case 1:{
				_results = _CIVcars;
			};
			case 2:{
				_results = _CIVtanks;
			};
			case 3:{
				_results = _CIVhelis;
			};
			case 4:{
				_results = _CIVplanes;
			};
			case 5:{
				_results = _CIVships;
			};
			case 6:{
				_results = _CIVmen;
			};
			case 7:{
				_results = _CIVdivers;
			};
		};
	};
};
_results