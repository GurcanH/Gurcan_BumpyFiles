 
local storyboard = require( "storyboard" )
local levels = require( "levels" )
--local itemsmenu = require( "items" )
local db = require( "db" )
local scene = storyboard.newScene()
local levelcompletedscr = require( "levelcompletedscr" )
local gameoverscr = require( "gameoverscr" )
local questtext = require( "questtext" )
local ccmenu = require( "changecolor" )
local buyitemsmenu = require( "buyitems" )
--local reklam = require( "reklam" )

local _W = display.contentWidth 
local _H = display.contentHeight
local mRandom = math.random

local score
level = 1
local levelText
txtScore = nil
--local imageSheetScore
imgScoreText = nil
imgLevelText = nil
local target
local targetText
local isFinishEnabled = true 		 
local isLevelCompleted = false
isGamePaused = false
--isLifeTimeUpdate = false
local extraText

gameTimer = 0
sec5Timer = 0
local gameTimerText
local gameTimerBar
local gameTimerBar_bg


local gemsTable = {}
local numberOfMarkedToDestroy = 0
local numberOfMarkedToChange = 0
local gemToBeDestroyed  			-- used as a placeholder
local gemToBeChange  			-- used as a placeholder
isGemTouchEnabled = true 		-- blocker for double touching gems

local gameOverLayout
local gameOverText1
local gameOverText2

local timers = {}

-- pre-declaration of function
local onGemTouch

local markedType
local yellowCount = 0
local redCount = 0
local blueCount = 0
local greenCount = 0
local iColor = 0
local gemColor = 0

mudEnabled= false
noScore = false

	bRed = false
	bYellow = false
	bBlue = false
	bGreen = false
	colorCount = 2

--extraLifeStart=false
--nextExtraTime =0 
local countDown = 5 
local countDownText --= display.newText( countDown , 20, _H/2,  "Helvetica",32 )
local isMud = false
local isBrick = false
local isMudCompleted = false
local countDowni = 0 
local countDownj = 0 
local iscountDownStart= false
local iscountDownNow = false
--finishText = display.newText( "LEVEL COMPLETED" , 20, _H/2, "",32 )

AddTimeCount=0
ChangeColorCount=0
local imgChangeColor
local imgEkstraTime
bChangeColor = false
giveChangeColor=0
giveAddTime=0
giveGameLife=0

local narrationSpeechMusic = audio.loadStream("sound/mus.mp3") 
local narrationChannelMusic 

local nYatay = 8 
local nDikey = 8 
local nBrick = 8 

if countDownText ~= nil then
	countDownText:removeSelf()
	countDownText = nil
end
		local options =
			{
    			width = 65,
    			height = 99,
    			numFrames = 1,
			}	
			
local imageSheetCD = graphics.newImageSheet( "img/numbers/5.png", options )
countDownText =display.newImageRect(imageSheetCD, 1, 10, 15 ) 
countDownText:setReferencePoint(display.CenterReferencePoint)


if countDownText ~= nil then
	countDownText.alpha=0
end
countdownEnable = false
sec5Enabled = false
display.setStatusBar( display.HiddenStatusBar )
gameImgMode = 1
gameGlassMode = false
isChangeShifting = false
ChangeShiftingR = 0
orderColorMode = false	
orderBallType ="red"
isGameOver = false
brickEnabled = true

--local ads = require "ads"

local function ATGift()
	AddTimeCount = AddTimeCount + 1
	ChangeAddTime()
	updateBuyItems()
	isGamePaused = false
end
local function CCGift()
	ChangeColorCount = ChangeColorCount + 1
	ChangeChangeColor()
	updateBuyItems()
	isGamePaused = false
end

function CCAnimation()

	local imgCCAnim = display.newImage( "img/ChangeColorani.png",200,200  )
	imgCCAnim:setReferencePoint(display.CenterReferencePoint)

	isGamePaused = true
	imgCCAnim.alpha=0
	transition.to( imgCCAnim, { time =10, xScale=0.1,yScale = 0.1 } )
	transition.to( imgCCAnim, { delay=10, time =1000, xScale=1,yScale = 1,alpha=1,x=150,y=250 } )
	transition.to( imgCCAnim, { delay=1010, time =1000, rotation=360} )
	transition.to( imgCCAnim, { delay=2010, time =1000,xScale=0,yScale = 0,alpha=0,x=80,y=0 } )

	timer.performWithDelay( 3000, CCGift )

end
function ATAnimation()

	local imgTTAnim = display.newImage( "img/AddTimeani.png",200,200  )
	imgTTAnim:setReferencePoint(display.CenterReferencePoint)

	isGamePaused = true
	imgTTAnim.alpha=0
	transition.to( imgTTAnim, { time =10, xScale=0.1,yScale = 0.1 } )
	transition.to( imgTTAnim, { delay=10, time =1000, xScale=1,yScale = 1,alpha=1,x=150,y=250 } )
	transition.to( imgTTAnim, { delay=1010, time =1000, rotation=360} )
	transition.to( imgTTAnim, { delay=2010, time =1000,xScale=0,yScale = 0,alpha=0,x=20,y=0 } )

	timer.performWithDelay( 3000, ATGift )

end


local options =
{
    width = 400,
    height = 394,
    numFrames = 1,
}
		

		local orderText = display.newText( txtBlowUp[LangId] , 0, 410, "Chalkduster", 14 )
		orderText.x = 30
		orderText.y=415
		orderText.alpha=0
			--		local g = graphics.newGradient(
  			--			{ 255, 255, 0 },
  			--			{ 100, 0, 0 },
  			--								"up" )
					orderText:setTextColor(255,0,0)

		
		local imageSheetRedOrder = graphics.newImageSheet( "img/set/red"..bumpySet.."_".. gameImgMode .. ".png", options )
		local imgRedOrder =display.newImageRect(imageSheetRedOrder, 1, 20, 20 )  
		imgRedOrder.x = 70
		imgRedOrder.y = 415 
		imgRedOrder.alpha = 0

		local imageSheetYellowOrder = graphics.newImageSheet( "img/set/yellow"..bumpySet.."_".. gameImgMode .. ".png", options )
		local imgYellowOrder =display.newImageRect(imageSheetYellowOrder, 1, 20, 20 )  
		imgYellowOrder.x = 70
		imgYellowOrder.y = 415 
		imgYellowOrder.alpha = 0

		local imageSheetBlueOrder = graphics.newImageSheet( "img/set/blue"..bumpySet.."_".. gameImgMode .. ".png", options )
		local imgBlueOrder =display.newImageRect(imageSheetBlueOrder, 1, 20, 20 )  
		imgBlueOrder.x = 70
		imgBlueOrder.y = 415 
		imgBlueOrder.alpha = 0

		local imageSheetGreenOrder = graphics.newImageSheet( "img/set/green"..bumpySet.."_".. gameImgMode .. ".png", options )
		local imgGreenOrder =display.newImageRect(imageSheetGreenOrder, 1, 20, 20 )  
		imgGreenOrder.x = 70
		imgGreenOrder.y = 415 
		imgGreenOrder.alpha = 0

 function showOrder()
		imgRedOrder.alpha = 0
		imgYellowOrder.alpha = 0
		imgBlueOrder.alpha = 0
		imgGreenOrder.alpha = 0
		orderText.alpha=0
	if isGamePaused == false then 	
		if orderBallType == "red" then
			imgRedOrder.alpha = 1
			imgYellowOrder.alpha = 0
			imgBlueOrder.alpha = 0
			imgGreenOrder.alpha = 0
			orderText.alpha=1
		end
		if orderBallType == "yellow" then
			imgRedOrder.alpha = 0
			imgYellowOrder.alpha = 1
			imgBlueOrder.alpha = 0
			imgGreenOrder.alpha = 0
			orderText.alpha=1
		end
		if orderBallType == "blue" then
			imgRedOrder.alpha = 0
			imgYellowOrder.alpha = 0
			imgBlueOrder.alpha = 1
			imgGreenOrder.alpha = 0
			orderText.alpha=1
		end
		if orderBallType == "green" then
			imgRedOrder.alpha = 0
			imgYellowOrder.alpha = 0
			imgBlueOrder.alpha = 0
			imgGreenOrder.alpha = 1
			orderText.alpha=1
		end
	end
end

local function orderBalls(gemType)
		print ("order ball typeA:" .. orderBallType)
		print ("self1A" .. gemType)
	if gemType~=orderBallType then
		gameTimer=gameTimer -5 
		gameTimerText.text = gameTimer 
		transition.cancel( gameTimerBar )
		transition.to( gameTimerBar, { time = gameTimer * 1000, xScale=0 } )

					local options = 
					{
						--parent = groupObj,
						text = "-5" ,
						x = imgTimer.x + 22, -- _W/2,
						y = imgTimer.y -5 ,  -- 440, --_H/2,
						font = "Chalkduster",   
						fontSize = 15,
						align = "left"          --new alignment field
					}

					local ekstraTimeText = display.newText( options )
					ekstraTimeText:setReferencePoint(display.CenterReferencePoint)
					local g = graphics.newGradient(
  						{ 255, 0, 0 },
  						{ 200, 0, 0 },
  											"up" )
					ekstraTimeText:setTextColor(255,255,81)




					transition.to( ekstraTimeText, { time=600, alpha=0.5 } )
					transition.to( ekstraTimeText, { time=1600, alpha=0 } )

	else
		print ("order ball type1:" .. orderBallType)
		print ("self1:" .. gemType)
		if orderBallType=="red" then
			orderBallType="yellow"
		elseif orderBallType=="yellow" then
			orderBallType="blue"
		elseif orderBallType=="blue" then
			orderBallType="green"
		elseif orderBallType=="green" then
			orderBallType="red"
		end
		print ("order ball type2:" .. orderBallType)
		print ("self2:" .. gemType)
	end
showOrder()
end 
function dropAllGems()
    for i = 1, nYatay, 1 do

    	--gemsTable[i] = {}

		for j = 1, nDikey, 1 do
			if gemsTable[i][j]~= nil then
				gemsTable[i][j]:removeSelf()
				gemsTable[i][j] = nil
			end
 		end
 	end
 		
end
function hideSmallBalls(a)
	for j = 1, 3, 1 do
		imgRedSmall[j].isVisible=a
		imgGreenSmall[j].isVisible=a
		imgBlueSmall[j].isVisible=a
		imgYellowSmall[j].isVisible=a
	end
end
function showSmallBalls(alp)
	k=0
	if bRed == true then
		imgRedSmall[1].alpha = alp
		imgRedSmall[2].alpha = alp
		imgRedSmall[3].alpha = alp
		imgRedSmall[1].x = (20 ) + k
		imgRedSmall[2].x = (40 ) + k
		imgRedSmall[3].x = (60 ) + k				
		k=k + 80
	end
	if bGreen == true then
		imgGreenSmall[1].alpha = alp
		imgGreenSmall[2].alpha = alp
		imgGreenSmall[3].alpha = alp
		imgGreenSmall[1].x = (20 ) + k
		imgGreenSmall[2].x = (40 ) + k
		imgGreenSmall[3].x = (60 ) + k				
		k=k + 80
	end
	if bBlue == true then
		imgBlueSmall[1].alpha = alp
		imgBlueSmall[2].alpha = alp
		imgBlueSmall[3].alpha = alp
		imgBlueSmall[1].x = (20 ) + k
		imgBlueSmall[2].x = (40 ) + k
		imgBlueSmall[3].x = (60 ) + k				
		k=k + 80
	end
	if bYellow == true then
		imgYellowSmall[1].alpha = alp
		imgYellowSmall[2].alpha = alp
		imgYellowSmall[3].alpha = alp
		imgYellowSmall[1].x = (20 ) + k
		imgYellowSmall[2].x = (40 ) + k
		imgYellowSmall[3].x = (60 ) + k				
		k=k + 80
	end 
end

local function createSmallBalls()
--print ("createSmallBalls")
local options =
{
    width = 400,
    height = 394,
    numFrames = 1,
}
		
		imgRedSmall = {}
		
		local imageSheetRed = graphics.newImageSheet( "img/set/red"..bumpySet.."_".. gameImgMode .. ".png", options )
		imgRedSmall[1] =display.newImageRect(imageSheetRed, 1, 20, 20 )  
		imgRedSmall[1].x = 20
		imgRedSmall[1].y = 415 
		imgRedSmall[1].alpha = 0

		imgRedSmall[2] =display.newImageRect(imageSheetRed, 1, 20, 20 )  
		imgRedSmall[2].x = 40
		imgRedSmall[2].y = 415 
		imgRedSmall[2].alpha = 0

		imgRedSmall[3] =display.newImageRect(imageSheetRed, 1, 20, 20 )  
		imgRedSmall[3].x = 60
		imgRedSmall[3].y = 415 
		imgRedSmall[3].alpha = 0
		imgGreenSmall = {}
		
		local imageSheetGreen = graphics.newImageSheet( "img/set/green"..bumpySet.."_".. gameImgMode .. ".png", options )
		imgGreenSmall[1] =display.newImageRect(imageSheetGreen, 1, 20, 20 )  
		imgGreenSmall[1].x = 100
		imgGreenSmall[1].y = 415 
		imgGreenSmall[1].alpha = 0

		imgGreenSmall[2] =display.newImageRect(imageSheetGreen, 1, 20, 20 )  
		imgGreenSmall[2].x = 120
		imgGreenSmall[2].y = 415 
		imgGreenSmall[2].alpha = 0

		imgGreenSmall[3] =display.newImageRect(imageSheetGreen, 1, 20, 20 )  
		imgGreenSmall[3].x = 140
		imgGreenSmall[3].y = 415 
		imgGreenSmall[3].alpha = 0
		imgBlueSmall = {}
		
		local imageSheetBlue = graphics.newImageSheet( "img/set/blue"..bumpySet.."_".. gameImgMode .. ".png", options )
		imgBlueSmall[1] =display.newImageRect(imageSheetBlue, 1, 20, 20 )  
		imgBlueSmall[1].x = 180
		imgBlueSmall[1].y = 415 
		imgBlueSmall[1].alpha = 0

		imgBlueSmall[2] =display.newImageRect(imageSheetBlue, 1, 20, 20 )  
		imgBlueSmall[2].x = 200
		imgBlueSmall[2].y = 415 
		imgBlueSmall[2].alpha = 0

		imgBlueSmall[3] =display.newImageRect(imageSheetBlue, 1, 20, 20 ) 
		imgBlueSmall[3].x = 220
		imgBlueSmall[3].y = 415 
		imgBlueSmall[3].alpha = 0

		imgYellowSmall = {}
		
		local imageSheetYellow = graphics.newImageSheet( "img/set/yellow"..bumpySet.."_".. gameImgMode .. ".png", options )
		imgYellowSmall[1] =display.newImageRect(imageSheetYellow, 1, 20, 20 )  
		imgYellowSmall[1].x = 260
		imgYellowSmall[1].y = 415 
		imgYellowSmall[1].alpha = 0

		imgYellowSmall[2] =display.newImageRect(imageSheetYellow, 1, 20, 20 ) 
		imgYellowSmall[2].x = 280
		imgYellowSmall[2].y = 415 
		imgYellowSmall[2].alpha = 0

		imgYellowSmall[3] =display.newImageRect(imageSheetYellow, 1, 20, 20 )  
		imgYellowSmall[3].x = 300
		imgYellowSmall[3].y = 415 
		imgYellowSmall[3].alpha = 0
	
end


local function newGem (i,j)

	local newGem
	local R = mRandom(1,4)
	local imgText = ""
	

	local options =
	{
    	width = 400,
	    height = 394,
    	numFrames = 1,
	}
	local options2 =
	{
    	width = 400,
	    height = 400,
    	numFrames = 1,
	}
	
	if mudEnabled== true  then
		local M = mRandom(1,10)
		if M==1 then
			R=5
		end 
	end 
	if isMud==true then
		R=5
	end 
	if isBrick==true then
		R=6
	end 
		
	if gemColor ~= 0 then
		R=gemColor
	end
	
	if gameGlassMode == true then
		imgText ="glass"
	else
		imgText=gameImgMode
	end

	if isChangeShifting	==true then
		R = ChangeShiftingR
	end 
	if 		(R == 1 ) then 		
		local imageSheet = graphics.newImageSheet( "img/set/red"..bumpySet.."_".. imgText .. ".png", options )
		newGem =display.newImageRect(imageSheet, 1, 35, 35 )  
		newGem.i = i
		newGem.j = j
		newGem.x = i*35
		if isChangeShifting == false and isMud == false and isBrick == false  then
			newGem.y = -60 
		else
			newGem.y = j*35+80
		end
		newGem.isMarkedToDestroy = false
		newGem.isMarkedToChange = false
		newGem.destination_y = j*35+80
		newGem.gemType = "red"
		newGem.isGlass = gameGlassMode
		newGem.r = R
		if gameGlassMode == true then
			newGem.gemType = newGem.gemType .. "_glass"
		end

	elseif 	(R == 2 ) then 
		local imageSheet = graphics.newImageSheet( "img/set/green"..bumpySet.."_".. imgText .. ".png", options )
		newGem =display.newImageRect(imageSheet, 1, 35, 35 )  
		newGem.i = i
		newGem.j = j
		newGem.x = i*35 
		if isChangeShifting == false and isMud == false and isBrick == false  then
			newGem.y = -60 
		else
			newGem.y = j*35+80
		end
		newGem.isMarkedToDestroy = false
		newGem.isMarkedToChange = false
		newGem.gemType = "green"
		newGem.isGlass = gameGlassMode
		newGem.destination_y = j*35+80
		newGem.r = R
		if gameGlassMode == true then
			newGem.gemType = newGem.gemType .. "_glass"
		end
	elseif 	(R == 3 ) then 
		local imageSheet = graphics.newImageSheet( "img/set/blue"..bumpySet.."_".. imgText .. ".png", options )
		newGem =display.newImageRect(imageSheet, 1, 35, 35 )  
		newGem.i = i
		newGem.j = j
		newGem.x = i*35 
		if isChangeShifting == false and isMud == false and isBrick == false  then
			newGem.y = -60 
		else
			newGem.y = j*35+80
		end
		newGem.isMarkedToDestroy = false
		newGem.isMarkedToChange = false
		newGem.gemType = "blue"
		newGem.isGlass = gameGlassMode
		newGem.destination_y = j*35+80
		newGem.r = R
		if gameGlassMode == true then
			newGem.gemType = newGem.gemType .. "_glass"
		end
	elseif 	(R == 4 ) then 
		local imageSheet = graphics.newImageSheet( "img/set/yellow"..bumpySet.."_".. imgText .. ".png", options )
		newGem =display.newImageRect(imageSheet, 1, 35, 35 )  
		newGem.i = i
		newGem.j = j
		newGem.x = i*35 
		if isChangeShifting == false and isMud == false and isBrick == false  then
			newGem.y = -60 
		else
			newGem.y = j*35+80
		end
		newGem.isMarkedToDestroy = false
		newGem.isMarkedToChange = false
		newGem.gemType = "yellow"
		newGem.isGlass = gameGlassMode
		newGem.destination_y = j*35+80
		newGem.r = R
		if gameGlassMode == true then
			newGem.gemType = newGem.gemType .. "_glass"
		end
	elseif 	(R == 5 ) then 
		local imageSheet = graphics.newImageSheet( "img/mud2.png", options2 )
		newGem =display.newImageRect(imageSheet, 1, 35, 35 )  
		newGem.i = i
		newGem.j = j
		newGem.x = i*35 
		if isChangeShifting == false and isMud == false and isBrick == false  then
			newGem.y = -60 
		else
			newGem.y = j*35+80
		end
		newGem.isMarkedToDestroy = false
		newGem.isMarkedToChange = false
		newGem.gemType = "dont"
		newGem.isGlass = gameGlassMode
		newGem.destination_y = j*35+80
		newGem.r = R
	elseif 	(R == 6 ) then 
		--local imageSheet = graphics.newImageSheet( "img/mud2.png", options2 )
		newGem =display.newImageRect( "img/brick.png",  35, 35 )  
--		print("iiiii"..i)
--		print("jjjjj"..j)
		newGem.i = i
		newGem.j = j
		newGem.x = i*35 
		if isChangeShifting == false and isMud == false and isBrick == false then
			newGem.y = -60 
		else
			newGem.y = j*35+80
		end
		newGem.isMarkedToDestroy = false
		newGem.isMarkedToChange = false
		newGem.gemType = "dont"
		newGem.isGlass = gameGlassMode
		newGem.destination_y = j*35+80
		newGem.r = R
--		newGem:setReferencePoint(display.BottomCenterReferencePoint)
		
	end

	--new gem falling animation
	if isChangeShifting == false then
		transition.to( newGem, { time=100, y= newGem.destination_y } )
	end
	if isMud == true then
		transition.to( newGem, { time=100, yScale= 0.5} )
		transition.to( newGem, { delay=100, time=100, yScale= 1} )
	end
	if  isBrick == true then
		--transition.to( newGem, { time=100, yScale= 0.5} )
		newGem.yScale=0.1
		newGem.y = newGem.y + 18
		transition.to( newGem, {  time=200, yScale= 1} )
	end
	groupGameLayer:insert( newGem )
	newGem.touch = onGemTouch
	newGem:addEventListener( "touch", newGem )

	return newGem
end



local function shiftGems () 

--print ("Shifting Gems")

	-- first roww
	for i = 1, nYatay, 1 do
		if isGameOver==false then
			if gemsTable[i][1].isMarkedToDestroy then

					-- current gem must go to a 'gemToBeDestroyed' variable holder to prevent memory leaks
					-- cannot destroy it now as gemsTable will be sorted and elements moved down
					gemToBeDestroyed = gemsTable[i][1]
					
					-- create a new one
					gemsTable[i][1] = newGem(i,1)
					
					-- destroy old gem
					gemToBeDestroyed:removeSelf()
					gemToBeDestroyed = nil

					if countDowni == i and countDownj== j then
						iscountDownNow=false
						iscountDownStart=false
						countDown=5
						--countDownText.text = countDown
						isMudCompleted=false
						if countDownText ~= nil then
							countDownText.alpha=0
						end
					end					
			end
		end
	end

	-- rest of the rows
	for j = 2, nYatay, 1 do  -- j = row number - need to do like this it needs to be checked row by row
		for i = 1, nDikey, 1 do
			if isGameOver==false then
			
				if gemsTable[i][j].isMarkedToDestroy then --if you find and empty hole then shift down all gems in column

					gemToBeDestroyed = gemsTable[i][j]
					if countDowni == i and countDownj== j then
						iscountDownNow=false
						iscountDownStart=false
						countDown=5
						--countDownText.text = countDown
						isMudCompleted=false
						if countDownText ~= nil then
							countDownText.alpha=0
						end
					end					
				
					-- shiftin whole column down, element by element in one column
					for k = j, 2, -1 do -- starting from bottom - finishing at the second row

						-- curent markedToDestroy Gem is replaced by the one above in the gemsTable
						gemsTable[i][k] = gemsTable[i][k-1]
						gemsTable[i][k].destination_y = gemsTable[i][k].destination_y +35
						transition.to( gemsTable[i][k], { time=100, y= gemsTable[i][k].destination_y} )
						
						-- we change its j value as it has been 'moved down' in the gemsTable
						gemsTable[i][k].j = gemsTable[i][k].j + 1
				
					end

					-- create a new gem at the first row as there is en ampty space due to gems
					-- that have been moved in the column
					gemsTable[i][1] = newGem(i,1)

					-- destroy the old gem (the one that was invisible and placed in gemToBeDestroyed holder)
					gemToBeDestroyed:removeSelf()
					gemToBeDestroyed = nil
			end 
			end
		end
	end
end --shiftGems()

local function shiftChangeGems () 

--print ("Changing Gems")

	-- first roww
	for i = 1, nYatay  do
		for j = 1, nDikey  do
			if gemsTable[i][j].isMarkedToChange then
					ChangeShiftingR=gemsTable[i][j].r
					-- current gem must go to a 'gemToBeDestroyed' variable holder to prevent memory leaks
					-- cannot destroy it now as gemsTable will be sorted and elements moved down
					gemToBeChange = gemsTable[i][j]
					
					-- create a new one
					gameGlassMode=false
					isChangeShifting = true
					gemsTable[i][j] = newGem(i,j)
					gameGlassMode=true
					isChangeShifting = false
					-- destroy old gem
					gemToBeChange:removeSelf()
					gemToBeChange = nil

			end
		end	
	end

end --changeGems()



local function markToDestroy( self )

	self.isMarkedToDestroy = true
	numberOfMarkedToDestroy = numberOfMarkedToDestroy + 1
	markedType=self.gemType
	
	-- check on the left
	if self.i>1 then
		if (gemsTable[self.i-1][self.j]).isMarkedToDestroy == false then

			if (gemsTable[self.i-1][self.j]).gemType == self.gemType and self.gemType ~= "dont"  then

			   markToDestroy( gemsTable[self.i-1][self.j] )
			end	 
		end
	end

	-- check on the right
	if self.i<nYatay then
		if (gemsTable[self.i+1][self.j]).isMarkedToDestroy == false then

			if (gemsTable[self.i+1][self.j]).gemType == self.gemType and self.gemType ~= "dont" then

			    markToDestroy( gemsTable[self.i+1][self.j] )
			end	 
		end
	end

	-- check above
	if self.j>1 then
		if (gemsTable[self.i][self.j-1]).isMarkedToDestroy == false then

			if (gemsTable[self.i][self.j-1]).gemType == self.gemType and self.gemType ~= "dont" then

			   markToDestroy( gemsTable[self.i][self.j-1] )
			end	 
		end
	end

	-- check below
	if self.j<nDikey then
		if (gemsTable[self.i][self.j+1]).isMarkedToDestroy== false then

			if (gemsTable[self.i][self.j+1]).gemType == self.gemType and self.gemType ~= "dont" then

			   markToDestroy( gemsTable[self.i][self.j+1] )
			end	 
		end
	end
end

local function markToChange( self )

	self.isMarkedToChange = true
	numberOfMarkedToChange = numberOfMarkedToChange + 1
	markedType=self.gemType
	
	-- check on the left
	if self.i>1 then
		if (gemsTable[self.i-1][self.j]).isMarkedToChange == false then

			if (gemsTable[self.i-1][self.j]).gemType == self.gemType and self.gemType ~= "dont"  then

			   markToChange( gemsTable[self.i-1][self.j] )
			end	 
		end
	end

	-- check on the right
	if self.i<nYatay then
		if (gemsTable[self.i+1][self.j]).isMarkedToChange == false then

			if (gemsTable[self.i+1][self.j]).gemType == self.gemType and self.gemType ~= "dont" then

			    markToChange( gemsTable[self.i+1][self.j] )
			end	 
		end
	end

	-- check above
	if self.j>1 then
		if (gemsTable[self.i][self.j-1]).isMarkedToChange == false then

			if (gemsTable[self.i][self.j-1]).gemType == self.gemType and self.gemType ~= "dont" then

			   markToChange( gemsTable[self.i][self.j-1] )
			end	 
		end
	end

	-- check below
	if self.j<nDikey then
		if (gemsTable[self.i][self.j+1]).isMarkedToChange== false then

			if (gemsTable[self.i][self.j+1]).gemType == self.gemType and self.gemType ~= "dont" then

			   markToChange( gemsTable[self.i][self.j+1] )
			end	 
		end
	end
end



local function enableGemTouch()

	isGemTouchEnabled = true
end

function changeColor(color1 , color2)
	-- first row
	for i = 1, nYatay, 1 do
		for j = 1, nDikey, 1 do

					-- current gem must go to a 'gemToBeDestroyed' variable holder to prevent memory leaks
					-- cannot destroy it now as gemsTable will be sorted and elements moved down
			if color1==gemsTable[i][j].gemType or color1 ..  "_glass" == gemsTable[i][j].gemType  then			
					bChangeColor=true
					gemToBeDestroyed = gemsTable[i][j]
					
					-- create a new one
					gemColor=color2
					gemsTable[i][j] = newGem(i,j)
					
					-- destroy old gem
					gemToBeDestroyed:removeSelf()
					gemToBeDestroyed = nil
			end
		end			
	end

	gemColor = 0
	-- rest of the rows

end


local function destroyGems()
	--print ("Destroying Gems. Marked to Destroy = "..numberOfMarkedToDestroy)

	local isTimerEnabled = true 		 

		if SoundId==1 then
			local narrationSpeech = audio.loadStream("sound/Bubbles")
			local narrationChannel = audio.play( narrationSpeech, { duration=500} )  -- play the speech on any available channel, for at most 30 seconds, and invoke a callback when the audio finishes playing
		end
	for i = 1, nYatay, 1 do
		for j = 1, nDikey, 1 do
			
			if gemsTable[i][j].isMarkedToDestroy then

				isGemTouchEnabled = false
				transition.to( gemsTable[i][j], { time=300, alpha=0.2, xScale=2, yScale = 2, onComplete=enableGemTouch } )

				-- update score
				if noScore == false then	
					score = score + 10
				end 

				local optionsScore1 =
					{
		    			width = 252,
		    			height = 100,
		    			numFrames = 1,
					}	
				local optionsScore2 =
					{
		    			width = 318,
		    			height = 100,
		    			numFrames = 1,
					}	


				--if imageSheetScore ~= nil then
				--	imageSheetScore:removeSelf()
				--	imageSheetScore=nil
				--end
				if imgScoreText ~= nil then
					imgScoreText:removeSelf()
					imgScoreText=nil
				end

				
				if LangId == 1 then
					 levelTextTemp="Puan" --imageSheetLevel = graphics.newImageSheet( "img/letters/seviye.png", optionsLevel1)
				end
				if LangId == 2 then
					 levelTextTemp="Score" --imageSheetLevel = graphics.newImageSheet( "img/letters/level.png", optionsLevel2 )
				end
					
				imgScoreText =display.newText( levelTextTemp ,100, 200, "Chalkduster", 18 ) --display.newImageRect(imageSheetScore, 1, 42, 17 ) 
				imgScoreText.x =  252
				imgScoreText.y =  442
				imgScoreText:setTextColor(255,255,81)


				if txtScore ~= nil then
					txtScore:removeSelf()
					txtScore=nil
				end

				txtScore =display.newText( score ,100, 200, "Chalkduster", 18 ) --display.newImageRect(imageSheetScore, 1, 42, 17 ) 
				txtScore.x =  252
				txtScore.y =  468
				txtScore:setTextColor(255,255,81)

				
				extraText.text = EkstraInformation 
				extraText:setReferencePoint(display.TopLeftReferencePoint)
				extraText.x = 60
				extraText:setTextColor(77, 82, 102)
				
				if numberOfMarkedToDestroy > gameImgMode + 4 and isTimerEnabled==true then
					score = score + (10 * (numberOfMarkedToDestroy+gameImgMode - 4))
					gameTimer = gameTimer +  (numberOfMarkedToDestroy+gameImgMode - 4)
					transition.cancel( gameTimerBar )
					if gameTimer>= 30 then
						gameTimer=30					 
							local options =
								{
					    			width = 436,
					    			height = 436,
					    			numFrames = 1,
								}	
--						if imageSheet ~= nil then
--							imageSheet:removeSelf()
--							imageSheet=nil
--						end
						if imgTimer ~= nil then
							imgTimer:removeSelf()
							imgTimer=nil
						end
							local imageSheet = graphics.newImageSheet( "img/timer/30.png", options )
							imgTimer =display.newImageRect(imageSheet, 1, 36, 36 ) 
							imgTimer:setReferencePoint(display.CenterReferencePoint)
							imgTimer.x =  151
							imgTimer.y =  455
					end 
			--		transition.to( gameTimerBar, { time = gameTimer * 1000, xScale=0 } )
					isTimerEnabled=false
					local ekstraTimeText
					local options = 
					{
						--parent = groupObj,
						text = "+" .. (numberOfMarkedToDestroy+gameImgMode - 4),-- "Hello World",     
						x = imgTimer.x + 22, -- _W/2,
						y = imgTimer.y -5 ,  -- 440, --_H/2,
						font = "Chalkduster",   
						fontSize = 15,
						align = "left"          --new alignment field
					}

					local ekstraTimeText = display.newText( options )
					ekstraTimeText:setReferencePoint(display.CenterReferencePoint)
					local g = graphics.newGradient(
  						{ 255, 0, 0 },
  						{ 200, 0, 0 },
  											"up" )
					ekstraTimeText:setTextColor(255,255,81)

					transition.to( ekstraTimeText, { time=600, alpha=0.5 } )
					transition.to( ekstraTimeText, { time=1600, alpha=0 } )

				end 
				if numberOfMarkedToDestroy==gameImgMode + 3  then
					if markedType=="green" then
						iColor=iColor + 1 
						if iColor == 1 then
							greenCount = greenCount + 1
							if bGreen==true then
								if greenCount<4 then
									imgGreenSmall[greenCount].alpha=1
								end
							end
							--print("Green" .. greenCount)
						end 
					end
					if markedType=="yellow" then
						iColor=iColor + 1 
						if iColor == 1 then
							yellowCount = yellowCount + 1
							if bYellow==true then
								if yellowCount<4 then
									imgYellowSmall[yellowCount].alpha=1
								end
							end
							--print("yellow" .. yellowCount)
						end 
					end
					if markedType=="blue" then
						iColor=iColor + 1 
						if iColor == 1 then
							blueCount=blueCount +1 
							if bBlue==true then
								if blueCount<4 then
									imgBlueSmall[blueCount].alpha=1
								end
							end
							--print("blue" .. blueCount)
						end 
					end
					if markedType=="red" then
						iColor=iColor + 1 
						if iColor == 1 then
							redCount=redCount +1
							if bRed==true then
								if redCount<4 then
									imgRedSmall[redCount].alpha=1
								end
							end
							--print("red" .. redCount)
						end 
					end
				end
				
				checkLevelCompleted(level,score,redCount,yellowCount,blueCount,greenCount)
				isLevelCompleted = bLevelCompleted
				
				--if score>= target and isFinishEnabled==true then
				if isLevelCompleted == true then
					isFinishEnabled=false
				--	isLevelCompleted=true
				--	LevelCompleted()
					--timer.performWithDelay( 1320, LevelCompleted )
					--
				end 
				
			end
		end
	end

	numberOfMarkedToDestroy = 0
	if isLevelCompleted == false and gameTimer >= 0  then 
		timer.performWithDelay( 320, shiftGems )
	end 

end

local function changeGems()
	--print ("Changeing Gems. Marked to Change = "..numberOfMarkedToChange)

	local isTimerEnabled = true 		 

	for i = 1, nYatay, 1 do
		for j = 1, nDikey, 1 do
			
			if gemsTable[i][j].isMarkedToChange then
				isGemTouchEnabled = false
				transition.to( gemsTable[i][j], { time=100, alpha=0.2, xScale=0.2, yScale = 0.2, onComplete=enableGemTouch } )
			end
		end
	end

	numberOfMarkedToChange = 0
	if  gameTimer >= 0  then 
		timer.performWithDelay( 320, shiftChangeGems )
	end 

end

function LevelCompleted()
	isGemTouchEnabled = false
--	local finishText = display.newText( "LEVEL COMPLETED" , 10, _H/2, "Helvetica",32 )
--	transition.to( finishText, { time=100, alpha=1 } )
--	finishText:setTextColor(0, 255, 0)
--	transition.to( finishText, { time=1000, alpha=0 } )
	isGemTouchEnabled = true
	level 		= level + 1
	
end

local function cleanUpGems()
	--print("Cleaning Up Gems")
		
	numberOfMarkedToDestroy = 0
	numberOfMarkedToChange = 0
	
	for i = 1, nYatay, 1 do
		for j = 1, nDikey, 1 do
			
			-- show that there is not enough
			if gemsTable[i][j].isMarkedToDestroy or gemsTable[i][j].isMarkedToChange then
				transition.to( gemsTable[i][j], { time=100, xScale=1.2, yScale = 1.2 } )
				transition.to( gemsTable[i][j], { time=100, delay=100, xScale=1.0, yScale = 1.0} )
			end

			gemsTable[i][j].isMarkedToDestroy = false
			gemsTable[i][j].isMarkedToChange = false
			

		end
	end
end
local function countDownStart()
		countDowni = mRandom(1,nYatay)
		countDownj = mRandom(1,nDikey)

		--countDowni = 3
		--countDownj = 5 
		if gemsTable[countDowni][countDownj].gemType~="dont" then
		local options =
			{
    			width = 65,
    			height = 99,
    			numFrames = 1,
			}	
		if countDownText ~= nil then
			countDownText:removeSelf()
			countDownText = nil
		end
			
			local imageSheetCD = graphics.newImageSheet( "img/numbers/5.png", options )
			countDownText =display.newImageRect(imageSheetCD, 1, 10, 15 ) 
			countDownText:setReferencePoint(display.CenterReferencePoint)
			countDownText.x = gemsTable[countDowni][countDownj].x + 12
			countDownText.y = gemsTable[countDowni][countDownj].destination_y + 12
			countDownText:toFront()
			countDownText.alpha=1
			iscountDownNow =true
		else
			countDownStart()
			--print("else'e girdi")
		end
end
function updateBuyItems()
				local options =
					{
		    			width = 65,
		    			height = 99,
		    			numFrames = 1,
					}	
				local options2 =
					{
		    			width = 20,
		    			height = 19,
		    			numFrames = 1,
					}	
				local options3 =
					{
		    			width = 20,
		    			height = 18,
		    			numFrames = 1,
					}	
				local options4 =
					{
		    			width = 200,
		    			height = 200,
		    			numFrames = 1,
					}	
				
				if string.len(ChangeColorCount)==2 then 
					ChangeColorCountX=ChangeColorCount
				end
				if string.len(ChangeColorCount)==1 then 
					ChangeColorCountX="0" .. ChangeColorCount
				end
				
				ChangeColorCount1=string.sub(ChangeColorCountX, 1 ,1)
				ChangeColorCount2=string.sub(ChangeColorCountX, 2 ,2)
				
				if ChangeColorCount1=="" then ChangeColorCount1="0" end
				if ChangeColorCount2=="" then ChangeColorCount2="0" end

				if imageSheetCC1 ~= nil then
					imageSheetCC1:removeSelf()
					imageSheetCC1=nil
				end
				if imageSheetCC2 ~= nil then
					imageSheetCC2:removeSelf()
					imageSheetCC2=nil
				end
				if imageSheetCC3 ~= nil then
					imageSheetCC3:removeSelf()
					imageSheetCC3=nil
				end
				if imgChangeColorCount1 ~= nil then
					imgChangeColorCount1:removeSelf()
					imgChangeColorCount1=nil
				end
				if imgChangeColorCount2 ~= nil then
					imgChangeColorCount2:removeSelf()
					imgChangeColorCount2=nil
				end
				if imgChangeColorCountBG ~= nil then
					imgChangeColorCountBG:removeSelf()
					imgChangeColorCountBG=nil
				end

			
				if ChangeColorCount==0 then
					local imageSheetCC1 = graphics.newImageSheet( "img/numbers/plus2.png", options2 )
					imgChangeColorCount1 =display.newImageRect(imageSheetCC1, 1, 16, 16 ) 
					imgChangeColorCount1:setReferencePoint(display.CenterReferencePoint)
					imgChangeColorCount1.x =  imgChangeColor.x - 5
					imgChangeColorCount1.y =  imgChangeColor.y + 30
				    groupGameLayer:insert ( imgChangeColorCount1 )

				else
					local imageSheetCC3 = graphics.newImageSheet( "img/numbers/numberbg.png", options4 )
					imgChangeColorCountBG =display.newImageRect(imageSheetCC3, 1, 16, 16 ) 
					imgChangeColorCountBG:setReferencePoint(display.CenterReferencePoint)
					imgChangeColorCountBG.x =  imgChangeColor.x 
					imgChangeColorCountBG.y =  imgChangeColor.y + 30
				    groupGameLayer:insert ( imgChangeColorCountBG )

					local imageSheetCC1 = graphics.newImageSheet( "img/numbers/"..ChangeColorCount1..".png", options )
					imgChangeColorCount1 =display.newImageRect(imageSheetCC1, 1, 6, 8 ) 
					imgChangeColorCount1:setReferencePoint(display.CenterReferencePoint)
					imgChangeColorCount1.x =  imgChangeColor.x -4
					imgChangeColorCount1.y =  imgChangeColor.y + 30
				    groupGameLayer:insert ( imgChangeColorCount1 )

					local imageSheetCC2 = graphics.newImageSheet( "img/numbers/"..ChangeColorCount2..".png", options )
					imgChangeColorCount2 =display.newImageRect(imageSheetCC2, 1, 6, 8 ) 
					imgChangeColorCount2:setReferencePoint(display.CenterReferencePoint)
					imgChangeColorCount2.x =  imgChangeColor.x + 2
					imgChangeColorCount2.y =  imgChangeColor.y + 30
				    groupGameLayer:insert ( imgChangeColorCount2 )
					
					if ChangeColorCount1=="0"  then 
						imgChangeColorCount1.alpha=0
						imgChangeColorCount2.x=imgChangeColorCount2.x -3
					else
						imgChangeColorCount1.alpha=1
					end
				end

				if string.len(AddTimeCount)==2 then 
					AddTimeCountX=AddTimeCount
				end
				if string.len(AddTimeCount)==1 then 
					AddTimeCountX="0" .. AddTimeCount
				end
				
				AddTimeCount1=string.sub(AddTimeCountX, 1 ,1)
				AddTimeCount2=string.sub(AddTimeCountX, 2 ,2)
				
				if AddTimeCount1=="" then AddTimeCount1="0" end
				if AddTimeCount2=="" then AddTimeCount2="0" end

				if imageSheetAT1 ~= nil then
					imageSheetAT1:removeSelf()
					imageSheetAT1=nil
				end
				if imageSheetAT2 ~= nil then
					imageSheetAT2:removeSelf()
					imageSheetAT2=nil
				end
				if imageSheetAT3 ~= nil then
					imageSheetAT3:removeSelf()
					imageSheetAT3=nil
				end
				if imgAddTimeCount1 ~= nil then
					imgAddTimeCount1:removeSelf()
					imgAddTimeCount1=nil
				end
				if imgAddTimeCount2 ~= nil then
					imgAddTimeCount2:removeSelf()
					imgAddTimeCount2=nil
				end
				if imgAddTimeCountBG ~= nil then
					imgAddTimeCountBG:removeSelf()
					imgAddTimeCountBG=nil
				end
			
				if AddTimeCount==0 then
					local imageSheetAT1 = graphics.newImageSheet( "img/numbers/plus2.png", options2 )
					imgAddTimeCount1 =display.newImageRect(imageSheetAT1, 1, 16, 16 ) 
					imgAddTimeCount1:setReferencePoint(display.CenterReferencePoint)
					imgAddTimeCount1.x =  imgEkstraTime.x - 5
					imgAddTimeCount1.y =  imgEkstraTime.y + 30
				    groupGameLayer:insert ( imgAddTimeCount1 )

				else
					local imageSheetAT3 = graphics.newImageSheet( "img/numbers/numberbg.png", options4 )
					imgAddTimeCountBG =display.newImageRect(imageSheetAT3, 1, 16, 16 ) 
					imgAddTimeCountBG:setReferencePoint(display.CenterReferencePoint)
					imgAddTimeCountBG.x =  imgEkstraTime.x - 5
					imgAddTimeCountBG.y =  imgEkstraTime.y + 30
				    groupGameLayer:insert ( imgAddTimeCountBG )

					local imageSheetAT1 = graphics.newImageSheet( "img/numbers/"..AddTimeCount1..".png", options )
					imgAddTimeCount1 =display.newImageRect(imageSheetAT1, 1, 6, 8 ) 
					imgAddTimeCount1:setReferencePoint(display.CenterReferencePoint)
					imgAddTimeCount1.x =  imgEkstraTime.x - 8
					imgAddTimeCount1.y =  imgEkstraTime.y + 30
				    groupGameLayer:insert ( imgAddTimeCount1 )

					local imageSheetAT2 = graphics.newImageSheet( "img/numbers/"..AddTimeCount2..".png", options )
					imgAddTimeCount2 =display.newImageRect(imageSheetAT2, 1, 6, 8 ) 
					imgAddTimeCount2:setReferencePoint(display.CenterReferencePoint)
					imgAddTimeCount2.x =  imgEkstraTime.x - 2
					imgAddTimeCount2.y =   imgEkstraTime.y + 30
				    groupGameLayer:insert ( imgAddTimeCount2 )
					if AddTimeCount1=="0"  then 
						imgAddTimeCount1.alpha=0
						imgAddTimeCount2.x=imgAddTimeCount2.x -3
					else
						imgAddTimeCount1.alpha=1
					end
				end

end
local function newLevel()

    -- reseting values
	local function RunAdModAdsBanner()
		local provider = "inmobi"

		-- Your application ID
		local appID = "52b13a3816174b1aa105c9827c25c570" --"ca-app-pub-6414961667069598/9710826665"

		-- Load Corona 'ads' library


		local function adListener( event )
    		if event.isError then
	    	else
    		end
		end

		ads.hide()		
		ads.init( "inmobi", appID, adListener )
		ads.show( "banner320x48", { x=0, y=100, interval=60, testMode=false } )

		ads.hide()		
		ads.init( "admob", "ca-app-pub-6414961667069598/9710826665", adListener )
		ads.show( "banner", { x=0, y=0 } )
 
 		
	end
 

    
    print("newlevel")
	print(bumpySet)
    score		= 0
    gameTimer 	= 30
    sec5Timer 	= 0
    nBrick = 8 
	level 		= gameLevel
	isLevelCompleted = false
	isGameOver = false  
	RunAdModAdsBanner()
   	groupGameLayer = display.newGroup()
   	groupEndGameLayer = display.newGroup()
   	groupPauseGameLayer = display.newGroup()
   	FindChangeColor()
   	FindAddTime()
   	AddLifeTime()

	--tapfortap.removeAdView();	


				local options =
					{
		    			width = 65,
		    			height = 99,
		    			numFrames = 1,
					}	
				
				scoreX="0000"
				score1=string.sub(scoreX, 1 ,1)
				score2=string.sub(scoreX, 2 ,2)
				score3=string.sub(scoreX, 3 ,3)
				score4=string.sub(scoreX, 4 ,4)
				
				if score1=="" then score1="0" end
				if score2=="" then score2="0" end
				if score3=="" then score3="0" end
				if score4=="" then score4="0" end

				if imageSheetS1 ~= nil then
					imageSheetS1:removeSelf()
					imageSheetS1=nil
				end
				if imageSheetS2 ~= nil then
					imageSheetS2:removeSelf()
					imageSheetS2=nil
				end
				if imageSheetS3 ~= nil then
					imageSheetS3:removeSelf()
					imageSheetS3=nil
				end
				if imageSheetS4 ~= nil then
					imageSheetS4:removeSelf()
					imageSheetS4=nil
				end
				if imgScore1 ~= nil then
					imgScore1:removeSelf()
					imgScore1=nil
				end
				if imgScore2 ~= nil then
					imgScore2:removeSelf()
					imgScore2=nil
				end
				if imgScore3 ~= nil then
					imgScore3:removeSelf()
					imgScore3=nil
				end
				if imgScore4 ~= nil then
					imgScore4:removeSelf()
					imgScore4=nil
				end

				local imageSheetS1 = graphics.newImageSheet( "img/numbers/"..score1..".png", options )
				imgScore1 =display.newImageRect(imageSheetS1, 1, 8, 12 ) 
				imgScore1:setReferencePoint(display.CenterReferencePoint)
				imgScore1.x =  235
				imgScore1.y =  466

				if score1=="0" then 
					imgScore1.alpha=0
				else
					imgScore1.alpha=1
				end

				local imageSheetS2 = graphics.newImageSheet( "img/numbers/"..score2..".png", options )
				imgScore2 =display.newImageRect(imageSheetS2, 1, 8, 12 ) 
				imgScore2:setReferencePoint(display.CenterReferencePoint)
				imgScore2.x =  243
				imgScore2.y =  466

				if score2=="0" then 
					imgScore2.alpha=0
				else
					imgScore2.alpha=1
				end

				local imageSheetS3 = graphics.newImageSheet( "img/numbers/"..score3..".png", options )
				imgScore3 =display.newImageRect(imageSheetS3, 1, 8, 12 ) 
				imgScore3:setReferencePoint(display.CenterReferencePoint)
				imgScore3.x =  251
				imgScore3.y =  466

				if score3=="0" then 
					imgScore3.alpha=0
				else
					imgScore3.alpha=1
				end

				local imageSheetS4 = graphics.newImageSheet( "img/numbers/"..score4..".png", options )
				imgScore4 =display.newImageRect(imageSheetS4, 1, 8, 120 ) 
				imgScore4:setReferencePoint(display.CenterReferencePoint)
				imgScore4.x =  259
				imgScore4.y =  466

				if score4=="0" then 
					imgScore4.alpha=0
				else
					imgScore4.alpha=1
				end

				imgScore1.isVisible=false
				imgScore2.isVisible=false
				imgScore3.isVisible=false
				imgScore4.isVisible=false

    --score text

				local optionsScore1 =
					{
		    			width = 252,
		    			height = 100,
		    			numFrames = 1,
					}	
				local optionsScore2 =
					{
		    			width = 318,
		    			height = 100,
		    			numFrames = 1,
					}	

				--if imageSheetScore ~= nil then
				--	imageSheetScore:removeSelf()
				--	imageSheetScore=nil
				--end
				if txtScore ~= nil then
					txtScore:removeSelf()
					txtScore=nil
				end

				txtScore =display.newText( score ,100, 200, "Chalkduster", 18 ) --display.newImageRect(imageSheetScore, 1, 42, 17 ) 
				txtScore.x =  252
				txtScore.y =  468
				txtScore:setTextColor(255,255,81)

				if imgScoreText ~= nil then
					imgScoreText:removeSelf()
					imgScoreText=nil
				end
				if LangId == 1 then
					 levelTextTemp="Puan" --imageSheetLevel = graphics.newImageSheet( "img/letters/seviye.png", optionsLevel1)
				end
				if LangId == 2 then
					 levelTextTemp="Score" --imageSheetLevel = graphics.newImageSheet( "img/letters/level.png", optionsLevel2 )
				end
					
				imgScoreText =display.newText( levelTextTemp ,100, 200, "Chalkduster", 18 ) --display.newImageRect(imageSheetScore, 1, 42, 17 ) 
				imgScoreText.x =  252
				imgScoreText.y =  442
				imgScoreText:setTextColor(255,255,81)
	

				if LangId == 1 then
					 levelTextTemp="Seviye - " .. level --imageSheetLevel = graphics.newImageSheet( "img/letters/seviye.png", optionsLevel1)
				end
				if LangId == 2 then
					 levelTextTemp="Level - ".. level --imageSheetLevel = graphics.newImageSheet( "img/letters/level.png", optionsLevel2 )
				end

				imgLevelText =  display.newText( levelTextTemp ,100, 200, "Chalkduster", 18 )
				-- display.newImageRect(imageSheetLevel, 1, 70, 20 ) 
				imgLevelText.x =  190
				imgLevelText.y =  67
				imgLevelText:setTextColor(255,255,81)
--------

-------				
	
	gameTimerBar_bg = display.newRoundedRect( 20, 430, 280, 20, 4)
	gameTimerBar_bg:setFillColor( 60, 60, 60 )
 	gameTimerBar = display.newRoundedRect( 20, 430, 280, 20, 4)
 	gameTimerBar:setFillColor( 0, 150, 0 )
	gameTimerBar:setReferencePoint(display.CenterReferencePoint)
 	
 	gameTimerText = display.newText( gameTimer , 0, 0, "Chalkduster", 18 )
 	gameTimerText:setTextColor( 255, 255, 255 )
	gameTimerText:setReferencePoint(display.TopLeftReferencePoint)
    gameTimerText.x = _W * 0.5 - 12
    gameTimerText.y = 426

	gameTimerBar.alpha=0
	gameTimerBar_bg.alpha=0
	gameTimerText.alpha=0

		
		local options =
			{
    			width = 436,
    			height = 436,
    			numFrames = 1,
			}	
		if imgTimer ~= nil then
			imgTimer:removeSelf()
			imgTimer=nil
		end
--		if imageSheet ~= nil then
--			imageSheet:removeSelf()
--			imageSheet=nil
--		end
		if gameTimer > 0 then
			local imageSheet = graphics.newImageSheet( "img/timer/30.png", options )  --30.png
			imgTimer =display.newImageRect(imageSheet, 1, 36, 36 ) 
			imgTimer:setReferencePoint(display.CenterReferencePoint)
			imgTimer.x =  151
			imgTimer.y =  455
		end


	levelOperations(level,gameTimer)
	
	if bRed==true or bBlue == true or bYellow==true or bGreen==true then
		showSmallBalls(0.3)
	end
	
	if orderColorMode==true then
		orderBallType="red"
		showOrder()
		orderText.alpha=1
	else
		orderBallType=""
		showOrder()
	end
	
	--print(LevelDescription)

	local wrappedText = textWrap( LevelDescription, 36, "    ", "    " )
	targetText = display.newText( wrappedText, 166, 0, 580, 800, native.systemFont, 16 )
	targetText:setReferencePoint(display.TopLeftReferencePoint)
	targetText.x = 0
	targetText.y =200
	targetText:setTextColor(0, 255, 0)
	targetText.alpha = 0


	extraText = display.newText( EkstraInformation , 0, 410, "Helvetica", 14 )
 

	
	local imgPause = display.newImage( "img/pause.png", 273,52  )
	imgPause:setReferencePoint(display.TopLeftReferencePoint)

	imgPause.touch = onPauseTouch
	imgPause:addEventListener( "touch", imgPause )

	--local imgItem =display.newImage("img/items.png", _W - 100,15  ) 
	--imgItem:setReferencePoint(display.TopLeftReferencePoint)
	
	--imgItem.touch = onItemTouch
	--imgItem:addEventListener( "touch", imgItem )

	imgChangeColor =display.newImage("img/change_colorsmall.png", 71,51  ) 
	imgChangeColor:setReferencePoint(display.TopLeftReferencePoint)


	imgChangeColor.touch = onCCTouch
	imgChangeColor:addEventListener( "touch", imgChangeColor )

	imgEkstraTime =display.newImage("img/extratime.png", 16,51  ) 
	imgEkstraTime:setReferencePoint(display.TopLeftReferencePoint)

	imgEkstraTime.touch = onETTouch
	imgEkstraTime:addEventListener( "touch", imgEkstraTime )


    local background = display.newImage( "img/bg/bg8.png" )
	background:setReferencePoint(display.TopLeftReferencePoint)
	background.y=40
--    background.alpha = 0.5

    local topBanner = display.newImage( "img/top.png" )
	topBanner:setReferencePoint(display.TopLeftReferencePoint)
    topBanner.x=0
    topBanner.y=40

		local optionssb =
			{
    			width = 273,
    			height = 35,
    			numFrames = 1,
			}	

			local imageSheet = graphics.newImageSheet( "img/seviyebanner.png", optionssb )
			local seviyeBanner =display.newImageRect(imageSheet, 1, 136, 26 ) 
			seviyeBanner:setReferencePoint(display.TopLeftReferencePoint)
			seviyeBanner.x =  120
			seviyeBanner.y =  54


 
    local bottomBanner = display.newImage( "img/bottom.png" )
	bottomBanner:setReferencePoint(display.TopLeftReferencePoint)
    bottomBanner.x=0
    bottomBanner.y=428
    
    groupGameLayer:insert( background )		
    groupGameLayer:insert( topBanner )		
    groupGameLayer:insert( bottomBanner )		
    groupGameLayer:insert( seviyeBanner )		
	groupGameLayer:insert ( imgScoreText )
	groupGameLayer:insert ( txtScore )
--	groupGameLayer:insert ( imgScore2 )
--	groupGameLayer:insert ( imgScore3 )
--	groupGameLayer:insert ( imgScore4 )
	groupGameLayer:insert ( imgLevelText )
--	groupGameLayer:insert ( imgLevel1 )
--	groupGameLayer:insert ( imgLevel2 )
--	groupGameLayer:insert ( imgLevel3 )
--	groupGameLayer:insert ( levelText )
--	groupGameLayer:insert ( targetText )
	groupGameLayer:insert ( gameTimerBar_bg )
 	groupGameLayer:insert ( gameTimerBar )
 	groupGameLayer:insert ( gameTimerText )
 	groupGameLayer:insert ( extraText )
    groupGameLayer:insert ( imgPause )
    groupGameLayer:insert ( imgChangeColor )
    groupGameLayer:insert ( imgEkstraTime )

	updateBuyItems()


    --gemsTable

--gggggg
    for i = 1, nYatay, 1 do

    	gemsTable[i] = {}

		for j = 1, nDikey, 1 do

			gemsTable[i][j] = newGem(i,j)
	
 		end
 	end
 		

	
 	gameOverLayout = display.newRect( 0, 0, 320, 480)
 	gameOverLayout:setFillColor( 0, 0, 0 )
 	gameOverLayout.alpha = 0
 	
 	gameOverText1 = display.newText( "GAME OVER", 0, 0, native.systemFontBold, 24 )
	gameOverText1:setTextColor( 255 )
	gameOverText1:setReferencePoint( display.CenterReferencePoint )
	gameOverText1.x, gameOverText1.y = _W * 0.5, _H * 0.5 -150
	gameOverText1.alpha = 0

	gameOverText2 = display.newText( "SCORE: ", 0, 0, native.systemFontBold, 24 )
	gameOverText2.text = string.format( "SCORE: %6.0f", score )
	gameOverText2:setTextColor( 255 )
	gameOverText2:setReferencePoint( display.CenterReferencePoint )
	gameOverText2.x, gameOverText2.y = _W * 0.5, _H * 0.5 - 50
	gameOverText2.alpha = 0

	
	gameOverLayout.touch = onTouchGameOverScreen
	gameOverLayout:addEventListener( "touch", gameOverLayout )


	groupEndGameLayer:insert ( gameOverLayout )
	groupEndGameLayer:insert ( gameOverText1 )
	groupEndGameLayer:insert ( gameOverText2 )


 	gamePauseLayout = display.newRect( 0, 0, _W, _H + 100)
 	gamePauseLayout:setFillColor( 0, 0, 0 )
 	gamePauseLayout.alpha = 0
 	
 	gamePauseText1 = display.newText( "", 0, 0, native.systemFontBold, 24 )
	gamePauseText1:setTextColor( 255)
	gamePauseText1:setReferencePoint( display.CenterReferencePoint )
	gamePauseText1.x, gamePauseText1.y = _W * 0.5, 200
	gamePauseText1.alpha = 0



	if LangId == 1 then
		gamePauseText2 = display.newText( "Devam etmek için ekrana tıklayın.", 0, 0, native.systemFontBold, 18 )
	end
	if LangId == 2 then
		gamePauseText2 = display.newText( "TOUCH TO CONTINUE", 0, 0, native.systemFontBold, 18 )
	end
	gamePauseText2:setTextColor( 255,0,0 )
	gamePauseText2:setReferencePoint( display.CenterReferencePoint )
	gamePauseText2.x, gamePauseText2.y = _W * 0.5,300
	gamePauseText2.alpha = 0
	


	gamePauseLayout.touch = onTouchGamePauseScreen
	gamePauseLayout:addEventListener( "touch", gamePauseLayout )

	groupPauseGameLayer:insert ( gamePauseLayout )
	groupPauseGameLayer:insert ( gamePauseText1 )
	groupPauseGameLayer:insert ( gamePauseText2 )
	groupPauseGameLayer:insert ( targetText )
	
	mudEnabled=false


end
local function showGamePause (a)
    
		gamePauseLayout.alpha = a
		gamePauseText1.alpha = a
		gamePauseText2.alpha = a
		targetText.alpha = a
		if a ~= 0 then
			showSmallBalls(0)
		else
			showSmallBalls(0.3)
		end 
end

function onPauseTouch( self, event )	-- was pre-declared

	if event.phase == "began" and isGemTouchEnabled then

	    
	    
		--print("Pause Touched")
		isGamePaused = true
		--showGamePause (0.8) 
		drawQuestScreen()
	end

return true

end
function onETTouch( self, event )	-- was pre-declared

	if event.phase == "began" and isGemTouchEnabled then
		isGemTouchEnabled = false 
		isGamePaused = true
		buyType="AT"
		if AddTimeCount==0 then
			showAppItems()
		else
			gameTimer = gameTimer + 30
			AddTimeCount=AddTimeCount -1
			ChangeAddTime()
			FindAddTime()
			updateBuyItems()
			isGemTouchEnabled = true
			isGamePaused = false
--			releaseItems()				
		end

	end

return true

end
function onCCTouch( self, event )	-- was pre-declared

	if event.phase == "began" and isGemTouchEnabled then
		isGemTouchEnabled = false 
		isGamePaused = true
		buyType="CC"
		if ChangeColorCount==0 then
			showAppItems()
--			drawColor1()
		else
			drawColor1()
		end
	end

return true

end
function onItemTouch( self, event )	-- was pre-declared

	if event.phase == "began" and isGemTouchEnabled then

	    
		--print("Item Touched")
		
		--changeColor ("yellow","red")
		isGemTouchEnabled = false 
		isGamePaused = true
		showItems()
	end

return true

end

function onGemTouch( self, event )	-- was pre-declared

	if event.phase == "began" and isGemTouchEnabled then

		--print("Gem touched i= "..self.i.." j= "..self.j)

		if self.isGlass == false then
			markToDestroy(self)
			if numberOfMarkedToDestroy >= gameImgMode + 2 then
				iColor=0
				destroyGems()
				if orderColorMode==true then
					orderBalls(self.gemType)
				end
			else 
				cleanUpGems()
			end
		else
			markToChange(self)
			if numberOfMarkedToChange >= gameImgMode + 1 then
				iColor=0
				changeGems()
			else 
				cleanUpGems()
			end
		end	
	
		if isLevelCompleted == true then
			--resetItems()
			--timer.performWithDelay( 700, killGems )
			--timer.performWithDelay( 2200, newLevel )
			level=level + 1 
			if level >= menuLevel then
				menuLevel = level
			end
			resetItems()
			AddLevel(level) 
			DeleteLifeTime()
			--timer.performWithDelay( 100, LevelCompleted )
			--timer.performWithDelay( 1000, storyboard.gotoScene( "menu-scene", "fade", 1200  ) )
			--storyboard.gotoScene( "menu-scene", "fade", 400  )
--			groupLCLayer.alpha=1
			transition.to( groupLCLayer, { time=200, alpha=1} )
			timer.performWithDelay( 1000, gogogo(event.time) )
			--print("hjhj" .. event.time)
			
		end
	
	end

return true

end

function killGems()
	for i = 1, nYatay, 1 do
		--gemsTable[i] = {}
		for j = 1, nDikey, 1 do
			gemToBeDestroyed = gemsTable[i][j]
			gemToBeDestroyed:removeSelf()
			gemToBeDestroyed = nil
		end
	end
end 
function resetItems()
	yellowCount = 0
	redCount = 0
	blueCount = 0
	greenCount = 0
	iColor = 0
	sec5Enabled=false
	countdownEnable = false
	
	if imgTimer ~= nil then
		imgTimer:removeSelf()
		imgTimer=nil
	end
	if imgScoreText~= nil then
		imgScoreText:removeSelf()
		imgScoreText=nil
	end
	if targetText~= nil then
		targetText:removeSelf()
		targetText=nil
	end
	if levelText~= nil then
		levelText:removeSelf()
		levelText=nil
	end
	if txtScore~= nil then
		txtScore:removeSelf()
		txtScore=nil
	end
	if extraText~= nil then
		extraText:removeSelf()
		extraText=nil
	end
	if countDownText ~= nil then
		countDownText.alpha=0
	end
	if imgScore1 ~= nil then
		imgScore1:removeSelf()
		imgScore1=nil
	end
	if imgScore2 ~= nil then
		imgScore2:removeSelf()
		imgScore2=nil
	end
	if imgScore3 ~= nil then
		imgScore3:removeSelf()
		imgScore3=nil
	end
	if imgScore4 ~= nil then
		imgScore4:removeSelf()
		imgScore4=nil
	end
	if imgChangeColorCountBG ~= nil then
		imgChangeColorCountBG:removeSelf()
		imgChangeColorCountBG=nil
	end
	if imgChangeColorCount1 ~= nil then
		imgChangeColorCount1:removeSelf()
		imgChangeColorCount1=nil
	end
	if imgChangeColorCount2 ~= nil then
		imgChangeColorCount2:removeSelf()
		imgChangeColorCount2=nil
	end
	if imgAddTimeCountBG ~= nil then
		imgAddTimeCountBG:removeSelf()
		imgAddTimeCountBG=nil
	end
	if imgAddTimeCount1 ~= nil then
		imgAddTimeCount1:removeSelf()
		imgAddTimeCount1=nil
	end
	if imgAddTimeCount2 ~= nil then
		imgAddTimeCount2:removeSelf()
		imgAddTimeCount2=nil
	end
	
	isFinishEnabled = true 		  
	dropAllGems()
	showSmallBalls(0)
	orderBallType=""
	showOrder()
end

function onTouchGameOverScreen ( self, event )

	if event.phase == "began" then

		groupEndGameLayer.alpha =0 		
		resetItems()
		storyboard.gotoScene( "menu-scene", "fade", 400  )
		
		return true
	end
end	

function onTouchGamePauseScreen ( self, event )

	if event.phase == "began" then
		
		isGamePaused = false
		showGamePause (0)
		
		return true
	end
end	


local function showGameOver ()

	--gameOverLayout.alpha = 0.8
	--gameOverText1.alpha = 1
	--gameOverText2.alpha = 1
--	if isGameOver == false then
		orderBallType=""
		showOrder()
		groupEndGameLayer.alpha =0 		
		resetItems()

		transition.to( groupGOLayer, { time=200, alpha=1} )
		timer.performWithDelay( 200, gogogo2 )
		--ChangeLife()

--	end	
		
--	if isLifeTimeUpdate == false then
--		isLifeTimeUpdate = true
--		life = life -1 
--	end 
end

local function changetoMud(i,j)
	isMud=true
	gemToBeDestroyed = gemsTable[i][j]
	
	-- create a new one
	gemsTable[i][j] = newGem(i,j)
	
	-- destroy old gem
	if gemToBeDestroyed ~= nil then
		gemToBeDestroyed:removeSelf()
		gemToBeDestroyed = nil
	end
	isMud=false
	isMudCompleted = true
	if countDownText ~= nil then
		countDownText.alpha=0
	end
	
end

local function countDownUpdate ()
	if isGamePaused==true then
		if countDownText ~= nil then
			countDownText.alpha=0
		end	
	else
		if iscountDownStart ==true and isLevelCompleted == false  and isGameOver ==false and countdownEnable == true then
			countDown = countDown - 1
			--print(countDown)
			if countDown >= 0 then 
		
--			countDownText.text = countDown
			local options =
				{
    			width = 65,
    			height = 99,
    			numFrames = 1,
			}	
			if countDownText ~= nil then
				countDownText:removeSelf()
				countDownText = nil
			end
				if 	countDown>=1 and countDown <= 5 then
					local imageSheetCD = graphics.newImageSheet( "img/numbers/" .. countDown .. ".png", options )
					countDownText =display.newImageRect(imageSheetCD, 1, 10, 15 ) 
					countDownText:setReferencePoint(display.CenterReferencePoint)
					countDownText.x = gemsTable[countDowni][countDownj].x + 12
					countDownText.y = gemsTable[countDowni][countDownj].destination_y + 12 
					countDownText:toFront()
					countDownText.alpha=1
				else
				end
			else
				--print(isMudCompleted)
				if isMudCompleted == false then
						changetoMud(countDowni,countDownj)
						if countDowni>1 then
							i=countDowni-1
							isMud=true
							isMudCompleted = false

							changetoMud(i,countDownj)
						end
						if countDowni<nYatay then
							i=countDowni+1
							isMud=true
							isMudCompleted = false

							changetoMud(i,countDownj)
						end
						if countDownj>1 then
							j=countDownj-1
							isMud=true
							isMudCompleted = false

							changetoMud(countDowni,j)
						end
						if countDownj<nDikey then
							j=countDownj+1
							isMud=true
							isMudCompleted = false

							changetoMud(countDowni,j)
						end
					end
					iscountDownNow=false
					iscountDownStart=false
					countDown=5
--				countDownText.text = countDown
					isMudCompleted=false
			end
		end
	end
end
local function changeRowstoBrick()

	isBrick=true
	if nBrick<1 then
		nBrick = 1
	end
	local R = nBrick
	nBrick = nBrick -1
	
	for i = 1, 8, 1 do
		for j = R, R, 1 do
			gemToBeDestroyed = gemsTable[i][j]
			gemsTable[i][j] = newGem(i,j)
	
			-- destroy old gem
			if gemToBeDestroyed ~= nil then
				gemToBeDestroyed:removeSelf()
				gemToBeDestroyed = nil
			end
		end
	end
	
	-- create a new one
	isBrick=false
end

local function deleteRows()

	local R = mRandom(2,nDikey)

	for i = 1, nYatay, 1 do
		for j = R, R, 1 do
			gemsTable[i][j].isMarkedToDestroy = true
		end
	end 
	noScore = true
	destroyGems()
	noScore = false
end
local function sec5TimerUpdate()
	if isGamePaused == false then
		sec5Timer = sec5Timer  + 1
	end
	if sec5Enabled == true and isGamePaused == false  then
		if sec5Timer % 5 ==0  and gameTimer ~= 30  then
			deleteRows()
		end
	end
	if brickEnabled == true and isGamePaused == false  then
		if sec5Timer % 10 ==0  and gameTimer ~= 30  then
			changeRowstoBrick()
		end
	end
end
	
local function gameTimerUpdate ()
	
    if isGamePaused == true then
		audio.pause(  )
	else
		audio.resume( narrationSpeechMusic )
	end 
	
    if isGamePaused == false then
		gameTimer = gameTimer - 1
		
		local options =
			{
    			width = 436,
    			height = 436,
    			numFrames = 1,
			}	
--		if imageSheet ~= nil then
--			imageSheet:removeSelf()
--			imageSheet=nil
--		end
		if gameTimer > 0 and isLevelCompleted == false  and isGameOver ==false then
			if imgTimer ~= nil then
				imgTimer:removeSelf()
				imgTimer=nil
			end
			if gameTimer > 30 then 
				gameTimer=30
			end
			
			local imageSheet = graphics.newImageSheet( "img/timer/" .. gameTimer .. ".png", options )
--			local imageSheet = graphics.newImageSheet( "img/timer/1.png", options )
			imgTimer =display.newImageRect(imageSheet, 1, 36, 36 ) 
			imgTimer:setReferencePoint(display.CenterReferencePoint)
			imgTimer.x =  151
			imgTimer.y =  455
		elseif gameTimer == 0 and isLevelCompleted == false  and isGameOver ==false then
			if imgTimer ~= nil then
				imgTimer:removeSelf()
				imgTimer=nil
			end
		local optionsto =
			{
    			width = 400,
    			height = 523,
    			numFrames = 1,
			}	

			local imageSheet = graphics.newImageSheet( "img/timer/timeout.png", optionsto )
			imgTimer =display.newImageRect(imageSheet, 1, 36, 36 ) 
			imgTimer:setReferencePoint(display.CenterReferencePoint)
			imgTimer.x =  151
			imgTimer.y =  455
			imgTimer.xScale = 0.1
			imgTimer.yScale = 0.1
			transition.to( imgTimer, { time=300 , xScale=1, yScale = 1 } )

		end
		
	end
	if  mRandom(1,4)==4 and gameTimer>0  and countdownEnable == true then
		iscountDownStart=true
	end 
	if iscountDownStart==true and iscountDownNow==false then
		countDownStart()
	end 
	
	if gameTimer >= 0 then gameTimerText.text = gameTimer

	else
		if isLevelCompleted == false and isGameOver==false then
--			gameOverText2.text = string.format( "SCORE: %6.0f", score )
  			isGameOver=true
  			isGemTouchEnabled=false
			iscountDownNow=false
			iscountDownStart=false
			countDown=5
  			
			timer.performWithDelay( 3000, showGameOver )
		end

	end

--	if 	extraLifeStart==false and life <5 then
--		extraLifeStart=false
--		nextExtraTime =0 
--
--	end if

end
-- Called when the scene's view does not exist:
function scene:createScene( event )
        local screenGroup = self.view
		--print( "\n1: createScene event")
 
        -----------------------------------------------------------------------------
                
        --      CREATE display objects and add them to 'group' here.
        --      Example use-case: Restore 'group' from previously saved state.
        
        -----------------------------------------------------------------------------


end
 
-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
        local screenGroup = self.view
        
        -----------------------------------------------------------------------------
                
        --      This event requires build 2012.782 or later.
        
        -----------------------------------------------------------------------------
        
end
 
-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
        local screenGroup = self.view
        
        -----------------------------------------------------------------------------
                
        --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)
        
        -----------------------------------------------------------------------------
	
	-- remove previous scene's view
        
    storyboard.purgeScene( "menu-scene" )

	print( "1: enterScene event" )
	
	-- storyboard.purgeScene( "scene4" )

	-- reseting values
    score		= 0
    gameTimer 	= 30
    sec5Timer = 0

	--level 		= 0
	target      = 1000 

	level = gameLevel
	createSmallBalls()
	newLevel()
		
	isGamePaused = true	
	drawQuestScreen()
	--showGamePause (1) 	

	transition.to( gameTimerBar, { time = gameTimer * 1000, xScale=0 } )
	timers.gameTimerUpdate = timer.performWithDelay(1000, gameTimerUpdate, 0)
	timers.countDownUpdate = timer.performWithDelay(1000, countDownUpdate, 0)
	timers.sec5TimerUpdate = timer.performWithDelay(1000, sec5TimerUpdate, 0)
	
	if SoundId==1 then
		--narrationSpeechMusic = audio.loadStream("sound/mus.mp3")
		audio.play( narrationSpeechMusic )  -- play the speech on any available channel, for at most 30 seconds, and invoke a callback when the audio finishes playing
		audio.pause( narrationSpeechMusic )  -- play the speech on any available channel, for at most 30 seconds, and invoke a callback when the audio finishes playing
	end
				
--	audio.pause( backgroundMusicChannel )
		-- insterting display groups to the screen group (storyboard group)
	screenGroup:insert ( groupGameLayer )
	screenGroup:insert ( groupEndGameLayer )
	screenGroup:insert ( groupPauseGameLayer )

end
 
 
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local screenGroup = self.view
        
        -----------------------------------------------------------------------------
        
        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
        
        -----------------------------------------------------------------------------
       
	if timers.gameTimerUpdate then 
		timer.cancel(timers.gameTimerUpdate)
		timers.gameTimerUpdate = nil
	 end
	if timers.sec5TimerUpdate then 
		timer.cancel(timers.sec5TimerUpdate)
		timers.sec5TimerUpdate = nil
	 end
	if timers.countDownUpdate then 
		timer.cancel(timers.countDownUpdate)
		timers.countDownUpdate = nil
	 end

end
 

-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
        local screenGroup = self.view
        
        -----------------------------------------------------------------------------
                
        --      This event requires build 2012.782 or later.
        
        -----------------------------------------------------------------------------
        
end
 
 
-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
        local screenGroup = self.view
        
        -----------------------------------------------------------------------------
        
        --      INSERT code here (e.g. remove listeners, widgets, save state, etc.)
        
        -----------------------------------------------------------------------------
        
end
 
-- Called if/when overlay scene is displayed via storyboard.showOverlay()
function scene:overlayBegan( event )
        local screenGroup = self.view
        local overlay_scene = event.sceneName  -- overlay scene name
        
        -----------------------------------------------------------------------------
                
        --      This event requires build 2012.797 or later.
        
        -----------------------------------------------------------------------------
        
end
 
-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
        local screenGroup = self.view
        local overlay_scene = event.sceneName  -- overlay scene name
 
        -----------------------------------------------------------------------------
                
        --      This event requires build 2012.797 or later.
        
        -----------------------------------------------------------------------------
        
end
 
 
 
---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
 
-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )
 
-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "willEnterScene", scene )
 
-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )
 
-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )
 
-- "didExitScene" event is dispatched after scene has finished transitioning out
scene:addEventListener( "didExitScene", scene )
 
-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )
 
-- "overlayBegan" event is dispatched when an overlay scene is shown
scene:addEventListener( "overlayBegan", scene )
 
-- "overlayEnded" event is dispatched when an overlay scene is hidden/removed
scene:addEventListener( "overlayEnded", scene )
 
---------------------------------------------------------------------------------
 
return scene