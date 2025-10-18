-- AID (stands for "Artificial Idiocy Detector") made with love by @pizzawizard32. kill them stupid clankas!!!
local catver = require("./catver")
local keywords = {"enhanc", "stands as", "plays a significant role", "play a significant role", "illustrate", "though it", "highlight", "role", "significant", "breathtaking", "however", "crucial", "prevent confusion", "symboliz", "ensur", "emphasiz", "aligns to", "aligns with", "contributing to", "contributes to", "contributet to", "overall", "in summary", "in conclusion", "despite", "not only", "faces several challenges", "challenges", "legacy", "future", "outlook", "may vary", "critical", "boasts a", "stunning", "groundbreaking", "intricate", "reflect", "plays a vital", "industry report", "industries report", "observers have cited", "some critics argue", "—", ", not", ", just", "is not just a", "it's not just a", "it's a celebration of", "as an ai language model", "as a large language model", "here's your", "while known for"}

return function(message)
	local detections = 0
	local cmdargs = message.content:split(" ")
	table.remove(cmdargs, 1)
	local cmdstring0 = table.concat(cmdargs, " ")
	local cmdstring = string.lower(cmdstring0)

	for _, keyword in pairs(keywords) do
		if string.find(cmdstring, string.lower(keyword)) then
			detections = detections + 1
		end
	end

	message:reply{
		embed = {
			title = "AID text results",
			description = "You can check the traces of suspicious text. Please note that AID is still a work-in-progress, and it may not be accurate.",
			fields = {
				--[[{
					name = "Input",
					value = "\n```txt\n"..cmdstring0.."\n```\n",
					inline = true,
				},]]
				{
					name = "Traces",
					value = tostring(detections),
					inline = true,
				},
			},
		},
		color = catver.config.embedColour,
	}
end