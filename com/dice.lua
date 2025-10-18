return function(msg)
	local rndn = math.random(1, 6)
	msg:reply{
		embed = {
			title = "Dice",
			description = "You've got "..rndn..", skill issue.",
			image = {url="https://c.tenor.com/i_L5KauoCcoAAAAi/dice.gif"},
			color = 0xff0000,
			author = {
				name = msg.author.username,
				icon_url = msg.author.avatarURL
			},
		}
	}
end