//by tankbuster
 #include "..\includes.sqf"
_myscript = "makediary";
__tky_starts;
player createDiarySubject ["auththemission", "Authority: The Mission"];// subject mission stuff
player createDiaryRecord ["auththemission", ["The Mission", "Your team has been put ashore with limited assets. You are to take targets from the enemy as directed. <br /> There are civilans here. This is their home, respect them and it. <br />You can expect to encounter enemies all over the island, not just in the area of operations. Engage and prosecute them."]];
//
player createDiarySubject ["yourstuff", "Your vehicles & bases"];// subject your stuff

player createDiaryRecord ["yourstuff", ["Island hopping", "If you take most or all of the targets on the island you are on, the mission might assign you a target that is on a different island. If it does, you will be given a vehicle transport Blackfish.<br /> It will be airdropped at the Airhead as a container and will need to be assembled by an engineer.<br />Vehicles that are too heavy to airlift can be moved to a FOB helipad using special capabilites in the FOB dataterminal."]];
player createDiaryRecord ["yourstuff", ["Prizes", "Everytime you complete a primary mission, you are given a new vehicle.<br /> If it's an aircraft, it will be dropped at the Airhead packed into a container. An engineer must assemble it. <br />Other types of vehicle are airdropped onto the nearest friendly place. These will not be replaced if they are destroyed so take care of them."]];
player createDiaryRecord ["yourstuff", ["Deploying the FOB", "Drive the FOB vehicle into a wideopen & flat enough space and you can deploy the FOB. When it deploys, a small number of assets are made close by; another ammocache & a spawn point. <br />The player who deploys it has access to the Zeus interface & can make a few other assets such as static weapons, sandbags and another helipad which can service your vehicles and aircraft."]];
player createDiaryRecord ["yourstuff", ["The FOB Vehicle", "The FOB vehicle is an unarmed Hunter MRAP and is delivered by airdrop once you have taken the airbase. Like the Prowler, you can access the artillery system from the back seat if the engine is off. <br />If the FOB Vehicle is in a flat and open enough area, it can be deployed (from the backseat with engine off) into a small FOB. <br />It will be replaced by airdrop if it is destroyed. "] ];
player createDiaryRecord ["yourstuff", ["The Forward Vehicle","The Forward vehicle is a Prower LSV, It is light, fast and armed with .50 machine gun. It has a small inventory of useful gear, mostly magazines and rockets.<br /> If you're in the backseat and the engine is off, you can access the artillery system. <br />If it's destroyed, a replacement will be airdropped to you. It's a spawnpoint."]];
player createDiaryRecord ["yourstuff", ["The Airhead", "Once you've taken it, the airfield will become your main base, known as The Airhead. <br />A large container will be dropped here that will unpack itself into the Airhead assets. It will have an ammobox, a spawnpoint, a jail, and a helipad where you can service your aircraft. <br /> The FOB vehicle will be airdrop delivered here too. "]];
player createDiaryRecord ["yourstuff", ["The Beachhead","The beachhead has an ammocache, some quads and a Prowler, known as the Forward Vehicle. <br /> From here, you will assault and secure the nearby airfield, then the Airhead will replace the Beachhead as your main base.<br />You can respawn at the beachhead."]];
//
player createDiarySubject ["enemystuff", "The Enemy"];// subject enemy stuff
player createDiaryRecord ["enemystuff", ["The dispersed enemy", "There are small enemy forces all over the island and they will attack you at every opportunity so be aware that you may be flanked or attacked from the rear at any time. They have access to air as well as land assets and actively patrol the entire island."]];
player createDiaryRecord ["enemystuff", ["Towns and bases", "After the airbase falls to BLUFOR, your team will be ordered to clear nearby towns and bases. As with the airbase, there will be an HQ that controls the enemy air patrol assets and a radar that controls the enemy air reinforcements. At the edge of the target, there are some roadblocks. Destroying them will stop the enemy reinforcing by road.<br />There are civilians in the towns. Avoid killing them or damaging their vehicles and buildings at all cost."]];
player createDiaryRecord ["enemystuff", ["Airfield", "The first enemy target you will attack is always the airfield. It's heavily defended and will be reinforced throughout. <br />There's an HQ building, usually hidden under a camo net, that controls the enemy air patrols and attack aircraft.<br /> On a hill nearby you should see a radar installation, destroying that will stop the enemy reinforcing by air."]];
//
player createDiarySubject ["authcomm","Development"];//subject author, development and discussion stuff
player createDiaryRecord ["authcomm", ["Code repository", "https://app.assembla.com/spaces/coop40-authority-altis/subversion/source"]];
player createDiaryRecord ["authcomm", ["Bug and feature tracker", "https://www.hostedredmine.com/projects/operation-authority"]];
player createDiaryRecord ["authcomm", ["Bohemia Interactive Forum", "https://forums.bistudio.com/forums/topic/194184-authority-20-player-coop/"]];
//
player createDiarySubject ["dialog", "Mission Status"];
player createDiaryRecord ["dialog", ["Mission Status", "<execute expression='[] spawn tky_fnc_showmissiondialog;'>Mission Status Dialog</execute>"] ];
__tky_ends