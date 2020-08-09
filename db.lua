maxLevel=1
life = 5 

--Include sqlite
require "sqlite3"
--Open data.db.  If the file doesn't exist it will be created
local path = system.pathForFile("data.db", system.DocumentsDirectory)
db = sqlite3.open( path )   
 
--Handle the applicationExit event to close the db
local function onSystemEvent( event )
        if( event.type == "applicationExit" ) then              
            db:close()
        end
end
 
--Setup the table if it doesn't exist
local tablesetup = [[CREATE TABLE IF NOT EXISTS Bubble (id INTEGER PRIMARY KEY, Level);]]
print(tablesetup)
db:exec( tablesetup )

function AddLevel(l) 
--maxLevel = 7
	findLevel()

	--text1 = display.newText( l, 0, 0, native.systemFontBold, 18 )
	--text2 = display.newText( tostring(maxLevel), 0, 0, native.systemFontBold, 18 )
		
	if l > maxLevel then
		local tablefill =[[DELETE from Bubble]]
		db:exec( tablefill )

		local tablefill =[[INSERT INTO Bubble VALUES (NULL, ]]..l..[[); ]]
		db:exec( tablefill )
	end
end
--print all the table contents
function findLevel()
	--lastLevel=2
	for row in db:nrows("SELECT * FROM Bubble") do
  		maxLevel = row.Level 	
  		
	end
	


end 

function findLeftLifeTime()
	aa=0
	for row in db:nrows("SELECT  * FROM BubbleLife ORDER BY Life") do
		aa=aa+ 1
		if aa==1 then
  			leftTime =row.Life
		end
	end	
	if leftTime == nil then
		leftTime=0
	end 
end
		
function findLife()
	local tablesetup = [[CREATE TABLE IF NOT EXISTS BubbleLife (id INTEGER PRIMARY KEY, Life);]]
	db:exec( tablesetup )		


    local tt = os.date( '*t' )  -- get table of current date and time
	t1=os.time(tt)
	
	local tablefill ="DELETE from BubbleLife WHERE Life<=".. t1
	db:exec( tablefill )
	

	for row in db:nrows("SELECT Count(*) AA FROM BubbleLife ") do
  		currentLife = row.AA
	end	
	
	leftLife = maxLife - currentLife

--	findLeftLife()
end

function DeleteLifeTime()
	for row in db:nrows("SELECT id FROM BubbleLife Order by id Desc LIMIT 1 ") do
  		lifeId=  row.id
	end	
	
	local tablefill ="DELETE from BubbleLife WHERE id=".. lifeId
	db:exec( tablefill )
	findLife()		
end
function AddLifeTime()
	for row in db:nrows("SELECT Count(*) AA FROM BubbleLife ") do
  		currentLife = row.AA
	end	
	
	if currentLife < maxLife then
	    local tt = os.date( '*t' )  -- get table of current date and time
		t1=os.time(tt)
		tt.sec = tt.sec + (60 * nextMinute * (currentLife +1)) --2 dakika ekle
		t2=os.time(tt)

		local tablefill =[[INSERT INTO BubbleLife VALUES (NULL, ]]..t2..[[); ]]
		db:exec( tablefill )
	end
	findLife()		
end

function FillFullLife()
	local tablefill ="DELETE from BubbleLife "
	db:exec( tablefill )
	
	findLife()		
end
function ChangeLang()

	
	local tablefill ="DELETE from Lang "
	db:exec( tablefill )
	
		local tablefill =[[INSERT INTO Lang VALUES (NULL, ]]..LangId..[[); ]]
		db:exec( tablefill )
end
function FindLang()
		
	local tablesetup = [[CREATE TABLE IF NOT EXISTS Lang (id INTEGER PRIMARY KEY, LangId);]]
	db:exec( tablesetup )		

	for row in db:nrows("SELECT Count(*) AA FROM Lang ") do
  		rCount = row.AA
	end	
	if rCount== 0 then
		local tablefill =[[INSERT INTO Lang VALUES (NULL, ]]..LangId..[[); ]]
		db:exec( tablefill )
	end
	
	for row in db:nrows("SELECT LangId FROM Lang ") do
  		LangId = row.LangId
	end	
	
end
function ChangeSound()

	
	local tablefill ="DELETE from Sound "
	db:exec( tablefill )
	
		local tablefill =[[INSERT INTO Sound VALUES (NULL, ]]..SoundId..[[); ]]
		db:exec( tablefill )
end
function FindSound()
		
	local tablesetup = [[CREATE TABLE IF NOT EXISTS Sound (id INTEGER PRIMARY KEY, SoundId);]]
	db:exec( tablesetup )		

	for row in db:nrows("SELECT Count(*) AA FROM Sound ") do
  		rCount = row.AA
	end	
	if rCount== 0 then
		local tablefill =[[INSERT INTO Sound VALUES (NULL, ]]..SoundId..[[); ]]
		db:exec( tablefill )
	end
	
	for row in db:nrows("SELECT SoundId FROM Sound ") do
  		SoundId = row.SoundId
	end	
	
end

function ChangeChangeColor()

	
	local tablefill ="DELETE from ChangeColor "
	db:exec( tablefill )
	
		local tablefill =[[INSERT INTO ChangeColor VALUES (NULL, ]]..ChangeColorCount..[[); ]]
		db:exec( tablefill )
end
function FindChangeColor()
		
	local tablesetup = [[CREATE TABLE IF NOT EXISTS ChangeColor (id INTEGER PRIMARY KEY, ChangeColorCount);]]
	db:exec( tablesetup )		

--Geçici 
--	local tablefill ="DELETE from ChangeColor "
--	db:exec( tablefill )

	for row in db:nrows("SELECT Count(*) AA FROM ChangeColor ") do
  		rCount = row.AA
	end	
	if rCount== 0 then
		local tablefill =[[INSERT INTO ChangeColor VALUES (NULL, ]]..ChangeColorCount..[[); ]]
		db:exec( tablefill )
	end
	
	for row in db:nrows("SELECT ChangeColorCount FROM ChangeColor ") do
  		ChangeColorCount = row.ChangeColorCount
	end	
	
end

function ChangeAddTime()

	
	local tablefill ="DELETE from AddTime "
	db:exec( tablefill )
	
		local tablefill =[[INSERT INTO AddTime VALUES (NULL, ]]..AddTimeCount..[[); ]]
		db:exec( tablefill )
end
function FindAddTime()
		
	local tablesetup = [[CREATE TABLE IF NOT EXISTS AddTime (id INTEGER PRIMARY KEY, AddTimeCount);]]
	db:exec( tablesetup )		

--Geçici 
--	local tablefill ="DELETE from AddTime "
--	db:exec( tablefill )


	for row in db:nrows("SELECT Count(*) AA FROM AddTime ") do
  		rCount = row.AA
	end	
	if rCount== 0 then
		local tablefill =[[INSERT INTO AddTime VALUES (NULL, ]]..AddTimeCount..[[); ]]
		db:exec( tablefill )
	end
	
	for row in db:nrows("SELECT AddTimeCount FROM AddTime ") do
  		AddTimeCount = row.AddTimeCount
	end	
	
end

function ChangeGift()

	
	local tablefill ="DELETE from Gift "
	db:exec( tablefill )
	
--	local tablefill =[[INSERT INTO Gift VALUES (NULL, ]]..AddTimeCount..[[); ]]
	local tablefill ="INSERT INTO Gift(id,ChangeColor,AddTime,GameLife) VALUES (NULL," ..giveChangeColor.. ",".. giveAddTime ..",".. giveGameLife..")"
	db:exec( tablefill )
end
function FindGift()
		
	local tablesetup = [[CREATE TABLE IF NOT EXISTS Gift (id INTEGER PRIMARY KEY, ChangeColor,AddTime,GameLife);]]
	db:exec( tablesetup )		

--Geçici 
--	local tablefill ="DELETE from AddTime "
--	db:exec( tablefill )


	for row in db:nrows("SELECT * FROM Gift ") do
		giveChangeColor=row.ChangeColor
		giveAddTime=row.AddTime
		giveGameLife=row.GameLife
	end	
	
end

function ChangeBumpySet()

	
	local tablefill ="DELETE from BumpySets "
	db:exec( tablefill )
	
		local tablefill =[[INSERT INTO BumpySets VALUES (NULL, ]]..bumpySet..[[); ]]
		db:exec( tablefill )
end
function FindBumpySet()
		
	local tablesetup = [[CREATE TABLE IF NOT EXISTS BumpySets (id INTEGER PRIMARY KEY, bumpySet);]]
	db:exec( tablesetup )		

	for row in db:nrows("SELECT Count(*) AA FROM BumpySets ") do
  		rCount = row.AA
	end	
	if rCount== 0 then
		local tablefill =[[INSERT INTO BumpySets VALUES (NULL, ]]..bumpySet..[[); ]]
		db:exec( tablefill )
	end
	
	for row in db:nrows("SELECT bumpySet FROM BumpySets ") do
  		bumpySet = row.bumpySet
	end	
	
end

function FindBumpyStore(bumpySetFind)

	
	for row in db:nrows("SELECT Count(*) AA FROM BumpyStore Where BumpyId=" .. bumpySetFind) do
  		rCount = row.AA
	end	
	
	if rCount== 0 then
		return false
	else
		return true
	end
	
end
function AddBumpyStore(bumpySetFind)	
		local tablefill =[[INSERT INTO BumpyStore VALUES (NULL, ]]..bumpySetFind..[[); ]]
		db:exec( tablefill )
end
function CreateBumpyStore()
		
	local tablesetup = [[CREATE TABLE IF NOT EXISTS BumpyStore (id INTEGER PRIMARY KEY, BumpyId);]]
	db:exec( tablesetup )		

--	local tablefill ="DELETE from BumpyStore "
--	db:exec( tablefill )

	for row in db:nrows("SELECT Count(*) AA FROM BumpyStore ") do
  		rCount = row.AA
	end	
	if rCount== 0 then
		bumpyTemp=1
		local tablefill =[[INSERT INTO BumpyStore VALUES (NULL, ]]..bumpyTemp..[[); ]]
		db:exec( tablefill )
	end
	
end

--setup the system listener to catch applicationExit
Runtime:addEventListener( "system", onSystemEvent )