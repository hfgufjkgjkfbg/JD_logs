function sanitize(string)
    return string:gsub('%@', '')
end

exports('sanitize', function(string)
    sanitize(string)
end)

RegisterNetEvent("discordLogs")
AddEventHandler("discordLogs", function(message, color, channel)
    discordLog(message, color, channel)
end)

-- Get exports from server side
exports('discord', function(message, color, channel)
    discordLog(message, color, channel)
end)

-- Sending message to the All Logs channel and to the channel it has listed
function discordLog(message, color, channel)
  if Config.AllLogs then
	PerformHttpRequest(Config.webhooks["all"], function(err, text, headers) end, 'POST', json.encode({username = Config.username, embeds = {{["color"] = color, ["author"] = {["name"] = Config.communtiyName,["icon_url"] = Config.communtiyLogo}, ["description"] = "".. message .."",["footer"] = {["text"] = "© JokeDevil.com - "..os.date("%x %X %p"),["icon_url"] = "https://www.jokedevil.com/img/logo.png",},}}, avatar_url = Config.avatar}), { ['Content-Type'] = 'application/json' })
  end
	PerformHttpRequest(Config.webhooks[channel], function(err, text, headers) end, 'POST', json.encode({username = Config.username, embeds = {{["color"] = color, ["author"] = {["name"] = Config.communtiyName,["icon_url"] = Config.communtiyLogo}, ["description"] = "".. message .."",["footer"] = {["text"] = "© JokeDevil.com - "..os.date("%x %X %p"),["icon_url"] = "https://www.jokedevil.com/img/logo.png",},}}, avatar_url = Config.avatar}), { ['Content-Type'] = 'application/json' })
end

-- Event Handlers

-- Send message when Player connects to the server.
AddEventHandler("playerConnecting", function(name, setReason, deferrals)
	if Config.steamID and Config.playerID then
		discordLog('**' .. sanitize(GetPlayerName(source)) .. '** is connecting to the server.\n **SteamID: **'.. GetPlayerIdentifiers(source)[1] ..'', Config.joinColor, 'joins')
	elseif Config.steamID and not Config.playerID then
		discordLog('**' .. sanitize(GetPlayerName(source)) .. '** is connecting to the server.\n **SteamID: **'.. GetPlayerIdentifiers(source)[1] ..'', Config.joinColor, 'joins')
	elseif Config.playerID and not Config.steamID then
		discordLog('**' .. sanitize(GetPlayerName(source)) .. '** is connecting to the server.', Config.joinColor, 'joins')
	else
		discordLog('**' .. sanitize(GetPlayerName(source)) .. '** is connecting to the server.', Config.joinColor, 'joins')
	end
end)

-- Send message when Player disconnects from the server
AddEventHandler('playerDropped', function(reason)
	if Config.steamID and Config.playerID then
		discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has left the server. (Reason: ' .. reason .. ')\n **PlayerID: **'.. source ..'\n **SteamID: **'.. GetPlayerIdentifiers(source)[1] ..'', Config.leaveColor, 'leaving')
	elseif Config.steamID and not Config.playerID then
		discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has left the server. (Reason: ' .. reason .. ')\n **SteamID: **'.. GetPlayerIdentifiers(source)[1] ..'', Config.leaveColor, 'leaving')
	elseif Config.playerID and not Config.steamID then
		discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has left the server. (Reason: ' .. reason .. ')\n **PlayerID: **'.. source ..'', Config.leaveColor, 'leaving')
	else
		discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has left the server. (Reason: ' .. reason .. ')', Config.leaveColor, 'leaving')
	end
end)

-- Send message when Player creates a chat message (Does not show commands)
AddEventHandler('chatMessage', function(source, name, msg)
	if Config.steamID and Config.playerID then
		discordLog('**' .. sanitize(GetPlayerName(source)) .. '**: ``' .. msg .. '``\n **PlayerID: **'.. source ..'\n **SteamID: **'.. GetPlayerIdentifiers(source)[1] ..'', Config.chatColor, 'chat')
	elseif Config.steamID and not Config.playerID then
		discordLog('**' .. sanitize(GetPlayerName(source)) .. '**: ``' .. msg .. '``\n **SteamID: **'.. GetPlayerIdentifiers(source)[1] ..'', Config.chatColor, 'chat')
	elseif Config.playerID and not Config.steamID then
		discordLog('**' .. sanitize(GetPlayerName(source)) .. '**: ``' .. msg .. '``\n **PlayerID: **'.. source ..'', Config.chatColor, 'chat')
	else
		discordLog('**' .. sanitize(GetPlayerName(source)) .. '**: ``' .. msg .. '``', Config.chatColor, 'chat')
	end
end)

-- Send message when Player died (including reason/killer check) (Not always working)
RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(killer,reason,cause)
	if killer == "**Invalid**" then
		reason = 2
	end
	if reason == 0 then  -- Suicide
		if Config.steamID and Config.playerID then
        discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has commited suicide.\n **PlayerID: **'.. source ..'\n **SteamID: **'.. GetPlayerIdentifiers(source)[1] ..'', Config.deathColor, 'deaths') -- sending to deaths channel
		elseif Config.steamID and not Config.playerID then
        discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has commited suicide.\n **SteamID: **'.. GetPlayerIdentifiers(source)[1] ..'', Config.deathColor, 'deaths') -- sending to deaths channel
		elseif Config.playerID and not Config.steamID then
        discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has commited suicide.\n **PlayerID: **'.. source ..'', Config.deathColor, 'deaths') -- sending to deaths channel
		else
        discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has commited suicide.', Config.deathColor, 'deaths') -- sending to deaths channel
		end
	elseif reason == 1 then -- Killed by other player
		if Config.steamID and Config.playerID then
        discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has been killed by ' .. killer .. ' (' .. cause .. ')\n **PlayerID: **'.. source ..'\n **SteamID: **'.. GetPlayerIdentifiers(source)[1] ..'\n **KillerID: **'.. killer ..'\n **Killer SteamID: **'.. GetPlayerIdentifiers(killer)[1] ..'', Config.deathColor, 'deaths') -- sending to deaths channel
		elseif Config.steamID and not Config.playerID then
		discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has been killed by ' .. killer .. ' (' .. cause .. ')\n **SteamID: **'.. GetPlayerIdentifiers(source)[1] ..'\n **Killer SteamID: **'.. GetPlayerIdentifiers(killer)[1] ..'', Config.deathColor, 'deaths') -- sending to deaths channel
		elseif Config.playerID and not Config.steamID then
		discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has been killed by ' .. killer .. ' (' .. cause .. ')\n **PlayerID: **'.. source ..'\n **KillerID: **'.. killer ..'', Config.deathColor, 'deaths') -- sending to deaths channel
		else
		discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has been killed by ' .. killer .. ' (' .. cause .. ')', Config.deathColor, 'deaths') -- sending to deaths channel
		end
	else -- When gets killed by something else (like getting run over by a car)
		if Config.steamID and Config.playerID then
        discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has died.\n **PlayerID: **'.. source ..'\n **SteamID: **'.. GetPlayerIdentifiers(source)[1] ..'', Config.deathColor, 'deaths') -- sending to deaths channel
		elseif Config.steamID and not Config.playerID then
        discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has died.\n **SteamID: **'.. GetPlayerIdentifiers(source)[1] ..'', Config.deathColor, 'deaths') -- sending to deaths channel
		elseif Config.playerID and not Config.steamID then
        discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has died.\n **PlayerID: **'.. source ..'', Config.deathColor, 'deaths') -- sending to deaths channel
		else
        discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has died.', Config.deathColor, 'deaths') -- sending to deaths channel
		end
	end
end)

-- Send message when Player fires a weapon
RegisterServerEvent('playerShotWeapon')
AddEventHandler('playerShotWeapon', function(weapon)
    if Config.weaponLog then
		if Config.steamID and Config.playerID then
			discordLog('**' .. sanitize(GetPlayerName(source))  .. '** fired a ' .. weapon .. '\n **PlayerID: **'.. source ..'\n **SteamID: **'.. GetPlayerIdentifiers(source)[1] ..'' , Config.shootingColor, 'shooting')
		elseif Config.steamID and not Config.playerID then
			discordLog('**' .. sanitize(GetPlayerName(source))  .. '** fired a ' .. weapon .. '\n **SteamID: **'.. GetPlayerIdentifiers(source)[1] ..'' , Config.shootingColor, 'shooting')
		elseif Config.playerID and not Config.steamID then
			discordLog('**' .. sanitize(GetPlayerName(source))  .. '** fired a ' .. weapon .. '\n **PlayerID: **'.. source ..'' , Config.shootingColor, 'shooting')
		else
			discordLog('**' .. sanitize(GetPlayerName(source))  .. '** fired a ' .. weapon .. '' , Config.shootingColor, 'shooting')
		end
    end
end)

-- Getting exports from clientside
RegisterServerEvent('ClientDiscord')
AddEventHandler('ClientDiscord', function(message, color, channel)
   discordLog(message, color,  channel)
end)

-- Send message when a resource is being stopped
AddEventHandler('onResourceStop', function (resourceName)
    discordLog('**' .. resourceName .. '** has been stopped.', Config.resourceColor, 'resources')
end)

-- Send message when a resource is being started
AddEventHandler('onResourceStart', function (resourceName)
    Wait(100)
    discordLog('**' .. resourceName .. '** has been started.', Config.resourceColor, 'resources')
end)
