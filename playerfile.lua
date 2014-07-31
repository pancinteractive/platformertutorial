--playerFile.lua
local TouchMgr = require( "dmc_touchmanager" )
local playerFile = {}
local fontName = "Xolonium"
local leftArrow
local rightArrow
local clipLoad
local rhG = .4
local xDa = 350
local aBg = display.screenOriginX+5
local STATE_IDLE = "Idle"
local STATE_WALKING = "Walking"
local STATE_JUMPING = "Jumping"
local DIRECTION_LEFT = -1
local DIRECTION_RIGHT = 1
local game4
local exploRad
local flameThrower1
local flameTimer1
local followBolt2
local timerHeroMoveStash = {}
local rndNum = math.random(8)
local ggP = 72
local ppA = (display.screenOriginY+display.actualContentHeight)-80
playerFile.heroDead = false
playerFile.equipState = false
playerFile.motionx = 0 
playerFile.motiony = 0 
playerFile.moveScale = 0
playerFile.scoreAmount = 0 
playerFile.hitPoints = 3
playerFile.speed = 2.25
playerFile.spriteIsMoving = 1
playerFile.spriteMovementTesting = 9
playerFile.gunType = 1
playerFile.attackState = 1
playerFile.firingState = 1
playerFile.movingInit = 0
playerFile.jumpingInit = 0
playerFile.jumpStart = 0
playerFile.statusIdent = 1
playerFile.playMovementMotion = 0
playerFile.firing1Timer = {}
playerFile.boltIcon = {}
playerFile.heart = {}
playerFile.ammoAmt = 3
playerFile.projThrow1 = {}
GameSettings.lockStatus = false
local lFa = 1050 -- repeat fire rate


local color1 = 
{
    highlight = 
    {
        r =0, g = 0, b = 0, a = 255
    },
    shadow =
    {
        r = 0, g = 0, b = 0, a = 255
    }
}
local color2 = 
{
    highlight = 
    {
         r = 255, g = 255, b = 255, a = 255
    },
    shadow =
    {
        r = 255, g = 255, b = 255, a = 255
    }
}

local function clearHealthBar()
heartBar:removeSelf()
heartBar=nil
end

local function createHealthBar()
heartBar = display.newGroup();
if playerFile.hitPoints >= 3 then 
	playerFile.hitPoints = 3
	hitPoints = playerFile.hitPoints
end
if playerFile.hitPoints <= 2 then 
	hitPoints  = playerFile.hitPoints
end
for i=1, hitPoints do
playerFile.heart[i] = display.newImageRect("media/images/action/heart.png", 26, 22)
playerFile.heart[i].x = (aBg)+(i*26)
playerFile.heart[i].y = display.screenOriginY+24
heartBar:insert(playerFile.heart[i])
	end
end
local function killScore()
	display.remove(game5)
	game5=nil
end
local function keepScore()
		game5 = display.newGroup();
		local scoreAmnt = display.newEmbossedText(playerFile.scoreAmount, 0,0,fontName, 24)
		scoreAmnt:setReferencePoint(display.CenterReferencePoint)
		scoreAmnt:setFillColor(255)
		scoreAmnt:setEmbossColor(color1)
		scoreAmnt.x = display.screenOriginX+400
		scoreAmnt.y = display.screenOriginY+14
		game5:insert(scoreAmnt)
end

local heroChargeStash = {}
local function cancelAllheroTrans()
    local k, v

    for k,v in pairs(heroChargeStash) do
        timer.cancel( v )
        v = nil; k = nil
    end
    heroChargeStash = nil
    heroChargeStash = {}
end

local function cancelAllHeroMoveTransitions()
    local k, v

    for k,v in pairs(timerHeroMoveStash) do
        timer.cancel( v )
        v = nil; k = nil
    end
    timerHeroMoveStash = nil
    timerHeroMoveStash = {}
end

	local function DestroyObj(Obj)
		display.remove(Obj)
		Obj=nil
	end
	
local function cancelAllFiringTimers()
    local k, v
    for k,v in pairs(playerFile.firing1Timer) do
        timer.cancel( v )
        v = nil; k = nil
    end
    playerFile.firing1Timer = nil
    playerFile.firing1Timer = {}
	--playerFile.firingState = 1
end

function playerFile.hasCollided(obj1, obj2)
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
			
	function playerFile.createBullet1()
		local options = {
		
			width = 16,
			height = 8,
			numFrames = 3,
			
			sheetContentWidth = 48,
			sheetContentHeight = 8
		}
		local imageSheet = graphics.newImageSheet( "media/images/action/bulletsheet1.png", options )
		local sequenceData = {
			{ name="idle", start=1, count=1},
			{ name="progress", start=1, count=3, time=150}
			}
		local bullet1 = display.newSprite( imageSheet, sequenceData, true)
		bullet1.x = 0
		bullet1.y = 0
		bullet1:setSequence("progress")
		bullet1:play()
		return bullet1
	end


local function createExpl1()
	local optionsEx1 = {
	
		width = 36,
		height = 64,
		numFrames = 6,
	
		sheetContentWidth = 216,
		sheetContentHeight = 64
	}
	local imageSheetEx1 = graphics.newImageSheet("media/images/action/explosion1.png", optionsEx1, true )
	local sequenceDataEx1 = {
		{ name="idle", start=1, count=1 },
		{ name="progress", start=1, count=6, loopCount=1, time=400 },
		}
	
	local exGren1 = display.newSprite( imageSheetEx1, sequenceDataEx1 )
	exGren1:setSequence("progress")
	exGren1:play()
	exGren1:scale(1.45,1.45)
	
	return exGren1
end
	
local function createShotg1()
	local optionsSG1 = {
	
		width = 64,
		height = 40,
		numFrames = 12,
	
		sheetContentWidth = 768,
		sheetContentHeight = 40
	}
	local imageSheetSG1 = graphics.newImageSheet("media/images/action/shotgunsheet1.png", optionsSG1, true )
	local sequenceDataSG1 = {
		{ name="idle", start=1, count=1 },
		{ name="progress", start=1, count=12, loopCount=1, time=500 },
		{ name="progress2", frames={1,2,3,4,5,6,7,8,9,10,10,10,11,11,11,12,12,12}, loopCount=1, time=450 },
		}
	
	local exShotg1 = display.newSprite( imageSheetSG1, sequenceDataSG1 )
	exShotg1:setSequence("progress2")
	exShotg1:play()
	exShotg1:scale(1.75,1.25)
	
	return exShotg1
end
	
local function createFlameT1()
	local optionsFL1 = {
	
		width = 67,
		height = 38,
		numFrames = 12,
	
		sheetContentWidth = 804,
		sheetContentHeight = 38
	}
	local imageSheetFL1 = graphics.newImageSheet("media/images/action/flamethrower1sheet.png", optionsFL1, true )
	local sequenceDataFL1 = {
		{ name="low", start=1, count=1 },
		{ name="progress", start=1, count=12, loopCount=1, time=200 },
		{ name="ignite", start=1, count=8, loopCount=1, time=120 },
		{ name="douse", frames={8,7,6,5,4,3,2,1}, loopCount=1, time=120 },
		{ name="high", start=8, count=1},
		{ name="fire", start=7, count=2, loopCount=0, time=500 },
		}
	
	local exFlameT1 = display.newSprite( imageSheetFL1, sequenceDataFL1 )
	exFlameT1:setSequence("progress")
	exFlameT1:play()
	
	return exFlameT1
end
	
local function createRocket1()
	local optionsRT1 = {
	
		width = 48,
		height = 28,
		numFrames = 2,
	
		sheetContentWidth = 96,
		sheetContentHeight = 28
	}
	local imageSheetRT1 = graphics.newImageSheet("media/images/action/rocket1sheet.png", optionsRT1, true )
	local sequenceDataRT1 = {
		{ name="idle", start=1, count=1 },
		{ name="progress", start=1, count=2, loopCount=0, time=150 },
		}
	
	local exRockt1 = display.newSprite( imageSheetRT1, sequenceDataRT1 )
	exRockt1:setSequence("idle")
	exRockt1:play()
	--exRockt1:scale(1.75,1.5)
	
	return exRockt1
end
	
local function createSwitch1()
	local optionsBS1 = {
	
		width = 22,
		height = 22,
		numFrames = 2,
	
		sheetContentWidth = 44,
		sheetContentHeight = 22
	}
	local imageSheetBS1 = graphics.newImageSheet("media/images/action/buttonstack1.png", optionsBS1, true )
	local sequenceDataBS1 = {
		{ name="sword", start=1, count=1 },
		{ name="gun", start=2, count=1 },
		}
	
	local buttonswitch1 = display.newSprite( imageSheetBS1, sequenceDataBS1 )
	buttonswitch1:setSequence("gun")
	buttonswitch1:play()
	buttonswitch1:scale(1.25,1.25)
	
	return buttonswitch1
end
	

local function createHeroBottomA()
	local optionsH2 = {
	
		width = 64,
		height = 64,
		numFrames = 64,
	
		sheetContentWidth = 512,
		sheetContentHeight = 512
	}
	local imageSheetH2 = graphics.newImageSheet("media/images/player/phabigsheet62a.png", optionsH2, true )
	local sequenceDataH2 = {
		{ name="blank", start=62, count=1 },
		{ name="idle", start=4, count=1 },
		{ name="walking", start=3, count=3, loopDirection = "bounce", time=xDa },
		{ name="running", start=6, count=4, time=xDa*1.5 },
		{ name="runningfire", start=6, count=4, time=xDa*1.5 },
		{ name="ready", start=4, count=1 },
		{ name="jumping", frames={ 20,21,22,23,24,25,26,26,26,23,22,21,20,19,18,17,18,19,20,21,22,23,24,25,26,25,24,23,22,21,20,19,18,17,18,19,20,21,22,23,24,25,26,25,24,23,22,21,19,18,17,18,19,20 }, loopDirection = "bounce", time=2700 },
		{ name="jumpingfire", frames={ 20,21,22,23,24,25,26,26,26,23,22,21,20,19,18,17,18,19,20,21,22,23,24,25,26,25,24,23,22,21,20,19,18,17,18,19,20,21,22,23,24,25,26,25,24,23,22,21,19,18,17,18,19,20 }, loopDirection = "bounce", time=2700 },
		}
	
	playerFile.heroBottomA = display.newSprite( imageSheetH2, sequenceDataH2 )
	playerFile.heroBottomA:setReferencePoint(display.CenterReferencePoint)
	playerFile.heroBottomA.x = 1100
	playerFile.heroBottomA.y = -50
	playerFile.heroBottomA.isFixedRotation = true
	playerFile.heroBottomA:setSequence("jumping")
	playerFile.heroBottomA:play()
end
local function createHeroBottomB()
	local optionsH2 = {
	
		width = 64,
		height = 64,
		numFrames = 64,
	
		sheetContentWidth = 512,
		sheetContentHeight = 512
	}
	local imageSheetH2 = graphics.newImageSheet("media/images/player/phabigsheet62b.png", optionsH2, true )
	local sequenceDataH2 = {
		{ name="blank", start=62, count=1 },
		{ name="idle", start=4, count=1 },
		{ name="walking", start=3, count=3, loopDirection = "bounce", time=xDa },
		{ name="running", start=6, count=4, time=xDa*1.5 },
		{ name="runningfire", start=6, count=4, time=xDa*1.5 },
		{ name="ready", start=4, count=1 },
		{ name="jumping", frames={ 20,21,22,23,24,25,26,26,26,23,22,21,20,19,18,17,18,19,20,21,22,23,24,25,26,25,24,23,22,21,20,19,18,17,18,19,20,21,22,23,24,25,26,25,24,23,22,21,19,18,17,18,19,20 }, loopDirection = "bounce", time=2700 },
		{ name="jumpingfire", frames={ 20,21,22,23,24,25,26,26,26,23,22,21,20,19,18,17,18,19,20,21,22,23,24,25,26,25,24,23,22,21,20,19,18,17,18,19,20,21,22,23,24,25,26,25,24,23,22,21,19,18,17,18,19,20 }, loopDirection = "bounce", time=2700 },
		}
	
	playerFile.heroBottomB = display.newSprite( imageSheetH2, sequenceDataH2 )
	playerFile.heroBottomB:setReferencePoint(display.CenterReferencePoint)
	playerFile.heroBottomB.x = 1100
	playerFile.heroBottomB.y = -50
	playerFile.heroBottomB.isFixedRotation = true
	playerFile.heroBottomB:setSequence("jumping")
	playerFile.heroBottomB:play()
		playerFile.heroBottomB:setFillColor(0,255,0)
end

local function createHeroTopA()
	local optionsH1a = {
	
		width = 64,
		height = 64,
		numFrames = 64,
	
		sheetContentWidth = 512,
		sheetContentHeight = 512
	}
	local imageSheetH1a = graphics.newImageSheet("media/images/player/phabigsheet62a.png", optionsH1a, true )
	local optionsH1b = {
	
		width = 100,
		height = 64,
		numFrames = 20,
	
		sheetContentWidth = 500,
		sheetContentHeight = 256
	}
	local imageSheetH1b = graphics.newImageSheet("media/images/player/swordattack49a.png", optionsH1b, true )
	local sequenceDataH1 = {
		{ name="blank", sheet=imageSheetH1a, start=62, count=1 },
		{ name="hit1", sheet=imageSheetH1a, start=20, count=1 },
		{ name="kneel", sheet=imageSheetH1a, start=49, count=1 },
		{ name="fallen", sheet=imageSheetH1a, start=50, count=1 },
		{ name="idleGun", sheet=imageSheetH1a, start=1, count=1 },
		{ name="idleSword", sheet=imageSheetH1a, start=39, count=1 },
		{ name="walking", sheet=imageSheetH1a, start=1, count=1 },
		{ name="runningGun", sheet=imageSheetH1a, frames={10,11,10,11}, time=xDa*1.5 },
		{ name="runningSword", sheet=imageSheetH1a, frames={42,43,44,41}, time=xDa*1.5 },
		{ name="runningfire", sheet=imageSheetH1a, frames={12,13,12,13}, loopDirection = "bounce", time=xDa*1.5 },
		{ name="ready", sheet=imageSheetH1a, start=15, count=1 },
		{ name="jumpingGun", sheet=imageSheetH1a, start=2, count=1 },
		{ name="jumpingSword", sheet=imageSheetH1b, start=15, count=1 },
		{ name="jumpingfire", sheet=imageSheetH1a, start=14, count=1 },
		{ name="reload", sheet=imageSheetH1a, frames={1,30,31,32,40,32}, loopDirection = "bounce", loopCount=1, time=600 },
		{ name="loadSword", sheet=imageSheetH1a, frames={1,27,28,29,34,33,34,35,36,37,38,39}, loopCount=1, time=950 },
		{ name="loadGun", sheet=imageSheetH1a, frames={39,38,37,36,35,34,33,34,29,28,27,1,1}, loopCount=1, time=950 },
		{ name="hit2", sheet=imageSheetH1b, start=5, count=1 },
		{ name="swordAttack3", sheet=imageSheetH1b, frames={4,4,3,3,2,2,1,1,11}, loopCount=1, time=xDa},
		{ name="swordAttackRunning", sheet=imageSheetH1b, frames={9,9,9,8,8,7,7,6,6}, loopCount=1, time=xDa},
		{ name="swordAttackJumping", sheet=imageSheetH1b, frames={9,9,9,8,8,7,7,6,6,15}, loopCount=1, time=xDa},
		}
	
	playerFile.heroTopA = display.newSprite( imageSheetH1a, sequenceDataH1 )
	playerFile.heroTopA:setReferencePoint(display.CenterReferencePoint)
	playerFile.heroTopA.x = 1100
	playerFile.heroTopA.y = -50
	playerFile.heroTopA.isFixedRotation = true
	playerFile.heroTopA:setSequence("idleGun")
	playerFile.heroTopA:play()
end
local function createHeroTopB()
	local optionsH1a = {
	
		width = 64,
		height = 64,
		numFrames = 64,
	
		sheetContentWidth = 512,
		sheetContentHeight = 512
	}
	local imageSheetH1a = graphics.newImageSheet("media/images/player/phabigsheet62b.png", optionsH1a, true )
	local optionsH1b = {
	
		width = 100,
		height = 64,
		numFrames = 20,
	
		sheetContentWidth = 500,
		sheetContentHeight = 256
	}
	local imageSheetH1b = graphics.newImageSheet("media/images/player/swordattack49b.png", optionsH1b, true )
	local sequenceDataH1 = {
		{ name="blank", sheet=imageSheetH1a, start=62, count=1 },
		{ name="hit1", sheet=imageSheetH1a, start=20, count=1 },
		{ name="kneel", sheet=imageSheetH1a, start=49, count=1 },
		{ name="fallen", sheet=imageSheetH1a, start=50, count=1 },
		{ name="idleGun", sheet=imageSheetH1a, start=1, count=1 },
		{ name="idleSword", sheet=imageSheetH1a, start=39, count=1 },
		{ name="walking", sheet=imageSheetH1a, start=1, count=1 },
		{ name="runningGun", sheet=imageSheetH1a, frames={10,11,10,11}, time=xDa*1.5 },
		{ name="runningSword", sheet=imageSheetH1a, frames={42,43,44,41}, time=xDa*1.5 },
		{ name="runningfire", sheet=imageSheetH1a, frames={12,13,12,13}, loopDirection = "bounce", time=xDa*1.5 },
		{ name="ready", sheet=imageSheetH1a, start=15, count=1 },
		{ name="jumpingGun", sheet=imageSheetH1a, start=2, count=1 },
		{ name="jumpingSword", sheet=imageSheetH1b, start=15, count=1 },
		{ name="jumpingfire", sheet=imageSheetH1a, start=14, count=1 },
		{ name="reload", sheet=imageSheetH1a, frames={1,30,31,32,40,32}, loopDirection = "bounce", loopCount=1, time=600 },
		{ name="loadSword", sheet=imageSheetH1a, frames={1,27,28,29,34,33,34,35,36,37,38,39}, loopCount=1, time=950 },
		{ name="loadGun", sheet=imageSheetH1a, frames={39,38,37,36,35,34,33,34,29,28,27,1,1}, loopCount=1, time=950 },
		{ name="hit2", sheet=imageSheetH1b, start=5, count=1 },
		{ name="swordAttack3", sheet=imageSheetH1b, frames={4,4,3,3,2,2,1,1,11}, loopCount=1, time=xDa},
		{ name="swordAttackRunning", sheet=imageSheetH1b, frames={9,9,9,8,8,7,7,6,6}, loopCount=1, time=xDa},
		{ name="swordAttackJumping", sheet=imageSheetH1b, frames={9,9,9,8,8,7,7,6,6,15}, loopCount=1, time=xDa},
		}
	
	playerFile.heroTopB = display.newSprite( imageSheetH1a, sequenceDataH1 )
	playerFile.heroTopB:setReferencePoint(display.CenterReferencePoint)
	playerFile.heroTopB.x = 1100
	playerFile.heroTopB.y = -50
	playerFile.heroTopB.isFixedRotation = true
	playerFile.heroTopB:setSequence("idleGun")
	playerFile.heroTopB:play()
		playerFile.heroTopB:setFillColor(0,255,0)
end

local function createHeroHitBox()
	playerFile.herohitBox = display.newRect(0,0,14,56)
	playerFile.herohitBox:setReferencePoint(display.CenterReferencePoint)
	playerFile.herohitBox:setFillColor(0,0,0,0)
	playerFile.herohitBox.canJump = false
	playerFile.herohitBox.hitType = "heroType"
	playerFile.herohitBox.x = playerFile.heroTopA.x 
	playerFile.herohitBox.y = playerFile.heroTopA.y
	physics.addBody(playerFile.herohitBox, { density = 1.9, friction = 0.3, bounce = 0 })
	playerFile.herohitBox.isFixedRotation = true
	playerFile.herohitBox.state = "Idle"
	playerFile.herohitBox.stateWalking = "idle" 
	playerFile.herohitBox.canJump  = "true"
end

	local function checkStateSprite()
		if playerFile.hitPoints <= 0 then
			playerFile.heroBottomA:setSequence("blank")
			playerFile.heroBottomA:play()
			playerFile.heroTopA:setSequence("fallen")
			playerFile.heroTopA:play()
			playerFile.heroBottomB:setSequence("blank")
			playerFile.heroBottomB:play()
			playerFile.heroTopB:setSequence("fallen")
			playerFile.heroTopB:play()
			return true
		end
		if playerFile.firingState == 1 and playerFile.herohitBox.stateWalking == "idle" and playerFile.herohitBox.state == "Idle" and playerFile.herohitBox.canJump == true and playerFile.movingInit == 0 then
			--print("STANDING IDLE")
			playerFile.heroBottomA:setSequence("idle")
			playerFile.heroBottomA:play()
			playerFile.heroBottomB:setSequence("idle")
			playerFile.heroBottomB:play()
				if playerFile.equipState == true then
					return false
				end
				if playerFile.attackState == 1 then
					playerFile.heroTopA:setSequence("idleGun")
					playerFile.heroTopA:play()
					playerFile.heroTopB:setSequence("idleGun")
					playerFile.heroTopB:play()
					return false
				end
				if playerFile.movingInit > 0 then
					return false
				end
				if playerFile.attackState == 2 then
					playerFile.heroTopA:setSequence("idleSword")
					playerFile.heroTopA:play()
					playerFile.heroTopB:setSequence("idleSword")
					playerFile.heroTopB:play()
					return false
				end
			return false
		end
		if playerFile.firingState == 1 and (playerFile.herohitBox.stateWalking == "idle" or playerFile.herohitBox.stateWalking == "walking") and (playerFile.herohitBox.state == "Idle" or playerFile.herohitBox.state == "Walking") and playerFile.herohitBox.canJump == false then
			if playerFile.jumpingInit == 0 then
				playerFile.heroBottomA:setSequence("jumping")
				playerFile.heroBottomA:play()
				playerFile.heroBottomB:setSequence("jumping")
				playerFile.heroBottomB:play()
			
			else
				--print("ALREADY JUMPING BOTTOM")
			end
			--print("STANDING JUMP")
				if playerFile.equipState == true then
					return false
				end
				if playerFile.attackState == 1 then
					playerFile.heroTopA:setSequence("jumpingGun")
					playerFile.heroTopA:play()
					playerFile.heroTopB:setSequence("jumpingGun")
					playerFile.heroTopB:play()
					return false
				end
				if playerFile.attackState == 2 then
					playerFile.heroTopA:setSequence("jumpingSword")
					playerFile.heroTopA:play()
					playerFile.heroTopB:setSequence("jumpingSword")
					playerFile.heroTopB:play()					
					return false
				end
		end
		if playerFile.firingState >= 2 and (playerFile.herohitBox.stateWalking == "idle" or playerFile.herohitBox.stateWalking == "walking") and (playerFile.herohitBox.state == "Idle" or playerFile.herohitBox.state == "Walking") and playerFile.herohitBox.canJump == false then
			--print("JUMPING FIRING RUNNING")
			if playerFile.jumpingInit == 0 then
				playerFile.heroBottomA:setSequence("jumpingfire")
				playerFile.heroBottomA:play()
				playerFile.heroBottomB:setSequence("jumpingfire")
				playerFile.heroBottomB:play()
			
			else
				--print("ALREADY JUMPING BOTTOM")
			end
				if playerFile.equipState == true then
					return false
				end
				if playerFile.attackState == 1 then
					playerFile.heroTopA:setSequence("jumpingfire")
					playerFile.heroTopA:play()
					playerFile.heroTopB:setSequence("jumpingfire")
					playerFile.heroTopB:play()
					return false
				end
				if playerFile.attackState == 2 then
					if playerFile.firingState == 3 then
						return false
					else
						playerFile.heroTopA:setSequence("swordAttackJumping")
						playerFile.heroTopA:play()
						playerFile.heroTopB:setSequence("swordAttackJumping")
						playerFile.heroTopB:play()
						return false
					end
				end
		end
		if playerFile.firingState >= 2 and playerFile.herohitBox.stateWalking == "idle" and playerFile.herohitBox.state == "Idle" and playerFile.herohitBox.canJump == true then
			--print("STANDING FIRING")
				if clipLoad == 0 and playerFile.attackState == 1 then
					--print("RELOAD")
					playerFile.heroTopA:setSequence("reload")
					playerFile.heroTopA:play()
					playerFile.heroTopB:setSequence("reload")
					playerFile.heroTopB:play()
					playerFile.heroBottomA:setSequence("idle")
					playerFile.heroBottomA:play()
					playerFile.heroBottomB:setSequence("idle")
					playerFile.heroBottomB:play()
					return false
				end
			playerFile.heroBottomA:setSequence("idle")
			playerFile.heroBottomA:play()
			playerFile.heroBottomB:setSequence("idle")
			playerFile.heroBottomB:play()
				if playerFile.equipState == true then
					return false
				end
				if playerFile.attackState == 1 then
					playerFile.heroTopA:setSequence("ready")
					playerFile.heroTopA:play()
					playerFile.heroTopB:setSequence("ready")
					playerFile.heroTopB:play()
					return false
				end
				if playerFile.attackState == 2 then
					if playerFile.firingState == 3 then
						playerFile.heroTopA:setSequence("idleSword")
						playerFile.heroTopA:play()
						playerFile.heroTopB:setSequence("idleSword")
						playerFile.heroTopB:play()
						return false
					else
						playerFile.heroTopA:setSequence("swordAttackRunning")
						playerFile.heroTopA:play()
						playerFile.heroTopB:setSequence("swordAttackRunning")
						playerFile.heroTopB:play()
						return false
					end
				end
		end
		if playerFile.firingState == 1 and playerFile.herohitBox.stateWalking == "walking" and playerFile.herohitBox.state == "Walking" and playerFile.herohitBox.canJump == true and playerFile.movingInit == 1 then
			--print("RUNNING NOT FIRING")
			playerFile.heroBottomA:setSequence("running")
			playerFile.heroBottomA:play()
			playerFile.heroBottomB:setSequence("running")
			playerFile.heroBottomB:play()
				if playerFile.equipState == true then
					return false
				end
				if playerFile.attackState == 1 then
					playerFile.heroTopA:setSequence("runningGun")
					playerFile.heroTopA:play()
					playerFile.heroTopB:setSequence("runningGun")
					playerFile.heroTopB:play()
					return false
				end
				if playerFile.attackState == 2 and playerFile.movingInit == 1 then
					playerFile.heroTopA:setSequence("runningSword")
					playerFile.heroTopA:play()
					playerFile.heroTopB:setSequence("runningSword")
					playerFile.heroTopB:play()
					return false
				end
		end
		if playerFile.firingState >= 2 and playerFile.herohitBox.stateWalking == "walking" and playerFile.herohitBox.state == "Walking" and playerFile.herohitBox.canJump == true then
			--print("RUNNING FIRING")
			playerFile.heroBottomA:setSequence("runningfire")
			playerFile.heroBottomA:play()
			playerFile.heroBottomB:setSequence("runningfire")
			playerFile.heroBottomB:play()
				if playerFile.equipState == true then
					return false
				end
				if playerFile.attackState == 1 then
					playerFile.heroTopA:setSequence("runningfire")
					playerFile.heroTopA:play()
					playerFile.heroTopB:setSequence("runningfire")
					playerFile.heroTopB:play()
					return false
				end
				if playerFile.attackState == 2 then
						timerHeroMoveStash[#timerHeroMoveStash+1]=timer.performWithDelay(500, function()
							playerFile.heroTopA:setSequence("runningSword")
							playerFile.heroTopA:play()
							playerFile.heroTopB:setSequence("runningSword")
							playerFile.heroTopB:play()
						end, 1)
					if playerFile.firingState == 2 then
						playerFile.heroTopA:setSequence("swordAttackRunning")
						playerFile.heroTopA:play()
						playerFile.heroTopB:setSequence("swordAttackRunning")
						playerFile.heroTopB:play()
						return false
					end
					return false
				end
		end
	end
	

	function playerFile.touchArrowCheck(self, event)
		if event.x < display.contentCenterX then
             if event.x > self.contentBounds.xMin and
                event.x < self.contentBounds.xMax and
                event.y > self.contentBounds.yMin and
                event.y < self.contentBounds.yMax
				then
                print("Its "..self.id.." IN")
			playerFile.leftArrow.alpha = rhG
			playerFile.rightArrow.alpha = rhG
			self.alpha = rFG
			self._touch_num = self._touch_num + 1
			GameSettings.playerIsMoving = self.idNum
			GameSettings.playerIsFirstMoving = 1
			GameSettings.playerMoveAttack = 1
			GameSettings.playerIsDirection = self.id
			spriteCallNum = spriteCallNum+1
				if self.id == "left" then
					playerFile.movingInit = playerFile.movingInit+1
					playerFile.motionx = -playerFile.speed
					playerFile.motiony = 0
					playerFile.herohitBox.xScale = -1
					TouchMgr:setFocus( playerFile.leftArrow, event.id )
					playerFile.leftArrow._touch_num = playerFile.leftArrow._touch_num + 1
					playerFile.herohitBox.stateWalking = "walking"
					playerFile.herohitBox.state = "Walking"
					playerFile.playMovementMotion = 2
					checkStateSprite()
					playerFile.leftArrow.alpha = .7
					playerFile.rightArrow.alpha = rhG
				end
				if self.id == "right" then
					playerFile.movingInit = playerFile.movingInit+1
					playerFile.motionx = playerFile.speed
					playerFile.motiony = 0
					playerFile.herohitBox.xScale = 1
					TouchMgr:setFocus( playerFile.rightArrow, event.id )
					playerFile.rightArrow._touch_num = playerFile.rightArrow._touch_num + 1
					playerFile.herohitBox.stateWalking = "walking"
					playerFile.herohitBox.state = "Walking"
					playerFile.playMovementMotion = 1
					checkStateSprite()
					playerFile.rightArrow.alpha = .7
					playerFile.leftArrow.alpha = rhG
				end
           end
             if 
				(event.phase == "ended" or event.phase == "cancelled")
				then
                print("Its out")
				if GameSettings.chargeInitiated < 2 then
					--player0:setSequence("stopped")
					--player0:play()
				end
			GameSettings.playerIsMoving = 0
			GameSettings.playerIsFirstMoving = 0
			GameSettings.playerMoveAttack = 0
			GameSettings.playerIsDirection = nil
			spriteCallNum = 0
			self._touch_num = 0
		playerFile.movingInit = 0
		playerFile.motionx = 0
		playerFile.motiony = 0
		playerFile.herohitBox.stateWalking = "idle" 
		playerFile.herohitBox.state = "Idle"
		checkStateSprite()
		playerFile.leftArrow.alpha = rhG
		playerFile.rightArrow.alpha = rhG
		playerFile.playMovementMotion = 0
				--setAlphaButtons()
             end
		end
		return true
	end
	local function deadMoveTouch( self, event)
		if GameSettings.chargeInitiated < 2 then
            --print("Touched "..self.." and stopped movement")
			print("WORKING NOW AAA")
			--player0:setSequence("stopped")
			--player0:play()
			GameSettings.playerIsMoving = 0
			GameSettings.playerIsFirstMoving = 0
			GameSettings.playerMoveAttack = 0
			GameSettings.playerIsDirection = nil
			spriteCallNum = 0
			playerFile.rightArrow._touch_num = 0
			playerFile.leftArrow._touch_num = 0
		playerFile.movingInit = 0
		playerFile.motionx = 0
		playerFile.motiony = 0
		playerFile.herohitBox.stateWalking = "idle" 
		playerFile.herohitBox.state = "Idle"
		checkStateSprite()
		playerFile.leftArrow.alpha = rhG
		playerFile.leftArrow.alpha = rhG
		playerFile.playMovementMotion = 0

			--setAlphaButtons()
		end
	end
	function playerFile.createArrows()
		motionx = 0 
		motiony = 0 
		speed = 4
		GameSettings.canAttackNum = 0
		GameSettings.playerIsMoving = 0
		GameSettings.playerIsDirection = nil
		GameSettings.playerIsFirstMoving = 0
		spriteCallNum = 0
		GameSettings.spriteIsMoving = 1
		GameSettings.spriteMovementTesting = 9
			testPoint5=display.newRect(0,0,180,120)
			testPoint5.x = display.contentWidth / 7.5
			testPoint5.y = ppA+20
			testPoint5.alpha = .01
			testPoint5.touch = deadMoveTouch
			testPoint5:addEventListener("touch", testPoint5)
				GameSettings.DefenseCharge = 0
				xV = 36
				yV = 52		
		playerFile.leftArrow = display.newImageRect("media/images/action/arrow.png", xV,yV, true)
		playerFile.leftArrow.alpha = rhG
		playerFile.leftArrow.id = "left"
		playerFile.leftArrow._touch_num = 0
		playerFile.leftArrow.idNum = 2
		playerFile.leftArrow.touch = playerFile.touchArrowCheck
		playerFile.leftArrow:addEventListener("touch", playerFile.leftArrow)
		playerFile.leftArrow.x = (display.contentWidth / 7.5)-xV
		playerFile.leftArrow.y = ppA+(xV/1.5)
		playerFile.rightArrow = display.newImageRect("media/images/action/arrow.png", xV,yV, true)
		playerFile.rightArrow.xScale = -1
		playerFile.rightArrow.alpha = rhG
		playerFile.rightArrow.id = "right"
		playerFile.rightArrow._touch_num = 0
		playerFile.rightArrow.idNum = 1
		playerFile.rightArrow.touch = playerFile.touchArrowCheck
		playerFile.rightArrow:addEventListener("touch", playerFile.rightArrow)
		playerFile.rightArrow.id = "right"
		playerFile.rightArrow.x = (display.contentWidth / 7.5)+xV
		playerFile.rightArrow.y = ppA+(xV/1.5)
end
local function checkPlayerMotionMovement()
	if playerFile.hitPoints <= 0 then
		print("CHECK PLAYER MOVED REMOVED")
		playerFile.eventid = nil
		playerFile.motionx = 0
		playerFile.motiony = 0
		playerFile.playMovementMotion = 0
		return false
	end
	if playerFile.playMovementMotion == 1 then
		playerFile.motionx = playerFile.speed
		playerFile.motiony = 0
		playerFile.herohitBox.xScale = 1
		playerFile.herohitBox.stateWalking = "walking"
		playerFile.herohitBox.state = "Walking"
		checkStateSprite()
	end
	if playerFile.playMovementMotion == 2 then
		playerFile.motionx = -playerFile.speed
		playerFile.motiony = 0
		playerFile.herohitBox.xScale = -1
		playerFile.herohitBox.stateWalking = "walking" 
		playerFile.herohitBox.state = "Walking"
		checkStateSprite()
	end
	if playerFile.playMovementMotion == 0 then
		playerFile.movingInit = 0		
		playerFile.motionx = 0 
		playerFile.motiony = 0
		playerFile.playMovementMotion = 0
		checkStateSprite()
	end
end

local function createAButton()
playerFile.buttonA = display.newImage("media/images/action/abutton1.png")
playerFile.buttonA.x = display.contentWidth - playerFile.buttonA.width / 2 - 9
playerFile.buttonA.y = display.contentHeight - playerFile.buttonA.height / 2 - 30
playerFile.buttonA.alpha = 0.8
playerFile.buttonAreal = display.newImageRect("media/images/action/abutton1.png",80,80)
playerFile.buttonAreal.x = playerFile.buttonA.x+10
playerFile.buttonAreal.y = playerFile.buttonA.y
playerFile.buttonAreal:setFillColor(0,0,0,0)
	local tp
	playerFile.buttonAreal._touch_num = 0
	playerFile.buttonAreal.touches = {}
end
local function onButtonAPress(event)
	if playerFile.heroDead == true then
	TouchMgr:unregister( playerFile.buttonAreal )
	playerFile.motionx = 0
	playerFile.motiony = 0
		return false
	end
		if event.phase == ("began") then
			playerFile.jumpingInit = playerFile.jumpingInit+1
			print("playerFile.jumpingInit = "..playerFile.jumpingInit)
		end
		if playerFile.herohitBox.canJump and playerFile.jumpStart == 1 then
			playerFile.herohitBox.canJump = false
		end
		if playerFile.herohitBox.canJump then
			if event.phase == ("began") and playerFile.heroDead == false and playerFile.jumpStart < 1 then
				checkStateSprite()
				playerFile.herohitBox:applyLinearImpulse(0, -11.7, playerFile.herohitBox.x, playerFile.herohitBox.y)
				playerFile.herohitBox.state = "Jumping"
				playerFile.jumpStart = 1
				playerFile.jumpingInit = 0
				timer.performWithDelay(2,checkStateSprite,3)
				timer.performWithDelay(300,function()
					playerFile.jumpStart = 0
					checkStateSprite()
				end, 1)
			end
		elseif ( event.phase == 'canceled' or event.phase == 'ended' ) then
			if event.isFocused then
				checkStateSprite()
			TouchMgr:unsetFocus( playerFile.buttonAreal, event.id )
			return true
		end
	end
	return true
end

local function onCollision(self, event )
	local item9 = event.other
	if event.phase == "ended" and event.other.platType == "ground" and item9.platType == "wall" then
		if event.other.myName == "playerFile.bolt" then
			print("++++++++++TOUCHED BLADE++++++++")
			return false
		end
		checkPlayerMotionMovement()
		playerFile.herohitBox.canJump = true
		checkStateSprite()
		return false
	end
	if event.phase == "began" and self.y < item9.y and event.other.platType == "ground" then
		if event.other.myName == "playerFile.bolt" then
			print("++++++++++TOUCHED BLADE++++++++")
			return false
		end
		checkPlayerMotionMovement()
		playerFile.herohitBox.canJump = true
		playerFile.jumpingInit = 0
		playerFile.jumpStart = 0
			if playerFile.playMovementMotion > 0 then
				playerFile.movingInit = 1
			end
		checkStateSprite()
		print("TOUCHED GROUND!")
		return false
	end
	if event.phase == "began" and self.y+22 < item9.y and event.other.platType == "platform" and (self.x <= item9.x+ggP and self.x >= item9.x-ggP) then
		if event.other.myName == "playerFile.bolt" then
			print("++++++++++TOUCHED BLADE++++++++")
			return false
		end
		checkPlayerMotionMovement()
		playerFile.herohitBox.canJump = true
		playerFile.jumpingInit = 0
		playerFile.jumpStart = 0
			if playerFile.playMovementMotion > 0 then
				playerFile.movingInit = 1
			end
		checkStateSprite()
		--print("TOUCHED PLATFORM!")
		print("player.y = "..self.y)
		print("platform.y = "..item9.y)
		return false
	end
	if event.phase == "ended" and self.y < item9.y then
		playerY1 = playerFile.herohitBox.y
		if event.other.myName == "playerFile.bolt" then
			print("++++++++++TOUCHED BLADE++++++++")
			return false
		end
			--[[
				if playerY1 > playerFile.herohitBox.y then
					checkPlayerMotionMovement()
					playerFile.herohitBox.canJump = false
					playerFile.herohitBox.state = "Idle"
					checkStateSprite()
					print("END OF PLAYER JUMP COLLISION FUNCTION")
				end
			]]
			FALLINGOFFTIMER = timer.performWithDelay(20, function()
				if playerFile.herohitBox.y >= playerY1+1.5 then
					checkPlayerMotionMovement()
					playerFile.herohitBox.canJump = false
					playerFile.herohitBox.state = "Idle"
					checkStateSprite()
					timer.cancel(FALLINGOFFTIMER)
					print("FALLING OFF OBJECT")
				end
					--[[
					print("player.y = "..tostring(playerFile.herohitBox.y))
					print("item9.y = "..tostring(item9.y))
					print("playerY1 = "..tostring(playerY1))
					print("---------------------------------------------------------")
					]]
			end, 3)
			STILLONTIMER = timer.performWithDelay(30, function()
				if playerFile.herohitBox.y >= playerY1-.5 and playerFile.herohitBox.y <= playerY1+.5 then
					checkPlayerMotionMovement()
					playerFile.herohitBox.canJump = true
					playerFile.jumpingInit = 0
					playerFile.jumpStart = 0
					timer.cancel(STILLONTIMER)
						if playerFile.playMovementMotion > 0 then
							playerFile.movingInit = 1
						end
					print("STILL ON OBJECT")
				end
					--[[
					print("player.y = "..tostring(playerFile.herohitBox.y))
					print("item9.y = "..tostring(item9.y))
					print("playerY1 = "..tostring(playerY1))
					print("---------------------------------------------------------")
					]]
			end, 3)
			timer.performWithDelay(15, function()
				if playerY1 > playerFile.herohitBox.y then
					checkPlayerMotionMovement()
					playerFile.herohitBox.canJump = false
					playerFile.herohitBox.state = "Idle"
					checkStateSprite()
					print("END OF PLAYER JUMP COLLISION FUNCTION")
				end
			end, 2)
		return false
	end
	if event.phase == "began" and self.y > item9.y and playerFile.herohitBox.canJump == false then
		checkPlayerMotionMovement()
		playerFile.herohitBox.canJump = false
		checkStateSprite()
		return false
	end
	if event.phase == "ended" and self.y > item9.y and playerFile.herohitBox.canJump == false then
		checkPlayerMotionMovement()
		playerFile.herohitBox.canJump = false
		checkStateSprite()
		return false
	end
end


local function endSpSeq()
	playerFile.heroBottomA:setSequence("blank")
	playerFile.heroBottomA:play()
	playerFile.heroBottomB:setSequence("blank")
	playerFile.heroBottomB:play()
	playerFile.heroTopA:setSequence("fallen")
	playerFile.heroTopA:play()
	playerFile.heroTopB:setSequence("fallen")
	playerFile.heroTopB:play()
		timer.performWithDelay(500, function()
			Runtime:removeEventListener("enterFrame", playerFile.endSpSeq)
		end, 1)

end
local function movingMotion()
playerFile.herohitBox.x = playerFile.herohitBox.x + playerFile.motionx
playerFile.herohitBox.y = playerFile.herohitBox.y + playerFile.motiony
	if playerFile.hitPoints <= 0 then
		Runtime:addEventListener("enterFrame", playerFile.endSpSeq)
		playerFile.heroBottomA:setSequence("blank")
		playerFile.heroBottomA:play()
		playerFile.heroBottomB:setSequence("blank")
		playerFile.heroBottomB:play()
		playerFile.heroTopA:setSequence("fallen")
		playerFile.heroTopA:play()
		playerFile.heroTopB:setSequence("fallen")
		playerFile.heroTopB:play()
		playerFile.motionx = 0
		playerFile.motiony = 0
		playerFile.scoreAmount = 0
		Runtime:removeEventListener("enterFrame", playerFile.movingMotion)	
	end
	if playerFile.enemyCollType == 1 then
		playerFile.heroBottomA:setSequence("hit1")
		playerFile.heroBottomA:play()
		playerFile.heroBottomB:setSequence("hit1")
		playerFile.heroBottomB:play()
		playerFile.heroTopA:setSequence("hit2")
		playerFile.heroTopA:play()
		playerFile.heroTopB:setSequence("hit2")
		playerFile.heroTopB:play()
		playerFile.motionx = 0
		playerFile.motiony = 0
	end
end


	function playerFile.createAttackTypeButton()
		--[[
		playerFile.attackTypeRect = display.newRect(0,0,80,20)
		playerFile.attackTypeRect.x = display.contentCenterX-70
		playerFile.attackTypeRect.y = display.contentCenterY*1.8
		playerFile.attackTypeRect:addEventListener("touch", changeAttackType)
		]]
		playerFile.attackTypeRect = createSwitch1()
		playerFile.attackTypeRect.x = display.contentWidth - playerFile.attackTypeRect.width / .62 + 10
		playerFile.attackTypeRect.y = display.contentHeight - playerFile.attackTypeRect.height / 1.75 - 5
		playerFile.attackTypeRect.alpha = 0.8
	end

	local function gunShot(yT) -- yT is the projectile counter which is being shot, and needs to be incremented upwards. 
		if GameSettings.lockStatus == false then
			GameSettings.lockStatus = true
			--playerFile.projThrow1[yT] = display.newRect(0,0,20,10)
			playerFile.projThrow1[yT] = playerFile.createBullet1()
			playerFile.projThrow1[yT].alpha = 1
			playerFile.projThrow1[yT].x = playerFile.heroTopB.x+(GameSettings.armXPF*playerFile.herohitBox.xScale)
			playerFile.projThrow1[yT].y = playerFile.heroTopB.y-(GameSettings.armYPF)
			playerFile.projThrow1[yT].gravityScale = 0
			physics.addBody(playerFile.projThrow1[yT], "kinematic", { density = .25, friction = 0, bounce = 0, isSensor = true })
			GameSettings.game:insert(playerFile.projThrow1[yT])
					local function moveShot(obj)
						--obj.y = 1800
						display.remove(obj)
						obj=nil
					end
				--heroChargeStash[#heroChargeStash+1] = transition.to(playerFile.projThrow1[yT], {time=420,x=playerFile.heroTopB.x+(120*playerFile.heroTopB.xScale), onComplete=moveShot})
				heroChargeStash[#heroChargeStash+1] = transition.to(playerFile.projThrow1[yT], {time=lFa+80,onComplete=moveShot})
				playerFile.projThrow1[yT]:setLinearVelocity(playerFile.projThrow1[yT].xScale*(350*playerFile.herohitBox.xScale), (playerFile.projThrow1[yT].yScale*1), playerFile.projThrow1[yT].x, playerFile.projThrow1[yT].y)
			timer.performWithDelay(lFa/2, function()
				GameSettings.lockStatus = false
			end, 1)
		end
	end
	local function buttonBtouch(event)
			playerFile.firingState = 2
			checkStateSprite()
		GameSettings.bulletCount = GameSettings.bulletCount+1
		gunShot(GameSettings.bulletCount)
	end
local function createBButton()
	playerFile.buttonB = display.newImage("media/images/action/bbutton1.png")
	playerFile.buttonB.x = display.contentWidth - playerFile.buttonB.width/2-70
	playerFile.buttonB.y = display.contentHeight - playerFile.buttonB.height/2-5
	playerFile.buttonB.alpha = 0.8
	playerFile.buttonBreal = display.newImageRect("media/images/action/bbutton1.png",80,80)
	playerFile.buttonBreal.x = display.contentWidth - playerFile.buttonB.width/2-80
	playerFile.buttonBreal.y = display.contentHeight - playerFile.buttonB.height/2-5
	playerFile.buttonBreal:setFillColor(0,0,0,0)
	playerFile.buttonB:addEventListener("touch",buttonBtouch)

end
	local function removeHUD()
		print("TOUCH REMOVED")
		playerFile.playMovementMotion = 0
		delSpawn()
		TouchMgr:unregister( playerFile.buttonAreal )
		playerFile.eventid = nil
		playerFile.motionx = 0
		playerFile.motiony = 0
		transition.to((game3), {time=250, delay=500, alpha=0, onComplete=DestroyObj})
		transition.to((playerFile.leftArrow), {time=250, delay=1500, alpha=0, onComplete=DestroyObj})
		transition.to((playerFile.rightArrow), {time=250, delay=1500, alpha=0, onComplete=DestroyObj})
		transition.to((playerFile.attackTypeRect), {time=250, delay=500, alpha=0, onComplete=DestroyObj})
		transition.to((playerFile.buttonA), {time=250, delay=500, alpha=0, onComplete=DestroyObj})
		transition.to((playerFile.buttonAreal), {time=250, delay=500, alpha=0, onComplete=DestroyObj})
		transition.to((playerFile.buttonB), {time=250, delay=500, alpha=0, onComplete=DestroyObj})
		transition.to((playerFile.buttonBreal), {time=250, delay=500, alpha=0, onComplete=DestroyObj})
		transition.to(playerFile.heroBottomA, {time=250, delay=500, alpha=0, onComplete=DestroyObj})
		transition.to(playerFile.heroBottomB, {time=250, delay=500, alpha=0, onComplete=DestroyObj})
		transition.to(playerFile.heroTopA, {time=250, delay=500, alpha=0, onComplete=DestroyObj})
		transition.to(playerFile.heroTopB, {time=250, delay=500, alpha=0, onComplete=DestroyObj})
		transition.to(playerFile.herohitBox, {time=250, delay=350, alpha=0, onComplete=DestroyObj})
		
	end
	
local function callInvincTimer1()
	if playerFile.statusIdent == 2 then
		invinceStatusIdent = 5
		local statusText = display.newText(invinceStatusIdent, display.contentWidth/2, display.screenOriginY+20, fontName, 20)
		invincetimer1 = timer.performWithDelay(1000, function()
			invinceStatusIdent = invinceStatusIdent-1
			statusText.text = invinceStatusIdent
			print(invinceStatusIdent)
				if invinceStatusIdent == -1 then
					timer.cancel(invincetimer1)
					statusText:removeSelf()
					statusText=nil
				end
		end, 6)
	end
end

playerFile.clearHealthBar = clearHealthBar
playerFile.createHealthBar = createHealthBar
playerFile.endSpSeq = endSpSeq
playerFile.spawnTest = spawnTest
playerFile.leftMove = leftMove
playerFile.rightMove = rightMove
playerFile.delSpawn = delSpawn
playerFile.killScore = killScore
playerFile.removeHUD = removeHUD
playerFile.onShotSpawn = onShotSpawn
playerFile.plateIdent = plateIdent
playerFile.createBButton = createBButton
playerFile.changeGunType2 = changeGunType2
playerFile.createAttackTypeButton = createAttackTypeButton
playerFile.cancelAllFiringTimers = cancelAllFiringTimers
playerFile.movementMon = movementMon
playerFile.createAButton = createAButton
playerFile.keepScore = keepScore
playerFile.onCollision = onCollision
playerFile.onButtonAPress = onButtonAPress
playerFile.checkPlayerMotionMovement = checkPlayerMotionMovement
playerFile.createHeroHitBox = createHeroHitBox
playerFile.createHeroBottomA = createHeroBottomA
playerFile.createHeroBottomB = createHeroBottomB
playerFile.createHeroTopA = createHeroTopA
playerFile.createHeroTopB = createHeroTopB
playerFile.checkStateSprite = checkStateSprite
playerFile.callInvincTimer1 = callInvincTimer1
playerFile.movingMotion = movingMotion
playerFile.enemyCollision = enemyCollision
playerFile.createLeftArrow = createLeftArrow
playerFile.createRightArrow = createRightArrow

return playerFile