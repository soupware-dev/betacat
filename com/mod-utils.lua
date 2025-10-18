local modutils = {}

function modutils:kick(message, memberToKick)
	local errors = 0
	if message.author.bot then return end

	if message.member:hasPermission("kickMembers") then
		if message.guild.me:hasPermission("kickMembers") then
			local mtk = message.guild:getMember(memberToKick)
			if mtk then
				if message.member.highestRole.position > mtk.highestRole.position then
					if message.guild.me.highestRole.position > mtk.highestRole.position then
						mtk:kick()
					else
						errors=errors+1
					end
				else
					errors=errors+1
				end
			else
				errors=errors+1
			end
		else
			errors=errors+1
		end
	else
		errors=errors+1
	end

	if errors > 0 then
		message:reply("Error (0): Unable to kick this member.")
	else
		message:reply("Done.")
	end
end

function modutils:ban(message, memberToKick)
	local errors = 0
	if message.author.bot then return end

	if message.member:hasPermission("banMembers") then
		if message.guild.me:hasPermission("banMembers") then
			local mtk = message.guild:getMember(memberToKick)
			if mtk then
				if message.member.highestRole.position > mtk.highestRole.position then
					if message.guild.me.highestRole.position > mtk.highestRole.position then
						mtk:ban()
					else
						message.guild:banUser(memberToKick.id)
					end
				else
					errors=errors+1
				end
			else
				errors=errors+1
			end
		else
			errors=errors+1
		end
	else
		errors=errors+1
	end

	if errors > 0 then
		message:reply("Error (0): Unable to ban this member.")
	else
		message:reply("Done.")
	end
end

return modutils
