//fn_getvehiclecolour by PierreMGI and Tankbuster
//
 #include "..\includes.sqf"
__tky_starts
params ["_obj"];
_textsources = "true" configClasses (configfile >> "CfgVehicles" >> typeOf _obj >> "TextureSources");
_color ="";
{
   if (((getArray (configfile >> "CfgVehicles" >> typeOf _obj >> "TextureSources" >> _x >> "textures") apply {tolower _x splitString "\"}) select 0) isEqualTo (((getObjectTextures _obj) apply {_x splitString "\"}) select 0)) exitWith {_color = _x}
} forEach (_textSources apply {configName _x});
_color