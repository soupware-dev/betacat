local discordia = require("Discordia")
local client = discordia.Client()
local com = require("./com/comlib")
local embedcolor = require("./com/catver").config.embedColour

discordia.extensions()

math.randomseed(os.time())

local cat = {}

local function err(channel)
	channel:send{
		embed = {
			title = "Error",
			description = "yeah that was kinda unexpected lol",
			color = 0xff0000,
		}
	}
end

local function truthOrDare(choice)
	local r2 = math.random(1,10)
	local prompt = ""
	
	if string.lower(choice) == "truth" then
		if r2 == 1 then
			prompt = "Do you drink alcohol?"
		elseif r2 == 2 then
			prompt = "What's the craziest thing you don't want your parents to know?"
		elseif r2 == 3 then
			prompt = "Are you a masochist?"
		elseif r2 == 4 then
			prompt = "Have you ever eaten pasta with ketchup? If yes, did it taste good?"
		elseif r2 == 5 then
			prompt = "What's one thing you hate people knowing about you?"
		elseif r2 == 6 then
			prompt = "What's your worst habit?"
		elseif r2 == 7 then
			prompt = "What's your biggest fear?"
		elseif r2 == 8 then
			prompt = "Are you vegetariam/vegan?"
		elseif r2 == 9 then
			prompt = "Which member here do you dislike the most?"
		elseif r2 == 10 then
			prompt = "What's your biggest red flag?"
		end
	elseif string.lower(choice) == "dare" then
		if r2 == 1 then
			prompt = "Share your YouTube watch history."
		elseif r2 == 2 then
			prompt = "Tell the second person in your DMs besides GDMs that you hate them"
		elseif r2 == 3 then
			prompt = "Write a simple hello world program in Assembly."
		elseif r2 == 4 then
			prompt = "Mix Coke and Fanta together and drink it. If you don't have these, do another dare."
		elseif r2 == 5 then
			prompt = "Send the most embarassing thing you can say."
		elseif r2 == 6 then
			prompt = "Play Roblox."
		elseif r2 == 7 then
			prompt = "Show all of your homescreens."
		elseif r2 == 8 then
			prompt = "Send a bag of skittles to a gay person."
		elseif r2 == 9 then
			prompt = "Listen to heavy metal"
		elseif r2 == 10 then
			prompt = "Tell a Linux fanboy their distro sucks."
		end
	else
		choice = "Error (123)"
		prompt = "You typed an invalid argument. Valid arguments for this command are 'truth' and 'dare'."
	end

	return {
		title       = string.upper(choice);
		description = prompt;
	}
end

function cat:err()
  return {
    title = ":(",
    description = "An error has occurred when searching. If this is your first time getting this error, just try again.",
    color = 0x0000ff,
  }
end

function cat:get()
  local sserver = client:getGuild("1321545663384780932")
  local storage1 = sserver:getChannel("1321545947850997811")

  local messages = storage1:getMessages(100)
  local msg

  for i,message in pairs(messages) do
    math.randomseed(os.time())
    local _random = math.random(1, #messages)

    if string.find(string.lower(message.content),"#"..tostring(_random)) then
      if message.attachment then
	    msg = message
		break
	  else
	    goto continue
      end
    end

	::continue::
  end

  return msg
end

function cat:search(query)
	local sserver = client:getGuild(1321545663384780932)
	local storage1 = sserver:getChannel("1321545947850997811")

	local messages = storage1:getMessages(100)
	local msg

	for i, message in pairs(messages) do
		if message.attachment then
			if string.find(string.lower(message.content), string.lower(tostring(query))) then
				msg = message
			end
		else
			goto continue
		end

		::continue::
	end
end

function cat:gen(method, query)
  local msg

  --[[
    Search methods:
	  1: Random
	  2: Specific
	  None: Default (Random)
  ]]--

  if method == 1 then
    msg = cat:get()

    if msg ~= nil then
      return {
        title = "Cat",
        description = msg.content,
        image = {url = msg.attachment.url},
        color = embedcolor,
      }
    else
      return cat:err()
    end
  elseif method == 2 then
    msg = cat:search(query)

    if msg ~= nil then
      return {
        title = "Cat",
        description = msg.content,
        image = {url = msg.attachment.url},
        color = embedcolor,
      }
    else
      return cat:err()
    end
  else
    local msg = cat:get()

    if msg ~= nil then
      return {
        title = "Cat",
        description = msg.content,
        image = {url = msg.attachment.url},
        color = embedcolor,
      }
    else
      return cat:err()
    end
  end
end

client:on("ready", function()
	client:setActivity("the piano")
	print("Logged in as " .. client.user.name)
end)

client:on("messageCreate", function(message)
	if string.lower(message.content) == "!ping" then
		message.channel:send{content="pong", reference={message=message,mention=true}}
	elseif string.lower(message.content) == "!dice" then
		com:rolldice(message)
	elseif string.sub(string.lower(message.content),1,13) == "!truthordare " then
		message:reply{embed=truthOrDare(string.sub(string.lower(message.content), 14))}
	elseif string.sub(string.lower(message.content),1,5) == "!ban " then
		com:ban(message, string.sub(string.lower(message.content), 6))
	elseif string.sub(string.lower(message.content),1, 6) == '!kick ' then
		com:kick(message, string.sub(string.lower(message.content), 7))
	elseif string.lower(message.content) == "!cat" then
		message:reply{embed=cat:gen()}
	elseif string.lower(message.content) == "!fortune" then
		com:fortune(message)
	elseif string.lower(message.content) == require("./com/catver").config.helpCommand then
		message:reply{
			embed = {
				title = "COMMAND LIST",
				description = "?help\n?catver\n!ping\n!dice\n!truthordare <truth/dare>\n!ban <member>\n!kick <member>\n!cat\n!fortune\n!echo <string>",
				color = embedcolor,
			}
		}
	elseif string.lower(message.content) == "?catver" then
		com:catver(message)
	elseif string.lower(message.content):startswith("!echo ") then
		message:reply(string.sub(message.content, 7))
	elseif string.lower(message.content):startswith("!date ") then
		-- under construction
		local content = string.sub(message.content, 7)
		local args = content:split("/")

		local argcount = 0
		for i, arg in ipairs(args) do
			argcount = argcount + 1
		end

		if argcount == 3 then
			if tonumber(args[3]) >= 1970 and tonumber(args[2]) >= 1 and tonumber(args[1]) >= 1 then
				if tonumber(args[3]) < 3001 then
					message:reply{
						embed = {
							title = "Datetime Generator",
							description = "Your datetime has been generated! :D",
							fields = {
								{
									name = "date with slashes idk (<t:sample:d>)",
									value = "<t:"..os.time{year=args[3], month=args[2], day=args[1]}..":d>"
								},
								{
									name = "normal date i also dont know (<t:sample:D>)",
									value = "<t:"..os.time{year=args[3], month=args[2], day=args[1]}..":D>"
								},
								{
									name = "Unix time conversion",
									value = os.time{year=args[3], month=args[2], day=args[1]}
								}
							},
							color = embedcolor,
						}
					}
				else
					err(message.channel)
				end
			else
				err(message.channel)
			end
		else
			err(message.channel)
		end
	elseif string.lower(message.content):startswith("!clock ") then
		-- under construction
		local content = string.sub(message.content, 8)
		local args = content:split(":")

		local argcount = 0
		for i, arg in ipairs(args) do
			argcount = argcount + 1
		end

		if argcount == 3 then
			if tonumber(args[1]) <= 24 and tonumber(args[2]) <= 59 and tonumber(args[3]) <= 59 and tonumber(args[1]) >= 0 and tonumber(args[2]) >= 0 and tonumber(args[3]) >= 0 then
				message:reply{
					embed = {
						title = "Clocktime Generator",
						description = "Your clocktime has been generated! :D",
						fields = {
							{
								name = "Clocktime (HH:MM) (<t:sample:t>)",
								value = "<t:"..os.time{hour=args[1], min=args[2], sec=args[3], day=os.date("%d"), month=os.date("%m"), year=os.date("%Y")}..":t>"
							},
							{
								name = "Clocktime (HH:MM:SS)",
								value = "<t:"..os.time{hour=args[1], min=args[2], sec=args[3], day=os.date("%d"), month=os.date("%m"), year=os.date("%Y")}..":T>"
							},
							{
								name = "Unix time conversion",
								value = os.time{hour=args[1], min=args[2], sec=args[3], day=os.date("%d"), month=os.date("%m"), year=os.date("%Y")}
							}
						},
						color = embedcolor,
					}
				}
			else
				err(message.channel)
			end
		else
			err(message.channel)
		end
	elseif string.lower(message.content):startswith("!aid ") then
		com:aid(message)
	end
end)

local file = io.open("token.txt", 'r')
local token = file:read()
client:run("Bot "..token)