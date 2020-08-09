local _W = display.contentWidth 
local _H = display.contentHeight
local screenW, screenH = display.contentWidth, display.contentHeight
local storyboard = require( "storyboard" )
local storeMod = require("storeMod")
buyType=""
itemCount=0
loadingOrder = 0
----------------------------------------------------
local timers = {}
local imgLoading1 
local imgDownloading
local scene = storyboard.newScene()

local function loadingUpdate()
if loadingOrder==3 then loadingOrder=0 end
loadingOrder=loadingOrder + 1 

	if imgLoading1 ~= nil then
		imgLoading1:removeSelf()
		imgLoading1=nil
	end

    imgLoading1 = display.newImage( "img/loading" ..loadingOrder..  ".png", _W/4+55,150 )
	imgLoading1:setReferencePoint(display.TopLeftReferencePoint)

end
function closeAppItems()

	if imgDownloading ~= nil then
		imgDownloading:removeSelf()
		imgDownloading =nil
	end

	if buyType=="CC" or buyType=="AT"  then
		isGemTouchEnabled = true
		isGamePaused = false
	end

	if gameItemLayout ~= nil then
		gameItemLayout:removeSelf()
		gameItemLayout=nil
	end
	if imgBanner1 ~= nil then
		imgBanner1:removeSelf()
		imgBanner1=nil
	end
	if imgBanner2 ~= nil then
		imgBanner2:removeSelf()
		imgBanner2=nil
	end
	if imgBanner3 ~= nil then
		imgBanner3:removeSelf()
		imgBanner3=nil
	end
	if imgBannerText1 ~= nil then
		imgBannerText1:removeSelf()
		imgBannerText1=nil
	end
	if imgBannerText2 ~= nil then
		imgBannerText2:removeSelf()
		imgBannerText2=nil
	end
	if imgBannerText3 ~= nil then
		imgBannerText3:removeSelf()
		imgBannerText3=nil
	end
	if txtTitle ~= nil then
		txtTitle:removeSelf()
		txtTitle=nil
	end
	if timers.loadingUpdate then 
		timer.cancel(timers.loadingUpdate)
		timers.loadingUpdate = nil
	 end
	if imgLoading1 ~= nil then
		imgLoading1:removeSelf()
		imgLoading1=nil
	end
	if imgExit ~= nil then
		imgExit:removeSelf()
		imgExit=nil
	end
	if txtResult ~= nil then
		txtResult:removeSelf()
		txtResult=nil
	end
	if txtDesc ~= nil then
		txtDesc:removeSelf()
		txtDesc=nil
	end

				


end

function showAppItems()
	timers.loadingUpdate = timer.performWithDelay(500, loadingUpdate, 0)
 
   	groupItemLayer = display.newGroup()




	local options2 =
		{
   			width = 320,
  			height = 480,
   			numFrames = 1,
		}	
	imageSheet = graphics.newImageSheet( "img/bg/bgitems.png", options2 )
					
	gameItemLayout =display.newImageRect(imageSheet, 1, 175, 250 ) 
 	gameItemLayout:setReferencePoint(display.TopLeftReferencePoint)
	gameItemLayout.x =  _W/4 -10
	gameItemLayout.y =  _H/4 -10
	gameItemLayout.alpha = 1


	function onTouch(self, event)
		if event.phase == "began" then
			if imgDownloading ~= nil then
			   imgDownloading:removeSelf()
		 	   imgDownloading =nil
			end
			local productIdentifier = event.target.product.productIdentifier
			itemCount = event.target.count
		    imgDownloading = display.newImage( "img/downloading.png", _W/4+55,150 )
			imgDownloading:setReferencePoint(display.TopLeftReferencePoint)
			txtDesc.alpha=0
			
          	storeMod.purchaseItem(productIdentifier)
		return true
		end
	end
	function onClose(self, event)
		if event.phase == "began" then
			closeAppItems()
		return true
		end
	end

--	local imgBuy = display.newImage( "button.png", _W/4 + 10,_H/4 + 150  )
--	imgBuy:setReferencePoint(display.TopLeftReferencePoint)

	local options =
		{
   			width = 312,
  			height = 84,
   			numFrames = 1,
		}	

	if imgBanner1 ~= nil then
		imgBanner1:removeSelf()
		imgBanner1=nil
	end
	if imgBanner2 ~= nil then
		imgBanner2:removeSelf()
		imgBanner2=nil
	end
	if imgBanner3 ~= nil then
		imgBanner3:removeSelf()
		imgBanner3=nil
	end
	if imgBannerText1 ~= nil then
		imgBannerText1:removeSelf()
		imgBannerText1=nil
	end
	if imgBannerText2 ~= nil then
		imgBannerText2:removeSelf()
		imgBannerText2=nil
	end
	if imgBannerText3 ~= nil then
		imgBannerText3:removeSelf()
		imgBannerText3=nil
	end

				
	imageSheet = graphics.newImageSheet( "img/itembanner1.png", options )
					
	imgBanner1 =display.newImageRect(imageSheet, 1, 156, 42 ) 
 	imgBanner1:setReferencePoint(display.TopLeftReferencePoint)
	imgBanner1.x =  _W/4 +2
	imgBanner1.y =  200


	imageSheet = graphics.newImageSheet( "img/itembanner2.png", options )
					
	imgBanner2 =display.newImageRect(imageSheet, 1, 156, 42 ) 
 	imgBanner2:setReferencePoint(display.TopLeftReferencePoint)
	imgBanner2.x =  _W/4 +2
	imgBanner2.y =  250
	if buyType=="GL"  or buyType=="SET2" or buyType=="SET3"  then
		imgBanner2.alpha=0
	end


	imageSheet = graphics.newImageSheet( "img/itembanner3.png", options )
					
	imgBanner3 =display.newImageRect(imageSheet, 1, 156, 42 ) 
 	imgBanner3:setReferencePoint(display.TopLeftReferencePoint)
	imgBanner3.x =  _W/4 +2
	imgBanner3.y =  300
	if buyType=="GL"  or buyType=="SET2" or buyType=="SET3"  then
		imgBanner3.alpha=0
	end



	if buyType=="CC" then
		txtTitle = display.newText("Change Color" ,_W/4 + 30, _H/4 , "Helvetica", 16 )
	end
	if buyType=="AT" then
		txtTitle = display.newText("Fill Up The Time" ,_W/4 + 30, _H/4 , "Helvetica", 16 )
	end
	if buyType=="GL" then
		txtTitle = display.newText("More Game Life" ,_W/4 + 30, _H/4 , "Helvetica", 16 )
	end
	if buyType=="SET2" or buyType=="SET3" then
		txtTitle = display.newText("Get Smiley Set" ,_W/4 + 30, _H/4 , "Helvetica", 16 )
	end
	txtTitle:setTextColor(255,0,0)
	txtTitle:setReferencePoint(display.TopLeftReferencePoint)

	loadingOrder=1
    imgLoading1 = display.newImage( "img/loading1.png", _W/4+55,150 )
	imgLoading1:setReferencePoint(display.TopLeftReferencePoint)

    imgExit = display.newImage( "img/x.png", 60,100 )
	imgExit:setReferencePoint(display.TopLeftReferencePoint)
	imgExit.touch = onClose
	imgExit:addEventListener( "touch", imgExit )



	txtResult = display.newText("" ,_W/4 + 50, _H/4 + 125, "Helvetica", 14 )
	txtResult:setReferencePoint(display.TopLeftReferencePoint)


	--txtBuy = display.newText("" ,_W/4 + 75, _H/4 + 175, "Helvetica", 20 )
	--imgBuy.touch = onTouch
	--imgBuy:addEventListener( "touch", imgBuy )




storeMod.setTransactionEvent(function(state, transaction)

  if state == 'purchased' then
	if buyType=="CC" then
		ChangeColorCount = ChangeColorCount + itemCount
		ChangeChangeColor()
		updateBuyItems()
	end
	if buyType=="AT" then
		AddTimeCount = AddTimeCount + itemCount
		ChangeAddTime()
		updateBuyItems()
	end
	if buyType=="GL" then
		FillFullLife()
	end
	if buyType=="SET2" then
		AddBumpyStore(2)	
		FindBumpyStore(2)
	end
	if buyType=="SET3" then
		AddBumpyStore(3)	
		FindBumpyStore(3)
	end
	imgDownloading.alpha=0
	txtDesc.alpha=1
	closeAppItems()
	--txtResult.text="Item Satın Alındı"
  elseif state == "cancelled" then
	--txtResult.text="Item Satın Alınamadı"
	imgDownloading.alpha=0
	txtDesc.alpha=1
	if LangId==1 then
		txtDesc.text="Satın alma işlemi tamamlanamadı."
	end
	if LangId==2 then
		txtDesc.text="Buying request is not completed."
	end
  end

end)


local productsCC = {
	"com.gunapps.bumpyItem001",
	"com.gunapps.bumpyItemCC6",
	"com.gunapps.bumpyItemCC15",
}
local productsAT = {
	"com.gunapps.bumpyItem002",
	"com.gunapps.bumpyItemAT6",
	"com.gunapps.bumpyItemAT15",
}
local productsGL = {
	"com.gunapps.bumpyItem003",
}
local productsSET2 = {
	"com.gunapps.bumpyItemNC001",
}
local productsSET3 = {
	"com.gunapps.bumpyItemNC002",
}

local products={}
if buyType=="CC" then
	products =  productsCC
end
if buyType=="AT" then
	products =  productsAT
end
if buyType=="GL" then
	products =  productsGL
end
if buyType=="SET2" then
	products =  productsSET2
end
if buyType=="SET3" then
	products =  productsSET3
end


---this gives you all the information you need form your products
---pressing this activates the store and gives you the product information
storeMod.startStore(products,function(validProducts, invalidProducts)
     --now you can poplate your info to make in app purchasing
  for k,v in ipairs(validProducts) do

   	 --txtBuy:setReferencePoint(display.TopLeftReferencePoint)
     --txtBuy.text= v.localizedPrice
--   	 txtTitle:setReferencePoint(display.TopLeftReferencePoint)
-- 	 txtTitle.text= "SSS" .. v.title 
	imgLoading1.alpha=0
	if timers.loadingUpdate then 
		timer.cancel(timers.loadingUpdate)
		timers.loadingUpdate = nil
	 end
	local wrappedText
	if k==1 then
-- 	   if v.productIdentifier ~= "com.gunapps.bumpyItem003" then 
--	   	   wrappedText = textWrap( v.description , 32, "    ", "    " )
--	   else
	   	   wrappedText =  v.description
--	   end
	   	 
	   txtDesc = display.newText(wrappedText ,_W/4 , _H/4 + 25,175, 250,  "Helvetica", 12 )
   	   txtDesc:setReferencePoint(display.TopLeftReferencePoint)
	end
	if v.productIdentifier == "com.gunapps.bumpyItem001" or v.productIdentifier == "com.gunapps.bumpyItem002" then
		imgBannerText1 = display.newText("x3 - " .. v.localizedPrice ,_W/4 + 50, _H/4 + 125, "Helvetica", 14 )
		imgBannerText1:setReferencePoint(display.TopLeftReferencePoint)
		imgBannerText1.x =  _W/4 +50
		imgBannerText1.y =  215
		imgBannerText1:setTextColor(255,0,0)
		imgBannerText1.product = v
		imgBannerText1.count = 3
		imgBannerText1.touch = onTouch
		imgBannerText1:addEventListener( "touch", imgBannerText1 )

	end 
	if v.productIdentifier == "com.gunapps.bumpyItem003" or v.productIdentifier =="com.gunapps.bumpyItemNC001"  or v.productIdentifier =="com.gunapps.bumpyItemNC002" then
		imgBannerText1 = display.newText( v.localizedPrice ,_W/4 + 50, _H/4 + 125, "Helvetica", 14 )
		imgBannerText1:setReferencePoint(display.TopLeftReferencePoint)
		imgBannerText1.x =  _W/4 +50
		imgBannerText1.y =  215
		imgBannerText1:setTextColor(255,0,0)
		imgBannerText1.product = v
		imgBannerText1.count = 1
		imgBannerText1.touch = onTouch
		imgBannerText1:addEventListener( "touch", imgBannerText1 )

	end 
	if v.productIdentifier == "com.gunapps.bumpyItemCC6" or v.productIdentifier == "com.gunapps.bumpyItemAT6" then
		imgBannerText2 = display.newText("x6 - " .. v.localizedPrice ,_W/4 + 50, _H/4 + 125, "Helvetica", 14 )
		imgBannerText2:setReferencePoint(display.TopLeftReferencePoint)
		imgBannerText2.x =  _W/4 +50
		imgBannerText2.y =  265
		imgBannerText2:setTextColor(255,0,0)
		imgBannerText2.product = v
		imgBannerText2.count = 6
		imgBannerText2.touch = onTouch
		imgBannerText2:addEventListener( "touch", imgBannerText2 )
	end 
	if v.productIdentifier == "com.gunapps.bumpyItemCC15" or v.productIdentifier == "com.gunapps.bumpyItemAT15" then
		imgBannerText3 = display.newText("x15 - " .. v.localizedPrice ,_W/4 + 50, _H/4 + 125, "Helvetica", 14 )
		imgBannerText3:setReferencePoint(display.TopLeftReferencePoint)
		imgBannerText3.x =  _W/4 +40
		imgBannerText3.y =  315
		imgBannerText3:setTextColor(255,0,0)
		imgBannerText3.product = v
		imgBannerText3.count = 15
		imgBannerText3.touch = onTouch
		imgBannerText3:addEventListener( "touch", imgBannerText3)
	end 
  end
end)







 	
return true	
end

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
        
	timers.loadingUpdate = timer.performWithDelay(500, loadingUpdate, 0)

end
 
 
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local screenGroup = self.view
        
        -----------------------------------------------------------------------------
        
        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
        
        -----------------------------------------------------------------------------
       

end
