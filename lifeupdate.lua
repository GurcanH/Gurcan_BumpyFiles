 --[[ 
life1Time=0
life2Time=0
life3Time=0
life4Time=0
life5Time=0

function doLifeUpdate()
	if life==0 then
		life1Time = time + 20 * 1 dakika
		life2Time = time + 20 * 2 dakika
		life3Time = time + 20 * 3 dakika
		life4Time = time + 20 * 4 dakika
		life5Time = time + 20 * 5 dakika
	end 
	if life==1 then
		life2Time = time + 20 * 1 dakika
		life3Time = time + 20 * 2 dakika
		life4Time = time + 20 * 3 dakika
		life5Time = time + 20 * 4 dakika
	end 
	if life==2 then
		life3Time = time + 20 * 1 dakika
		life4Time = time + 20 * 2 dakika
		life5Time = time + 20 * 3 dakika
	end 
	if life==3 then
		life4Time = time + 20 * 1 dakika
		life5Time = time + 20 * 2 dakika
	end 
	if life==4 then
		life5Time = time + 20 * 1 dakika
	end 

end

function findTimes()
end

]]--
