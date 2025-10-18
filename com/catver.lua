local catver = {}

catver.config = {
	forkVersion = "Pianocat 2.0 Scarlet Sage", -- replace this to your fork's version
	helpCommand = "?help",
	embedColour = 0x0033ff,
}

function catver:sendVersionInformation(message)
	message:reply{
		embed = {
			title = "ABOUT SCARLET SAGE",
			description = "Scarlet Sage is a free and public-domain bot made by @pizzawizard32 for any server, and includes 0% AI features.",
			fields = {
				{
					name = "Pianocat Version",
					value = "Scarlet Sage 2.0",
					inline = true,
				},
				{
					name = "Version",
					value = catver.config.forkVersion,
					inline = true,
				},
				{
					name = "Help command",
					value = catver.config.helpCommand,
					inline = true,
				},
			},
			color = catver.config.embedColour,
			footer = {text="Powered by Pianocat (written in Lua)"}
		}
	}
end

return catver