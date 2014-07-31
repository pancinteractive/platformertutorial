--enemies.lua
local TouchMgr = require( "dmc_touchmanager" )
local playerfile = require( "playerfile" )
local enemies = {}
enemies.enemiessentry = {}
enemies.enemiesenemSentryHitPoints = {}
enemies.enemiesguardbot = {}
enemies.enemiesenemGuardBotHitPoints = {}

	local function DestroyObj(Obj)
		display.remove(Obj)
		Obj=nil
	end
	local function partBurst(objEnem)
    local function DestroyPop(Obj)
        display.remove(Obj)
        Obj = nil
	end
	timer.performWithDelay(5, function()
			local function createParts()
				timer.performWithDelay(5, function()
					starRnd = math.random
					partDown = display.newRect(0,0,5,5)
					partDown:setFillColor(200,200,0)
					physics.addBody( partDown, "dynamic",{ density = 1.5, isSensor=true } )
					partDown.x = objEnem.x+(starRnd(-5, 5))
					partDown.y = objEnem.y
					partDown:applyForce(1*(starRnd(-5,5)),-13, partDown.x*(starRnd(1,10)), partDown.y)
					partDown:applyTorque(5*starRnd(5,10))
					transition.to(partDown, {time=1500, onComplete=DestroyPop})
					game:insert(partDown)
					return partDown
				end, 15)
			end
		createParts()
		end, 1)
	end

local function hasCollided(obj1, obj2)
		if obj1 == nil then
			return false
		end		
		if obj2 == nil then
			return false
		end		
        return obj1.contentBounds.xMin < obj2.contentBounds.xMax
                and obj1.contentBounds.xMax > obj2.contentBounds.xMin
                and obj1.contentBounds.yMin < obj2.contentBounds.yMax
                and obj1.contentBounds.yMax > obj2.contentBounds.yMin
			end
local function playerCollision1(yG)
	if playerfile.statusIdent == 1 then
		playerfile.hitPoints = playerfile.hitPoints-yG
		print("OBJECT HAS BEEN TOUCHED BY PLAYER")
			transition.to(playerfile.herohitBox,{time = 10,y=playerfile.herohitBox.y-20, x = playerfile.herohitBox.x-(50*playerfile.herohitBox.xScale)})
			playerfile.clearHealthBar()
			playerfile.createHealthBar()
			playerfile.enemyCollType = 1
			playerfile.motionx = 0
			playerfile.motionx = 0
			timer.performWithDelay(70, function()
				playerfile.heroBottomB.alpha=0
				playerfile.heroTopB.alpha=0
				timer.performWithDelay(35, function()
					playerfile.heroBottomB.alpha=1
					playerfile.heroTopB.alpha=1
				end, 1)
			end, 3)
			timer.performWithDelay(300, function()
				playerfile.heroBottomB.alpha=1
				playerfile.heroTopB.alpha=1
				playerfile.enemyCollType = 0
				playerfile.movingInit = 0
				playerfile.attackInit = 0
				playerfile.motionx = 0
				playerfile.motionx = 0
			end, 1)
		end
	end
----------------------------------------------------------------------	


local function createTestSentry1(yT)
	local optionsE1 = {
	
		width = 48,
		height = 46,
		numFrames = 5,
	
		sheetContentWidth = 240,
		sheetContentHeight = 46
	}
	local imageSheetE1 = graphics.newImageSheet("media/images/enemy/sentry1sheet.png", optionsE1, true )
	local sequenceDataE1 = {
		{ name="idle1", start=1, count=1 },
		{ name="idle2", start=2, count=1 },
		{ name="fire", start=5, count=1 },
		{ name="action", start=1, count=5, loopDirection = "bounce", time=500 },
		}
	
	enemies.enemiessentry[yT] = display.newSprite( imageSheetE1, sequenceDataE1 )
	enemies.enemiessentry[yT]:setReferencePoint(display.CenterReferencePoint)
	enemies.enemiessentry[yT].x = math.random(410,4300)
	enemies.enemiessentry[yT].y = 0
	enemies.enemiessentry[yT].isAlive = true
	enemies.enemiessentry[yT].alpha = 0
	enemies.enemiessentry[yT]:setSequence("action")
	enemies.enemiessentry[yT]:play()
	enemies.enemiesenemSentryHitPoints[yT] = 8
	game:insert(enemies.enemiessentry[yT])
	enemies.enemiessentry[yT].hitBox = display.newRect(0,0,42,40)
	enemies.enemiessentry[yT].hitBox:setFillColor(0,0,0,0)
	enemies.enemiessentry[yT].hitBox.x = enemies.enemiessentry[yT].x 
	enemies.enemiessentry[yT].hitBox.y = enemies.enemiessentry[yT].y
	game:insert(enemies.enemiessentry[yT].hitBox)
	--print(enemies.enemiessentry[yT].hitBox)
	physics.addBody(enemies.enemiessentry[yT].hitBox, "kinematic",{ density = 35.50, friction = 0.3, bounce = 0 })
	enemies.enemiessentry[yT].hitBox.isFixedRotation = true
	transition.to(enemies.enemiessentry[yT], {time=150, alpha=1})
		local function enemySentryAI()
		enemies.enemiessentry[yT].x = enemies.enemiessentry[yT].hitBox.x 
		enemies.enemiessentry[yT].y = enemies.enemiessentry[yT].hitBox.y
			for a = 1, playerfile.ammoAmt, 1 do
			if playerfile.bolts == nil then
				return false
			end
					if hasCollided(playerfile.bolts[a], enemies.enemiessentry[yT].hitBox) and playerfile.bolts ~= nil then
						enemies.enemiesenemSentryHitPoints[yT] = enemies.enemiesenemSentryHitPoints[yT]-playerfile.boltStrength
						bolt1x = playerfile.bolts[a].x
						bolt1y = playerfile.bolts[a].y
							if playerfile.gunType ~= 6 then
								playerfile.bolts[a].x = 1800
								playerfile.bolts[a].y = 1500
							end
						playerfile.projHitLogic()
						timer.performWithDelay(70, function()
							enemies.enemiessentry[yT]:setFillColor(255,10,10)
								timer.performWithDelay(35, function()
									enemies.enemiessentry[yT]:setFillColor(255)
								end, 1)
						end, 3)
					end
				end
			if enemies.enemiesenemSentryHitPoints[yT] <= 0 then
				partBurst(enemies.enemiessentry[yT])
				playerfile.scoreAmount = playerfile.scoreAmount + 3
				playerfile.killScore()
				playerfile.keepScore()
				enemies.enemiessentry[yT].isAlive = false
				enemies.enemiessentry[yT].hitBox:setLinearVelocity(0,0)
				Runtime:removeEventListener("enterFrame", enemySentryAI)
				transition.to(enemies.enemiessentry[yT], {time=250, delay=500, alpha=0, onComplete=DestroyObj})
				display.remove(enemies.enemiessentry[yT].hitBox)
				enemies.enemiessentry[yT].hitBox=nil
				timer.performWithDelay(2000, function()
					--createSentry1()
				end, 1)
			end
			if playerfile.hitPoints <= 0 then
				enemies.enemiessentry[yT].hitBox:setLinearVelocity(0,0)
				Runtime:removeEventListener("enterFrame", enemySentryAI)
				transition.to(enemies.enemiessentry[yT], {time=250, delay=500, alpha=0, onComplete=DestroyObj})
				display.remove(enemies.enemiessentry[yT].hitBox)
				enemies.enemiessentry[yT].hitBox=nil
			end
		end
		Runtime:addEventListener("enterFrame", enemySentryAI)
		local function sentryCollision(self, event)		
			local item8 = event.other.hitType
			if event.phase == "began" and item8 == "heroType" and enemies.enemiessentry[yT].isAlive == true then
				playerCollision1(1)
			end	
		end	
		enemies.enemiessentry[yT].hitBox.collision = sentryCollision
		enemies.enemiessentry[yT].hitBox:addEventListener( "collision", enemies.enemiessentry[yT].hitBox )
		local function moveSentry1()
			if enemies.enemiesenemSentryHitPoints[yT] > 0  then
				local function moveEnem1()
					if enemies.enemiesenemSentryHitPoints[yT] > 0  then
						local function moveEnem2()
							if enemies.enemiesenemSentryHitPoints[yT] > 0  then
								local rnd1 = math.random(-30,30)
								local rnd2 = math.random(-30,30)
								enemies.enemiessentry[yT].hitBox:setLinearVelocity(rnd1,rnd2)
								transition.to(enemies.enemiessentry[yT].hitBox, {time=1500, onComplete=moveEnem1})
							end
						end
							local rnd1 = math.random(-30,30)
							local rnd2 = math.random(-30,30)
							enemies.enemiessentry[yT].hitBox:setLinearVelocity(rnd1,rnd2)
							transition.to(enemies.enemiessentry[yT].hitBox, {time=1500, onComplete=moveEnem2})
						end
				end
			moveEnem1()		
			end
		end
		moveSentry1()
		return enemies.enemiessentry[yT]
end

local function createTestGuardBot1(yT)
	local optionsE1 = {
	
		width = 56,
		height = 62,
		numFrames = 3,
	
		sheetContentWidth = 168,
		sheetContentHeight = 62
	}
	local imageSheetE1 = graphics.newImageSheet("media/images/enemy/guardbot1sheet.png", optionsE1, true )
	local sequenceDataE1 = {
		{ name="idle1", start=1, count=1 },
		{ name="idle2", start=2, count=1 },
		{ name="fire", start=1, count=1 },
		{ name="walk", start=1, count=3, loopDirection = "bounce", time=500 },
		}
	
	enemies.enemiesguardbot[yT] = display.newSprite( imageSheetE1, sequenceDataE1 )
	enemies.enemiesguardbot[yT]:setReferencePoint(display.CenterReferencePoint)
	enemies.enemiesguardbot[yT].x = math.random(510,4200)
	enemies.enemiesguardbot[yT].y = 80
	enemies.enemiesguardbot[yT].isAlive = true
	enemies.enemiesguardbot[yT].alpha = 0
	enemies.enemiesguardbot[yT].rnd1 = -60
	enemies.enemiesguardbot[yT]:setSequence("walk")
	enemies.enemiesguardbot[yT]:play()
	enemies.enemiesenemGuardBotHitPoints[yT] = 10
	game:insert(enemies.enemiesguardbot[yT])
	enemies.enemiesguardbot[yT].hitBox = display.newRect(0,0,42,40)
	enemies.enemiesguardbot[yT].hitBox:setFillColor(0,0,0,0)
	enemies.enemiesguardbot[yT].hitBox.x = enemies.enemiesguardbot[yT].x 
	enemies.enemiesguardbot[yT].hitBox.y = enemies.enemiesguardbot[yT].y
	game:insert(enemies.enemiesguardbot[yT].hitBox)
	--print(enemies.enemiesguardbot[yT].hitBox)
	physics.addBody(enemies.enemiesguardbot[yT].hitBox, "dynamic",{ density = 35.50, friction = 0.3, bounce = 0 })
	enemies.enemiesguardbot[yT].hitBox.isFixedRotation = true
	transition.to(enemies.enemiesguardbot[yT], {time=150, alpha=1})
		local function enemyGuardBotAI()
			if enemies.enemiesguardbot[yT].hitBox.x <= 1150 then
				enemies.enemiesguardbot[yT].rnd1 = 60
				enemies.enemiesguardbot[yT].xScale = -1
			elseif enemies.enemiesguardbot[yT].hitBox.x >= 1600 then
				enemies.enemiesguardbot[yT].rnd1 = -60
				enemies.enemiesguardbot[yT].xScale = 1
			end	
		enemies.enemiesguardbot[yT].x = enemies.enemiesguardbot[yT].hitBox.x 
		enemies.enemiesguardbot[yT].y = enemies.enemiesguardbot[yT].hitBox.y-10
			--for a = 1, playerfile.clipSize, 1 do
			for a = 1, 999 do
			--print("playerfile.clipSize = "..tostring(playerfile.clipSize))
			--print("a = "..tostring(a))
			--[[
			if playerfile.bolts == nil or playerfile.bolt[a] == nil then
				return false
			end
			]]
					if hasCollided(playerfile.bolt[a], enemies.enemiesguardbot[yT].hitBox) then
						enemies.enemiesenemGuardBotHitPoints[yT] = enemies.enemiesenemGuardBotHitPoints[yT]-playerfile.boltStrength
						--bolt1x = playerfile.bolts[a].x
						--bolt1y = playerfile.bolts[a].y
						--playerfile.bolt[a].x = enemies.enemiesguardbot[yT].x-70
						--playerfile.bolt[a].y = enemies.enemiesguardbot[yT].y-50
						display.remove(playerfile.bolt[a])
						playerfile.bolt[a] = nil
						playerfile.projHitLogic()
						timer.performWithDelay(70, function()
							enemies.enemiesguardbot[yT]:setFillColor(255,10,10)
								timer.performWithDelay(35, function()
									enemies.enemiesguardbot[yT]:setFillColor(255)
								end, 1)
						end, 3)
					end
				end
			if enemies.enemiesenemGuardBotHitPoints[yT] <= 0 then
				partBurst(enemies.enemiesguardbot[yT])
				--playerfile.scoreAmount = playerfile.scoreAmount + 3
				--playerfile.killScore()
				--playerfile.keepScore()
				enemies.enemiesguardbot[yT].isAlive = false
				enemies.enemiesguardbot[yT].hitBox:setLinearVelocity(0,0)
				Runtime:removeEventListener("enterFrame", enemyGuardBotAI)
				transition.to(enemies.enemiesguardbot[yT], {time=250, delay=500, alpha=0, onComplete=DestroyObj})
				display.remove(enemies.enemiesguardbot[yT].hitBox)
				enemies.enemiesguardbot[yT].hitBox=nil
				timer.performWithDelay(2000, function()
					--createGuardBot1()
				end, 1)
			end
			--[[
			]]
			if playerfile.hitPoints <= 0 then
				enemies.enemiesguardbot[yT].hitBox:setLinearVelocity(0,0)
				Runtime:removeEventListener("enterFrame", enemyGuardBotAI)
				transition.to(enemies.enemiesguardbot[yT], {time=250, delay=500, alpha=0, onComplete=DestroyObj})
				display.remove(enemies.enemiesguardbot[yT].hitBox)
				enemies.enemiesguardbot[yT].hitBox=nil
			end
		end
		Runtime:addEventListener("enterFrame", enemyGuardBotAI)
		local function guardbotCollision(self, event)		
			local item8 = event.other.hitType
			if event.phase == "began" and item8 == "heroType" and enemies.enemiesguardbot[yT].isAlive == true then
				playerCollision1(1)
			end	
		end	
		enemies.enemiesguardbot[yT].hitBox.collision = guardbotCollision
		enemies.enemiesguardbot[yT].hitBox:addEventListener( "collision", enemies.enemiesguardbot[yT].hitBox )
		local function moveGuardBot1()
			if enemies.enemiesenemGuardBotHitPoints[yT] > 0  then
				local function moveEnem1()
					if enemies.enemiesenemGuardBotHitPoints[yT] > 0  then
						local function moveEnem2()
							if enemies.enemiesenemGuardBotHitPoints[yT] > 0  then
								local rnd1 = math.random(-30,30)
								local rnd2 = math.random(-30,30)
								enemies.enemiesguardbot[yT].hitBox:setLinearVelocity(enemies.enemiesguardbot[yT].rnd1,0)
								transition.to(enemies.enemiesguardbot[yT].hitBox, {time=1500, onComplete=moveEnem1})
							end
						end
							local rnd1 = math.random(-30,30)
							local rnd2 = math.random(-30,30)
							enemies.enemiesguardbot[yT].hitBox:setLinearVelocity(enemies.enemiesguardbot[yT].rnd1,0)
							transition.to(enemies.enemiesguardbot[yT].hitBox, {time=1500, onComplete=moveEnem2})
						end
				end
			moveEnem1()		
			end
		end
		moveGuardBot1()
		return enemies.enemiesguardbot[yT]
end


enemies.createSentry1 = createSentry1
enemies.createSentry2 = createSentry2
enemies.createSentry3 = createSentry3
enemies.createSentry4 = createSentry4
enemies.createSentry5 = createSentry5
enemies.createGuardbot1 = createGuardbot1
enemies.createGuardbot2 = createGuardbot2
enemies.createTestSentry1 = createTestSentry1
enemies.createTestGuardBot1 = createTestGuardBot1




return enemies