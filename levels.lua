	LevelDescription =""
	EkstraInformation =""
	target = 0
	bLevelCompleted =  false
		
function textWrap( str, limit, indent, indent1 )

   limit = limit or 72
   indent = indent or ""
   indent1 = indent1 or indent

   local here = 1 - #indent1
   return indent1..str:gsub( "(%s+)()(%S+)()",
      function( sp, st, word, fi )
         if fi-here > limit then
            here = st - #indent
            return "\n"..indent..word
         end
      end )
end
	
	function levelOperations( level,gameTimer) -- Level Açıklamasını oluştur
		local color=""
		countdownEnable = false
		sec5Enabled = false
		bRed = false
		bYellow = false
		bBlue = false
		bGreen = false
		gameImgMode = 1
		gameGlassMode = false
		orderColorMode = false	
		brickEnabled = false

		if level>=1 and level<11 then
			if level==1 then target = 1000 end
			if level==2 then target = 1500 end
			if level==3 then target = 2000 end
			if level==4 then target = 2200 end
			if level==5 then target = 2500 end
			if level==6 then target = 3000 end
			if level==7 then target = 3200 end
			if level==8 then target = 3500 end
			if level==9 then target = 4000 end
			if level==10 then target = 5000 end
--		orderColorMode = true	

			if LangId == 1 then
				txtQuestText1[1]= " "
				txtQuestText2[1]="Görev: " .. gameTimer .. " Saniye içinde " 
				txtQuestText3[1]= target .. " puanı tamamla." 				
				txtQuestText4[1]= " "
				txtQuestText5[1]= " "
				LevelDescription="Görev: " .. gameTimer .. " Saniye içinde "  .. target .. " puanı tamamla." 
			end
			if LangId == 2 then
				txtQuestText1[2]= " "
				txtQuestText2[2]="Mission: Complete " .. target .. "  "
				txtQuestText3[2]= "point within " .. gameTimer .. " seconds. "  
				txtQuestText4[2]= " "
				txtQuestText5[2]= " "
				LevelDescription="Mission:  Complete " .. target .. " point within " .. gameTimer .. " seconds "  
			end
		end
		if level>10 and level <21 then
			target      = 3000
			if level == 11 then 
				if LangId == 1 then
					color  ="Kırmızı"  
				end
				if LangId == 2 then
					color  ="Red"  
				end
				bRed = true
				bYellow = false
				bBlue = false
				bGreen = false
			end
			if level == 12 then 
				if LangId == 1 then
					color  ="Mavi"  
				end
				if LangId == 2 then
					color  ="Blue"  
				end
				bRed = false
				bYellow = false
				bBlue = true
				bGreen = false
			end
			if level == 13 then 
				if LangId == 1 then
					color  ="Sarı"  
				end
				if LangId == 2 then
					color  ="Yellow"  
				end
				bRed = false
				bYellow = true
				bBlue = false
				bGreen = false
			end
			if level == 14 then 
				if LangId == 1 then
					color  ="Yeşil"  
				end
				if LangId == 2 then
					color  ="Green"  
				end
				bRed = false
				bYellow = false
				bBlue = false
				bGreen = true
			end
			if level == 15 then 
				if LangId == 1 then
					color  ="Kırmızı ve Mavi"  
				end
				if LangId == 2 then
					color  ="Red and Blue"  
				end
				bRed = true
				bYellow = false
				bBlue = true
				bGreen = false
			end
			if level == 16 then 
				if LangId == 1 then
					color  ="Sarı ve Yeşil"  
				end
				if LangId == 2 then
					color  ="Yellow and Green"  
				end
				bRed = false
				bYellow = true
				bBlue = false
				bGreen = true
			end
			if level == 17 then 
				if LangId == 1 then
					color  ="Kırmızı, Mavi ve Yeşil"  
				end
				if LangId == 2 then
					color  ="Red, Blue and Green"  
				end
				bRed = true
				bYellow = false
				bBlue = true
				bGreen = true
			end
			if level == 18 then 
				if LangId == 1 then
					color  ="Sarı, Mavi ve Yeşil"  
				end
				if LangId == 2 then
					color  ="Yellow, Blue and Green"  
				end
				bRed = false
				bYellow = true
				bBlue = true
				bGreen = true
			end
			if level == 19 then 
				if LangId == 1 then
					color  ="Kırmızı, Mavi ve Sarı"  
				end
				if LangId == 2 then
					color  ="Red, Blue and Yellow"  
				end
				bRed = true
				bYellow = true
				bBlue = true
				bGreen = false
			end
			if level == 20 then 
				if LangId == 1 then
					color  ="Kırmızı, Mavi, Sarı ve Yeşil"  
				end
				if LangId == 2 then
					color  ="Red, Blue, Yellow and Green"  
				end
				bRed = true
				bYellow = true
				bBlue = true
				bGreen = true
			end
				if LangId == 1 then
					txtQuestText1[1]="Görev: " .. gameTimer .. " Saniye içinde " 
					txtQuestText2[1]= target .. " puanı tamamla ve " 				
					txtQuestText3[1]= "3 tane dörtlü " 
					txtQuestText4[1]= color
					txtQuestText5[1]= " top patlat."
				end
				if LangId == 2 then
					txtQuestText1[2]="Mission: Complete " .. target .. "  "
					txtQuestText2[2]= "point within " .. gameTimer .. " seconds "  
					txtQuestText3[2]= "you must blow up 3 sets of" 
					txtQuestText4[2]= color 
					txtQuestText5[2]= "balls." 
				end
		end
		if level>20 and level <31 then
			mudEnabled = true  
			color=""
			if level == 21 then target=1000  end
			if level == 22 then target=1500  end
			if level == 23 then target=2000  end
			if level == 24 then target=2500  end
			if level == 25 then target=3000  end
			if level == 26 then 
				target=3000 
				if LangId == 1 then
					color  ="Kırmızı"  
				end
				if LangId == 2 then
					color  ="Red"  
				end
				bRed = true
				bYellow = false
				bBlue = false
				bGreen = false
			end
			if level == 27 then 
				target=3000 
				if LangId == 1 then
					color  ="Mavi"  
				end
				if LangId == 2 then
					color  ="Blue"  
				end
				bRed = false
				bYellow = false
				bBlue = true
				bGreen = false
			end
			if level == 28 then 
				target=3000 
				if LangId == 1 then
					color  ="Sarı"  
				end
				if LangId == 2 then
					color  ="Yellow"  
				end
				bRed = false
				bYellow = true
				bBlue = false
				bGreen = false
			end
			if level == 29 then 
				target=3000 
				if LangId == 1 then
					color  ="Yeşil"  
				end
				if LangId == 2 then
					color  ="Green"  
				end
				bRed = false
				bYellow = false
				bBlue = false
				bGreen = true
			end
			if level == 30 then 
				target=3000 
				if LangId == 1 then
					color  ="Kırmızı, Mavi, Sarı ve Yeşil"
				end
				if LangId == 2 then
					color  ="Red, Blue, Yellow and Green"  
				end
				bRed = true
				bYellow = true
				bBlue = true
				bGreen = true
			end

			if LangId == 1 then
				txtQuestText1[1]="Görev: " .. gameTimer .. " Saniye içinde " 
				txtQuestText2[1]= target .. " puanı tamamla  " 				
				txtQuestText3[1]= ""
				txtQuestText4[1]= ""
				txtQuestText5[1]= ""
			end
			if LangId == 2 then
				txtQuestText1[2]="Mission: Complete " .. target .. "  "
				txtQuestText2[2]= "point within " .. gameTimer .. " seconds "  
				txtQuestText3[2]= ""
				txtQuestText4[2]= ""
				txtQuestText5[2]= ""
			end

			if color~="" then
				if LangId == 1 then
					txtQuestText3[1]= " ve 3 tane dörtlü " 
					txtQuestText4[1]= color
					txtQuestText5[1]= " top patlat."
				end
				if LangId == 2 then
					txtQuestText3[2]= "and you must blow up 3 sets of" 
					txtQuestText4[2]= color 
					txtQuestText5[2]= "balls." 
				end

			end 
		end
		if level>30 and level <41 then
			sec5Enabled = true
			color=""
			if level == 31 then target=2000  end
			if level == 32 then target=2500  end
			if level == 33 then target=3000  end
			if level == 34 then 
				target=3000  
				if LangId == 1 then
					color  ="Sarı"  
				end
				if LangId == 2 then
					color  ="Yellow"  
				end
				bRed = false
				bYellow = true
				bBlue = false
				bGreen = false
			end
			if level == 35 then 
				target=3000  
				if LangId == 1 then
					color  ="Kırmızı"  
				end
				if LangId == 2 then
					color  ="Red"  
				end
				bRed = true
				bYellow = false
				bBlue = false
				bGreen = false
			end
			if level == 36 then 
				target=3000  
				if LangId == 1 then
					color  ="Mavi"  
				end
				if LangId == 2 then
					color  ="Blue"  
				end
				bRed = false
				bYellow = false
				bBlue = true
				bGreen = false
			end
			if level == 37 then 
				target=3000  
				if LangId == 1 then
					color  ="Yeşil"  
				end
				if LangId == 2 then
					color  ="Green"  
				end
				bRed = false
				bYellow = false
				bBlue = false
				bGreen = true
			end
			if level == 38 then 
				target=3000  
				if LangId == 1 then
					color  ="Sarı, Kırmızı"  
				end
				if LangId == 2 then
					color  ="Yellow, Red"  
				end
				bRed = true
				bYellow = true
				bBlue = false
				bGreen = false
			end
			if level == 39 then 
				target=3000  
				if LangId == 1 then
					color  ="Yeşil, Mavi"  
				end
				if LangId == 2 then
					color  ="Green, Blue"  
				end
				bRed = false
				bYellow = false
				bBlue = true
				bGreen = true
			end
			if level == 40 then 
				target=3000 
				if LangId == 1 then
					color  ="Kırmızı, Mavi, Sarı ve Yeşil"  
				end
				if LangId == 2 then
					color  ="Red, Blue, Yellow and Green"  
				end
				bRed = true
				bYellow = true
				bBlue = true
				bGreen = true
			end
			if LangId == 1 then
				txtQuestText1[1]="Görev: " .. gameTimer .. " Saniye içinde " 
				txtQuestText2[1]= target .. " puanı tamamla  " 				
				txtQuestText3[1]= ""
				txtQuestText4[1]= ""
				txtQuestText5[1]= ""
			end
			if LangId == 2 then
				txtQuestText1[2]="Mission: Complete " .. target .. "  "
				txtQuestText2[2]= "point within " .. gameTimer .. " seconds "  
				txtQuestText3[2]= ""
				txtQuestText4[2]= ""
				txtQuestText5[2]= ""
			end

			if color~="" then
				if LangId == 1 then
					txtQuestText3[1]= " ve 3 tane dörtlü " 
					txtQuestText4[1]= color
					txtQuestText5[1]= " top patlat."
				end
				if LangId == 2 then
					txtQuestText3[2]= "and you must blow up 3 sets of" 
					txtQuestText4[2]= color 
					txtQuestText5[2]= "balls." 
				end

			end 
		end
		if level>40 and level <51 then
			--sec5Enabled = true
			--sec52Enabled = false
			mudEnabled = false
			countdownEnable = true
			color=""
			if level == 41 then target=2000  end
			if level == 42 then target=2500  end
			if level == 43 then target=3000  end
			if level == 44 then 
				target=3000  
			--	sec52Enabled = true
			end
			if level == 45 then 
				target=2000  
				countdownEnable = true
			end
			if level == 46 then 
				target=2500  
				countdownEnable = true
			end
			if level == 47 then 
				target=3000  
				countdownEnable = true
			end
			if level == 48 then 
				target=3500  
				countdownEnable = true
			end
			if level == 49 then 
				target=4000  
				countdownEnable = true
			end
			if level == 50 then 
				target=5000  
				countdownEnable = true
			end
			if LangId == 1 then
				txtQuestText1[1]= " "
				txtQuestText2[1]="Görev: " .. gameTimer .. " Saniye içinde " 
				txtQuestText3[1]= target .. " puanı tamamla." 				
				txtQuestText4[1]= " "
				txtQuestText5[1]= " "
				LevelDescription="Görev: " .. gameTimer .. " Saniye içinde "  .. target .. " puanı tamamla." 
			end
			if LangId == 2 then
				txtQuestText1[2]= " "
				txtQuestText2[2]="Mission: Complete " .. target .. "  "
				txtQuestText3[2]= "point within " .. gameTimer .. " seconds. "  
				txtQuestText4[2]= " "
				txtQuestText5[2]= " "
				LevelDescription="Mission:  Complete " .. target .. " point within " .. gameTimer .. " seconds "  
			end
		end
		if level>=51 and level<61 then
			gameImgMode = 2
			--orderColorMode = true	
			if level==51 then target = 1000 end
			if level==52 then target = 1250 end
			if level==53 then target = 1500 end
			if level==54 then target = 1750 end
			if level==55 then target = 2000 end
			if level==56 then target = 2250 end
			if level==57 then target = 2500 end
			if level==58 then target = 3000 end
			if level==59 then target = 4000 end
			if level==60 then target = 5000 end

			if LangId == 1 then
				txtQuestText1[1]= " "
				txtQuestText2[1]="Görev: " .. gameTimer .. " Saniye içinde " 
				txtQuestText3[1]= target .. " puanı tamamla." 				
				txtQuestText4[1]= " "
				txtQuestText5[1]= " "
				LevelDescription="Görev: " .. gameTimer .. " Saniye içinde "  .. target .. " puanı tamamla." 
			end
			if LangId == 2 then
				txtQuestText1[2]= " "
				txtQuestText2[2]="Mission: Complete " .. target .. "  "
				txtQuestText3[2]= "point within " .. gameTimer .. " seconds. "  
				txtQuestText4[2]= " "
				txtQuestText5[2]= " "
				LevelDescription="Mission:  Complete " .. target .. " point within " .. gameTimer .. " seconds "  
			end
		end
		if level>=61 and level<71 then
			gameImgMode = 2
			gameGlassMode = true
			if level==61 then target = 1000 end
			if level==62 then target = 1250 end
			if level==63 then target = 1500 end
			if level==64 then target = 1750 end
			if level==65 then target = 2000 end
			if level==66 then target = 2250 end
			if level==67 then target = 2500 end
			if level==68 then target = 3000 end
			if level==69 then target = 4000 end
			if level==70 then target = 5000 end

			if LangId == 1 then
				txtQuestText1[1]= " "
				txtQuestText2[1]="Görev: " .. gameTimer .. " Saniye içinde " 
				txtQuestText3[1]= target .. " puanı tamamla." 				
				txtQuestText4[1]= " "
				txtQuestText5[1]= " "
				LevelDescription="Görev: " .. gameTimer .. " Saniye içinde "  .. target .. " puanı tamamla." 
			end
			if LangId == 2 then
				txtQuestText1[2]= " "
				txtQuestText2[2]="Mission: Complete " .. target .. "  "
				txtQuestText3[2]= "point within " .. gameTimer .. " seconds. "  
				txtQuestText4[2]= " "
				txtQuestText5[2]= " "
				LevelDescription="Mission:  Complete " .. target .. " point within " .. gameTimer .. " seconds "  
			end
		end
		if level>=71 and level<81 then
			gameImgMode = 2
			orderColorMode = true	
			if level==71 then target = 1000 end
			if level==72 then target = 1250 end
			if level==73 then target = 1500 end
			if level==74 then target = 1750 end
			if level==75 then target = 2000 end
			if level==76 then target = 2250 end
			if level==77 then target = 2500 end
			if level==78 then target = 3000 end
			if level==79 then target = 4000 end
			if level==80 then target = 5000 end

			if LangId == 1 then
				txtQuestText1[1]= " "
				txtQuestText2[1]="Görev: " .. gameTimer .. " Saniye içinde " 
				txtQuestText3[1]= target .. " puanı tamamla." 				
				txtQuestText4[1]= " "
				txtQuestText5[1]= " "
				LevelDescription="Görev: " .. gameTimer .. " Saniye içinde "  .. target .. " puanı tamamla." 
			end
			if LangId == 2 then
				txtQuestText1[2]= " "
				txtQuestText2[2]="Mission: Complete " .. target .. "  "
				txtQuestText3[2]= "point within " .. gameTimer .. " seconds. "  
				txtQuestText4[2]= " "
				txtQuestText5[2]= " "
				LevelDescription="Mission:  Complete " .. target .. " point within " .. gameTimer .. " seconds "  
			end
		end
		if level>=81 and level<91 then
			gameImgMode = 2
			gameGlassMode = true
			orderColorMode = true	
			if level==81 then target = 1000 end
			if level==82 then target = 1250 end
			if level==83 then target = 1500 end
			if level==84 then target = 1750 end
			if level==85 then target = 2000 end
			if level==86 then target = 2250 end
			if level==87 then target = 2500 end
			if level==88 then target = 3000 end
			if level==89 then target = 4000 end
			if level==90 then target = 5000 end

			if LangId == 1 then
				txtQuestText1[1]= " "
				txtQuestText2[1]="Görev: " .. gameTimer .. " Saniye içinde " 
				txtQuestText3[1]= target .. " puanı tamamla." 				
				txtQuestText4[1]= " "
				txtQuestText5[1]= " "
				LevelDescription="Görev: " .. gameTimer .. " Saniye içinde "  .. target .. " puanı tamamla." 
			end
			if LangId == 2 then
				txtQuestText1[2]= " "
				txtQuestText2[2]="Mission: Complete " .. target .. "  "
				txtQuestText3[2]= "point within " .. gameTimer .. " seconds. "  
				txtQuestText4[2]= " "
				txtQuestText5[2]= " "
				LevelDescription="Mission:  Complete " .. target .. " point within " .. gameTimer .. " seconds "  
			end
		end
		if level>=91 and level<101 then
			gameImgMode = 2
			gameGlassMode = true
			orderColorMode = true	
			if level==91 then target = 1000 end
			if level==92 then target = 1250 end
			if level==93 then target = 1500 end
			if level==94 then target = 1750 end
			if level==95 then target = 2000 end
			if level==96 then target = 2250 end
			if level==97 then target = 2500 end
			if level==98 then target = 3000 end
			if level==99 then target = 4000 end
			if level==100 then target = 5000 end

			if level>=91 and level<96 then
				mudEnabled = true
				countdownEnable = false
			end
			if level>=96 and level<101 then
				mudEnabled = false
				countdownEnable = true
			end
			
			if LangId == 1 then
				txtQuestText1[1]= " "
				txtQuestText2[1]="Görev: " .. gameTimer .. " Saniye içinde " 
				txtQuestText3[1]= target .. " puanı tamamla." 				
				txtQuestText4[1]= " "
				txtQuestText5[1]= " "
				LevelDescription="Görev: " .. gameTimer .. " Saniye içinde "  .. target .. " puanı tamamla." 
			end
			if LangId == 2 then
				txtQuestText1[2]= " "
				txtQuestText2[2]="Mission: Complete " .. target .. "  "
				txtQuestText3[2]= "point within " .. gameTimer .. " seconds. "  
				txtQuestText4[2]= " "
				txtQuestText5[2]= " "
				LevelDescription="Mission:  Complete " .. target .. " point within " .. gameTimer .. " seconds "  
			end
		end
		if level>=101 and level<111 then
			gameImgMode = 2
			brickEnabled = true

			--orderColorMode = true	
			if level==101 then target = 1000 end
			if level==102 then target = 1250 end
			if level==103 then target = 1500 end
			if level==104 then target = 1750 end
			if level==105 then target = 2000 end
			if level==106 then target = 2250 end
			if level==107 then target = 2500 end
			if level==108 then target = 3000 end
			if level==109 then target = 4000 end
			if level==110 then target = 5000 end

			if LangId == 1 then
				txtQuestText1[1]= " "
				txtQuestText2[1]="Görev: " .. gameTimer .. " Saniye içinde " 
				txtQuestText3[1]= target .. " puanı tamamla." 				
				txtQuestText4[1]= " "
				txtQuestText5[1]= " "
				LevelDescription="Görev: " .. gameTimer .. " Saniye içinde "  .. target .. " puanı tamamla." 
			end
			if LangId == 2 then
				txtQuestText1[2]= " "
				txtQuestText2[2]="Mission: Complete " .. target .. "  "
				txtQuestText3[2]= "point within " .. gameTimer .. " seconds. "  
				txtQuestText4[2]= " "
				txtQuestText5[2]= " "
				LevelDescription="Mission:  Complete " .. target .. " point within " .. gameTimer .. " seconds "  
			end
		end

	end 
	
	function checkLevelCompleted(level,score,redCount,yellowCount,blueCount,greenCount)
		bLevelCompleted = false
		
		if score >= target then
			bLevelCompleted = true
			if bRed == true and bLevelCompleted == true then
				if redCount>colorCount then
					bLevelCompleted = true
				else
					bLevelCompleted = false	
				end 
			end 
			if bBlue == true and bLevelCompleted == true then
				if blueCount>colorCount then
					bLevelCompleted = true
				else
					bLevelCompleted = false	
				end 
			end 
			if bYellow == true and bLevelCompleted == true then
				if yellowCount>colorCount then
					bLevelCompleted = true
				else
					bLevelCompleted = false	
				end 
			end 
			if bGreen == true and bLevelCompleted == true then
				if greenCount>colorCount then
					bLevelCompleted = true
				else
					bLevelCompleted = false	
				end 
			end 
		end 
	end 