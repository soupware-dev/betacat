local comlib = {}

function comlib:rolldice(msg)
	require("./dice.lua")(msg)
end

function comlib:ban(message, memberToKick)
	require("./mod-utils"):ban(message, memberToKick)
end

function comlib:kick(message, memberToKick)
	require('./mod-utils'):kick(message, memberToKick)
end

function comlib:getCat(client)
	return require("./cat"):gen(client, 1)
end

function comlib:searchCat(client,query)
	return require("./cat"):gen(client, 2, query)
end

function comlib:fortune(msg)
	require("./fortune")(msg)
end

function comlib:catver(msg)
	require("./catver"):sendVersionInformation(msg)
end

function comlib:aid(msg)
	require("./aid")(msg)
end

return comlib