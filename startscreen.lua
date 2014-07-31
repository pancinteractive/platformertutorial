--startscreen.lua

local playerfile = require( "playerfile" )
local storyboard = require "storyboard"
local TouchMgr = require( "dmc_touchmanager" )
local enemies = require( "enemies" )
local CP = require( "colorpicking" )
local scene = storyboard.newScene()
local group = display.newGroup();
local fontName = "Xolonium"
				--[[
				picker.m_r = 120
				picker.m_g = 120
				picker.m_b = 120
				]]
	function scene:createScene( event )
		local group = self.view
		
		local S = display.newText("S",-150,0,fontName, 50)
		local O = display.newText("O",-150,0,fontName, 50)
		local F = display.newText("F",-150,0,fontName, 50)
		local T = display.newText("T",-150,0,fontName, 50)
		local W = display.newText("W",-150,0,fontName, 50)
		local A = display.newText("A",-150,0,fontName, 50)
		local R = display.newText("R",-150,0,fontName, 50)
		local _ = display.newText("_",-150,0,fontName, 50)
		
		transition.to(S, {time=1000, delay=250, x=30})
		transition.to(O, {time=1000, delay=250, x=70})
		transition.to(F, {time=1000, delay=250, x=110})
		transition.to(T, {time=1000, delay=250, x=150})
		transition.to(W, {time=1000, delay=250, x=200})
		transition.to(A, {time=1000, delay=250, x=243})
		transition.to(R, {time=1000, delay=250, x=285})
		transition.to(_, {time=1000, delay=1250, x=325})
		
		local function startPlay(self, event)
			if event.phase == "ended" then
				storyboard.gotoScene("levelselect", options)
			end
		end
		
local startButton = display.newText("START ",0,0,fontName, 40)
startButton.x = display.contentWidth/2
startButton.y = display.contentCenterY*1.5
startButton.alpha = 0
startButton.touch = startPlay
startButton:addEventListener("touch", startButton)
group:insert(startButton)
transition.to(startButton, {time=1000, delay=1500, alpha=1})

group:insert(S)
group:insert(O)
group:insert(F)
group:insert(T)
group:insert(W)
group:insert(A)
group:insert(R)
group:insert(_)

local blackRect = display.newRect(0,0,50,94)
blackRect.x = -70
blackRect.y = 0
blackRect:setFillColor(0)
group:insert(blackRect)

		local function trans1()
			local function trans2()
				transition.to(blackRect, {time=4000,delay=1000, x=650,onComplete=trans1})
			end
			transition.to(blackRect, {time=4000, delay=1000, x=-65, onComplete=trans2})
		end
		local function trans3()
			local function trans4()
				transition.to(_, {time=500, alpha=0,onComplete=trans3})
			end
			transition.to(_, {time=500, alpha=1, onComplete=trans4})
		end
		timer.performWithDelay(2000, trans3,1)
		timer.performWithDelay(2500, trans1,1)


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
