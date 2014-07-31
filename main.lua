display.setStatusBar( display.HiddenStatusBar )
system.activate("multitouch")
local storyboard = require "storyboard"
storyboard.purgeOnSceneChange = true
ads = require( "ads" )
provider = "admob"
local json = require("json")
local tran = require "tran"
local savemanage = require "savemanage"
local music = require ("music")
require("physics")
physics.start()
transition = tran
--physics.setDrawMode("hybrid")
local performance = require('performance')
performance:newPerformanceMeter()
io.output():setvbuf('no') -- disable output buffering for console in device!

local function exitOnBackKey(event)
	if event.phase == "down" and event.keyName == "back" then
		os.exit()
		return true
	end
end
Runtime:addEventListener("key", exitOnBackKey)

local isDevice
isDevice = system.getInfo( "platformName" )
	if isDevice == "Android" then
		appID = "ca-app-pub-3720841538563658/4409945328"
	elseif isDevice == "iPhone OS" then
		appID = "ca-app-pub-3720841538563658/7363411728"
	end


local function printStats()
	--print("GameSettings.gridGroup = "..tostring(GameSettings.gridGroup))
	--print("GameSettings.pressedMove = "..tostring(GameSettings.pressedMove))
	--print("GameSettings.locStart = "..tostring(GameSettings.locStart))
	--print("GameSettings.canJump = "..tostring(GameSettings.canJump))
	--print("GameSettings.armY = "..tostring(GameSettings.armY))
	--print("GameSettings.levcal = "..tostring(GameSettings.levcal))
	--print("GameSettings.shotCount = "..tostring(GameSettings.shotCount))
	--print("GameSettings.playerIsMoving = "..tostring(GameSettings.playerIsMoving))
	--print("GameSettings.wasMoving = "..tostring(GameSettings.wasMoving))
	--print("GameSettings.touchEnabled = "..tostring(GameSettings.touchEnabled))
	--print("GameSettings.spawnNum1 = "..tostring(GameSettings.spawnNum1))
	--print("GameSettings.willJump = "..tostring(GameSettings.willJump))
	--print("GameSettings.moveSpeed = "..tostring(GameSettings.moveSpeed))
	--print("GameSettings.isRunning = "..tostring(GameSettings.isRunning))
	--print("GameSettings.isWalking = "..tostring(GameSettings.isWalking))
	--print("GameSettings.movementNum1 = "..tostring(GameSettings.movementNum1))
	--print("GameSettings.clipSize = "..GameSettings.clipSize)
	--print("GameSettings.ammoSize = "..GameSettings.ammoSize)
	--print("GameSettings.jumpAmount1 = "..GameSettings.jumpAmount1)
	--print("GameSettings.jumpAmount2 = "..GameSettings.jumpAmount2)
	--print("GameSettings.holsterOption = "..tostring(GameSettings.holsterOption))
	--print("GameSettings.targetAcq = "..GameSettings.targetAcq)
	--print("GameSettings.bulletCount = "..GameSettings.bulletCount)
	--print("GameSettings.rndItem2 = "..GameSettings.rndItem2)
	--print("GameSettings.rocketLive = "..tostring(GameSettings.rocketLive))
end

		--Runtime:addEventListener("enterFrame", printStats)

display.setDefault( "minTextureFilter", "nearest" )
display.setDefault( "magTextureFilter", "nearest" )
system.setIdleTimer( false )
options =
{
    effect = "zoomInOutFade",
    time = 400,
	isModal = true,
}

GameSettings = {}
GameSettingsEnemies = {}
SavedGameOneSettings = {}
GameSettings.fontName = "Xolonium"
GameSettings.gameEnd = false
GameSettings.isPlaying = true
-----------------------------
GameSettings.isDebug = true
GameSettings.enemyDebug = false
-----------------------------
GameSettings.movementNum1 = 0
GameSettings.EnemInLevel1 = 0
GameSettings.EnemInLevel2 = 0
GameSettings.EnemInLevel3 = 0
GameSettings.EnemInLevel4 = 0
GameSettings.EnemInLevel5 = 0
GameSettings.EnemInLevel6 = 0
GameSettings.EnemInLevel7 = 0
GameSettings.EnemInLevel8 = 0
GameSettings.EnemInLevel9  = 0
GameSettings.EnemInLevel10 = 0
GameSettings.levelRnd1a = 0
GameSettings.levelRnd1b = 0
GameSettings.levelRnd1c = 0
GameSettings.EnemiesSpawnedLevel1 = 0
GameSettings.EnemiesSpawnedLevel2 = 0
GameSettings.EnemiesSpawnedLevel3 = 0
GameSettings.EnemiesSpawnedLevel4 = 0
GameSettings.EnemiesSpawnedLevel5 = 0
GameSettings.EnemiesSpawnedLevel6 = 0
GameSettings.EnemiesSpawnedLevel7 = 0
GameSettings.EnemiesSpawnedLevel8 = 0
GameSettings.hitPointTotal = 34
GameSettings.planetTr = 0
GameSettings.itemReady = 0
GameSettings.movementGrid = false
GameSettings.progCount = 0
GameSettings.jumpingYLoc = 0
GameSettings.moveSpeed = 0
GameSettings.shotAmt = 0
GameSettings.bulletCount = 0
GameSettings.jumpingNow = false
GameSettings.rocketLive = false
GameSettings.rndItem2 = 975
GameSettings.canJump = 0
GameSettings.reloadNow = false
GameSettings.isMoving = false
GameSettings.willJump = false
GameSettings.pressedMove = true
GameSettings.shotCount = 0
GameSettings.levelProgress = true
GameSettings.wantToQuitGame = false
GameSettings.wantToFinish = false
GameSettings.levelIsCleared = false
GameSettings.purchSuccess = false
GameSettings.SoundOn = true
GameSettings.MusicOn = true
GameSettings.HintsOn = true
GameSettings.Controls = false
GameSettings.isPaused = false
GameSettings.lockStatus = false
GameSettings.enemiesInLevel = 0
GameSettings.playerIsMoving = 0
GameSettings.VibeOn = true
GameSettings.rndItem1 = 0
GameSettings.targetAcq = 3
GameSettings.orientSetJoyX = 0
GameSettings.orientSetJoyY = 0
GameSettings.orientSetFireX = display.contentWidth/1.2
GameSettings.orientSetFireY = 0
GameSettings.orientSetHUDX = display.contentWidth/3.4
GameSettings.orientSetHUDY = 0
GameSettings.isRunning = false
GameSettings.isWalking = false
GameSettings.levcal = 0
GameSettings.sentryConf = 0
GameSettings.MoneyAmountChain = 0
GameSettings.ScoreAmntChain = 0
GameSettings.canAttackNum = 0
GameSettings.playerMoveAttack = 0
GameSettings.chargeInitiated = 0
GameSettings.playerIsRegAtt = 0
GameSettings.enemDefeatChain = 0
GameSettings.holsterOption = true
GameSettings.enemInLevel = 0
GameSettings.canTouch1 = true
GameSettings.optionHolder1 = true
GameSettings.SpeedChain = 0
GameSettings.PowerChain = 0
GameSettings.DefenseChain = 0
GameSettings.UnlimitedChain = 0
GameSettings.HyperChain = 0
GameSettings.spawnNum1 = 0
GameSettings.spawnNum2 = 200000
GameSettings.spawnNum3 = 300000
GameSettings.spawnNum4 = 400000
GameSettings.spawnNum5 = 500000
GameSettings.spawnNum6 = 600000
GameSettings.ispurchasing = 0
GameSettings.ammoSize = 0
GameSettings.clipSize = 0
GameSettings.clipSizeStnd = 0
GameSettings.BronzeMedal = 0
GameSettings.PlatMedal = 0
GameSettings.GoldMedal = 0
GameSettings.GoldenEagle = 0
GameSettings.levelAttained = 1
GameSettings.levelAttainedX = 1
GameSettings.levelAttainedY = 1
GameSettings.jumpAmount1 = -85
GameSettings.jumpAmount2 = 0
GameSettings.powerUp = false
GameSettings.gameCheck1 = 0
GameSettings.PowerUp = 0
GameSettings.firstPlayY = 0
GameSettings.secondPlayY = 0
GameSettings.EnemyDam1 = 1
GameSettings.destroyAllEnem = false
GameSettings.HUDLine = {
"",
"",
"",
"",
}
GameSettings.statLine= {
"S",
"A",
"D",
}
-- clip amount
GameSettings.machinegunDebugAmount = 30
GameSettings.rocketDebugAmount = 1
GameSettings.sniperDebugAmount = 5
GameSettings.shotgunDebugAmount = 7
GameSettings.empDebugAmount = 5
GameSettings.grenadelauncherDebugAmount = 3
GameSettings.grenadefireDebugAmount = 1

-- inventoried amount
if GameSettings.isDebug == true then
GameSettings.machinegunDebugTotal = 300
GameSettings.rocketDebugTotal = 55
GameSettings.sniperDebugTotal = 99
GameSettings.shotgunDebugTotal = 99
GameSettings.empDebugTotal = 99
GameSettings.grenadelauncherDebugTotal = 99
GameSettings.grenadefireDebugTotal = 99
else
GameSettings.machinegunDebugTotal = 30
GameSettings.rocketDebugTotal = 5
GameSettings.sniperDebugTotal = 6
GameSettings.shotgunDebugTotal = 10
GameSettings.empDebugTotal = 10
GameSettings.grenadelauncherDebugTotal = 8
GameSettings.grenadefireDebugTotal = 2
end

GameSettings.raptInc = 0
GameSettings.sentInc = 0
GameSettings.guardInc = 0
GameSettings.turrInc = 0
if GameSettings.enemyDebug == true then
GameSettings.enemInc5a = 0 -- threshold before enemy difficulty starts increasing
else
GameSettings.enemInc5a = 7
end
GameSettings.guardTableProg = {6,24,44,63,87,105}
GameSettings.sentryTableProg = {7,19,31,43,60,85}
GameSettings.raptorTableProg = {11,50,62,80,120,150}
GameSettings.turrTableProg = {8,18,30,60,70,200}

GameSettings.incAmount = {
0,
200,
1500,
7500,
13500,
30000,
65000,
100000,
215000,
500000,
}	

GameSettings.playerRank = {
"Trainee",
"Mole",
"Junior",
"Scout",
"Operator",
"Agent",
"Principal",
"Sleeper",
"Ghost",
"Legend"
}	

GameSettings.armLocTableX1 = {
0,0,0,0,1,-1, 	-- glock
-4,4,0,0,1,-1,  -- shotgun
-4,4,0,0,1,-1,  -- machinegun
-4,4,-1,1,1,-1, -- sniper
-4,4,-1,1,1,-1, -- grenadelauncher
-4,4,-1,1,1,-1, -- rocket
}
GameSettings.armLocTableY1 = {
10,10,2,2,7,7,      -- glock
6,6,0,0,1,1,        -- shotgun
6,6,2,2,2,2,        -- machinegun
6,6,3,3,7,7,        -- sniper
0,0,-2,-2,-5,-5,      -- grenadelauncher
-3,-3,-2,-2,-4,-4,  -- rocket
}
GameSettings.armLocTableYPF1 = {
12,12,-8,-8,6,6, -- glock
10,10,-6,-6,4,4, -- shotgun
12,12,-8,-8,2,2, -- machinegun
12,12,-8,-8,6,6, -- sniper
12,12,-8,-8,6,6, -- grenadelauncher
12,12,-8,-8,6,6, -- rocket
}
GameSettings.armLocTableXFF1 = {
12,12,-8,-8,6,6, -- glock
10,10,-6,-6,4,4, -- shotgun
12,12,-8,-8,2,2, -- machinegun
12,12,-8,-8,6,6, -- sniper
12,12,-8,-8,6,6, -- grenadelauncher
12,12,-8,-8,6,6, -- rocket
}
GameSettings.armLocTableXPF1 = {
22,22,20,20,26,26, -- glock
10,10,20,20,42,42, -- shotgun
14,14,20,20,26,26, -- machinegun
14,14,20,20,26,26, -- sniper
14,14,20,20,26,26, -- grenadelauncher
14,14,20,20,40,40, -- rocket
}
GameSettings.armLocTableYSH1 = {
18,18,-12,-12,6,6,    -- glock
14,14,-16,-16,4,4,    -- shotgun
24,24,-12,-12,4,4,    -- machinegun
24,24,-12,-12,4,4,    -- sniper
24,24,-12,-12,13,13,  -- grenadelauncher
24,24,-12,-12,11,11,  -- rocket
}

GameSettings.armX = GameSettings.armLocTableX1[1] -- x coord runtime for gunarm
GameSettings.armY = GameSettings.armLocTableY1[1] -- y coord runtime for gunarm
GameSettings.armYPF = GameSettings.armLocTableYPF1[1] -- y coord for shell casing
GameSettings.armXFF = GameSettings.armLocTableXFF1[1] -- x coord for shell casing
GameSettings.armXPF = GameSettings.armLocTableXPF1[1] -- x coord for projectile
GameSettings.armYSH = GameSettings.armLocTableYSH1[1] -- y coord for projectile

GameSettings.tileNum = {
	{1,},
    {2,},
    {3,},
    {4,},
    {5,},
    {6,},
    {7,},
    {8,},
    {9,},
    {10,},
    {11,},
    {12,},
    {13,},
    {14,},
    {15,},
    {16,},
    {17,},
    {18,},
    {19,},
    {20,},
    {21,},
    {22,},
    {23,},
    {24,},
    {25,},
    {26,},
    {27,},
    {28,},
    {29,},
    {30,},
    {31,},
    {32,},
    {33,},
    {34,},
    {35,},
    {36,},
    {37,},
    {38,},
    {39,},
    {40,},
    {41,},
    {42,},
    {43,},
    {44,},
    {45,},
    {46,},
    {47,},
    {48,},
    {49,},
    {50,},
    {51,},
    {52,},
    {53,},
    {54,},
    {55,},
    {56,},
    {57,},
    {58,},
    {59,},
    {60,},
    {61,},
    {62,},
    {63,},
    {64,},
    {65,},
    {66,},
    {67,},
    {68,},
    {69,},
    {70,},
    {71,},
    {72,},
    {73,},
    {74,},
    {75,},
    {76,},
    {77,},
    {78,},
    {79,},
    {80,},
    {81,},
    {82,},
    {83,},
    {84,},
    {85,},
    {86,},
    {87,},
    {88,},
    {89,},
    {90,},
    {91,},
    {92},
    {93,},
    {94,},
    {95,},
    {96,},
    {97,},
    {98,},
    {99,},
    {100,},
    {101,},
    {102,},
    {103,},
    {104,},
    {105,},
    {106,},
    {107,},
    {108,},
    {109,},
    {110,},
    {111,},
    {112,},
    {113,},
    {114,},
    {115,},
    {116,},
    {117,},
    {118,},
    {119,},
    {120,},
    {121,},
    {122,},
    {123,},
    {124,},
    {125,},
    {126,},
    {127,},
    {128,},
    {129,},
    {130,},
    {131,},
    {132,},
	}

GameSettings.itemName = {
"RIGHT",
"DOWN",
"EXIT WORLD",
"BOXES",
"MACHINE GUN AMMO",
"TOPHAT",
"MEDIKIT",
"WIFI SIGNAL",
"SIGHT MAP",
"POISON CURE",
"",
"",
"SLOW CURE",
"LIFE",
"",
"LEFT",
"UP",
"ENTER WORLD",
"MISSLE",
"GOLD",
"PLATINUM",
"COPPER", -- 22
"FULL SKULL",
"HALF SKULL",
"POISON SHOT",
"WRENCH",
"BACKPACK",
"SLOW SHOT",
"GREEN DOCUMENT",
"",
"CELLPHONE", 
"BULLETS",
"",
"",
"GOLD MEDAL",
"PLATINUM MEDAL",
"COPPER MEDAL", -- 37
"GASOLINE",
"CRANE",
"SAPPHIRE", -- 40
"EMERALD",
"RUBY",
"SHOTGUN SHELLS",
"MEDICINE", -- 44
"",
"GLOCK",
"REVOLVER",
"UZI",
"SHOTGUN",
"MACHINE GUN",
"ROCKET LAUNCHER",
"FLAMETHROWER",
"LASER GUN",
"MACHINE GUN",
"CHAIN GUN",
"LASER RIFLE",
"BOMB",
"BULLETS",
"SHOTGUN SHELLS",
"",
"TURN LEFT",
"TURN RIGHT",
"MUSHROOM CLOUD",
"POISON SYMBOL",
"CHAINSAW",
"",
"",
"BATTERY",
"",
"",
"TERMINAL",
"BLUE DISK",
"GREEN DISK",
"RED DISK",
"",
"",
"", 
"ROCKET LAUNCHER",
"",
"",
"OXYGEN MASK",
"NIGHTVISION",
"SCREW",
"MONEY", -- 84
"AXE SHOVEL",
"",
"",
"BLUE DOCUMENT",
"RED DOCUMENT",
"",
"BUTTON",
"BLANK DOCUMENT",
"BLANK DOCUMENT",
"BUTTON",
"TROLLFACE", 
"",
"SUPPLIES",
"LASER AMMO",
"LASER SIGHT",
"PLANE WING",
"",
"SOLAR WIND",
"SOLAR CLOUD",
"VEST",
"",
"PLANE DOWN",
"PLANE UP",
"SATELLITE DISH",
"LEVELS",
"",
"",
"GOLDEN EAGLE",
"ROCK",
"ROCK",
"ROCK",
"",
"",
"PLUS",
"VEST",
"",
"GRENADE LAUNCHER",
"GRENADE LAUNCHER",
"NUKE",
"COG",
"CIRCUIT BOARD",
"MALEW ORKER",
"FEMALE WORKER",
"TRUCKER",
"SUIT",
"SOLDIER",
"SPY WOMAN",
"ZOMBIE",
"SUIT",
"SUIT",
"",
"SOLDIER",
"ALIEN",
"EXPLOSIONA NIM",
"GUNSHOT",
"LASER SHOT",
"FLAME SHOT",
"",
"",
"",
"",
"",
"",
"",
"",
"MALE ASTRONAUT",
"ALIEN",
"ALIEN",
"ZOMBIE",
"FEMALE ASTRONAUT",
"MALE SCIENTIST",
"FEMALE SCIENTIST",
"LABCOAT",
"SPACESUIT",
"FATIGUES",
"BUSINESS SUIT",
"WOODEN BARREL",
"LASER AMMO",
"GRENADE",
"",
"MULTISUIT",
"RED KEYCARD",
"BLUE KEYCARD",
"GREEN KEYCARD",
"COMBAT KNIFE",
"ROCKET FUEL",
"NUKE EXPLOSION",
"",
"",
"",
"BELL",
"BOMB",
"SUITCASE",
"DSLR",
"",
"DOORKEY",
"LOCK",
"CITY MAP",
"SERVER",
"LEDGER",
"BLANK",
"WALL CIRCUIT",
"HANDLER",
"FIST",
"FLICKER",
}

GameSettings.randDropSlots = {
"MEDIKIT",
"LIFE",
"GOLD",
"PLATINUM",
"COPPER",
"GOLD MEDAL",
"PLATINUM MEDAL",
"BRONZE MEDAL",
"SAPPHIRE",--"SAPPHIRE",
"EMERALD",--"EMERALD",
"RUBY",--"RUBY",
"MONEY",
}

GameSettings.randDropSlots1 = {
"medikit",
"life",
"gold",
"platinum",
"copper",
"goldmedal",
"platinummedal",
"bronzemedal",
"sapphire",--"sapphire",
"emerald",--"emerald",
"ruby",--"ruby",
"money",
}

GameSettings.randDropSlots2 = {
2,
1,
5,
7,
3,
10,
15,
6,
16,--"sapphire",
17,--"emerald",
18,--"ruby",
20,
}

GameSettings.spriteEnemName = {
"medikit",
"poisoncure",
"slowcure",
"life",
"gold",
"platinum",
"copper",
"poisonshot",
"slowshot",
"greendoc",
"goldmedal",
"platinummedal",
"bronzemedal",
"medicine",
"poisonsymbol",
"bluedisk",
"greendisk",
"reddisk",
"oxygenmask",
"lasersight",
"overmap",
"nightvision",
"money",
"bluedoc",
"reddoc",
"vest1",
"goldeneagle",
"redkeycard",
"bluekeycard",
"greenkeycard",
"jetpack",
"cellphone",
"blankdoc1",
"blankdoc2",
"supplies",
}
GameSettings.spriteEnemTitle = {
"MEDIKIT",
"POISON CURE",
"SLOW CURE",
"LIFE",
"GOLD",
"PLATINUM",
"COPPER",
"POISON SHOT",
"SLOW SHOT",
"GREEN DOCUMENT",
"GOLD MEDAL",
"PLATINUM MEDAL",
"BRONZE MEDAL",
"MEDICINE",
"POISON SYMBOL",
"BLUE DISK",
"GREEN DISK",
"RED DISK",
"OXYGEN MASK",
"LASER SIGHT",
"WORLD MAP",
"NIGHTVISION GOGGLES",
"MONEY",
"BLUE DOCUMENT",
"RED DOCUMENT",
"KEVLAR VEST",
"GOLDEN EAGLE",
"RED KEYCARD",
"BLUE KEYCARD",
"GREEN KEYCARD",
"JETPACK",
"DETONATOR",
"BLANK DOCUMENT",
"BLANK DOCUMENT",
"SUPPLIES",
}

GameSettings.weaponList = { 
"glock",
"shotgun",
"machinegun",
"sniper",
"grenadelauncher",
"rocket",
"poisoncure", -- cure poison
"slowcure", -- cure slow
"overmap", -- skip level
"cellphone", -- destroy one enemy
"oxygenmask", -- protection from status'
"nightvision", -- increases level drop amount
"lasersight", -- extend flight of projectile
"vest1", -- protection for 5 seconds
"jetpack", -- jetpack
}

GameSettings.purchaseTableName = { 
"SHOTGUN" ,
"MACHINE GUN",
"SNIPER RIFLE",
"GRENADE LAUNCHER",
"ROCKET LAUNCHER",
"SHOTGUN SHELLS",
"SNIPER AMO",
"MACHINE GUN AMMO",
"GRENADES",
"MISSLE",
"POISON CURE", -- CURE POISON
"SLOW CURE", -- CURE SLOW
"LEVEL MAP", -- SKIP LEVEL
"DETONATOR", -- DESTROY ONE ENEMY
"OXYGEN MASK", -- PROTECTION FROM STATUS'
"NIGHTVISION GOOGLES", -- INCREASES LEVEL DROP AMOUNT
"LASERSIGHT", -- EXTEND FLIGHT OF PROJECTILE
"KEVLAR VEST", -- PROTECTION FOR 5 SECONDS
"JETPACK", -- JETPACK
"FINANCIAL UPTURN", -- +10000 in-game currency
"MARKSMAN ENHANCEMENT", -- UPGRADE WITH PERMANENT INCREASE IN SHOT DAMAGE
"BODY ARMOR", -- UPGRADE TO DECREASE AMOUNT OF DAMAGE TAKEN
"ARMORY", -- UPGRADE TO MAKE AMMO INFINITE
"FATIGUES", -- UPGRADE TO INCREASE DURATION OF POSITIVE ITEMS
"ACCESS CARD", -- REMOVE ADS
"CONTROL GAUGE", -- UPGRADE TO TOGGLE ENEMIES DIFFICULTY
}

GameSettings.purchaseTable = { 
"shotgun" ,
"machinegun",
"sniper",
"grenadelauncher",
"rocket",
"shotgunshells2",
"bullets1",
"ammobox",
"grenade1",
"missle",
"poisoncure", -- cure poison
"slowcure", -- cure slow
"overmap", -- skip level
"cellphone", -- destroy one enemy
"oxygenmask", -- protection from status'
"nightvision", -- increases level drop amount
"lasersight", -- increase projectile damage
"vest1", -- protection for 5 seconds
"jetpack", -- jetpack
"fullcase", -- +10000 in-game currency
"rocketfuel", -- upgrade with permanent increase in shot damage
"vest2", -- upgrade to decrease amount of damage taken
"boxes", -- upgrade to make ammo infinite
"fatigues", -- upgrade to increase duration of positive items
"vcard", -- remove ads
"levels1", -- upgrade to toggle enemies difficulty
}

GameSettings.purchaseTableDesc = {
"Shotgun weapon", -- "shotgun",
"Machine Gun weapon", --"machinegun",
"Sniper weapon", --"sniper",
"Grenade Launcher weapon", --"grenadelauncher",
"Rocket Launcher weapon", -- "rocket",
------------
"ammo for the shotgun weapon", -- "shotgunshells2",
"ammo for the sniper weapon", -- "bullets1",
"ammo for the machiengun weapon", -- "ammobox",
"ammo for the grenade launcher weapon", -- "grenade1",
"ammo for the rocket launcher weapon", -- "missle",
------------
"Cures the poison status ailment", -- "poisoncure", -- cure poison
"Cures the slow status ailment", -- "slowcure", -- cure slow
"Teleport a bit higher up in the tower", -- "overmap", -- skip level
"Destroy all visible enemies", -- "cellphone", -- destroy one enemy
"Protects against all status ailments", -- "oxygenmask", -- protection from status'
"Increases amount of random items", -- "nightvision", -- increases level drop amount
"Increases damage amount of your weapons", -- "lasersight", -- extend flight of projectile
"Makes you impervious to harm", -- "vest1", -- protection for 5 seconds
"Fly around the level at will", -- "jetpack", -- jetpack
------------
"100,000 creds to use as you see fit", -- "fullcase", -- +10000 in-game currency
"Double damage to all weapons", -- "rocketfuel", -- upgrade with permanent increase in shot damage
"Decrease amount of damage taken by half", -- "vest2", -- upgrade to decrease amount of damage taken
"Stockpile for infinite ammo", -- "boxes", -- upgrade to make ammo infinite
"Increase duration of positive items", -- "fatigues", -- upgrade to increase duration of positive items
"Remove all ads in game", -- "vcard", -- remove ads
"Complete control over all settings", --"levels1", -- upgrade to toggle enemies difficulty
}

GameSettings.purchaseTableType = {
"weapon", -- "shotgun",
"weapon", --"machinegun",
"weapon", --"sniper",
"weapon", --"grenadelauncher",
"weapon", -- "rocket",
"ammo", -- "shotgunshells2",
"ammo", -- "bullets1",
"ammo", -- "ammobox",
"ammo", -- "grenade1",
"ammo", -- "missle",
"inventory", -- "poisoncure", -- cure poison
"inventory", -- "slowcure", -- cure slow
"inventory", -- "overmap", -- skip level
"inventory", -- "cellphone", -- destroy one enemy
"inventory", -- "oxygenmask", -- protection from status'
"inventory", -- "nightvision", -- increases level drop amount
"inventory", -- "lasersight", -- extend flight of projectile
"inventory", -- "vest1", -- protection for 5 seconds
"inventory", -- "jetpack", -- jetpack
"upgrade", -- "fullcase", -- upgrade with permanent increase in shot damage
"upgrade", -- "rocketfuel", -- upgrade with permanent increase in shot damage
"upgrade", -- "vest2", -- upgrade to decrease amount of damage taken
"upgrade", -- "boxes", -- upgrade to make ammo infinite
"upgrade", -- "fatigues", -- upgrade to increase duration of positive items
"upgrade", -- "vcard", -- remove ads
"upgrade", --"levels1", -- upgrade to toggle enemies difficulty
}

GameSettings.purchaseTablePrice = {
1000,--"Shotgun weapon", -- "shotgun",
3000,--"Machinegun weapon", --"machinegun",
4500,--"Sniper weapon", --"sniper",
7000,--"Grenade Launcher weapon", --"grenadelauncher",
10000,--"Rocket Launcher weapon", -- "rocket",
100,--"ammo for the shotgun weapon", -- "shotgunshells2",
200,--"ammo for the sniper weapon", -- "bullets1",
300,--"ammo for the machiengun weapon", -- "ammobox",
600,--"ammo for the grenade launcher weapon", -- "grenade1",
1000,--"ammo for the rocket launcher weapon", -- "missle",
700,--"Cures the poison status ailment", -- "poisoncure", -- cure poison
700,--"Cures the slow status ailment", -- "slowcure", -- cure slow
1000,--"Skip one level up in the tower", -- "overmap", -- skip level
4000,--"Destroy all visible enemies", -- "cellphone", -- destroy one enemy
1200,--"Protects against all status ailments", -- "oxygenmask", -- protection from status'
3000,--"Increases amount of random items", -- "nightvision", -- increases level drop amount
2200,--"Increases damage of a projectile", -- "lasersight", -- extend flight of projectile
2700,--"Makes you impervious to harm", -- "vest1", -- protection for 5 seconds
3000,--"Fly around the level at will", -- "jetpack", -- jetpack
"$.99",--"100,000 creds to use as you see fit", -- "fullcase", -- +10000 in-game currency
"$.99",--"Upgrade with permanent increase in shot damage", -- "rocketfuel", -- upgrade with permanent increase in shot damage
"$.99",--"Upgrade to decrease amount of damage taken", -- "vest2", -- upgrade to decrease amount of damage taken
"$.99",--"Upgrade to infinite ammunition", -- "boxes", -- upgrade to make ammo infinite
"$.99",--"Upgrade to increase duration of positive items", -- "fatigues", -- upgrade to increase duration of positive items
"$.99",--"Remove all ads in game", -- "vcard", -- remove ads
"$1.99",--"Increase the difficulty of enemies", --"levels1", -- upgrade to toggle enemies difficulty
}

GameSettings.purchaseStingTable = {
--	"android.test.purchased",
--[["FINANCIAL UPTURN",]] "com.pancsoft.infiltrationfull.curruptenk1a", 
--[["MARKSMAN ENHANCEMENT", ]] "com.pancsoft.infiltrationfull.projdaminc1a",
--[["BODY ARMOR", ]]  "com.pancsoft.infiltrationfull.enemdamdec1a",
--[["ARMORY", ]]  "com.pancsoft.infiltrationfull.ammoinfin1a",
--[["FATIGUES", ]]  "com.pancsoft.infiltrationfull.extstataff1a",
--[["ACCESS CARD", ]]  "com.pancsoft.infiltrationfull.remads1a",
--[["CONTROL GAUGE", ]]  "com.pancsoft.infiltrationfull.fullcontr1a",
}

GameSettings.iapCompTable = {
"levels1", -- upgrade to toggle enemies difficulty
"vcard", -- remove ads
"fatigues", -- upgrade to increase duration of positive items
"boxes", -- upgrade to make ammo infinite
"vest2", -- upgrade to decrease amount of damage taken
"rocketfuel", -- upgrade with permanent increase in shot damage
}

GameSettings.ammoConf = {
GameSettings.glockDebugTotal,
GameSettings.shotgunDebugTotal,
GameSettings.machinegunDebugTotal,
GameSettings.sniperDebugTotal,
GameSettings.grenadelauncherDebugTotal,
GameSettings.rocketDebugTotal,
GameSettings.empDebugTotal,
}

GameSettings.clipConf = {
GameSettings.glockDebugAmount,
GameSettings.shotgunDebugAmount,
GameSettings.machinegunDebugAmount,
GameSettings.sniperDebugAmount,
GameSettings.grenadelauncherDebugAmount,
GameSettings.rocketDebugAmount,
GameSettings.empDebugAmount,
}

GameSettings.spriteName = {
"",--"right",
"",--"down",
"",--"exitworld",
"boxes",
"ammobox", -- 5
"tophat",
"medikit",
"wifisignal",
"sightmap",
"poisoncure",
"",
"",
"slowcure",
"life",
"",
"",--"left",
"",--"up",
"enterworld",
"missle", -- 19
"gold",
"platinum",
"copper",
"",--"skullfull",
"",--"skullhalf",
"poisonshot",
"wrench",
"backpack",
"slowshot",
"greendoc",
"",
"cellphone",
"bullets1",
"",
"",
"goldmedal",
"platinummedal",
"bronzemedal",
"gasoline",
"",--"crane1",
"sapphire",--"sapphire",
"emerald",--"emerald",
"ruby",--"ruby",
"shotgunshells1",
"medicine",
"",
"glock",
"revolver",
"uzi",
"shotgun",
"machinegun",
"rocketlauncher1",
"flamethrower",
"lasergun",
"machinegun2",
"chaingun",
"emp",
"bomb1",
"bullets2",
"shotgunshells2",
"",
"",--"turnleft",
"",--"turnright",
"",
"poisonsymbol",
"chainsaw",
"",
"",
"battery",
"",
"",
"terminal",
"bluedisk",
"greendisk",
"reddisk",
"",
"",
"",
"rocketlauncher2",
"",
"",
"oxygenmask",
"nightvision",
"screw",
"money",
"axeshovel",
"",
"",
"bluedoc",
"reddoc",
"",
"button1",
"blankdoc1",
"blankdoc2",
"button2",
"",--"trollface", 
"",
"supplies",
"laserammo1",
"lasersight",
"",--"planewing",
"",
"solarwind",
"solarcloud",
"vest1",
"",
"planedown",
"planeup",
"satellitedish",
"levels1",
"",
"",
"goldeneagle",
"",--"rock1",
"",--"rock2",
"",--"rock3",
"",
"",
"",--"plus",
"vest2",
"",
"grenadelauncher1",
"grenadelauncher2",
"nuke",
"cog",
"circuitboard",
"maleworker",
"femaleworker",
"trucker",
"suit3",
"soldier1",
"spywoman",
"zombie2",
"suit1",
"suit2",
"",
"soldier2",
"alien1",
"explosionanim",
"gunshot",
"lasershot",
"flameshot",
"",
"",
"",
"",
"",
"",
"",
"",
"maleastronaut",
"alien2",
"alien3",
"zombie1",
"femaleastronaut",
"malescientist",
"femalescientist",
"labcoat",
"spacesuit",
"fatigues",
"businesssuit",
"woodenbarrel",
"laserammo2",
"grenade1",
"",
"multisuit",
"redkeycard",
"bluekeycard",
"greenkeycard",
"combatknife",
"rocketfuel",
"nukeexplosion",
"",
"",
"",
"bell",
"bomb",
"suitcase",
"dslr",
"",
"doorkey",
"lock",
"citymap",
"server",
"ledger",
"blank",
"wallcircuit",
"handler",
"fist",
"flicker",
"",
"",
"overmap",
"",
"",
"",
"jetpack",
}
-----------------------------
		savemanage.oneFileCheck()
		savemanage.gameFileCheck()


storyboard.gotoScene("startscreen", options)
--storyboard.gotoScene("firstlevel", options)

