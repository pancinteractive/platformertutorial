--firstlevel.lua

local playerfile = require( "playerfile" )
local storyboard = require "storyboard"
local TouchMgr = require( "dmc_touchmanager" )
local enemies = require( "enemies" )
local itemspawn = require( "itemspawn" )
local scene = storyboard.newScene()
local group = display.newGroup();
local platform
local respawnEnemies1
local respawnEnemies2
local respawnEnemies3
physics.start()
local topPlat
local plateIdent
local game2
local game3
local moveTop
local platRnd = math.random(-220,800)
local playerState1
local playerState2
local playerState3
local playerState4
local playerState5
local smallPlat1	
local mediumPlat1	
local largePlat1	
local wb1 = {-250,250}
local wb2 = {-300,300}
local wb3 = {-350,350}
local wb4 = {160,90,-40} 
local back = {} 

	local function DestroyObj(Obj)
		display.remove(Obj)
		Obj=nil
	end

	function scene:createScene( event )
		local group = self.view
			GameSettings.game1 = display.newGroup();
			GameSettings.game = display.newGroup();
			group:insert(GameSettings.game)
	if GameSettings.planetTr == 1 then

		for i=1, 30 do	
			back[i] = display.newImage("media/images/background/bg1.png")
			back[i].x = 100+(i*144)
			back[i].y = -100
			GameSettings.game:insert(back[i])
		end
	elseif GameSettings.planetTr == 2 then
		
		local back = display.newRect(0, -1000, 9900, 1480)
		back:setFillColor(50,150,145)
		GameSettings.game:insert(back)
		
		local back1 = display.newRect(0, -100, 9900, 1480)
		back1:setFillColor(68,200,190)
		GameSettings.game:insert(back1)
		
		local back2 = display.newRect(0, 10, 9900, 1480)
		back2:setFillColor(140,200,200)
		GameSettings.game:insert(back2)
	end
local platformPhysics = display.newRect(0,0,8000,10)
platformPhysics.x = 750
platformPhysics.y = 194
platformPhysics:setFillColor(0,0,0,0)
platformPhysics.platType = "ground"
GameSettings.game:insert(platformPhysics)
physics.addBody( platformPhysics, "static", { density=1, friction=0.3, bounce=0 } )

----------------------------------------------------------------------
-- BARRIERS FOR LEFT AND RIGHT
----------------------------------------------------------------------

	local barrLeft = display.newRect(0,0,20,1000)
	barrLeft.x = 260
	barrLeft.y = 100
	barrLeft.platType = "wall"
	barrLeft:setFillColor(0,0,0,0)
	GameSettings.game:insert(barrLeft)
    physics.addBody(barrLeft, "static", {density = 10.0, friction = 10, bounce = 0})

	local barrRight = display.newRect(0,0,20,1000)
	barrRight.x = 4600
	barrRight.y = 100
	barrRight.platType = "wall"
	barrRight:setFillColor(0,0,0,0)
	GameSettings.game:insert(barrRight)
    physics.addBody(barrRight, "static", {density = 10.0, friction = 10, bounce = 0})

----------------------------------------------------------------------
-- CREATE PLAYER
----------------------------------------------------------------------
	
		playerfile.createHeroBottomA()
		playerfile.createHeroTopA()
		playerfile.createHeroBottomB()
		playerfile.createHeroTopB()
		playerfile.createHeroHitBox()
		playerfile.createAButton()
		playerfile.createBButton()
		playerfile.createArrows()
		playerfile.hitPoints = 3
		
----------------------------------------------------------------------
-- JUMPING FUNCTIONS (TESTING, NOT ACTIVE)
----------------------------------------------------------------------
		
		function plateIdent(self, event)
			--print("+-+-+-+-+-+-+-+-+-PLAYER HIT PLATFORM")
			timer.performWithDelay(100, function()
				if self.y < playerfile.herohitBox.y then
					--print("***************PLATFORM ABOVE")
				elseif self.y > playerfile.herohitBox.y then
					playerfile.herohitBox.canJump = true
					playerfile.jumpingInit = 0
					playerfile.jumpStart = 0
					playerfile.checkStateSprite()
					--print("///////////////PLATFORM BELOW")
				end
					--print("playerfile.herohitBox.canJump = "..tostring(playerfile.herohitBox.canJump))
			end, 2)
		end

----------------------------------------------------------------------
-- CREATION OF BACKGROUND GFX
----------------------------------------------------------------------
	
	local function topPlatCreate()
		topPlat = display.newRect(0,0,130,8)
		topPlat.x = 0
		topPlat.y = 0
		topPlat:setFillColor(0,255,0,0)
		topPlat.platType = "platform"
		topPlat.collision = plateIdent
		topPlat:addEventListener( "collision", topPlat )
		physics.addBody(topPlat, "static", {density = 10.0, friction = 10, bounce = 0})
		return topPlat
	end
	
	local platform = {}
for i=1, 60 do
	if GameSettings.planetTr == 1 then
		platform[i] = display.newImageRect( "media/images/background/ground2a.png", 144, 80)
	elseif GameSettings.planetTr == 2 then
		platform[i] = display.newImageRect( "media/images/background/ground1.png", 144,80, 3808, 160 )
	end
	platform[i].x = 100+(i*144)
	platform[i].y = 225
	GameSettings.game:insert(platform[i])
end
	local function createBG1()
for i=1, 30 do
	local backshadow1 = display.newImage("media/images/background/backshadow1.png",0, 0 )
	backshadow1.x = 150+(i*200)
	backshadow1.y = 110
	GameSettings.game:insert(backshadow1)
end
for i=1, 30 do
	local backshadow2 = display.newImage("media/images/background/backshadow2.png",0, 0 )
	backshadow2.x = 150+(i*200)
	backshadow2.y = 122
	GameSettings.game:insert(backshadow2)
end
for i=1, 30 do
	local backshadow3 = display.newImage("media/images/background/backshadow3.png",0, 0 )
	backshadow3.x = 150+(i*200)
	backshadow3.y = 174
	GameSettings.game:insert(backshadow3)
end
for i=1, 30 do
	local backshadow4 = display.newImage("media/images/background/treefront1.png",0, 0 )
	backshadow4.x = 160+(i*200)
	backshadow4.y = 122
	GameSettings.game:insert(backshadow4)
end
for i=1, 30 do
	local backshadow5 = display.newImageRect("media/images/background/forecloud1.png",680, 194)
	backshadow5.x = 200+(i*160)
	backshadow5.y = -140
	GameSettings.game:insert(backshadow5)
		local function trans1()
			local function trans2()
				transition.to(backshadow1, {time=6000, yScale=1.01, xScale=1.01, onComplete=trans1})
			end
			transition.to(backshadow1, {time=6000, yScale=.975, xScale=.975, onComplete=trans2})
		end
		trans1()
	
end
end
----------------------------------------------------------------------
-- CREATION OF PLATFORM HOLDERS
----------------------------------------------------------------------
	
	local function topPlatCreate()
		topPlat = display.newRect(0,0,130,8)
		topPlat.x = 0
		topPlat.y = 0
		topPlat:setFillColor(0,255,0,0)
		topPlat.platType = "platform"
		--topPlat.collision = onCollision2
		topPlat:addEventListener( "collision", topPlat )
		physics.addBody(topPlat, "static", {density = 10.0, friction = 10, bounce = 0})
		return topPlat
	end

local woodplat = {}
local woodplat1 = {}
local woodplat2 = {}
local woodplat3 = {}
local woodplat4 = {}
local woodplat5 = {}
local gamePlat1 = {}
local topPlat1 = {}
local topPlat2 = {}
local botPlat1 = {}
local woodplat6 = {}
local woodplat7 = {}
local woodplat8 = {}
local woodplat9 = {}
local woodplat10 = {}
local woodplat11 = {}
local woodplat12 = {}
local tHi = {}
local gamePlat3 = {}
local topPlat3 = {}
local botPlat3 = {}

----------------------------------------------------------------------
-- CREATION OF SHORT PLATFORMS
----------------------------------------------------------------------

local function createSmall()
	--smallest
	smallPlat1 = 12
	for i=1, smallPlat1 do
	gamePlat1[i] = display.newGroup();
	local tVg = math.random(550,4500)
		woodplat[i] = display.newImage("media/images/background/techplat2b.png",0, 0 )
		--woodplat[i].x = 300+(i*172)
		woodplat[i].x = tVg
		woodplat[i].y = 140
		--woodplat[i].alpha = 0
		woodplat1[i] = display.newImage("media/images/background/techplat2a.png",0, 0 )
		woodplat1[i].x = woodplat[i].x
		woodplat1[i].y = 170
		topPlat1[i] = topPlatCreate()
		topPlat1[i].collision = playerfile.plateIdent
		topPlat1[i]:addEventListener( "collision", topPlat1[i] )
		topPlat1[i].x = woodplat[i].x
		topPlat1[i].y = woodplat[i].y-16
		gamePlat1[i]:insert(woodplat[i])
		gamePlat1[i]:insert(woodplat1[i])
		gamePlat1[i]:insert(topPlat1[i])
		GameSettings.game:insert(gamePlat1[i])
	end
end

	local function reorderSmallPlats3()
		local tQW = 200
		local tHg = math.random(420,900)
		local tHj = math.random(2)
			for t=1, smallPlat1-1 do
				--print("-------TEST WORKING-------")
			if woodplat[t].x >= woodplat[t+1].x+tQW or woodplat[t].x <= woodplat[t+1].x-tQW then
				woodplat[t].x = woodplat[t].x+wb1[tHj]
				topPlat1[t].x = woodplat[t].x
				woodplat1[t].x = woodplat[t].x
			end
		end
	end

----------------------------------------------------------------------
-- CREATION OF MEDIUM PLATFORMS
----------------------------------------------------------------------

local function createMedium()
	--second smallest
	mediumPlat1 = 8
	for i=1, mediumPlat1 do
	local tHg = math.random(450,4400)
	--local tHg = i*300
		woodplat2[i] = display.newImage("media/images/background/techplat2a.png",0, 0 )
		woodplat2[i].x = tHg
		woodplat2[i].y = 170
		GameSettings.game:insert(woodplat2[i])
		woodplat3[i] = display.newImage("media/images/background/techplat2a.png",0, 0 )
		woodplat3[i].x = woodplat2[i].x
		woodplat3[i].y = 138
		GameSettings.game:insert(woodplat3[i])
		woodplat4[i] = display.newImage("media/images/background/techplat2a.png",0, 0 )
		woodplat4[i].x = woodplat2[i].x
		woodplat4[i].y = 106
		GameSettings.game:insert(woodplat4[i])
		woodplat5[i] = display.newImage("media/images/background/techplat2b.png",0, 0 )
		woodplat5[i].x = woodplat2[i].x
		woodplat5[i].y = 74
		GameSettings.game:insert(woodplat5[i])
		topPlat2[i] = topPlatCreate()
		topPlat2[i].x = woodplat2[i].x
		topPlat2[i].y = woodplat5[i].y-16
		GameSettings.game:insert(topPlat2[i])
	end
end


	local function reorderMediumPlats3()
		local tQW = 200
		local tHg = math.random(200,900)
		local tHj = math.random(2)
		--print("#woodplat2 = "..#woodplat2)
			if #woodplat2 == nil then
				return false
			end
			for t=1, #woodplat2-3 do
				--print("*********TEST WORKING*********")
			if woodplat2[t].x >= woodplat2[t+1].x+tQW or woodplat2[t].x <= woodplat2[t+1].x-tQW then
				--print("xxxxxxxxxxxTEST WORKINGxxxxxxxxxxx")
				--gamePlat1[t+1].x = gamePlat1[t].x+tQW
				woodplat2[t].x = woodplat2[t].x+wb2[tHj]
				topPlat2[t].x = woodplat2[t].x
				woodplat3[t].x = woodplat2[t].x
				woodplat4[t].x = woodplat2[t].x
				woodplat5[t].x = woodplat2[t].x
			end
		end
	end

----------------------------------------------------------------------
-- CREATION OF TALL PLATFORMS
----------------------------------------------------------------------

local function createLarge()
	largePlat1 = 7
	for i=1, largePlat1 do
	rFd = math.random(520,4600)
	gamePlat3[i] = display.newGroup();
	--third smallest
		woodplat6[i] = display.newImage("media/images/background/techplat2a.png",0, 0 )
		woodplat6[i].x = rFd
		woodplat6[i].y = 170
		woodplat7[i] = display.newImage("media/images/background/techplat2a.png",0, 0 )
		woodplat7[i].x = woodplat6[i].x
		woodplat7[i].y = 138
		woodplat8[i] = display.newImage("media/images/background/techplat2a.png",0, 0 )
		woodplat8[i].x = woodplat6[i].x
		woodplat8[i].y = 106
		woodplat9[i] = display.newImage("media/images/background/techplat2a.png",0, 0 )
		woodplat9[i].x = woodplat6[i].x
		woodplat9[i].y = 74
		woodplat11[i] = display.newImage("media/images/background/techplat2a.png",0, 0 )
		woodplat11[i].x = woodplat6[i].x
		woodplat11[i].y = 42
		woodplat10[i] = display.newImage("media/images/background/techplat2b.png",0, 0 )
		woodplat10[i].x = woodplat6[i].x
		woodplat10[i].y = 7
		topPlat3[i] = topPlatCreate()
		topPlat3[i].x = woodplat6[i].x
		topPlat3[i].y = woodplat10[i].y-16
		gamePlat3[i]:insert(woodplat6[i])
		gamePlat3[i]:insert(woodplat7[i])
		gamePlat3[i]:insert(woodplat8[i])
		gamePlat3[i]:insert(woodplat9[i])
		gamePlat3[i]:insert(woodplat10[i])
		gamePlat3[i]:insert(woodplat11[i])
		gamePlat3[i]:insert(topPlat3[i])
		GameSettings.game:insert(gamePlat3[i])
	end
end

	
	local function reorderLargePlats3()
		local tQW = 200
		local tHg = math.random(200,900)
		local tHj = math.random(2)
				--print("#woodplat6 = "..#woodplat6)
			for t=1, largePlat1-1 do
				--print("*********TEST WORKING*********")
				if woodplat6[t] == nil and woodplat6[t+1] == nil then
					print("*********TEST WORKING*********")
					return false
				elseif woodplat6[t].x >= woodplat6[t+1].x+tQW or woodplat6[t].x <= woodplat6[t+1].x-tQW then
				--print("xxxxxxxxxxxTEST WORKINGxxxxxxxxxxx")
				--gamePlat1[t+1].x = gamePlat1[t].x+tQW
				woodplat6[t].x = woodplat6[t].x+wb3[tHj]
				topPlat3[t].x = woodplat6[t].x
				woodplat7[t].x = woodplat6[t].x
				woodplat8[t].x = woodplat6[t].x
				woodplat9[t].x = woodplat6[t].x
				woodplat10[t].x = woodplat6[t].x
				woodplat11[t].x = woodplat6[t].x
			end
		end
	end
	

----------------------------------------------------------------------
-- CALL PLATFORMS BASED ON LOCATION IN DISPLAY
----------------------------------------------------------------------

	if GameSettings.planetTr == 1 then
			createLarge()
		for i=1, 4 do
			reorderLargePlats3()
		end
			createMedium()
		for i=1, 4 do
			reorderMediumPlats3()
		end
			createSmall()
			--reorderSmallPlats1()
		for i=1, 4 do
			reorderSmallPlats3()
		end
	elseif GameSettings.planetTr == 2 then
		createBG1()
	end
----------------------------------------------------------------------
-- ADDITION OF POWERUPS, ITEMS, INTERACTABLES, GUNS
----------------------------------------------------------------------

	local function createGunPowerUp()
		local weaponUp
		local wbw = math.random(6)
		--local wbw = 6
		local wbi = math.random(300,4100)
		local wbg = math.random(3)
		--local wbg = 1
		--local wbw = 2
			weaponUp = itemspawn.createGunEnItem(wbw)
			weaponUp.x = playerfile.herohitBox.x+50+wbi
			--weaponUp.x = playerfile.herohitBox.x-350
			weaponUp.y = wb4[wbg]
			GameSettings.game:insert(weaponUp)
		end
		for i=1, 4 do
			--createGunPowerUp()
		end

	local function createHealthPowerUp()
		local weaponUp
		--local wbw = math.random(2)
		local wbw = 3
		local wbi = math.random(300,4100)
		local wbg = math.random(2)
		--local wbg = 1
		--local wbw = 2
			weaponUp = itemspawn.createHealthEnItem(wbw)
			--weaponUp.x = playerfile.herohitBox.x+50+wbi
			weaponUp.x = 480
			--weaponUp.x = playerfile.herohitBox.x-350
			weaponUp.y = wb4[wbg]
			GameSettings.game:insert(weaponUp)
		end
		for i=1, 1 do
			createHealthPowerUp()
		end
		
		local function testIvince()
			timer.performWithDelay(2500, function()
				playerfile.statusIdent = 2
				playerfile.callInvincTimer1()
			end, 1)
		end
		--testIvince()

----------------------------------------------------------------------
-- CREATION OF UI AND PLACEMENT OF PLAYER
----------------------------------------------------------------------

		--playerfile.onShotSpawn()
		--playerfile.createTestBolts()
		--playerfile.spawnTest()
		playerfile.createHealthBar()
		--playerfile.keepScore()
		
		playerfile.herohitBox.x = 400
		GameSettings.game.x = -261
		playerfile.herohitBox.y = 120

		GameSettings.game:insert(playerfile.heroBottomB)
		GameSettings.game:insert(playerfile.heroBottomA)
		GameSettings.game:insert(playerfile.heroTopB)
		GameSettings.game:insert(playerfile.heroTopA)
		GameSettings.game:insert(playerfile.herohitBox)		
		
		
		--TouchMgr:register( playerfile.buttonAreal, playerfile.onButtonAPress)
		playerfile.buttonA:addEventListener("touch", playerfile.onButtonAPress)
		Runtime:addEventListener("enterFrame", playerfile.movingMotion)

		local function createStopMovement()
			local stopRect = display.newRect(0,0,100,50)
			stopRect.x = playerfile.rightArrow.x+75
			stopRect.y = playerfile.rightArrow.y
				local function stopPlayMovement1(event)
					playerfile.playMovementMotion = 0
					playerfile.checkPlayerMotionMovement()
					print("playerFile.playMovementMotion = "..tostring(playerfile.playMovementMotion))
					print("playerFile.movingInit = "..tostring(playerfile.movingInit))
				end
				--stopRect:addEventListener("touch", stopPlayMovement1)
		end
		--createStopMovement()
----------------------------------------------------------------------
-- CREATION OF FOREGROUND GFX
----------------------------------------------------------------------

for i=1, 2 do
	local backshadow1 = display.newImage("media/images/background/grass2.png",0, 0 )
	backshadow1.x = 400+(i*48)
	backshadow1.y = 170
	GameSettings.game:insert(backshadow1)
end
for i=1, 3 do
	local backshadow1 = display.newImage("media/images/background/grass2.png",0, 0 )
	backshadow1.x = 700+(i*48)
	backshadow1.y = 170
	GameSettings.game:insert(backshadow1)
end

----------------------------------------------------------------------
-- CREATION OF ENEMIES
----------------------------------------------------------------------

	local sentrySpawn1 = 0
	local guardBotSpawn1 = 6
	
	local function callEnemies2()
		for i=1, sentrySpawn1 do
			enemies.createTestSentry1(i)
		end
		for i=1, guardBotSpawn1 do
			enemies.createTestGuardBot1(i)
		end
	--print(enemies.enemiessentry[5].hitBox.x)
	enemies.enemiesguardbot[5].hitBox.x = playerfile.herohitBox.x+200
	end

		--callEnemies2()
		
	
----------------------------------------------------------------------
-- ADDITION OF COLLISION LISTENER
----------------------------------------------------------------------

playerfile.herohitBox.collision = playerfile.onCollision
playerfile.herohitBox:addEventListener( "collision", playerfile.herohitBox )

----------------------------------------------------------------------
-- ADDITION OF GAMELOOP
----------------------------------------------------------------------

 local function moveCamera()

	if (playerfile.herohitBox.x > 500 and playerfile.herohitBox.x < 4400) then
		GameSettings.game.x = -playerfile.herohitBox.x + display.contentWidth/2
		end
		if (playerfile.herohitBox.y > -150 and playerfile.herohitBox.y < 160) then
		GameSettings.game.y = -playerfile.herohitBox.y + 255
	end
end
	local function onUpdate()
			if playerfile.hitPoints <= 0 then
				playerfile.heroDead = true
				Runtime:removeEventListener("enterFrame", onUpdate)
				playerfile.removeHUD()
				timer.performWithDelay(2000, function()
					playerfile.killScore()
					storyboard.gotoScene("startscreen", options)
				end, 1)
			end
		playerfile.heroTopA.x = playerfile.herohitBox.x
		playerfile.heroTopA.y = playerfile.herohitBox.y
		playerfile.heroBottomA.x = playerfile.herohitBox.x
		playerfile.heroBottomA.y = playerfile.herohitBox.y-1
		playerfile.heroTopA.xScale = playerfile.herohitBox.xScale
		playerfile.heroBottomA.xScale = playerfile.herohitBox.xScale
		playerfile.heroTopB.x = playerfile.herohitBox.x
		playerfile.heroTopB.y = playerfile.herohitBox.y
		playerfile.heroBottomB.x = playerfile.herohitBox.x
		playerfile.heroBottomB.y = playerfile.herohitBox.y-1
		playerfile.heroTopB.xScale = playerfile.herohitBox.xScale
		playerfile.heroBottomB.xScale = playerfile.herohitBox.xScale
		--print("playerfile.heroDead = "..tostring(playerfile.heroDead))
		moveCamera()
		playerfile.movingMotion()

-------------------------------------------------------------------------------

		playerfile.heroBottomB:setFillColor(150)
		playerfile.heroTopB:setFillColor(150)
		
-------------------------------------------------------------------------------
	end
Runtime:addEventListener("enterFrame", onUpdate)
end

function scene:enterScene( event )
	local group = self.view
end

function scene:exitScene( event )
	local group = self.view
		storyboard.purgeAll()
		storyboard.removeAll()
		playerfile.heroDead = false
	end

function scene:destroyScene( event )
	local group = self.view
end

scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "destroyScene", scene )

return scene
