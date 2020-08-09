local _W = display.contentWidth 
local _H = display.contentHeight
local ball1 ={}
local ball2 ={}
local color1
local color2
local screenW, screenH = display.contentWidth, display.contentHeight
local storyboard = require( "storyboard" )
local storeMod = require("storeMod")



-- Product IDs for the "apple" app store.
--local appleProductList =
--{
--
--	"com.gunapps.bumpyItem001",
--	"com.gunapps.bumpyItem002",
--	"com.gunapps.bumpyItem003",
--	"com.gunapps.bumpyItem004",
--}




----------------------------------------------------


function showItems()
   	groupItemLayer = display.newGroup()

-- 	gameItemLayout = display.newRect( 0, 0, _W, _H + 100)
 	gameItemLayout = display.newImage( "img/bg/bgitems.png", 0,0 )

-- 	gameItemLayout:setFillColor( 0, 0, 0 )
 	gameItemLayout.alpha = 1
 	
	local g1 = graphics.newGradient(
  		{ 0, 0, 255 },
  		{ 200, 200, 200 },
  					"down" )

	local g2 = graphics.newGradient(
  		{ 255, 255, 0 },
  		{ 100, 0, 100 },
  					"down" )
local function onMenuTouch(self, event)
	if event.phase == "began" then
		resetItems()
		isLifeTimeUpdate = false
    	isGemTouchEnabled = true
		isGamePaused = false
		releaseItems()
		storyboard.gotoScene( "menu-scene", "fade", 400  )
		return true
	end
end

local function onRestartTouch( self, event )
	if event.phase == "began" then
		resetItems()
		releaseItems()
		gameLevel =level  
		isLifeTimeUpdate = false
    	isGemTouchEnabled = true
		isGamePaused = false
		storyboard.gotoScene( "game-scene", "fade", 400  )
		return true
	end
end 
local function onNextTouch( self, event )
	if event.phase == "began" then
    	isGemTouchEnabled = true
		isGamePaused = false
		releaseItems()
		return true
	end
end 

--[[
	menuText = display.newText(txtMain[LangId] ,100, 200, "Helvetica", 20 )
	menuText:setReferencePoint(display.TopCenterReferencePoint)
	menuText.x = screenW / 2
	menuText.y = screenH / 2 -200
	
	menuText:setTextColor(g2)
	menuText.touch = onMenuTouch
	menuText:addEventListener( "touch", menuText )
	menuText.alpha=0
	
	restartText = display.newText( txtRestart[LangId] ,100, 200, "Helvetica", 20 )
	restartText:setReferencePoint(display.TopCenterReferencePoint)
	restartText.x = screenW / 2
	restartText.y = screenH / 2 -150
	restartText.alpha=0
	
	restartText:setTextColor(g2)
	restartText.touch = onRestartTouch
	restartText:addEventListener( "touch", restartText )

	nextText = display.newText(txtResume[LangId] ,100, 200, "Helvetica", 32 )
	nextText:setReferencePoint(display.TopCenterReferencePoint)
	nextText.x = screenW / 2
	nextText.y = screenH / 2 -100
	
	nextText:setTextColor(g2)
	nextText.touch = onNextTouch
	nextText:addEventListener( "touch", nextText )
]]--
	local options =
	{
    	width = 436,
    	height = 436,
    	numFrames = 1,
	}
	local options2 =
	{
    	width = 788,
    	height = 788,
    	numFrames = 1,
	}
	local item30Sheet = graphics.newImageSheet( "img/30.png", options )
	local imgItem30 =display.newImageRect(item30Sheet, 1, 50, 50 ) -- display.newImage("ball1.png",i*40-20  ,-60)
	imgItem30.x = 50
	imgItem30.y = 250


    Item30Text = display.newText(txt30Sec[LangId] , _W / 2, 450, "Helvetica", 14 )
	Item30Text:setReferencePoint(display.TopLeftReferencePoint)
	Item30Text.x = 100
	Item30Text.y = 250
	local g = graphics.newGradient(
  		{ 255, 0, 0 },
  		{ 200, 200, 200 },
  					"down" )
	Item30Text:setTextColor(g)


	local itemColorSheet = graphics.newImageSheet( "img/change_color.png", options2 )
	local imgItemColor =display.newImageRect(itemColorSheet, 1, 50, 50 ) -- display.newImage("ball1.png",i*40-20  ,-60)
	imgItemColor.x = 50
	imgItemColor.y = 350

    ItemColorText = display.newText( txtChangeColor1[LangId] , _W / 2, 450, "Helvetica", 14 )
	ItemColorText:setReferencePoint(display.TopLeftReferencePoint)
	ItemColorText.x = 100
	ItemColorText.y = 330
	local g = graphics.newGradient(
  		{ 255, 0, 0 },
  		{ 200, 200, 200 },
  					"down" )
	ItemColorText:setTextColor(g)

    ItemColorText2 = display.newText( txtChangeColor2[LangId] , _W / 2, 450, "Helvetica", 14 )
	ItemColorText2:setReferencePoint(display.TopLeftReferencePoint)
	ItemColorText2.x = 100
	ItemColorText2.y = 350
	local g = graphics.newGradient(
  		{ 255, 0, 0 },
  		{ 200, 200, 200 },
  					"down" )
	ItemColorText2:setTextColor(g)


	imgItem30.touch = onItem30Touch
	imgItem30:addEventListener( "touch", imgItem30 )

	imgItemColor.touch = onItemColorTouch
	imgItemColor:addEventListener( "touch", imgItemColor )


	groupItemLayer:insert ( gameItemLayout )
	groupItemLayer:insert ( imgItem30 )
	groupItemLayer:insert ( imgItemColor )
	groupItemLayer:insert ( Item30Text )
	groupItemLayer:insert ( ItemColorText )
	groupItemLayer:insert ( ItemColorText2 )
	groupItemLayer:insert( menuText )
	groupItemLayer:insert( restartText )
	groupItemLayer:insert( nextText )	

	
end

	function drawColor1()
		local options =
		{
    		width = 400,
    		height = 394,
    		numFrames = 1,
		}

		for i = 1, 4 do
			ballName=""
			if i==1 then
				ballName="img/red_"
			end
			if i==2 then
				ballName="img/green_"
			end
			if i==3 then
				ballName="img/blue_"
			end
			if i==4 then
				ballName="img/yellow_"
			end
			local imageSheet = graphics.newImageSheet( ballName .. gameImgMode .. ".png", options )
			ball1[i] =display.newImageRect(imageSheet, 1, 40, 40 ) -- display.newImage("ball1.png",i*40-20  ,-60)
			ball1[i].i = i
			ball1[i].x = i*40 
			ball1[i].y = 400 
--			groupItemLayer:insert ( ball1[i] )
	
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
				ballName="img/red_"
			end
			if i==2 then
				ballName="img/green_"
			end
			if i==3 then
				ballName="img/blue_"
			end
			if i==4 then
				ballName="img/yellow_"
			end
			local imageSheet = graphics.newImageSheet( ballName .. gameImgMode .. ".png", options )
			ball2[i] =display.newImageRect(imageSheet, 1, 40, 40 ) -- display.newImage("ball1.png",i*40-20  ,-60)
			ball2[i].i = i
			ball2[i].j = j
			ball2[i].x = i * 40 
			ball2[i].y = 450 
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
	    	
	    	changeColor(color1 , color2)
	    	isGemTouchEnabled = true
			isGamePaused = false
			releaseItems()	
		end

	return true

	end

	function onItem30Touch( self, event )	-- was pre-declared

		if event.phase == "began"  then

	    

local products = {
	"com.gunapps.bumpyItem001",
	"com.gunapps.bumpyItem002",
	"com.gunapps.bumpyItem003",
	"com.gunapps.bumpyItem004",
}

storeMod.setTransactionEvent(function(state, transaction)
  
  aaaText = display.newText("girdi" ,100, 200, "Helvetica", 20 )
  
  if state == 'purchased' then
	  aaa2Text = display.newText("purchased" ,100, 200, "Helvetica", 20 )
  elseif state == "cancelled" then
	  aaa2Text = display.newText("cancelled" ,100, 200, "Helvetica", 20 )
  end
end)

storeMod.startStore(products,function(validProducts, invalidProducts)

     --now you can poplate your information to make in app purchasing
          local productIdentifier =  "com.gunapps.bumpyItem001" --event.target.product.productIdentifier

		aaa4Text = display.newText("PI:"..productIdentifier ,50, 500, "Helvetica", 42 )
		--aaa4Text:setReferencePoint(display.TopLeftReferencePoint)
          storeMod.purchaseItem(productIdentifier)

end)






--			if storeMod.purchaseItem(productIdentifier) then
--				gameTimer = gameTimer + 30
--			else
--				aaaText = display.newText("olmadi" ,100, 200, "Helvetica", 20 )
--			end
--			isGemTouchEnabled = true
--			isGamePaused = false
--			releaseItems()				
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
