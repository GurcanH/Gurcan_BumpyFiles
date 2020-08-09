local _W = display.contentWidth 
local _H = display.contentHeight
local ball1 ={}
local ball2 ={}
local color1
local color2
local screenW, screenH = display.contentWidth, display.contentHeight
local storyboard = require( "storyboard" )
local storeMod = require("storeMod")



----------------------------------------------------
local	function onClose(self, event)
		if event.phase == "began" then

	    	isGemTouchEnabled = true
			isGamePaused = false
			releaseItems()	

		return true
		end
	end


function showItems()
   	groupItemLayer = display.newGroup()

	local options2 =
		{
   			width = 320,
  			height = 480,
   			numFrames = 1,
		}	
	imageSheet = graphics.newImageSheet( "img/bg/bgitems.png", options2 )
					
	gameItemLayout =display.newImageRect(imageSheet, 1, 175, 150 ) 
 	gameItemLayout:setReferencePoint(display.TopLeftReferencePoint)
	gameItemLayout.x =  _W/4 -10
	gameItemLayout.y =  _H/4 + 50
	gameItemLayout.alpha = 1

    imgExit = display.newImage( "img/x.png", 60,150 )
	imgExit:setReferencePoint(display.TopLeftReferencePoint)
	imgExit.touch = onClose
	imgExit:addEventListener( "touch", imgExit )

	groupItemLayer:insert ( gameItemLayout )
	groupItemLayer:insert ( imgExit )

	
end

	function drawColor1()
		showItems()
		local options =
		{
    		width = 400,
    		height = 394,
    		numFrames = 1,
		}

		for i = 1, 4 do
			ballName=""
			if i==1 then
				ballName="img/set/red"..bumpySet.."_"
			end
			if i==2 then
				ballName="img/set/green"..bumpySet.."_"
			end
			if i==3 then
				ballName="img/set/blue"..bumpySet.."_"
			end
			if i==4 then
				ballName="img/set/yellow"..bumpySet.."_"
			end
			local imageSheet = graphics.newImageSheet( ballName .. gameImgMode .. ".png", options )
			ball1[i] =display.newImageRect(imageSheet, 1, 40, 40 ) -- display.newImage("ball1.png",i*40-20  ,-60)
			ball1[i].i = i
			ball1[i].x = i*40  + 58
			ball1[i].y = 220 
			groupItemLayer:insert ( ball1[i] )
	
			ball1[i].touch = onBall1Touch
			ball1[i]:addEventListener( "touch", ball1[i] )

		end
	end

	function drawColor2(j)
		local options =
		{
    		width = 400,
    		height = 394,
    		numFrames = 1,
		}

		for i = 1, 4 do

			ballName=""
			if i==1 then
				ballName="img/set/red"..bumpySet.."_"
			end
			if i==2 then
				ballName="img/set/green"..bumpySet.."_"
			end
			if i==3 then
				ballName="img/set/blue"..bumpySet.."_"
			end
			if i==4 then
				ballName="img/set/yellow"..bumpySet.."_"
			end
			local imageSheet = graphics.newImageSheet( ballName .. gameImgMode .. ".png", options )
			ball2[i] =display.newImageRect(imageSheet, 1, 40, 40 ) -- display.newImage("ball1.png",i*40-20  ,-60)
			ball2[i].i = i
			ball2[i].j = j
			ball2[i].x = i * 40 + 58
			ball2[i].y = 270 
			groupItemLayer:insert ( ball2[i] )
			
			if i==j then
				ball2[i].alpha=0
			end 
			
			ball2[i].touch = onBall2Touch
			ball2[i]:addEventListener( "touch", ball2[i] )

		end
	end



	function releaseItems()
			groupItemLayer:removeSelf()
			groupItemLayer = nil
	end
	
	function onBall1Touch( self, event )	-- was pre-declared

		if event.phase == "began"  then
		
			j=self.i			    
			if j==1 then
				color1="red"
			end 
			if j==2 then
				color1="green"
			end 
			if j==3 then
				color1="blue"
			end 
			if j==4 then
				color1="yellow"
			end 
			
				for i = 1, 4 do

					if i ~= j then
						ball1[i].alpha = 0
					end

				end
	    	drawColor2(j)
		end

	return true

	end

	function onBall2Touch( self, event )	-- was pre-declared

		if event.phase == "began"  then
		
			j=self.i			    
			color2 = j	
				for i = 1, 4 do

					if i ~= j then
						ball2[i].alpha = 0
					end

				end
	    	bChangeColor=false
	    	changeColor(color1 , color2)
	    	isGemTouchEnabled = true
			isGamePaused = false
			if bChangeColor==true then
				ChangeColorCount=ChangeColorCount -1
				ChangeChangeColor()
			  	FindChangeColor()
				updateBuyItems()
			end
			releaseItems()	
		end

	return true

	end


	function onItemColorTouch( self, event )	-- was pre-declared

		if event.phase == "began"  then

	    
	    
			print("onItem30Touch Touched")

			drawColor1()			
			--isGemTouchEnabled = true
			--isGamePaused = false
			--gameTimer = gameTimer + 30
			--releaseItems()				
		end

	return true

	end
