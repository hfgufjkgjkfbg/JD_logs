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
	PerformHttpRequest(Config.webhooks['all'], function(err, text, headers) end, 'POST', json.encode({username = "Server Logs", embeds = {{["color"] = color,["title"] = "Server Logs",["description"] = "".. message .."",["footer"] = {["text"] = os.date(),["icon_url"] = Config.communtiylogo,},}}, avatar_url = Config.avatar}), { ['Content-Type'] = 'application/json' })
	PerformHttpRequest(Config.webhooks[channel], function(err, text, headers) end, 'POST', json.encode({username = "Server Logs", embeds = {{["color"] = color,["title"] = "Server Logs",["description"] = "".. message .."",["footer"] = {["text"] = os.date(),["icon_url"] = Config.communtiylogo,},}}, avatar_url = Config.avatar}), { ['Content-Type'] = 'application/json' })
end

-- Event Handlers

-- Send message when Player connects to the server.
AddEventHandler("playerConnecting", function(name, setReason, deferrals)
    discordLog('**' .. sanitize(GetPlayerName(source)) .. '** is connecting to the server.\n **SteamID: **'.. GetPlayerIdentifiers(source)[1] ..'', '3066993', 'joins') -- sending to joins channel
end)

-- Send message when Player disconnects from the server
AddEventHandler('playerDropped', function(reason)
    discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has left the server. (Reason: ' .. reason .. ')\n **SteamID: **'.. GetPlayerIdentifiers(source)[1] ..'', '15158332', 'leaving') -- sending to leaving channel
end)

-- Send message when Player creates a chat message (Does not show commands)
AddEventHandler('chatMessage', function(source, name, msg)
    discordLog('**' .. sanitize(GetPlayerName(source)) .. '**: ``' .. msg .. '``\n **SteamID: **'.. GetPlayerIdentifiers(source)[1] ..'', '1146986', 'chat') -- sending to chat channel
end)

-- Send message when Player died (including reason/killer check)
RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(killer,reason,cause)
	if killer == "**Invalid**" then
		reason = 2
	end
	if reason == 0 then  -- Suicide
        discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has commited suicide.\n **SteamID: **'.. GetPlayerIdentifiers(source)[1] ..'', '10038562', 'deaths') -- sending to deaths channel
	elseif reason == 1 then -- Killed by other player
        discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has been killed by ' .. killer .. ' (' .. cause .. ')\n **SteamID: **'.. GetPlayerIdentifiers(source)[1] ..'\n **Killer SteamID: **'.. GetPlayerIdentifiers(killer)[1] ..'', '10038562', 'deaths') -- sending to deaths channel
	else -- When gets killed by something else (like getting run over by a car)
        discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has died.\n **SteamID: **'.. GetPlayerIdentifiers(source)[1] ..'', '10038562', 'deaths') -- sending to deaths channel
	end
end)

-- Send message when Player fires a weapon
RegisterServerEvent('playerShotWeapon')
AddEventHandler('playerShotWeapon', function(weapon)
   discordLog('**' .. sanitize(GetPlayerName(source))  .. '** fired a ' .. weapon .. '\n **SteamID: **'.. GetPlayerIdentifiers(source)[1] ..'' , '7419530', 'shooting') --Sending to shooting channel
end)

-- Getting exports from clientside
RegisterServerEvent('ClientDiscord')
AddEventHandler('ClientDiscord', function(message, color, channel)
   discordLog(message, color,  channel)
end)

-- Send message when a resource is being stopped
AddEventHandler('onResourceStop', function (resourceName)
    discordLog('**' .. resourceName .. '** has been stopped.', '9936031', 'resources')
end)

-- Send message when a resource is being started
AddEventHandler('onResourceStart', function (resourceName)
    Wait(100)
    discordLog('**' .. resourceName .. '** has been started.', '9936031', 'resources')
end)
