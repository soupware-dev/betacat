return function(msg)
	local randomCookie = math.random(1,6)
	local atchm
	if randomCookie == 1 then
		atchm="../resources/fortune-cookies/ew.gif"
	elseif randomCookie == 2 then
		atchm="../resources/fortune-cookies/fortune-fortune-cookie.gif"
	elseif randomCookie == 3 then
		atchm="../resources/fortune-cookies/league-of-legends-fortune-cookie.gif"
	elseif randomCookie == 4 then
		atchm="../resources/fortune-cookies/locket-my-beloved.gif"
	elseif randomCookie == 5 then
		atchm="../resources/fortune-cookies/makesweet1.gif"
	elseif randomCookie == 6 then
		atchm="../resources/fortune-cookie/no-one-likes-you-4hala.gif"
	end
	message:reply{file=atchm}
end