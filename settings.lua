
---------------------------------------------------------------------------------------
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local screenW, screenH = display.contentWidth, display.contentHeight
local groupSettingsLayer = display.newGroup()
local targetText
local imgSetIcon1
local imgSetIcon2
local imgSetIcon3
local imgSetIcon4
local imgSetIcon5
local bg
local imgMenu
local imgBanner
local imgResume
local imgResumeX
local setStatu=1
local imgSet1
local imgSet2
local imgSet3
local imgSet1plus
local imgSet2plus
local imgSetText1
local imgSetText2
local imgSetText3
local imgSetText4
local imgSetText5
local imgSetText6
local _W = display.contentWidth 
local _H = display.contentHeight

local imgHTPBG
local txthtpCaption
local txthtp1_1
local txthtp1_2
local txthtp1_3
local txthtp2_1
local txthtp2_2
local txthtp2_3
local txthtp3_1
local txthtp3_2
local txthtp3_3
local txthtp4

local imgCredits
local imgGurcan
local txtGurcan1
local txtGurcan2
local imgNesli
local txtNesli1
local txtNesli1_1
local txtNesli2
local imgName
local txtName2
local txtName1

local imgCredits
local imgNesli
local imgGurcan


local store = require "store"

function transactionCallback( event )
    local transaction = event.transaction
    if transaction.state == "purchased" then
        print("Transaction succuessful!")

    elseif transaction.state == "restored" then

        print("Transaction restored (from previous session)")
        print("productIdentifier", transaction.productIdentifier)

        if transaction.productIdentifier ==	"com.gunapps.bumpyItemNC001" then
			AddBumpyStore(2)	
        end
        if transaction.productIdentifier ==	"com.gunapps.bumpyItemNC002" then
			AddBumpyStore(3)	
        end

        print("receipt", transaction.receipt)
        print("transactionIdentifier", transaction.identifier)
        print("date", transaction.date)
        print("originalReceipt", transaction.originalReceipt)
        print("originalTransactionIdentifier", transaction.originalIdentifier)
        print("originalDate", transaction.originalDate)

    elseif transaction.state == "cancelled" then
        print("User cancelled transaction")

    elseif transaction.state == "failed" then
        print("Transaction failed, type:", transaction.errorType, transaction.errorString)
		if LangId==1 then
			imgSetText6.text="Item Bulunamadı"
		end
		if LangId==2 then
			imgSetText6.text="No Items Founded"
		end

    else
        print("unknown event")
    end

    store.finishTransaction( transaction )
end




local function releaseObject(o)
	if o~= nil then
		display.remove( o )
	end
end
local function restoreItems(self,event)
	if event.phase == "began"  then
		if SoundId==1 then
			local narrationSpeech = audio.loadStream("sound/Click.wav")
			local narrationChannel = audio.play( narrationSpeech)
		end

		if LangId==1 then
			imgSetText6.text="Itemlar Yükleniyor.."
		end
		if LangId==2 then
			imgSetText6.text="Restoring Items..."
		end

		store.init( transactionCallback )
		store.restore()
		if LangId==1 then
			imgSetText6.text="Itemlar Yüklendi.."
		end
		if LangId==2 then
			imgSetText6.text="Restored Items..."
		end

		return true
	end
end
local function onNone( self, event )	-- was pre-declared
	return true
--Bütün Baground tıklandığında bişey yapmaması için eklendi.
end

local function onPauseTouchHTP( self, event )	-- was pre-declared

	if event.phase == "began"  then
		releaseObject(imgHTPBG)
		releaseObject(txthtpCaption)
		releaseObject(txthtp1_1)
		releaseObject(txthtp1_2)
		releaseObject(txthtp1_3)
		releaseObject(txthtp2_1)
		releaseObject(txthtp2_2)
		releaseObject(txthtp2_3)
		releaseObject(txthtp3_1)
		releaseObject(txthtp3_2)
		releaseObject(txthtp3_3)
		releaseObject(txthtp4)
		releaseObject(imgResumeX)
	end

return true

end

local function onCloseCredits( self, event )	-- was pre-declared

	if event.phase == "began"  then
		releaseObject(imgCredits)
		releaseObject(imgGurcan)
		releaseObject(txtGurcan1)
		releaseObject(txtGurcan2)
		releaseObject(imgNesli)
		releaseObject(txtNesli1)
		releaseObject(txtNesli1_1)
		releaseObject(txtNesli2)
		releaseObject(imgName)
		releaseObject(txtName2)
		releaseObject(txtName1)
	end

return true

end


local function onPauseTouchBack( self, event )	-- was pre-declared

	if event.phase == "began"  then
		groupSettingsLayer.alpha=0
		storyboard.gotoScene( "menu-scene", "fade", 400  )
	    
		isSettingsCall=false
		groupLife.alpha=1	
		imgSetting.alpha=1
		buttonAlphaControl()
	end

return true

end
local function setText()

	releaseObject(imgSetText1)
    imgSetText1 = display.newText( "bbbbb" , 300, 300, "Chalkduster", 12 )
	imgSetText1:setReferencePoint(display.TopLeftReferencePoint)
	imgSetText1.y=220
	imgSetText1.touch = switchFlag
	imgSetText1:addEventListener( "touch", imgSetText1 )
	groupSettingsLayer:insert( imgSetText1 )

	releaseObject(imgSetText2)
    imgSetText2 = display.newText( " " , 40, 40, "Chalkduster", 12 )
	imgSetText2:setReferencePoint(display.TopLeftReferencePoint)
	imgSetText2.y=260
	imgSetText2.touch = switchSound
	imgSetText2:addEventListener( "touch", imgSetText2 )
	groupSettingsLayer:insert( imgSetText2 )

	releaseObject(imgSetText3)
    imgSetText3 = display.newText( " " , 40, 40, "Chalkduster", 12 )
	imgSetText3:setReferencePoint(display.TopLeftReferencePoint)
	imgSetText3.y=295
	imgSetText3.touch = switchSet
	imgSetText3:addEventListener( "touch", imgSetText3 )
	groupSettingsLayer:insert( imgSetText3 )

	releaseObject(imgSetText4)
    imgSetText4 = display.newText( " " , 40, 40, "Chalkduster", 12 )
	imgSetText4:setReferencePoint(display.TopLeftReferencePoint)
	imgSetText4.y=373
	imgSetText4.touch = showHowtoPlay
	imgSetText4:addEventListener( "touch", imgSetText4 )
	groupSettingsLayer:insert( imgSetText4)

	releaseObject(imgSetText5)
    imgSetText5 = display.newText( " " , 40, 40, "Chalkduster", 12 )
	imgSetText5:setReferencePoint(display.TopLeftReferencePoint)
	imgSetText5.y=410
	imgSetText5.touch = showInformation
	imgSetText5:addEventListener( "touch", imgSetText5 )
	groupSettingsLayer:insert( imgSetText5)

	releaseObject(imgSetText6)
    imgSetText6 = display.newText( " " , 40, 40, "Chalkduster", 12 )
	imgSetText6:setReferencePoint(display.TopLeftReferencePoint)
	imgSetText6.y=333
	imgSetText6.touch = restoreItems
	imgSetText6:addEventListener( "touch", imgSetText6 )
	groupSettingsLayer:insert( imgSetText6)



	if LangId==1 then
    	imgSetText1.text = "Dil Seçimi" 
    	imgSetText1.x=120

		if SoundId==1 then
	    	imgSetText2.text = "Ses Açık" 
	    	imgSetText2.x=130
	    end
		if SoundId==2 then
	    	imgSetText2.text = "Ses Kapalı" 
	    	imgSetText2.x=135
	    end
    	imgSetText3.text = "Smiley'ni değiştir" 
	   	imgSetText3.x=160
    	imgSetText4.text = "Nasıl oynanır" 
	   	imgSetText4.x=145
    	imgSetText5.text = "Oyun hakkında" 
	   	imgSetText5.x=152
    	imgSetText6.text = "Itemları Geri Yükle" 
	   	imgSetText6.x=168
	end
	if LangId==2 then
    	imgSetText1.text = "Choose Your Language"
    	imgSetText1.x=165
		if SoundId==1 then
	    	imgSetText2.text = "Sound On" 
	    	imgSetText2.x=135
	    end
		if SoundId==2 then
	    	imgSetText2.text = "Sound Off" 
	    	imgSetText2.x=135
	    end
    	imgSetText3.text = "Change your smileys" 
	   	imgSetText3.x=175
    	imgSetText4.text = "How to play" 
	   	imgSetText4.x=145
    	imgSetText5.text = "Credits" 
	   	imgSetText5.x=130
    	imgSetText6.text = "Restore Purchases" 
	   	imgSetText6.x=165

	   	
	end
end
function createFlags()
	releaseObject(imgSetIcon1)
	if LangId==1 then
    	imgSetIcon1 = display.newImage( "img/settings/turkishflag.png" )
	end
	if LangId==2 then
    	imgSetIcon1 = display.newImage( "img/settings/englishflag.png" )
	end
	
	imgSetIcon1:setReferencePoint(display.TopLeftReferencePoint)
	imgSetIcon1.x=60
	imgSetIcon1.y=211
	imgSetIcon1.touch = switchFlag
	imgSetIcon1:addEventListener( "touch", imgSetIcon1 )
	groupSettingsLayer:insert( imgSetIcon1 )


end
function switchFlag(self, event)
	if event.phase == "began" then
		if SoundId==1 then
			local narrationSpeech = audio.loadStream("sound/Click.wav")
			local narrationChannel = audio.play( narrationSpeech)
		end
		if LangId==1 then
			LangId=2 
		elseif LangId==2 then
			LangId=1
		end
	createFlags()
	ChangeLang()
	setText()	
	return true
	end
end
function switchSound(self, event)
		if SoundId==1 then
			local narrationSpeech = audio.loadStream("sound/Click.wav")
			local narrationChannel = audio.play( narrationSpeech)
		end
	if event.phase == "began" then
		if SoundId==1 then
			SoundId=2 
		elseif SoundId==2 then
			SoundId=1
		end
	createSound()
	ChangeSound()	
	setText()	
	return true
	end
end
function createSound()
	releaseObject(imgSetIcon2)
	if SoundId==1 then
	    imgSetIcon2 = display.newImage( "img/settings/soundon.png" )
	end
	if SoundId==2 then
	    imgSetIcon2 = display.newImage( "img/settings/soundoff.png" )
	end
	imgSetIcon2:setReferencePoint(display.TopLeftReferencePoint)
	imgSetIcon2.x=60
	imgSetIcon2.y=249
	imgSetIcon2.touch = switchSound
	imgSetIcon2:addEventListener( "touch", imgSetIcon2 )
	groupSettingsLayer:insert( imgSetIcon2 )

end
function showSet(self, event)
	if event.phase == "began" then
		if SoundId==1 then
			local narrationSpeech = audio.loadStream("sound/Click.wav")
			local narrationChannel = audio.play( narrationSpeech)
		end
		if self.store==true then
				if self.set ==2 then
					buyType="SET2"
				end
				if self.set ==3 then
					buyType="SET3"
				end
		showAppItems()
		else		
			bumpySet = self.set
			createSets()
			ChangeBumpySet()	
			showSetIcons()
		end
	end 
end

function showSetIcons()

	local optionsSet =
	{
    	width = 400,
	    height = 394,
    	numFrames = 1,
	}

	local imageSheet1 
	local imageSheet2 

	if bumpySet==1 then
	    imageSheet1 = graphics.newImageSheet( "img/set/green2_glass.png", optionsSet )
	    imageSheet2 = graphics.newImageSheet( "img/set/blue3_1.png", optionsSet )
	end
	if bumpySet==2 then
	    imageSheet1 = graphics.newImageSheet( "img/set/yellow1_1.png", optionsSet )
	    imageSheet2 = graphics.newImageSheet( "img/set/blue3_1.png", optionsSet )
	end
	if bumpySet==3 then
	    imageSheet1 = graphics.newImageSheet( "img/set/yellow1_1.png", optionsSet )
	    imageSheet2 = graphics.newImageSheet( "img/set/green2_glass.png", optionsSet )
	end

	releaseObject(imgSet1plus)
	releaseObject(imgSet1)
	imgSet1 =display.newImageRect(imageSheet1, 1, 30, 30 )  
	imgSet1.x =  140
	imgSet1.y =  305
	imgSet1.touch = showSet
	imgSet1:addEventListener( "touch", imgSet1 )
	groupSettingsLayer:insert( imgSet1 )


	releaseObject(imgSet2plus)
	releaseObject(imgSet2)
	imgSet2 =display.newImageRect(imageSheet2, 1, 30, 30 )  
	imgSet2.x =  180
	imgSet2.y =  305
	imgSet2.touch = showSet
	imgSet2:addEventListener( "touch", imgSet2 )
	groupSettingsLayer:insert( imgSet2 )

	if bumpySet==1 then
		imgSet1.set = 2
		imgSet2.set = 3	
	end
	if bumpySet==2 then
		imgSet1.set = 1
		imgSet2.set = 3	
	end
	if bumpySet==3 then
		imgSet1.set = 1
		imgSet2.set = 2	
	end

	if FindBumpyStore(imgSet1.set) == false then
		imgSet1.store=true
		imgSet1plus = display.newImage("img/numbers/plus2.png", 245, 40 ) 
		imgSet1plus.x = imgSet1.x -15
		imgSet1plus.y = imgSet1.y +15
		groupSettingsLayer:insert( imgSet1plus )
	end
	if FindBumpyStore(imgSet2.set) == false then
		imgSet2.store=true
		imgSet2plus = display.newImage("img/numbers/plus2.png", 245, 40 ) 
		imgSet2plus.x = imgSet2.x -15
		imgSet2plus.y = imgSet2.y +15
		groupSettingsLayer:insert( imgSet2plus )
	end

end

function switchSet(self, event)
	if event.phase == "began"  then
		if SoundId==1 then
			local narrationSpeech = audio.loadStream("sound/Click.wav")
			local narrationChannel = audio.play( narrationSpeech)
		end
		if setStatu==1 then
			showSetIcons()
			imgSetText3.alpha=0
			setStatu=2 
		elseif 	setStatu==2 then
			imgSetText3.alpha=1
			releaseObject(imgSet1plus)
			releaseObject(imgSet1)
			releaseObject(imgSet2plus)
			releaseObject(imgSet2)
			setStatu=1 
		end
		return true
	end
end
function createSets()
	local optionsSet =
	{
    	width = 400,
	    height = 394,
    	numFrames = 1,
	}
	local imageSheet1
	
	if bumpySet==1 then
	    imageSheet1 = graphics.newImageSheet( "img/set/yellow1_1.png", optionsSet )
	end
	if bumpySet==2 then
	   imageSheet1 = graphics.newImageSheet( "img/set/green2_glass.png", optionsSet )
	end
	if bumpySet==3 then
	   imageSheet1 = graphics.newImageSheet( "img/set/blue3_1.png", optionsSet )
	end
	

	
	releaseObject(imgSetIcon3)
	imgSetIcon3 =display.newImageRect(imageSheet1, 1, 30, 30 )  
	imgSetIcon3:setReferencePoint(display.TopLeftReferencePoint)
	imgSetIcon3.x=60
	imgSetIcon3.y=288
	imgSetIcon3.touch = switchSet
	imgSetIcon3:addEventListener( "touch", imgSetIcon3 )
	groupSettingsLayer:insert( imgSetIcon3 )
end
function showInformation()
		if SoundId==1 then
			local narrationSpeech = audio.loadStream("sound/Click.wav")
			local narrationChannel = audio.play( narrationSpeech)
		end
	releaseObject(imgCredits)
    imgCredits = display.newImage( "img/settings/credits.png" )
	imgCredits:setReferencePoint(display.TopLeftReferencePoint)
	imgCredits.x =  0
	imgCredits.y =  0
	imgCredits.touch = onCloseCredits
	imgCredits:addEventListener( "touch", imgCredits )

	local optionsCr =
	{
    	width = 244,
	    height = 244,
    	numFrames = 1,
	}

	local imageSheet1 
	
	imageSheet1 = graphics.newImageSheet( "img/settings/gurcan.png", optionsCr )
	releaseObject(imgGurcan)
    imgGurcan =display.newImageRect(imageSheet1, 1, 80, 80 ) -- display.newImage( "img/settings/gurcan.png" )
	imgGurcan:setReferencePoint(display.TopLeftReferencePoint)
	imgGurcan.x =  50
	imgGurcan.y =  80

	releaseObject(txtGurcan1)
    txtGurcan1 = display.newText( "Programmer" , 300, 300, "Chalkduster", 11 )
	txtGurcan1:setReferencePoint(display.TopLeftReferencePoint)
	txtGurcan1:setTextColor(255,0,0)
	txtGurcan1.rotation=-10
	txtGurcan1.x =  47
	txtGurcan1.y =  170

	releaseObject(txtGurcan2)
    txtGurcan2 = display.newText( "Gürcan Hamalı" , 300, 300, "Chalkduster", 11 )
	txtGurcan2:setReferencePoint(display.TopLeftReferencePoint)
	txtGurcan2:setTextColor(98,113,127)
	txtGurcan2.rotation=-10
	txtGurcan2.x =  40
	txtGurcan2.y =  190

	imageSheet1 = graphics.newImageSheet( "img/settings/nesli.png", optionsCr )
	releaseObject(imgNesli)
    imgNesli = display.newImageRect(imageSheet1, 1, 80, 80 )-- display.newImage( "img/settings/nesli.png" )
	imgNesli:setReferencePoint(display.TopLeftReferencePoint)
	imgNesli.x =  190
	imgNesli.y =  100
	
	releaseObject(txtNesli1)
    txtNesli1 = display.newText( "Graphic" , 300, 300, "Chalkduster", 11 )
	txtNesli1:setReferencePoint(display.TopLeftReferencePoint)
	txtNesli1:setTextColor(255,0,0)
	txtNesli1.rotation=-10
	txtNesli1.x =  180
	txtNesli1.y =  190

	releaseObject(txtNesli1_1)
    txtNesli1_1 = display.newText( "Designer" , 300, 300, "Chalkduster", 11 )
	txtNesli1_1:setReferencePoint(display.TopLeftReferencePoint)
	txtNesli1_1:setTextColor(255,0,0)
	txtNesli1_1.rotation=-10
	txtNesli1_1.x =  215
	txtNesli1_1.y =  195

	releaseObject(txtNesli2)
    txtNesli2 = display.newText( "Neslihan Hamalı" , 300, 300, "Chalkduster", 11 )
	txtNesli2:setReferencePoint(display.TopLeftReferencePoint)
	txtNesli2:setTextColor(98,113,127)
	txtNesli2.rotation=-10
	txtNesli2.x =  175
	txtNesli2.y =  220


	releaseObject(imgName)
    imgName = display.newImage( "img/settings/name.png" )
	imgName:setReferencePoint(display.TopLeftReferencePoint)
	imgName.rotation=-15
	imgName.x =  110
	imgName.y =  360

	releaseObject(txtName2)
    txtName2 = display.newText( "(C) 2014" , 300, 300, "Chalkduster", 11 )
	txtName2:setReferencePoint(display.TopLeftReferencePoint)
	txtName2:setTextColor(255,0,0)
	txtName2.rotation=-15
	txtName2.x =  120
	txtName2.y =  320

	releaseObject(txtName1)
    txtName1 = display.newText( "bumpy@gunappsios.com" , 300, 300, "Chalkduster", 12 )
	txtName1:setReferencePoint(display.TopLeftReferencePoint)
	txtName1:setTextColor(255,0,0)
	txtName1.x =  130
	txtName1.y =  420
	
end
function showHowtoPlay()
		if SoundId==1 then
			local narrationSpeech = audio.loadStream("sound/Click.wav")
			local narrationChannel = audio.play( narrationSpeech)
		end

	releaseObject(imgHTPBG)
    imgHTPBG = display.newImage( "img/settings/howtoplaybg.png" )
	imgHTPBG:setReferencePoint(display.TopLeftReferencePoint)
	imgHTPBG.x =  -5
	imgHTPBG.y =  0

	if LangId==1 then
		releaseObject(txthtpCaption)
		txthtpCaption = display.newText( txtHowtoPlayCaption[LangId] , 40, 40, "Chalkduster", 20 )
		txthtpCaption:setTextColor(255,0,0)
		txthtpCaption.rotation=-10

		releaseObject(txthtp1_1)
		txthtp1_1 = display.newText(txtHowtoPlay1_1[LangId] , 10, 65, "Chalkduster", 12 )
		txthtp1_1:setTextColor(98,113,127)
		txthtp1_1.rotation=-10
	
		releaseObject(txthtp1_2)
		txthtp1_2 = display.newText(txtHowtoPlay1_2[LangId] , 10, 80, "Chalkduster", 12 )
		txthtp1_2:setTextColor(98,113,127)
		txthtp1_2.rotation=-10

		releaseObject(txthtp1_3)
		txthtp1_3 = display.newText(txtHowtoPlay1_3[LangId] , 15, 100, "Chalkduster", 12 )
		txthtp1_3:setTextColor(98,113,127)
		txthtp1_3.rotation=-10

		releaseObject(txthtp2_1)
		txthtp2_1 = display.newText(txtHowtoPlay2_1[LangId] , 20, 125, "Chalkduster", 12 )
		txthtp2_1:setTextColor(98,113,127)
		txthtp2_1.rotation=-10
	
		releaseObject(txthtp2_2)
		txthtp2_2 = display.newText(txtHowtoPlay2_2[LangId] , 20, 140, "Chalkduster", 12 )
		txthtp2_2:setTextColor(98,113,127)
		txthtp2_2.rotation=-10

		releaseObject(txthtp2_3)
		txthtp2_3 = display.newText(txtHowtoPlay2_3[LangId] , 25, 160, "Chalkduster", 12 )
		txthtp2_3:setTextColor(98,113,127)
		txthtp2_3.rotation=-10

		releaseObject(txthtp3_1)
		txthtp3_1 = display.newText(txtHowtoPlay3_1[LangId] , 30, 185, "Chalkduster", 12 )
		txthtp3_1:setTextColor(98,113,127)
		txthtp3_1.rotation=-10
	
		releaseObject(txthtp3_2)
		txthtp3_2 = display.newText(txtHowtoPlay3_2[LangId] , 40, 200, "Chalkduster", 12 )
		txthtp3_2:setTextColor(98,113,127)
		txthtp3_2.rotation=-10

		releaseObject(txthtp3_3)
		txthtp3_3 = display.newText(txtHowtoPlay3_3[LangId] , 50, 215, "Chalkduster", 12 )
		txthtp3_3:setTextColor(98,113,127)
		txthtp3_3.rotation=-10

		releaseObject(txthtp4)
		txthtp4 = display.newText(txtHowtoPlay4[LangId] , 110, 245, "Chalkduster", 12 )
		txthtp4:setTextColor(98,113,127)
		txthtp4.rotation=-10
		
		releaseObject(imgResumeX)
    	imgResumeX = display.newImage( "img/x.png" )
		imgResumeX:setReferencePoint(display.TopLeftReferencePoint)
		imgResumeX.rotation=-10
		imgResumeX.x=230
		imgResumeX.y=15
		imgResumeX.touch = onPauseTouchHTP
		imgResumeX:addEventListener( "touch", imgResumeX )
		
	end
	if LangId==2 then
		releaseObject(txthtpCaption)
		txthtpCaption = display.newText( txtHowtoPlayCaption[LangId] , 50, 40, "Chalkduster", 20 )
		txthtpCaption:setTextColor(255,0,0)
		txthtpCaption.rotation=-10

		releaseObject(txthtp1_1)
		txthtp1_1 = display.newText(txtHowtoPlay1_1[LangId] , 10, 70, "Chalkduster", 12 )
		txthtp1_1:setTextColor(98,113,127)
		txthtp1_1.rotation=-10
	
		releaseObject(txthtp1_2)
		txthtp1_2 = display.newText(txtHowtoPlay1_2[LangId] , 10, 90, "Chalkduster", 12 )
		txthtp1_2:setTextColor(98,113,127)
		txthtp1_2.rotation=-10

		releaseObject(txthtp1_3)
		txthtp1_3 = display.newText(txtHowtoPlay1_3[LangId] , 10, 110, "Chalkduster", 12 )
		txthtp1_3:setTextColor(98,113,127)
		txthtp1_3.rotation=-10

		releaseObject(txthtp2_1)
		txthtp2_1 = display.newText(txtHowtoPlay2_1[LangId] , 20, 120, "Chalkduster", 12 )
		txthtp2_1:setTextColor(98,113,127)
		txthtp2_1.rotation=-10
	
		releaseObject(txthtp2_2)
		txthtp2_2 = display.newText(txtHowtoPlay2_2[LangId] , 20, 140, "Chalkduster", 12 )
		txthtp2_2:setTextColor(98,113,127)
		txthtp2_2.rotation=-10

		releaseObject(txthtp2_3)
		txthtp2_3 = display.newText(txtHowtoPlay2_3[LangId] , 20, 160, "Chalkduster", 12 )
		txthtp2_3:setTextColor(98,113,127)
		txthtp2_3.rotation=-10

		releaseObject(txthtp3_1)
		txthtp3_1 = display.newText(txtHowtoPlay3_1[LangId] , 30, 170, "Chalkduster", 12 )
		txthtp3_1:setTextColor(98,113,127)
		txthtp3_1.rotation=-10
	
		releaseObject(txthtp3_2)
		txthtp3_2 = display.newText(txtHowtoPlay3_2[LangId] , 30, 185, "Chalkduster", 12 )
		txthtp3_2:setTextColor(98,113,127)
		txthtp3_2.rotation=-10

		releaseObject(txthtp3_3)
		txthtp3_3 = display.newText(txtHowtoPlay3_3[LangId] , 50, 210, "Chalkduster", 12 )
		txthtp3_3:setTextColor(98,113,127)
		txthtp3_3.rotation=-10

		releaseObject(txthtp4)
		txthtp4 = display.newText(txtHowtoPlay4[LangId] , 100, 240, "Chalkduster", 12 )
		txthtp4:setTextColor(98,113,127)
		txthtp4.rotation=-10

		releaseObject(imgResumeX)
    	imgResumeX = display.newImage( "img/x.png" )
		imgResumeX:setReferencePoint(display.TopLeftReferencePoint)
		imgResumeX.rotation=-10
		imgResumeX.x=230
		imgResumeX.y=15
		imgResumeX.touch = onPauseTouchHTP
		imgResumeX:addEventListener( "touch", imgResumeX )
	end
	
end

 function drawSettingsScreen()

FindLang()	

	releaseObject(bg)
    bg = display.newImage( "img/bg/settingbg2.png" )
	bg:setReferencePoint(display.TopLeftReferencePoint)
	bg.x=0
	bg.y=0
    bg.xScale=0.1    
	bg.touch = onNone
	bg:addEventListener( "touch", bg )
	groupSettingsLayer:insert( bg )
	transition.to( bg, { time= 1000, xScale=1 } )

	releaseObject(imgMenu)
    imgMenu = display.newImage( "img/settings/settings_menu.png" )
	imgMenu:setReferencePoint(display.TopLeftReferencePoint)
	imgMenu.x =  0
	imgMenu.y =  0
	imgMenu.yScale=0.1
	imgMenu.touch = onNone
	imgMenu:addEventListener( "touch", imgMenu )
	transition.to( imgMenu, { time= 1000, yScale=1 } )	
	groupSettingsLayer:insert( imgMenu )		

	releaseObject(imgBanner)
    imgBanner = display.newImage( "img/settings/settingsbanner.png" )
	imgBanner:setReferencePoint(display.TopLeftReferencePoint)
	imgBanner.x=50
	imgBanner.y=210
    imgBanner.alpha=0    
	imgBanner.touch = onNone
	imgBanner:addEventListener( "touch", imgBanner )
	groupSettingsLayer:insert( imgBanner )
	transition.to( imgBanner, {delay=1000, time= 10, alpha=1 } )

	timer.performWithDelay( 1000, createFlags )
	timer.performWithDelay( 1000, createSound )
	timer.performWithDelay( 1000, createSets )
	timer.performWithDelay( 1000, 	setText )


	releaseObject(imgSetIcon4)
    imgSetIcon4 = display.newImage( "img/settings/howtoplay.png" )
	imgSetIcon4:setReferencePoint(display.TopLeftReferencePoint)
	imgSetIcon4.x=60
	imgSetIcon4.y=363
    imgSetIcon4.alpha=0    
	imgSetIcon4.touch = showHowtoPlay
	imgSetIcon4:addEventListener( "touch", imgSetIcon4 )
	groupSettingsLayer:insert( imgSetIcon4 )
	transition.to( imgSetIcon4, {delay=1000, time= 10, alpha=1 } )

	releaseObject(imgSetIcon5)
    imgSetIcon5 = display.newImage( "img/settings/information.png" )
	imgSetIcon5:setReferencePoint(display.TopLeftReferencePoint)
	imgSetIcon5.x=60
	imgSetIcon5.y=402
    imgSetIcon5.alpha=0    
	imgSetIcon5.touch = showInformation
	imgSetIcon5:addEventListener( "touch", imgSetIcon5 )
	groupSettingsLayer:insert( imgSetIcon5 )
	transition.to( imgSetIcon5, {delay=1000, time= 10, alpha=1 } )

	releaseObject(imgSetIcon6)
    imgSetIcon6 = display.newImage( "img/settings/restore.png" )
	imgSetIcon6:setReferencePoint(display.TopLeftReferencePoint)
	imgSetIcon6.x=60
	imgSetIcon6.y=328
    imgSetIcon6.alpha=0    
	imgSetIcon6.touch = restoreItems
	imgSetIcon6:addEventListener( "touch", imgSetIcon6 )
	groupSettingsLayer:insert( imgSetIcon6 )
	transition.to( imgSetIcon6, {delay=1000, time= 10, alpha=1 } )

	releaseObject(imgResume)
    imgResume = display.newImage( "img/x.png" )
	imgResume:setReferencePoint(display.TopLeftReferencePoint)
	imgResume.x=40
	imgResume.y=190
    imgResume.alpha=0    
	imgResume.touch = onPauseTouchBack
	imgResume:addEventListener( "touch", imgResume )
	groupSettingsLayer:insert( imgResume )
	transition.to( imgResume, {delay=1000, time= 10, alpha=1 } )



--[[
	createFlags()
	groupSettingsLayer:insert( imgFlag )		

	local imageSheet = graphics.newImageSheet( "img/information.png", options2 )
	imgInfo =display.newImageRect(imageSheet, 1, 30, 70 ) 
	imgInfo.x =  260
	imgInfo.y =  420
	groupSettingsLayer:insert( imgInfo )		

	local imageSheet = graphics.newImageSheet( "img/howtoplay.png", options )
	imgHow =display.newImageRect(imageSheet, 1, 50, 50 ) 
	imgHow.x =  55
	imgHow.y =  370
	groupSettingsLayer:insert( imgHow )		


	createSound()
	groupSettingsLayer:insert( imgSound )		

	local imageSheet = graphics.newImageSheet( "img/basket.png", options3 )
	imgItem =display.newImageRect(imageSheet, 1, 50, 50 ) 
	imgItem.x =  160
	imgItem.y =  50
	groupSettingsLayer:insert( imgItem )		
]]--
groupSettingsLayer.alpha=1
groupSettingsLayer:toFront()
end



function scene:createScene( event )
        local screenGroup = self.view

end
 
-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
        local screenGroup = self.view
        
        
end
 
-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
        local screenGroup = self.view
drawSettingsScreen()
        

end
 
 
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local screenGroup = self.view
        

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