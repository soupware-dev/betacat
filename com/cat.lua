local com = {}

function com:err()
  return {
    title = ":(",
    description = "An error has occurred when searching. If this is your first time getting this error, just try again.",
    color = 0x0000ff,
  }
end

function com:get(client)
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

function com:search(client, query)
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

function com:gen(client, method, query)
  local msg

  --[[
    Search methods:
	  1: Random
	  2: Specific
	  None: Default (Random)
  ]]--

  if method == 1 then
    msg = com:get(client)

    if msg ~= nil then
      return {
        title = "Cat",
        description = msg.content,
        image = {url = msg.attachment.url},
        color = 0x612C00,
      }
    else
      return com:err()
    end
  elseif method == 2 then
    msg = com:search(client, query)

    if msg ~= nil then
      return {
        title = "Cat",
        description = msg.content,
        image = {url = msg.attachment.url},
        color = 0x612C00,
      }
    else
      return com:err()
    end
  else
    local msg = com:get(client)

    if msg ~= nil then
      return {
        title = "Cat",
        description = msg.content,
        image = {url = msg.attachment.url},
        color = 0x612C00,
      }
    else
      return com:err()
    end
  end
end

return com