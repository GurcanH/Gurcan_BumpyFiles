local storyboard = require( "storyboard" )
local nolife = require( "nolife" )
local screenW, screenH = display.contentWidth, display.contentHeight
local friction = 0.4
local gravity = .05
local speedX, speedY, prevX, prevY, lastTime, prevTime = 0, 0, 0, 0, 0, 0
groupGOLayer = display.newGroup()

local levelText 
local menuText
local menuTextbg
local restartText
local restartTextbg
local nextText
local nextTextbg
local ball
local eventtime = 0
local mRandom = math.random
local bBallKilled = false

local background = display.newImage( "img/stage.png", true )
background.x = screenW / 2
background.y = screenH / 2


groupGOLayer:insert( background )


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
		groupGOLayer.alpha=0
		storyboard.gotoScene( "menu-scene", "fade", 400  )
		eventtime = 30 
		speedY = 0
		lastTime=0
		levelText.x = screenW / 2
		levelText.y = screenH / 2 - 50 
		return true
	end
end

local function onRestartTouch( self, event )
	if event.phase == "began" then
		if life> 0 then
			Runtime:removeEventListener( "enterFrame", onMoveCircle )
			releaseBall()
			groupGOLayer.alpha=0
			eventtime = 30 
			speedY = 0
			lastTime=0
			levelText.x = screenW / 2
			levelText.y = screenH / 2 - 50
			gameLevel =level 
			isLifeTimeUpdate = false
			storyboard.gotoScene( "game-scene", "fade", 400  )
		else
			groupNoLifeLayer.alpha=1
			groupNoLifeLayer:toFront()
			
			transition.to( groupNoLifeLayer, { time=2000,delay=2500,  alpha = 0 , xScale=2, yScale = 2  })
--			transition.to( levelText, { time=2000, xScale=2, yScale = 2 ,rotation=0 })
			
		end
		return true
	end
end 
local function onNextTouch( self, event )
	if event.phase == "began" then
		Runtime:removeEventListener( "enterFrame", onMoveCircle )
		releaseBall()
		groupGOLayer.alpha=0
		eventtime = 30 
		speedY = 0
		lastTime=0
		levelText.x = screenW / 2
		levelText.y = screenH / 2 - 50
		
		gameLevel =level
		isLifeTimeUpdate = false
		storyboard.gotoScene( "game-scene", "fade", 400  )
		return true
	end
end 

	levelText = display.newText( txtFailed[LangId] , screenW / 2, 400, "Chalkduster", 32 )
	levelText:setReferencePoint(display.TopCenterReferencePoint)
	levelText.x = screenW / 2
	levelText.y = screenH / 2 -50
	levelText.yScale = 0.01
	
	local g1 = graphics.newGradient(
  		{ 0, 0, 255 },
  		{ 200, 200, 200 },
  					"down" )
	levelText:setTextColor(255,255,81)

	local g2 = graphics.newGradient(
  		{ 255, 255, 0 },
  		{ 100, 0, 100 },
  					"down" )

	menuTextbg = display.newImage( "img/letters/redbanner.png", true )
	menuTextbg:setReferencePoint(display.TopCenterReferencePoint)
	menuTextbg.x = screenW / 2
	menuTextbg.y = screenH / 2 -200

	menuText =  display.newText( txtMain[LangId],100, 200, "Chalkduster", 14 )
	menuText:setReferencePoint(display.TopCenterReferencePoint)
	menuText.x = screenW / 2 
	menuText.y = screenH / 2 -195
	
	menuText:setTextColor(255,255,81)
	menuText.touch = onMenuTouch
	menuText:addEventListener( "touch", menuText )

	restartTextbg = display.newImage( "img/letters/redbanner.png", true )
	restartTextbg:setReferencePoint(display.TopCenterReferencePoint)
	restartTextbg.x = screenW / 2
	restartTextbg.y = screenH / 2 -150

	restartText = display.newText( txtRestart[LangId] ,100, 200, "Chalkduster", 14 )
	restartText:setReferencePoint(display.TopCenterReferencePoint)
	restartText.x = screenW / 2
	restartText.y = screenH / 2 -145
	
	restartText:setTextColor(255,255,81)
	restartText.touch = onRestartTouch
	restartText:addEventListener( "touch", restartText )


--	nextText = display.newText( "Next Level" ,100, 200, "Helvetica", 20 )
--	nextText:setReferencePoint(display.TopCenterReferencePoint)
--	nextText.x = screenW / 2
--	nextText.y = screenH / 2 -100
	
--	nextText:setTextColor(g2)
--	nextText.touch = onNextTouch
--	nextText:addEventListener( "touch", nextText )


groupGOLayer:insert( levelText )
groupGOLayer:insert( menuTextbg )
groupGOLayer:insert( menuText )
groupGOLayer:insert( restartTextbg )
groupGOLayer:insert( restartText )
--groupGOLayer:insert( nextText )
groupGOLayer.alpha = 0
eventtime = 30 





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


function gogogo2()

	releaseBall()

	local R = mRandom(1,7)

		local optionsgo =
			{
    			width = 200,
    			height = 200,
    			numFrames = 1,
			}	


	local imageSheet = graphics.newImageSheet("img/gameover/go"..R..".png", optionsgo )
	ball =display.newImageRect(imageSheet, 1, 150, 150 ) 


--	ball = display.newImage( "img/gameover/go"..R..".png", screenW  / 2  -100 ,200 )
	ball:setReferencePoint(display.CenterReferencePoint)
	ball.x=screenW  / 2 -- -50
	ball.y=180
	groupGOLayer:insert( ball )
	bBallKilled = false
	
	transition.to( levelText, { time=1000,  yScale = 2  })
	Runtime:addEventListener("enterFrame", onMoveCircle)

	menuText.alpha=0
	transition.to( menuText, { time=1000,  alpha = 1  })

	menuTextbg.alpha=0
	transition.to( menuTextbg, { time=1000,  alpha = 1  })

	restartText.alpha=0
	restartTextbg.alpha=0

	if leftLife >0 then 
		transition.to( restartText, { time=1000,  alpha = 1  })
		transition.to( restartTextbg, { time=1000,  alpha = 1  })
	end
	isGemTouchEnabled=true

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

--ball:addEventListener("touch", startDrag)
