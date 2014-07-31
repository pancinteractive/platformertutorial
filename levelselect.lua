--levelselect.lua

local playerfile = require( "playerfile" )
local storyboard = require "storyboard"
local TouchMgr = require( "dmc_touchmanager" )
local enemies = require( "enemies" )
local CP = require( "colorpicking" )
local scene = storyboard.newScene()
local group = display.newGroup();
local fontName = "Xolonium"

	function scene:createScene( event )
		local group = self.view
		
		local back = {}
		for i=1, 6 do	
			back[i] = display.newImage("media/images/background/bg1.png")
			back[i].x = 100+(i*144)
			back[i].y = 100
			group:insert(back[i])
		end
		
		
		local S = display.newText("S",-150,0,fontName, 50)
		local E1 = display.newText("E",-150,0,fontName, 50)
		local L = display.newText("L",-150,0,fontName, 50)
		local E = display.newText("E",-150,0,fontName, 50)
		local C = display.newText("C",-150,0,fontName, 50)
		local T = display.newText("T",-150,0,fontName, 50)
		local _ = display.newText("_",-150,0,fontName, 50)
		
		local your_world = display.newText("Your World",1000,1000,fontName, 30)
		your_world.x = -150
		your_world.y = display.screenOriginY+80
		
		transition.to(S, {time=1000, delay=250, x=30})
		transition.to(E1, {time=1000, delay=250, x=70})
		transition.to(L, {time=1000, delay=250, x=110})
		transition.to(E, {time=1000, delay=250, x=150})
		transition.to(C, {time=1000, delay=250, x=190})
		transition.to(T, {time=1000, delay=250, x=233})
		transition.to(_, {time=1000, delay=1250, x=265})
		transition.to(your_world, {time=1000, delay=1500, x=325})
		
		local planetFile = {
		"media/images/background/planet1a.png",
		"media/images/background/planet1b.png",
		"media/images/background/planet1c.png",
		}
		local planetImg = {}
		local function createPlanets()
			for i=1, #planetFile do
				--print("planetFile = "..tostring(planetFile[i]))
				planetImg[i] = display.newImageRect(planetFile[i], 125,125)
				planetImg[i].x = (display.screenOriginX-70)+(i*170)
				planetImg[i].y = display.contentHeight/2
				planetImg[i].id = i
				group:insert(planetImg[i])
				local function sendTouch(self, event)
					if event.phase == "ended" then
						print("self.id = "..self.id)
						GameSettings.planetTr = self.id
						storyboard.gotoScene("firstlevel", options)
					end
				end
				planetImg[i].touch = sendTouch
				planetImg[i]:addEventListener("touch", planetImg[i])
			end
		end
		createPlanets()		

group:insert(S)
group:insert(E1)
group:insert(L)
group:insert(E)
group:insert(C)
group:insert(T)
group:insert(_)
group:insert(your_world)


end
function scene:enterScene( event )
	local group = self.view
end

function scene:exitScene( event )
	local group = self.view

	end

function scene:destroyScene( event )
	local group = self.view
end

scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "destroyScene", scene )

return scene
