--savemanage.lua
local json = require("json")
local music = require("music")
local SM = {}

SM.PlayCollInventGame = system.pathForFile(  "PlayCollInvent.json", system.DocumentsDirectory )
SM.PlayCollInventFile = io.open( SM.PlayCollInventGame )

		local function loadTablePlayCollInvent(filename)
    local path = system.pathForFile( "PlayCollInvent.json", system.DocumentsDirectory)
    local contents = ""
    local myTable = {}
    local file = io.open( path, "r" )
    if file then
                  local contents = file:read( "*a" )
         myTable = json.decode(contents);
         io.close( file )
         return myTable 
    end
    return nil
end

		local function loadTableOne(filename)
    local path = system.pathForFile( "SavedGameOneSettings.json", system.DocumentsDirectory)
    local contents = ""
    local myTable = {}
    local file = io.open( path, "r" )
    if file then
                  local contents = file:read( "*a" )
         myTable = json.decode(contents);
         io.close( file )
         return myTable 
    end
    return nil
end

		local function saveTableGame(t, filename)
    local path = system.pathForFile( "GameSettings.json", system.DocumentsDirectory)
    local file = io.open(path, "w")
    if file then
        local contents = json.encode(t)
        file:write( contents )
        io.close( file )
        return true
    else
        return false
    end
end

		local function saveTableOne(t, filename)
		--print("SAVING FIRST GAME")
    local path = system.pathForFile( "SavedGameOneSettings.json", system.DocumentsDirectory)
    local file = io.open(path, "w")
    if file then
        local contents = json.encode(t)
        file:write( contents )
        io.close( file )
        return true
    else
        return false
    end
end

		local function loadTableGame(filename)
    local path = system.pathForFile( "GameSettings.json", system.DocumentsDirectory)
    local contents = ""
    local myTable = {}
    local file = io.open( path, "r" )
    if file then
                  local contents = file:read( "*a" )
         myTable = json.decode(contents);
         io.close( file )
         return myTable 
    end
    return nil
end

		local function saveTablePlayCollInvent(t, filename)
    local path = system.pathForFile( "PlayCollInvent.json", system.DocumentsDirectory)
    local file = io.open(path, "w")
    if file then
        local contents = json.encode(t)
        file:write( contents )
        io.close( file )
        return true
    else
        return false
    end
end

local function chargePointIncrease()
checkSavedGameOneSettingsActive()
if SavedGameOneSettings.chargePoints <= 19 then
		SavedGameOneSettings.chargePoints = SavedGameOneSettings.chargePoints+1
elseif SavedGameOneSettings.chargePoints >= 20 then
		SavedGameOneSettings.chargePoints = SavedGameOneSettings.chargePoints
	end
end
	local function savePlayLoc()
		checkSavedGameOneSettingsActive()
		SavedGameOneSettings.isOnLevel = sceneIn
		saveActiveGame()
	end
	local function refillHitPoints()
	print("POINTS REFILL")
			SavedGameOneSettings.hitPoints = 10
			SavedGameOneSettings.Speed = 14
			SavedGameOneSettings.chargePoints = 0
			saveTableOne(SavedGameOneSettings, "SavedGameOneSettings.json")
	end

	local function createGameOne()
	print("NEW FILE CREATION ATTEMPTED")
	if SavedGameOneSettings.hasStarted == nil then
	print("NEW FILE ONE CREATE SUCCESS")
		SavedGameOneSettings.orientSet = "right"
		SavedGameOneSettings.isOnLevel = ""
		SavedGameOneSettings.levelAttained = 1
		SavedGameOneSettings.hasStarted = 0
		SavedGameOneSettings.moneyAmount = 0
		SavedGameOneSettings.Speed = 14
		SavedGameOneSettings.damageAmount = 1
		SavedGameOneSettings.hitPoints = 10
		SavedGameOneSettings.scoreAmount = 0
		SavedGameOneSettings.enemDefeated = 0
		SavedGameOneSettings.ScoreAmnted = 0
		SavedGameOneSettings.jumpLength = 200
		SavedGameOneSettings.hitCount = 0
		SavedGameOneSettings.statExtend = 1
		SavedGameOneSettings.statusIdent = 1
		SavedGameOneSettings.iapPurch = 0
		SavedGameOneSettings.countShot = {
		1,		
		0,		
		0,		
		0,		
		0,		
		0,		
		}
		SavedGameOneSettings.ammoInfinite = false
		SavedGameOneSettings.showAllControls = false		
		SavedGameOneSettings.showAds = true
		SavedGameOneSettings.SoundOn = true
		SavedGameOneSettings.MusicOn = true
		SavedGameOneSettings.VibeOn = true
		SavedGameOneSettings.glockShot = 1
		SavedGameOneSettings.shotgunShot = 0
		SavedGameOneSettings.machinegunShot = 0
		SavedGameOneSettings.sniperShot = 0
		SavedGameOneSettings.grenadelauncherShot = 0
		SavedGameOneSettings.rocketShot = 0
		SavedGameOneSettings.mainWeapon = "glock"
		SavedGameOneSettings.glockClipSz = 8
		SavedGameOneSettings.glockAmmo = 89451234567489746515235687
		SavedGameOneSettings.machinegunAmmo = GameSettings.machinegunDebugTotal
		SavedGameOneSettings.machinegunClipSz = GameSettings.machinegunDebugAmount
		SavedGameOneSettings.rocketAmmo = GameSettings.rocketDebugTotal
		SavedGameOneSettings.rocketClipSz = GameSettings.rocketDebugAmount
		SavedGameOneSettings.sniperAmmo = GameSettings.sniperDebugTotal
		SavedGameOneSettings.sniperClipSz = GameSettings.sniperDebugAmount
		SavedGameOneSettings.shotgunAmmo = GameSettings.shotgunDebugTotal
		SavedGameOneSettings.shotgunClipSz = GameSettings.shotgunDebugAmount
		SavedGameOneSettings.empAmmo = GameSettings.empDebugTotal
		SavedGameOneSettings.empClipSz = GameSettings.empDebugAmount
		SavedGameOneSettings.grenadelauncherAmmo = GameSettings.grenadelauncherDebugTotal
		SavedGameOneSettings.grenadelauncherClipSz = GameSettings.grenadelauncherDebugAmount
		SavedGameOneSettings.grenadefireAmmo = GameSettings.grenadefireDebugTotal
		SavedGameOneSettings.grenadefireClipSz = GameSettings.grenadefireDebugAmount
		if GameSettings.isDebug then
		-- inventoried amount
		SavedGameOneSettings.ammoListing = {
		SavedGameOneSettings.glockAmmo,
		SavedGameOneSettings.shotgunAmmo,
		SavedGameOneSettings.machinegunAmmo,
		SavedGameOneSettings.sniperAmmo,
		SavedGameOneSettings.grenadelauncherAmmo,
		SavedGameOneSettings.rocketAmmo,
		}
		-- clip amount
		SavedGameOneSettings.clipListing = {
		SavedGameOneSettings.glockClipSz,
		SavedGameOneSettings.shotgunClipSz,
		SavedGameOneSettings.machinegunClipSz,
		SavedGameOneSettings.sniperClipSz,
		SavedGameOneSettings.grenadelauncherClipSz,
		SavedGameOneSettings.rocketClipSz,
		}
		SavedGameOneSettings.itemInventContents = {
		"glock",
		"shotgun",
		"machinegun",
		"sniper",
		"grenadelauncher",
		"rocket",
		}
		else
		-- inventoried amount
		SavedGameOneSettings.ammoListing = {
		SavedGameOneSettings.glockAmmo,
		}
		-- clip amount
		SavedGameOneSettings.clipListing = {
		SavedGameOneSettings.glockClipSz,
		}
		SavedGameOneSettings.itemInventContents = {
		"glock",
		}
		end
	end
end

	function SM.incIAPcount()
		SavedGameOneSettings.iapPurch = SavedGameOneSettings.iapPurch+1
		saveTableOne(SavedGameOneSettings, "SavedGameOneSettings.json")
	end

	function SM.iap10KPurch()
		print(" ++++++++ PURCHASING THE 10K IN-GAME CURRENCY! +++++++++ ")
		SavedGameOneSettings.moneyAmount = SavedGameOneSettings.moneyAmount+100000
		saveTableOne(SavedGameOneSettings, "SavedGameOneSettings.json")
	end
	
	function SM.markenhan()
		print(" ++++++++ PURCHASING THE MARKSMAN ENHANCEMENT! +++++++++ ")
		SavedGameOneSettings.damageAmount = SavedGameOneSettings.damageAmount+2
		SM.incIAPcount()
	end
	
	function SM.bodyarm()
		print(" ++++++++ PURCHASING THE BODY ARMOR! +++++++++ ")
		SavedGameOneSettings.hitCount = SavedGameOneSettings.hitCount+.5
		SM.incIAPcount()
	end
	
	function SM.armory()
		print(" ++++++++ PURCHASING INFINITE AMMO! +++++++++ ")
		SavedGameOneSettings.ammoInfinite = true
		SM.incIAPcount()
	end
	
	function SM.fatigues()
		print(" ++++++++ PURCHASING EXTEND STATUS'! +++++++++ ")
		SavedGameOneSettings.statExtend = SavedGameOneSettings.statExtend+1
		SM.incIAPcount()
	end
	
	function SM.showads()
		print(" ++++++++ PURCHASING SHOW ADS'! +++++++++ ")
		SavedGameOneSettings.showAds = false
		ads.hide()
		SM.incIAPcount()
	end
	
	function SM.fullcontrol()
		print(" ++++++++ PURCHASING FULL CONTROL'! +++++++++ ")
		SavedGameOneSettings.showAllControls = true
		SM.incIAPcount()
	end
	
	local function clearStatusOptions()
		GameSettings.levelIsCleared = false
		GameSettings.isPaused = false
		GameSettings.lockStatus = false
		GameSettings.playerHasDied = false
		GameSettings.enemiesInLevel = 0
		GameSettings.playerIsMoving = 0
		GameSettings.ChargeChain = 0
		GameSettings.enemDefeatChain = 0
		GameSettings.enemInLevel = 0
		GameSettings.quitGameNow = false
		GameSettings.MoneyAmountChain = 0
		GameSettings.ScoreAmntChain = 0
		GameSettings.currLevNum = 0
		saveTableGame(GameSettings, "GameSettings.json")
	end
	
local function oneFileClear()	
SM.pathOne = system.pathForFile(  "SavedGameOneSettings.json", system.DocumentsDirectory )
SM.oneFile = io.open( SM.pathOne )
	createGameOne()
	saveTableOne(SavedGameOneSettings, "SavedGameOneSettings.json")
	SM.oneFile.close(SM.oneFile)
	print( "File SavedGameOneSettings didn't exist, but now IT DOES!" )
end

local function oneFileCheck()	
SM.pathOne = system.pathForFile(  "SavedGameOneSettings.json", system.DocumentsDirectory )
SM.oneFile = io.open( SM.pathOne )
	if SM.oneFile then
		print( "File SavedGameOneSettings exists" )
		SM.oneFile.close(SM.oneFile)
	else
		createGameOne()
		saveTableOne(SavedGameOneSettings, "SavedGameOneSettings.json")
		print( "File SavedGameOneSettings didn't exist, but now IT DOES!" )
	end
end

local function gameFileCheck()
SM.pathGame = system.pathForFile(  "GameSettings.json", system.DocumentsDirectory )
SM.gameFile = io.open( SM.pathGame )
	if SM.gameFile then
		print( "File exists" )
		SM.gameFile.close(SM.gameFile)
	else
		saveTableGame(GameSettings, "GameSettings.json")
		print( "File didn't exist, but now IT DOES!" )
	end
end

local function playCollFileCheck()
	if SM.PlayCollInventFile then
		print( "File exists" )
		SM.PlayCollInventFile.close(SM.PlayCollInventFile)
	else
		saveTablePlayCollInvent(PlayCollInvent, "PlayCollInvent.json")
		print( "File didn't exist, but now IT DOES!" )
	end
end

function SM.callAdsNow()
-- Create a text object to display ad status

local showAd

-- Set up ad listener.
local function adListener( event )
	-- event table includes:
	-- 		event.provider
	--		event.isError (e.g. true/false )
	
	local msg = event.response

	-- just a quick debug message to check what response we got from the library
	print("Message received from the ads library: ", msg)

	if event.isError then

	showAd( "banner" )
	--showAd( "interstitial" )
	else

	end
end

-- Initialize the 'ads' library with the provider you wish to use.
if appID then
	ads.init( provider, appID, adListener )
end

--------------------------------------------------------------------------------
-- UI
--------------------------------------------------------------------------------

-- initial variables
local sysModel = system.getInfo("model")
local sysEnv = system.getInfo("environment")

-- create a background for the app

-- Shows a specific type of ad
showAd = function( adType )
	--local adX, adY = display.contentCenterX, (display.actualContentHeight)-25
	local adX, adY = display.screenOriginX, (display.actualContentHeight)-70

	ads.show( adType, { x=adX, y=adY } )
end

-- if on simulator, let user know they must build for device
if sysEnv == "simulator" then
		print("ON SIMULATOR NOW")
	else
		print("ON "..sysModel.." NOW")
		-- start with banner ad
		showAd( "banner" )
		--showAd( "interstitial" )
	end
end

	local function inputWeapon(weapPickup)
		SavedGameOneSettings.itemInventContents[#SavedGameOneSettings.itemInventContents+1] = weapPickup
		SavedGameOneSettings.ammoListing[#SavedGameOneSettings.itemInventContents+1] = GameSettings.ammoConf[6]
		SavedGameOneSettings.clipListing[#SavedGameOneSettings.itemInventContents+1] = GameSettings.clipConf[6]
		--SavedGameOneSettings.VMac1Killed = SavedGameOneSettings.VMac1Killed+1
		--print("SavedGameOneSettings.VMac1Killed = "..SavedGameOneSettings.VMac1Killed) 
		return true
	end
	
	
	function SM.popWeapEq(weapPickup)
		music.collectSoundPlay()
		for e=1, #SavedGameOneSettings.itemInventContents+1 do
			--if weapPickup == SavedGameOneSettings.itemInventContents[e] then
			if SavedGameOneSettings.itemInventContents[e] == weapPickup then
				print("INVENTORY IS ALREADY LOADED WITH "..tostring(weapPickup))
				GameSettings.purchSuccess = false
				print("---------------------------------------------------------------")
				return true
			end
			if SavedGameOneSettings.itemInventContents[e] == nil then
				print("---------------------------------------------------------------")
				print("INVENTORY IS NOT CURRENTLY LOADED WITH "..tostring(weapPickup))
				for q=1, 6 do
					--print("GameSettings.weaponList[q] = "..tostring(GameSettings.weaponList[q]))
					if GameSettings.weaponList[q] == weapPickup then
						GameSettings.purchSuccess = true
						SavedGameOneSettings.itemInventContents[#SavedGameOneSettings.itemInventContents+1] = weapPickup
						SavedGameOneSettings.ammoListing[#SavedGameOneSettings.itemInventContents] = GameSettings.ammoConf[q]
						SavedGameOneSettings.clipListing[#SavedGameOneSettings.itemInventContents] = GameSettings.clipConf[q]
						--print("GameSettings.weaponList "..q.." = "..tostring(GameSettings.weaponList[q]))	
						--print("SavedGameOneSettings.itemInventContents"..e.." = "..tostring(SavedGameOneSettings.itemInventContents[e]))
						--print("SavedGameOneSettings.ammoListing"..e.." = "..tostring(SavedGameOneSettings.ammoListing[e]))
						--SavedGameOneSettings.VMac1Killed = SavedGameOneSettings.VMac1Killed+1
						--print("SavedGameOneSettings.VMac1Killed = "..SavedGameOneSettings.VMac1Killed) 
						--inputWeapon(weapPickup)
						saveTableOne(SavedGameOneSettings, "SavedGameOneSettings.json") 
					end
				end
			end
		end
	end 
	
	function SM.popInventSG(itemPickup)
		music.collectSoundPlay()
		for r=1, #GameSettings.weaponList do
			if itemPickup == GameSettings.weaponList[r]then
			print("itemPickup = "..tostring(itemPickup))
			print("GameSettings.weaponList["..r.."] = "..tostring(GameSettings.weaponList[r]))
				for e=1, #SavedGameOneSettings.itemInventContents+1 do
					--if itemPickup == SavedGameOneSettings.itemInventContents[e] then
					if SavedGameOneSettings.itemInventContents[e] == itemPickup then
						--print("e = "..e)
						--print("GameSettings.weaponList[q] = "..tostring(GameSettings.weaponList[q]))
						SavedGameOneSettings.ammoListing[e] = SavedGameOneSettings.ammoListing[e]+1
						print("SavedGameOneSettings.ammoListing["..e.."] = "..SavedGameOneSettings.ammoListing[e])
						print("INVENTORY IS ALREADY LOADED WITH "..tostring(itemPickup))
						print("---------------------------------------------------------------")
						saveTableOne(SavedGameOneSettings, "SavedGameOneSettings.json") 
						return true
					end
					if SavedGameOneSettings.itemInventContents[e] == nil then
						print("---------------------------------------------------------------")
						print("INVENTORY IS NOT CURRENTLY LOADED WITH "..tostring(itemPickup))
						for q=1, #GameSettings.weaponList do
							--print("GameSettings.weaponList[q] = "..tostring(GameSettings.weaponList[q]))
							if GameSettings.weaponList[q] == itemPickup then
								SavedGameOneSettings.itemInventContents[#SavedGameOneSettings.itemInventContents+1] = itemPickup
								if SavedGameOneSettings.ammoListing[#SavedGameOneSettings.ammoListing+1] == nil then
									SavedGameOneSettings.ammoListing[#SavedGameOneSettings.ammoListing+1] = 1
								end
								if SavedGameOneSettings.clipListing[#SavedGameOneSettings.clipListing+1] == nil then
									SavedGameOneSettings.clipListing[#SavedGameOneSettings.clipListing+1] = 1
								end
								--print("GameSettings.weaponList "..q.." = "..tostring(GameSettings.weaponList[q]))	
								print("SavedGameOneSettings.itemInventContents"..e.." = "..tostring(SavedGameOneSettings.itemInventContents[e]))
								--print("SavedGameOneSettings.ammoListing"..e.." = "..tostring(SavedGameOneSettings.ammoListing[e]))
								--SavedGameOneSettings.VMac1Killed = SavedGameOneSettings.VMac1Killed+1
								--print("SavedGameOneSettings.VMac1Killed = "..SavedGameOneSettings.VMac1Killed) 
								--inputWeapon(itemPickup)
								saveTableOne(SavedGameOneSettings, "SavedGameOneSettings.json") 
								return true
							end
						end
					end
				end
			end
		end
	end 
		
--[[

	SavedGameOneSettings = savemanage.loadTableOne("SavedGameOneSettings.json")	
	SavedGameTwoSettings = savemanage.loadTableTwo("SavedGameTwoSettings.json")	
	SavedGameThreeSettings = savemanage.loadTableThree("SavedGameThreeSettings.json")	
   	savemanage.saveTableGame(GameSettings, "GameSettings.json")
   	savemanage.saveTableOne(SavedGameOneSettings, "SavedGameOneSettings.json")
   	savemanage.saveTableTwo(SavedGameTwoSettings, "SavedGameTwoSettings.json")
   	savemanage.saveTableThree(SavedGameThreeSettings, "SavedGameThreeSettings.json")

]]
		
SM.oneFileClear = oneFileClear
SM.oneFileCheck = oneFileCheck
SM.twoFileCheck = twoFileCheck
SM.threeFileCheck = threeFileCheck
SM.gameFileCheck = gameFileCheck
SM.playCollFileCheck = playCollFileCheck
SM.enemyFileCheck = enemyFileCheck
SM.checkSavedGameOneSettingsActive = checkSavedGameOneSettingsActive
SM.clearStatusOptions = clearStatusOptions
SM.collectProj1a = collectProj1a
SM.loadTableGame = loadTableGame
SM.loadTableEnemies = loadTableEnemies
SM.loadTableOne = loadTableOne
SM.loadTableTwo = loadTableTwo
SM.endLevelAdd = endLevelAdd
SM.loadTableThree = loadTableThree
SM.loadTablePractice = loadTablePractice
SM.saveTableGame = saveTableGame
SM.saveTableOne = saveTableOne
SM.createGameOne = createGameOne
SM.saveTable = saveTable
SM.loadTable = loadTable
SM.saveActiveGame = saveActiveGame
SM.savePlayLoc = savePlayLoc
SM.chargePointIncrease = chargePointIncrease
SM.confirmStarAmount = confirmStarAmount
SM.refillHitPoints = refillHitPoints

return SM