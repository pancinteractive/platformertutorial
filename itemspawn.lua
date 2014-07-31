--itemspawn.lua

local playerfile = require( "playerfile" )
local fontName = "Xolonium"
local ggF = 34

local iS = {}

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

	local function DestroyObj(Obj)
		display.remove(Obj)
		Obj=nil
	end
	
local function createGunEnItem(gD)
	local gunEnUpLevel1

	if gD == 1 then
		gunEnUpLevel1 = display.newImageRect("media/images/item/gun/singleshot4.png", 32,32)
		gunEnUpLevel1.x = 0
		gunEnUpLevel1.y = 0
	end
	if gD == 2 then
		gunEnUpLevel1 = display.newImageRect("media/images/item/gun/grenade4.png", 32,32)
		gunEnUpLevel1.x = 0
		gunEnUpLevel1.y = 0
	end
	if gD == 3 then
		gunEnUpLevel1 = display.newImageRect("media/images/item/gun/shotgun4.png", 32,32)
		gunEnUpLevel1.x = 0
		gunEnUpLevel1.y = 0
	end
	if gD == 4 then
		gunEnUpLevel1 = display.newImageRect("media/images/item/gun/rapidfire4.png", 32,32)
		gunEnUpLevel1.x = 0
		gunEnUpLevel1.y = 0
	end
	if gD == 5 then
		gunEnUpLevel1 = display.newImageRect("media/images/item/gun/rocket4.png", 32,32)
		gunEnUpLevel1.x = 0
		gunEnUpLevel1.y = 0
	end
	if gD == 6 then
		gunEnUpLevel1 = display.newImageRect("media/images/item/gun/flamethrower4.png", 32,32)
		gunEnUpLevel1.x = 0
		gunEnUpLevel1.y = 0
	end
	if gD == 7 then
		gunEnUpLevel1 = display.newImageRect("media/images/item/gun/emp4.png", 32,32)
		gunEnUpLevel1.x = 0
		gunEnUpLevel1.y = 0
	end
		local function checkOnPlayerEMPColl()
				if playerfile.hitPoints <= 0 then
					Runtime:removeEventListener("enterFrame", checkOnPlayerEMPColl)
					gunEnUpLevel1:removeSelf()
					gunEnUpLevel1=nil
					return true
				end
		if playerfile.gunType > 0 then
			if hasCollided(gunEnUpLevel1, playerfile.herohitBox) then
				--music.levelClearSound()
				local gunEnCollText
					if gD == 1 then
						playerfile.gunType = 1
						gunEnCollText = display.newEmbossedText("SINGLE SHOT!", 0,0,fontName, ggF)
					end
					if gD == 2 then
						playerfile.gunType = 2
						gunEnCollText = display.newEmbossedText("GRENADE LAUNCHER!", 0,0,fontName, ggF)
					end
					if gD == 3 then
						playerfile.gunType = 3
						gunEnCollText = display.newEmbossedText("SHOTGUN!", 0,0,fontName, ggF)
					end
					if gD == 4 then
						playerfile.gunType = 4
						gunEnCollText = display.newEmbossedText("RAPID FIRE!", 0,0,fontName, ggF)
					end
					if gD == 5 then
						playerfile.gunType = 5
						gunEnCollText = display.newEmbossedText("ROCKET LAUNCHER!", 0,0,fontName, ggF)
					end
					if gD == 6 then
						playerfile.gunType = 6
						gunEnCollText = display.newEmbossedText("FLAMETHROWER!", 0,0,fontName, ggF)
					end
					if gD == 7 then
						playerfile.gunType = 7
						gunEnCollText = display.newEmbossedText("ELECTRO-MAGNETIC PULSE!", 0,0,fontName, ggF)
					end
				gunEnCollText.x = display.contentCenterX
				gunEnCollText.y = display.screenOriginY+140
				gunEnCollText:setFillColor(255,232,0)
				gunEnCollText:setEmbossColor(color1)
				transition.to(gunEnCollText, {time=2000, y=gunEnCollText.y-100, alpha=0, onComplete=DestroyObj})
				transition.to(gunEnUpLevel1, {time=150, onComplete=DestroyObj})
				Runtime:removeEventListener("enterFrame", checkOnPlayerEMPColl)
			end
		end
	end
    local function DestroyObjEMP(Obj)
 	Runtime:removeEventListener("enterFrame", checkOnPlayerEMPColl)
       display.remove(Obj)
        Obj = nil
	end
	Runtime:addEventListener("enterFrame", checkOnPlayerEMPColl)
			--transition.to(gunEnUpLevel1, {time=1000, delay=15000, onComplete=DestroyObjEMP})
	return gunEnUpLevel1
end

local function createHealthEnItem(gF)
	local healthEnUpLevel1

	if gF == 1 then
		healthEnUpLevel1 = display.newImageRect("media/images/item/powerups/firstaid3.png", 32,32)
		healthEnUpLevel1.x = 0
		healthEnUpLevel1.y = 0
	end
	if gF == 2 then
		healthEnUpLevel1 = display.newImageRect("media/images/item/powerups/invincible3.png", 32,32)
		healthEnUpLevel1.x = 0
		healthEnUpLevel1.y = 0
	end
	if gF == 3 then
		healthEnUpLevel1 = display.newImageRect("media/images/item/powerups/unlimitedammo2.png", 32,32)
		healthEnUpLevel1.x = 0
		healthEnUpLevel1.y = 0
	end
		local function checkOnPlayerHEALTHColl()
				if playerfile.hitPoints <= 0 then
					Runtime:removeEventListener("enterFrame", checkOnPlayerHEALTHColl)
					healthEnUpLevel1:removeSelf()
					healthEnUpLevel1=nil
					return true
				end
			if hasCollided(healthEnUpLevel1, playerfile.herohitBox) then
				--music.levelClearSound()

					if gF == 1 then
						playerfile.hitPoints = 3
						playerfile.clearHealthBar()
						playerfile.createHealthBar()
						itemUpText = "FIRST AID!"
					end
					if gF == 2 then
						playerfile.hitPoints = 3
						playerfile.statusIdent = 2
						playerfile.clearHealthBar()
						playerfile.createHealthBar()
						playerfile.callInvincTimer1()
						itemUpText = "INVINCIBLE!"
							timer.performWithDelay(5000, function()
								playerfile.statusIdent = 1
							end, 1)
					end
					if gF == 3 then
						--playerfile.ammoAmt = playerfile.ammoAmt+10
						--playerfile.clipSize = playerfile.clipSize+10
						--playerfile.onShotSpawn()
						--playerfile.delSpawn()
						--playerfile.spawnTest()
						itemUpText="MORE AMMO!"
					end
				local healthEnCollText = display.newEmbossedText(itemUpText, 0,0,fontName, ggF)
				healthEnCollText.x = display.contentCenterX
				healthEnCollText.y = display.screenOriginY+140
				--healthEnCollText:setFillColor(255)
				healthEnCollText:setFillColor(255,232,0)
				healthEnCollText:setEmbossColor(color1)
				transition.to(healthEnCollText, {time=2000, y=healthEnCollText.y-100, alpha=0, onComplete=DestroyObj})
				transition.to(healthEnUpLevel1, {time=150, onComplete=DestroyObj})
				Runtime:removeEventListener("enterFrame", checkOnPlayerHEALTHColl)
			end
		end
    local function DestroyObjHEALTH(Obj)
 	Runtime:removeEventListener("enterFrame", checkOnPlayerHEALTHColl)
       display.remove(Obj)
        Obj = nil
	end
	Runtime:addEventListener("enterFrame", checkOnPlayerHEALTHColl)
			--transition.to(healthEnUpLevel1, {time=1000, delay=15000, onComplete=DestroyObjHEALTH})
	return healthEnUpLevel1
end

iS.createGrenadeUpItem = createGrenadeUpItem
iS.createShotgunUpItem = createShotgunUpItem
iS.createRapidfireUpItem = createRapidfireUpItem
iS.createRocketUpItem = createRocketUpItem
iS.createFlamethrowerUpItem = createFlamethrowerUpItem
iS.createEMPUpItem = createEMPUpItem
iS.createGunEnItem = createGunEnItem
iS.createHealthEnItem = createHealthEnItem

return iS