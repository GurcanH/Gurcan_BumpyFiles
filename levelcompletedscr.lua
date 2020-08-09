---------------------------------------------------------------------------------------
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local screenW, screenH = display.contentWidth, display.contentHeight
local friction = 0.4
local gravity = .05
local speedX, speedY, prevX, prevY, lastTime, prevTime = 0, 0, 0, 0, 0, 0
groupLCLayer = display.newGroup()


local levelText 
local menuText
local menuTextbg
local restartText
local restartTextbg
local nextText
local nextTextbg
local ball
local eventtime= 0
local mRandom = math.random
local bBallKilled = false


local function releaseBall()
	bBallKilled = true
	if ball ~= nil then
		ball:removeSelf()
		ball = nil
	end
end

local function onMenuTouch(self, event)
	if event.phase == "began" then

		Runtime:removeEventListener( "enterFrame", onMoveCircle )
		releaseBall()
		groupLCLayer.alpha=0
		storyboard.gotoScene( "menu-scene", "fade", 400  )
		eventtime = 30 
		speedY = 0
		lastTime=0
		levelText.x = screenW / 2
		levelText.y = screenH / 2
		levelText.rotation=-180
		return true
	end
end

local function onRestartTouch( self, event )
	if event.phase == "began" then
		Runtime:removeEventListener( "enterFrame", onMoveCircle )
		releaseBall()
		groupLCLayer.alpha=0
		eventtime = 30 
		speedY = 0
		lastTime=0
		levelText.x = screenW / 2
		levelText.y = screenH / 2
		levelText.rotation=-180
		gameLevel =level -1
		isLifeTimeUpdate = false
		storyboard.gotoScene( "game-scene", "fade", 400  )
		return true
	end
end 
local function onNextTouch( self, event )
	if event.phase == "began" then
		Runtime:removeEventListener( "enterFrame", onMoveCircle )
		releaseBall()
		groupLCLayer.alpha=0
		eventtime = 30 
		speedY = 0
		lastTime=0
		levelText.x = screenW / 2
		levelText.y = screenH / 2
		levelText.rotation=-180
		gameLevel =level
		isLifeTimeUpdate = false
		storyboard.gotoScene( "game-scene", "fade", 400  )
		return true
	end
end 

local function drawScreen()

	if background ~= nil then
		background:removeSelf()
		background = nil
	end

	local background = display.newImage( "img/stage.png", true )
	background.x = screenW / 2
	background.y = screenH / 2


	if levelText ~= nil then
		levelText:removeSelf()
		levelText = nil
	end
		
	levelText = display.newText( txtComplete[LangId] , screenW / 2, 400, "Chalkduster", 16 )
	levelText:setReferencePoint(display.TopCenterReferencePoint)
	levelText.x = screenW / 2
	levelText.y = screenH / 2
	
	local g1 = graphics.newGradient(
  		{ 0, 0, 255 },
  		{ 200, 200, 200 },
  					"down" )
	levelText:setTextColor(255,255,81)
	levelText.rotation=-180

	local g2 = graphics.newGradient(
  		{ 255, 255, 0 },
  		{ 100, 0, 100 },
  					"down" )

	if menuText ~= nil then
		menuText:removeSelf()
		menuText = nil
	end
	if menuTextbg ~= nil then
		menuTextbg:removeSelf()
		menuTextbg = nil
	end

	menuTextbg = display.newImage( "img/letters/redbanner.png", true )
	menuTextbg:setReferencePoint(display.TopCenterReferencePoint)
	menuTextbg.x = screenW / 2
	menuTextbg.y = screenH / 2 -200


	menuText = display.newText( txtMain[LangId] ,100, 200, "Chalkduster", 14)
	menuText:setReferencePoint(display.TopCenterReferencePoint)
	menuText.x = screenW / 2
	menuText.y = screenH / 2 -195
	
	menuText:setTextColor(255,255,81)
	menuText.touch = onMenuTouch
	menuText:addEventListener( "touch", menuText )

	if restartText ~= nil then
		restartText:removeSelf()
		restartText = nil
	end
	if restartTextbg ~= nil then
		restartTextbg:removeSelf()
		restartTextbg = nil
	end

	restartTextbg = display.newImage( "img/letters/redbanner.png", true )
	restartTextbg:setReferencePoint(display.TopCenterReferencePoint)
	restartTextbg.x = screenW / 2
	restartTextbg.y = screenH / 2 -150

	restartText = display.newText( txtRestart[LangId] ,100, 200,"Chalkduster", 14 )
	restartText:setReferencePoint(display.TopCenterReferencePoint)
	restartText.x = screenW / 2
	restartText.y = screenH / 2 -145
	
	restartText:setTextColor(255,255,81)
	restartText.touch = onRestartTouch
	restartText:addEventListener( "touch", restartText )

	if nextText ~= nil then
		nextText:removeSelf()
		nextText = nil
	end
	if nextTextbg ~= nil then
		nextTextbg:removeSelf()
		nextTextbg = nil
	end
	nextTextbg = display.newImage( "img/letters/redbanner.png", true )
	nextTextbg:setReferencePoint(display.TopCenterReferencePoint)
	nextTextbg.x = screenW / 2
	nextTextbg.y = screenH / 2 -100
	
	nextText = display.newText( txtNext[LangId] ,100, 200, "Chalkduster", 14 )
	nextText:setReferencePoint(display.TopCenterReferencePoint)
	nextText.x = screenW / 2
	nextText.y = screenH / 2 -95
	
	nextText:setTextColor(255,255,81)
	nextText.touch = onNextTouch
	nextText:addEventListener( "touch", nextText )

	groupLCLayer:insert( background )
	groupLCLayer:insert( levelText )
	groupLCLayer:insert( menuTextbg )
	groupLCLayer:insert( menuText )
	groupLCLayer:insert( restartTextbg )
	groupLCLayer:insert( restartText )
	groupLCLayer:insert( nextTextbg )
	groupLCLayer:insert( nextText )
	groupLCLayer.alpha = 0
	eventtime = 30 

end




local function onMoveCircle(event) 

	if bBallKilled == false then
		local timePassed = eventtime - lastTime
		lastTime = lastTime + timePassed

		eventtime=eventtime + 20
		speedY = speedY + gravity

		ball.y = ball.y + speedY*timePassed

		if ball.y >= screenH  - ball.height*.5 then
			ball.y = screenH - ball.height*.5 
			speedY = speedY*friction
			speedX = speedX*friction
			speedY = speedY*-1  --change direction  
		elseif ball.y <= ball.height*.5 then
			ball.y = ball.height*.5
			speedY = speedY*friction
			speedY = speedY*-1 --change direction     
		end
	end
end

function gogogo(et)
--	print("ball" .. ball)
	drawScreen()

	releaseBall()

	
		local optionslc =
			{
    			width = 400,
    			height = 400,
    			numFrames = 1,
			}	

	local R = mRandom(1,10)

	local imageSheet = graphics.newImageSheet("img/gameover/lc"..R..".png", optionslc )
	ball =display.newImageRect(imageSheet, 1, 150, 150 ) 

	bBallKilled = false
	
--	ball = display.newImage( "img/gameover/lc"..R..".png", screenW  / 2  -50 ,200 )
	ball:setReferencePoint(display.CenterReferencePoint)
	ball.x=screenW  / 2 -- -50
	ball.y=180
	groupLCLayer:insert( ball )


	transition.to( levelText, { time=2000, xScale=1.6, yScale = 1.6 ,rotation=0 })
	Runtime:addEventListener("enterFrame", onMoveCircle)

	menuText.alpha=0
	transition.to( menuText, { time=1000,  alpha = 1  })

	menuTextbg.alpha=0
	transition.to( menuTextbg, { time=1000,  alpha = 1  })

	restartText.alpha=0
	transition.to( restartText, { time=1000,  alpha = 1  })

	restartTextbg.alpha=0
	transition.to( restartTextbg, { time=1000,  alpha = 1  })

	nextTextbg.alpha=0
	transition.to( nextTextbg, { time=1000,  alpha = 1  })

	nextText.alpha=0
	transition.to( nextText, { time=1000,  alpha = 1  })

end 	
-- A general function for dragging objects
local function startDrag( event )
	local t = event.target
	local phase = event.phase

	if "began" == phase then
		display.getCurrentStage():setFocus( t )
		t.isFocus = true

		-- Store initial position
		t.x0 = event.x - t.x
		t.y0 = event.y - t.y
						
		-- Stop current motion, if any
		Runtime:removeEventListener("enterFrame", onMoveCircle)
		-- Start tracking velocity
		Runtime:addEventListener("enterFrame", trackVelocity)

	elseif t.isFocus then
		if "moved" == phase then
					
			t.x = event.x - t.x0
			t.y = event.y - t.y0

		elseif "ended" == phase or "cancelled" == phase then
			lastTime = event.time		

			Runtime:removeEventListener("enterFrame", trackVelocity)
			Runtime:addEventListener("enterFrame", onMoveCircle)

			display.getCurrentStage():setFocus( nil )
			t.isFocus = false
		end
	end

	-- Stop further propagation of touch event!
	return true
end

function trackVelocity(event) 
	if bBallKilled == false then
		local timePassed = event.time - prevTime
		prevTime = prevTime + timePassed
	
		speedX = (ball.x - prevX)/timePassed
		speedY = (ball.y - prevY)/timePassed

		prevX = ball.x
		prevY = ball.y
	end
end			

-- Called when the scene's view does not exist:
function scene:createScene( event )
         screenGroup = self.view
 



end

--ball:addEventListener("touch", startDrag)
