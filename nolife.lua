
---------------------------------------------------------------------------------------
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local screenW, screenH = display.contentWidth, display.contentHeight

groupNoLifeLayer = display.newGroup()

local noLifeText 



	if noLifeText ~= nil then
		noLifeText:removeSelf()
		noLifeText = nil
	end
		
	noLifeText = display.newText( "Hakkın Kalmadı" , screenW / 2, 400, "Helvetica", 36 )
	noLifeText:setReferencePoint(display.TopCenterReferencePoint)
	noLifeText.x = screenW / 2
	noLifeText.y = screenH / 2 + 100
	
	local g1 = graphics.newGradient(
  		{ 0, 255, 255 },
  		{ 200, 200, 200 },
  					"up" )
	noLifeText:setTextColor(g1)


groupNoLifeLayer:insert( noLifeText )
groupNoLifeLayer.alpha = 0

