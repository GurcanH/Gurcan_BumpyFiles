local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local screenW, screenH = display.contentWidth, display.contentHeight
local groupQuestLayer = display.newGroup()
local targetText1
local targetText2
local targetText3
local targetText4
local targetText5
local function onPauseTouchBack( self, event )	-- was pre-declared

	if event.phase == "began" and isGemTouchEnabled then

	    
--	    groupQuestLayer.alpha=0
		transition.to( groupQuestLayer, { time= 500, xScale=0,alpha=0 } )

		isGamePaused = false
		if level==5 then
			FindGift()
			if giveAddTime==0 then
				giveAddTime=giveAddTime + 1	
				ChangeGift()
				isGamePaused = true
				
				timer.performWithDelay( 600, ATAnimation )
			end
		end
		if level==10 then
			FindGift()
			if giveChangeColor==0 then
				giveChangeColor=giveChangeColor + 1	
				ChangeGift()
				isGamePaused = true
				timer.performWithDelay( 600, CCAnimation )
			end
		end
		if groupGameLayer ~= nil then
		    groupGameLayer.alpha=1
		end
		if imgTimer ~= nil then
		    imgTimer.alpha=1
		end
		if imgScoreText ~= nil then
		    imgScoreText.alpha=1
		end
		if txtScore ~= nil then
		    txtScore.alpha=1
		end
		if imgScore1 ~= nil then
		    imgScore1.alpha=1
		end
		if imgScore2 ~= nil then
		    imgScore2.alpha=1
		end
		if imgScore3~= nil then
		    imgScore3.alpha=1
		end
		if imgScore4 ~= nil then
		    imgScore4.alpha=1
		end

		showOrder()
		if bRed==true or bBlue == true or bYellow==true or bGreen==true then
--			showSmallBalls(0.3)
		end
	    hideSmallBalls(true)
		
   		

--		showGamePause (0.8) 
	end

return true

end

 function drawQuestScreen()
	    groupQuestLayer.alpha=1
	    groupQuestLayer.xScale=1
	    isGamePaused = true
	    showOrder()
	    --showSmallBalls(0)
	    hideSmallBalls(false)
		if groupGameLayer ~= nil then
		    groupGameLayer.alpha=0
		end
		if imgTimer ~= nil then
		    imgTimer.alpha=0
		end
		if txtScore ~= nil then
		    txtScore.alpha=0
		end
		if imgScoreText ~= nil then
		    imgScoreText.alpha=0
		end
		if imgScore1 ~= nil then
		    imgScore1.alpha=0
		end
		if imgScore2 ~= nil then
		    imgScore2.alpha=0
		end
		if imgScore3~= nil then
		    imgScore3.alpha=0
		end
		if imgScore4 ~= nil then
		    imgScore4.alpha=0
		end

		local options =
			{
    			width = 600,
    			height = 586,
    			numFrames = 1,
			}
			
	if background ~= nil then
		background:removeSelf()
		background = nil
	end
	if bg ~= nil then
		bg:removeSelf()
		bg = nil
	end

    local bg = display.newImage( "img/thinking2.png" )
	bg.touch = onPauseTouchBack
	bg:addEventListener( "touch", bg )

	local imageSheet = graphics.newImageSheet( "img/thinking.png", options )
	local background = display.newImageRect(imageSheet, 1, 320, 480 ) 
	background:setReferencePoint(display.TopLeftReferencePoint)
	background.x = 0--screenW / 2
	background.y = 0--sscreenH / 2
--	background:toFront()
	background.alpha=0
	background.touch = onPauseTouchBack
	background:addEventListener( "touch", background )
--	local cutText = 28
--	if string.len(LevelDescription) > 100 then
--		cutText = 28
--	end 
--	local wrappedText = textWrap( LevelDescription, cutText, "    ", "    " )
				--txtQuestText1[1]="Görev: " .. gameTimer .. " Saniye içinde " 
				--txtQuestText2[1]= target .. " puanı tamamla.. " 				
	if targetText1 ~= nil then
		targetText1:removeSelf()
		targetText1 = nil
	end
	if targetText2 ~= nil then
		targetText2:removeSelf()
		targetText2 = nil
	end
	if targetText3 ~= nil then
		targetText3:removeSelf()
		targetText3 = nil
	end
	if targetText4 ~= nil then
		targetText4:removeSelf()
		targetText4 = nil
	end
	if targetText5 ~= nil then
		targetText5:removeSelf()
		targetText5 = nil
	end

	targetText1 = display.newText( txtQuestText1[LangId], 166, 0, 580, 800, "Chalkduster", 14 )
	targetText1:setReferencePoint(display.TopCenterReferencePoint)
	targetText1.x = 350
	targetText1.y = 50
	targetText1:setTextColor(32,77,168)
--	targetText:toFront()

	targetText2 = display.newText( txtQuestText2[LangId], 166, 0, 580, 800, "Chalkduster", 14 )
	targetText2:setReferencePoint(display.TopCenterReferencePoint)
	targetText2.x = 350
	targetText2.y = 70
	targetText2:setTextColor(32,77,168)

	targetText3 = display.newText( txtQuestText3[LangId], 166, 0, 580, 800, "Chalkduster", 14 )
	targetText3:setReferencePoint(display.TopCenterReferencePoint)
	targetText3.x = 350
	targetText3.y = 90
	targetText3:setTextColor(32,77,168)

	targetText4 = display.newText( txtQuestText4[LangId], 166, 0, 580, 800, "Chalkduster", 14 )
	targetText4:setReferencePoint(display.TopCenterReferencePoint)
	targetText4.x = 350
	targetText4.y = 110
	targetText4:setTextColor(32,77,168)

	targetText5 = display.newText( txtQuestText5[LangId], 166, 0, 580, 800, "Chalkduster", 14 )
	targetText5:setReferencePoint(display.TopCenterReferencePoint)
	targetText5.x = 370
	targetText5.y = 130
	targetText5:setTextColor(32,77,168)

	groupQuestLayer:insert( bg )
	groupQuestLayer:insert( background )
	groupQuestLayer:insert( targetText1)
	groupQuestLayer:insert( targetText2)
	groupQuestLayer:insert( targetText3)
	groupQuestLayer:insert( targetText4)
	groupQuestLayer:insert( targetText5)


end




-- Called when the scene's view does not exist:
function scene:createScene( event )
         screenGroup = self.view
 --drawScreen()



end

--ball:addEventListener("touch", startDrag)
