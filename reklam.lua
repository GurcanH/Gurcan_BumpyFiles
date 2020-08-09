--------------------------------------------------------------------------------
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2013 Corona Labs Inc. All Rights Reserved.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

-- Hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- The name of the ad provider.




function RunAdModAds()
	local provider = "admob"

	-- Your application ID
	local appID = "ca-app-pub-6414961667069598/1828390264"

	-- Load Corona 'ads' library
	local ads = require "ads"

	local function adListener( event )
    	if event.isError then
	  --      statusText.text = event.response
    	else
	    --    statusText.text = "Hata Yok"
    	end
	end

	ads.init( provider,appID, adListener )
	ads.show( "interstitial", { x=0, y=100 } )
end


function RuniAdsAds()
	local ads = require "ads"

	local function adListener( event )
	local msg = event.response
    	if event.isError then
        	-- Failed to receive an ad, we print the error message returned from the library.
	        print(msg)
    	end
	end

	ads.init( "iads", "com.gunapps.bumpy", adListener )
	ads.show( "banner", { x=0, y=0 } )
	
end
