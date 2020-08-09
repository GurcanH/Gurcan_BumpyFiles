
 
local storyboard = require( "storyboard" )
--local gamescene = require( "game-scene" )
local scene = storyboard.newScene()
local db = require( "db" )
local nolife = require( "nolife" )
local lang = require( "lang" )
local buyitemsmenu = require( "buyitems" )
local settings = require( "settings" )
--local reklam = require( "reklam" )
menuLevel=1
--findLevel()
--menuLevel = 1
--life = 5
maxLevelCount=110
gameLevel = 0
maxLife = 5
nextMinute = 20 
local timers = {}

groupLife = display.newGroup()
local  groupNameLayer = display.newGroup()
local  groupMain = display.newGroup()
local boolFirst = false
isSettingsCall = false
SoundId = 1
bumpySet = 1
LangId = 2
local reklamBasladi = false
local reklamSure = 0
noBumpySet = false

ads = require "ads"

--FillFullLife()
----------------------------------------------------------------------------------
-- 
--      NOTE:
--      
--      Code outside of listener functions (below) will only be executed once,
--      unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------
 
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local bg_rect, text1, text2, text3;
local _W = display.contentWidth 
local _H = display.contentHeight
-- Touch event listener for background image

--tapfortap = require "plugin.tapfortap"

local MALE = 0
local FEMALE = 0

local TOP = 1
local CENTER = 2
local BOTTOM = 3
local LEFT = 1
local RIGHT = 3
local ballLeft ={}


display.setStatusBar( display.HiddenStatusBar )




 function buttonAlphaControl()
	if page==1 then
		imgPrevious.alpha=0
	else
		imgPrevious.alpha=1
	end 
	
	if page  *10==maxLevelCount then
		imgNext.alpha=0
		imgComingSoon.alpha=1
	else
		imgNext.alpha=1
		imgComingSoon.alpha=0
	end 
	
	if boolFirst== false then
		imgNext.alpha=0
		imgPrevious.alpha=0
		imgComingSoon.alpha=0
	end
end

local function showSetting( self, event )
	if event.phase == "began"  then
		if SoundId==1 then
			local narrationSpeech = audio.loadStream("sound/Click.wav")
			local narrationChannel = audio.play( narrationSpeech)
		end
		isSettingsCall=true
		groupLife.alpha=0	
		imgSetting.alpha=0
		--imgBanner.alpha=0
		imgNext.alpha=0
		imgPrevious.alpha=0
		imgComingSoon.alpha=0
		drawSettingsScreen()	
--		storyboard.gotoScene( "settings", "fade", 400  )
		
		return true
	end
end 
local function onPlay( self, event )
	if event.phase == "began" and groupNameLayer.alpha==1  then
		groupNameLayer.alpha=0
		boolFirst = true
		groupLife.alpha = 1	
		imgSetting.alpha=1
		--imgBanner.alpha=1
		buttonAlphaControl()
		return true
	end
end 
local function onBuyTouch( self, event )
	if event.phase == "began" then
		buyType="GL"
		showAppItems()
--		FillFullLife()

		return true
	end
end 
function drawleftBalls()
--	print("hhhyy")
	local g1 = graphics.newGradient(
  		{ 255, 0, 0 },
  		{ 255, 255, 255 },
  					"down" )

	local g2 = graphics.newGradient(
  		{ 0, 255, 0 },
  		{ 255, 255, 255 },
  					"down" )

		local options =
		{
    		width = 40,
    		height = 40,
    		numFrames = 1,
		}

		for i = 1, 5 do
			if ballLeft[i] ~= nil then
				ballLeft[i]:removeSelf()
				ballLeft[i]=nil
			end
		end
		if txtLife ~= nil then
			txtLife:removeSelf()
			txtLife = nil
		end
		if txtLifeMin ~= nil then
			txtLifeMin:removeSelf()
			txtLifeMin = nil
		end
		if txtLifeBuy ~= nil then
			txtLifeBuy:removeSelf()
			txtLifeBuy = nil
		end
		findLife()
		if leftLife >0 then 
			--txtLife = display.newText( txtLeftLife[LangId] .. " : " , 0, 0, native.systemFontBold, 18 )
	 		--txtLife:setReferencePoint( display.TopLeftReferencePoint )
			--txtLife:setTextColor(g1)
			--txtLife.x = 25
			--txtLife.y = 100
    		--groupLife:insert( txtLife )		
			if imgBanner ~= nil then
				imgBanner:removeSelf()
				imgBanner=nil
			end
			imgBanner =display.newImage("img/bluebanner.png", 140, 25 ) 
			imgBanner:setReferencePoint( display.TopLeftReferencePoint )
    		groupLife:insert( imgBanner )		

			for i = 1, 5 do
				if leftLife >= i then

					local imageSheet = graphics.newImageSheet( "img/life.png", options )
					ballLeft[i] ={}
					ballLeft[i] =  display.newImageRect(imageSheet, 1, 30, 30 ) -- display.newImage("ball1.png",i*40-20  ,-60)
			 		ballLeft[i]:setReferencePoint( display.TopLeftReferencePoint )
					ballLeft[i].x = (i*30) + 120
					ballLeft[i].y = 30 
			    	groupLife:insert( ballLeft[i] )	
				end
			end

		else
			findLeftLifeTime()

			if imgBanner ~= nil then
				imgBanner:removeSelf()
				imgBanner=nil
			end
			imgBanner =display.newImage("img/bluebanner.png", 140, 25 ) 
			imgBanner:setReferencePoint( display.TopLeftReferencePoint )
    		groupLife:insert( imgBanner )		

			txtLifeBuy = display.newImage("img/buylife.png", 170, 25 ) 
	 		txtLifeBuy:setReferencePoint( display.TopLeftReferencePoint )
			txtLifeBuy.x = 220
			txtLifeBuy.y = 19
			txtLifeBuy.plus = display.newImage("img/numbers/plus2.png", 245, 40 ) 
			txtLifeBuy.plus.x = txtLifeBuy.x  + 55
			txtLifeBuy.plus.y = txtLifeBuy.y + 30
			txtLifeBuy.touch = onBuyTouch
			txtLifeBuy:addEventListener( "touch", txtLifeBuy )

    		groupLife:insert( txtLifeBuy )		
    		groupLife:insert( txtLifeBuy.plus )		

			txtLifeMin = display.newText( "" , 0, 0, "Chalkduster", 18 )
	 		txtLifeMin:setReferencePoint( display.TopLeftReferencePoint )
			txtLifeMin:setTextColor(255,0,0)
			txtLifeMin.x = 175
			txtLifeMin.y = 30

    		groupLife:insert( txtLifeMin )		


			if leftTime > 0 then
				local tt = os.date( '*t' )  -- get table of current date and time
				t1=os.time(tt)
				abc= os.difftime(leftTime, t1)
		

				sDate= os.date('*t', abc) 
				sSecond = sDate.sec
				sMin = sDate.min
				if string.len( sSecond ) == 1 then
					sSecond = "0" .. sSecond
				end
				if string.len( sMin ) == 1 then
					sMin = "0" .. sMin
				end
				txtLifeMin.text =  sMin ..":".. sSecond
			end
			
		end
		groupLife.alpha=1
end
	 


local function onSceneTouch( self, event )
	if event.phase == "began" then
		if self.alpha == 1 and groupNameLayer.alpha==0 then
			if leftLife>0 then
				--print("onSceneTouch")
				gameLevel = self.level
				isLifeTimeUpdate = false
				imgNext.alpha = 0
				imgPrevious.alpha=0
				imgComingSoon.alpha=0
				groupLife.alpha = 0	
				imgSetting.alpha=0
	--			imgBanner.alpha=0
				print("lll:"..imgSetting.alpha)
				storyboard.gotoScene( "game-scene", "fade", 400  )
			else
--				groupNoLifeLayer.alpha=1
--				groupNoLifeLayer:toFront()
				transition.from( txtLifeBuy, { time=2000,  xScale=2, yScale=2  })
--				transition.from( txtLifeBuy, {delay=2000, time=10,  xScale=1, yScale=1  })
			end
		end
--		return true
	end
	return true
end 


local function drawScreen ()

 imgLevel = {}
 textLevel = {}

	local options =
		{
    		width = 429,
    		height = 292,
    		numFrames = 1,
		}
	local options2 =
		{
    		width = 320,
    		height = 480,
    		numFrames = 1,
		}
	local options3 =
		{
    		width = 80,
    		height = 51,
    		numFrames = 1,
		}
	local options4 =
		{
    		width = 400,
    		height = 400,
    		numFrames = 1,
		}
	local options5 =
		{
    		width = 320,
    		height = 480,
    		numFrames = 1,
		}
	local options6 =
		{
    		width = 120,
    		height = 34,
    		numFrames = 1,
		}


	if imageSheetBG ~= nil then
		imageSheetBG:removeSelf()
		imageSheetBG=nil
	end


	local imageSheetBG = graphics.newImageSheet( "img/bg/bgmain.png", options2 )
	imgBG =   display.newImageRect(imageSheetBG, 1, 320, 480 ) 
	imgBG:setReferencePoint( display.TopLeftReferencePoint )
	imgBG:toBack()
	imgBG.x=0
	imgBG.y=0
--	imgBG.alpha=0
	screenGroup:insert( imgBG )


	local imageSheetS = graphics.newImageSheet( "img/settings/settingss.png", options3 )
	if imgSetting ~= nil then
		imgSetting:removeSelf()
		imgSetting=nil
	end
	imgSetting =display.newImageRect(imageSheetS, 1, 80, 51 ) 
	imgSetting.x =  60
	imgSetting.y =  40
	imgSetting.touch = showSetting
	imgSetting:addEventListener( "touch", imgSetting )

	imgSetting:toFront()
--	screenGroup:insert( imgSetting )

--	screenGroup.alpha=0

	if boolFirst== false then

		local imageSheetNameBG = graphics.newImageSheet( "img/bg/bgfirst.png", options5 )

--	ball = display.newImage( "img/gameover/go"..R..".png", screenW  / 2  -100 ,200 )
		imgNameBG =display.newImageRect(imageSheetNameBG, 1, 320, 480 ) 
		imgNameBG:setReferencePoint( display.TopLeftReferencePoint )
		imgNameBG.x =  0
		imgNameBG.y =  0
		groupNameLayer:insert( imgNameBG )


		local imageSheetName = graphics.newImageSheet( "img/name.png", options4 )
		imgName =display.newImageRect(imageSheetName, 1, 300, 300 ) 
		imgName:setReferencePoint( display.TopLeftReferencePoint )
		imgName.x =  15
		imgName.y =  0
		imgName:toFront()
		groupNameLayer:insert( imgName )

		local imageSheetPlay = graphics.newImageSheet( "img/play.png", options6 )
		imgPlay =display.newImageRect(imageSheetPlay, 1, 120, 34 ) 
		imgPlay:setReferencePoint( display.TopLeftReferencePoint )
		imgPlay.x =  100
		imgPlay.y =  310
		imgPlay:toFront()

		imgPlay.touch = onPlay
		imgPlay:addEventListener( "touch", imgPlay )

		groupNameLayer:insert( imgPlay )
		imgSetting.alpha=0
--		imgBanner.alpha=0
		imgNext.alpha=0
		imgPrevious.alpha=0
		imgComingSoon.alpha=0
	end

	
	local _x=0
	local _y=0
	for i= (page-1) * 10 + 1, (page-1) * 10 + 10 do

		
    	if _x % 4  == 0 then
    		_y=_y + 1
    		_x=0
    	end
    	if i  <10 then
    		levelStr = "level00" .. i 
    	elseif i  >=10 and i <100 then
    		levelStr = "level0" .. i 
    	else
    		levelStr =  "level" .. i 
    	end 

	local g1 = graphics.newGradient(
  		{ 0, 0, 255 },
  		{ 0, 0, 155 },
  					"down" )
        		
		local imageSheet = graphics.newImageSheet( "img/level.png", options )
		imgLevel[i] =   display.newImageRect(imageSheet, 1, 86, 58 ) 
		imgLevel[i]:setReferencePoint( display.TopLeftReferencePoint )
		if _y == 3 then
			imgLevel[i].x = _x  * 78 + 78
		else
			imgLevel[i].x = _x  * 78 -- + 86
		end
		imgLevel[i].y =  70*_y + 90
		imgLevel[i]:toFront()
		
		--print ("i:" ..  i )
		--print ("menuLevel:" ..  menuLevel )
		--imgLevel[i]:setFillColor(g1)


		textLevel[i] = display.newText(  i , 0, 0, native.systemFontBold, 12 )
		--"BrushScriptMT"
		textLevel[i]:setReferencePoint( display.TopLeftReferencePoint )
		textLevel[i].x = imgLevel[i].x + 40 
		textLevel[i].y =  imgLevel[i].y + 40
		textLevel[i]:toFront()


		if i <= menuLevel then
			imgLevel[i].alpha = 1
			textLevel[i].alpha = 1
		else
			imgLevel[i].alpha = 0.4
			textLevel[i].alpha = 0.4
		end
		imgLevel[i].level = i  -- + ((page-1) *10)
		--print ("imgLevel:" ..  i )
		imgLevel[i].touch = onSceneTouch
		imgLevel[i]:addEventListener( "touch", image )
		
	screenGroup:insert( imgLevel[i] )
	screenGroup:insert( textLevel[i] )

		_x=_x + 1       
	
	end 


	
	text3 = display.newText( "Touch to continue.", 0, 0, native.systemFontBold, 18 )
	text3:setTextColor( 255 ); text3.isVisible = false
--	text3:setReferencePoint( display.CenterReferencePoint )
	text3.x, text3.y = _W * 0.5, _H - 100
	screenGroup:insert( text3 )
	
	--print( "\n1: createScene event")

	timer.performWithDelay( 50, buttonAlphaControl )





end 

local function onNextTouch( self, event )
	if event.phase == "began" then

		for i= (page-1) * 10 + 1, (page-1) * 10 + 10 do
			imgLevel[i]:removeSelf()
			imgLevel[i]=nil
			textLevel[i]:removeSelf()
			textLevel[i]=nil
		end

		page = page + 1
		--print("page:" .. page)
		drawScreen()
		return true
	end
end 
local function onPreTouch( self, event )
	if event.phase == "began" then

		for i= (page-1) * 10 + 1, (page-1) * 10 + 10 do
			imgLevel[i]:removeSelf()
			imgLevel[i]=nil
			textLevel[i]:removeSelf()
			textLevel[i]=nil
		end

		page = page - 1
		--print("page:" .. page)
		drawScreen()
		return true
	end
end 


local function alphaSet(a)
	for i= (page-1) * 10 + 1, (page-1) * 10 + 10 do

		
		if i <= menuLevel then
			imgLevel[i].alpha = a
			textLevel[i].alpha = a
		end
	end 

end


local function gameTimerUpdate ()
	if isSettingsCall == false then
		drawleftBalls()
	end
end
local function reklamTimerUpdate ()

reklamSure=reklamSure + 1
	if reklamBasladi == true or reklamSure>=15 then
		timer.performWithDelay( 1000, alphaSet(1) )		
	end
end

function RunAdModAds()
	local provider = "admob"

	-- Your application ID
	local appID = "ca-app-pub-6414961667069598/1828390264"

	-- Load Corona 'ads' library

	local function adListener( event )
    	if event.isError then
	  --      statusText.text = event.response
		  reklamBasladi=true
    	else
		  reklamBasladi=true    	
	    --    statusText.text = "Hata Yok"
    	end
	end

	ads.hide()		
	ads.init( provider,appID, adListener )
	ads.show( "interstitial", { x=0, y=0 } )
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
         screenGroup = self.view
 
        -----------------------------------------------------------------------------
                
        --      CREATE display objects and add them to 'group' here.
        --      Example use-case: Restore 'group' from previously saved state.
        
        -----------------------------------------------------------------------------
        
	--menuBgImage = display.newRect( 0, 0, _W, _H)
	--menuBgImage:setFillColor(255, 20, 20)
	--screenGroup:insert( menuBgImage )

	--text1 = display.newText( "Gürcan Neslihanı Çok Seviyor", 0, 0, native.systemFontBold, 18 )
	--text1:setTextColor( 255 )
	--text1:setReferencePoint( display.CenterReferencePoint )
	--text1.x, text1.y = _W * 0.5, 50
	--screenGroup:insert( text1 )
	--text1.alpha=0
	
	--txtLife = display.newText( "Kalan Hak: " .. life, 0, 0, native.systemFontBold, 18 )
	--txtLife:setTextColor( 255 )
	--txtLife:setReferencePoint( display.TopLeftReferencePoint )
	--txtLife.x, txtLife.y = 25, 100
	--screenGroup:insert( txtLife )		
	--menuBgImage.touch = onSceneTouch
imgNext = display.newImage( "img/forward.png", 220,400 )
imgPrevious = display.newImage( "img/backward.png", 50,400 )
imgComingSoon = display.newImage( "img/comingsoon.png", 200,360 )
--imgNext:toFront()
--imgPrevious:toFront()

--screenGroup:insert( imgNext )
--screenGroup:insert( imgPrevious )

imgNext.touch = onNextTouch
imgNext:addEventListener( "touch", image )

imgPrevious.touch = onPreTouch
imgPrevious:addEventListener( "touch", image )


print ("createScene...")
		
findLevel()
--maxLevel=110
menuLevel =  maxLevel
--print("menuLevel:"..menuLevel)
if menuLevel< 11 then
	page = 1 
elseif  menuLevel>= 11 and  menuLevel< 21  then
	page = 2 
elseif  menuLevel>= 21 and  menuLevel< 31  then
	page = 3
elseif  menuLevel>= 31 and  menuLevel< 41  then
	page = 4
elseif  menuLevel>= 41 and  menuLevel< 51  then
	page = 5
elseif  menuLevel>= 51 and  menuLevel< 61  then
	page = 6
elseif  menuLevel>= 61 and  menuLevel< 71  then
	page = 7
elseif  menuLevel>= 71 and  menuLevel< 81  then
	page = 8
elseif  menuLevel>= 81 and  menuLevel< 91  then
	page = 9
elseif  menuLevel>= 91 and  menuLevel< 101  then
	page = 10
elseif  menuLevel>= 101 and  menuLevel< 111  then
	page = 11
end
drawScreen()
drawleftBalls()
--createFlags()
FindLang()	
FindSound()	
FindBumpySet()	
CreateBumpyStore()
reklamBasladi=false
alphaSet(0.4)
reklamSure=0
RunAdModAds()


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
        
        --storyboard.purgeScene( "game-scene" )

	--print( "1: enterScene event" )
	
	-- remove previous scene's view
	--storyboard.purgeScene( "game-scene" )
	

	local memTimer = timer.performWithDelay( 100, showMem, 1 )

	timers.gameTimerUpdate = timer.performWithDelay(1000, gameTimerUpdate, 0)
	timers.reklamTimerUpdate = timer.performWithDelay(200, reklamTimerUpdate, 0)

-- Initialize Tap for Tap with your account API key
--tapfortap.initialize("dc7b1fa6e5c2bb21832ef13855c6b503")
--tapfortap.createAdView(TOP ,CENTER)

end
 
 
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local screenGroup = self.view
        
	if timers.gameTimerUpdate then 
		timer.cancel(timers.gameTimerUpdate)
		timers.gameTimerUpdate = nil
	 end
	if timers.reklamTimerUpdate then 
		timer.cancel(timers.reklamTimerUpdate)
		timers.reklamTimerUpdate = nil
	 end
        -----------------------------------------------------------------------------
        
        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
        
        -----------------------------------------------------------------------------
        
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