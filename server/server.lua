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
	local ids = ExtractIdentifiers(source)
	if Config.discordID then _discordID ="\n**Discord ID:** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "" end
	if Config.steamID then _steamID ="\n**Steam ID:** " ..ids.steam.."" else _steamID = "" end
	if Config.steamURL then _steamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "" end
	if Config.playerID then _playerID ="\n**Playeer ID:** " ..source.."" else _playerID = "" end
	discordLog('**' .. sanitize(GetPlayerName(source)) .. '** is connecting to the server.'.._playerID..''.. _discordID..''.._steamID..''.._steamURL..'', Config.joinColor, 'joins')
end)

-- Send message when Player disconnects from the server
AddEventHandler('playerDropped', function(reason)
	local ids = ExtractIdentifiers(source)
	if Config.discordID then _discordID ="\n**Discord ID:** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "" end
	if Config.steamID then _steamID ="\n**Steam ID:** " ..ids.steam.."" else _steamID = "" end
	if Config.steamURL then _steamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "" end
	if Config.playerID then _playerID ="\n**Playeer ID:** " ..source.."" else _playerID = "" end
	discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has left the server. (Reason: ' .. reason .. ')'.._playerID..''.. _discordID..''.._steamID..''.._steamURL..'', Config.leaveColor, 'leaving')
end)

-- Send message when Player creates a chat message (Does not show commands)
AddEventHandler('chatMessage', function(source, name, msg)
	local ids = ExtractIdentifiers(source)
	if Config.discordID then _discordID ="\n**Discord ID:** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "" end
	if Config.steamID then _steamID ="\n**Steam ID:** " ..ids.steam.."" else _steamID = "" end
	if Config.steamURL then _steamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "" end
	if Config.playerID then _playerID ="\n**Playeer ID:** " ..source.."" else _playerID = "" end

	discordLog('**' .. sanitize(GetPlayerName(source)) .. '**: ``' .. msg .. '``'.._playerID..''.. _discordID..''.._steamID..''.._steamURL..'', Config.chatColor, 'chat')
end)

-- Send message when Player died (including reason/killer check) (Not always working)
RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(killer,reason,cause,killerid)
	local ids = ExtractIdentifiers(source)

	if Config.discordID then _discordID ="\n**Discord ID:** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "" end
	if Config.steamID then _steamID ="\n**Steam ID:** " ..ids.steam.."" else _steamID = "" end
	if Config.steamURL then _steamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "" end
	if Config.playerID then _playerID ="\n**Playeer ID:** " ..source.."" else _playerID = "" end

	if killer == "**Invalid**" then
		reason = 2
	end

	if reason == 0 then  -- Suicide
        discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has commited `suicide`.'.._playerID..''.. _discordID..''.._steamID..''.._steamURL..'', Config.deathColor, 'deaths') -- sending to deaths channel
	elseif reason == 1 then -- Killed by other player
		local ids2 = ExtractIdentifiers(killerid)
		if Config.discordID then _KillDiscordID ="\n**Discord ID:** <@" ..ids2.discord:gsub("discord:", "")..">" else _KillDiscordID = "" end
		if Config.steamID then _KillSteamID ="\n**Steam ID:** " ..ids2.steam.."" else _KillSteamID = "" end
		if Config.steamURL then _KillSteamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids2.steam:gsub("steam:", ""),16).."" else _KillSteamURL = "" end
		if Config.playerID then _killPlayerID ="\n**Playeer ID:** " ..killerid.."" else _killPlayerID = "" end
		discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has been `murdered` by ' .. killer .. ' `(' .. cause .. ')`\n\n**[Player INFO]**'.._playerID..''.. _discordID..''.._steamID..''.._steamURL..'\n\n**[Killer INFO]**'.._killPlayerID..''.. _KillDiscordID..''.._KillSteamID..''.._KillSteamURL..'', Config.deathColor, 'deaths') -- sending to deaths channel
	else -- When gets killed by something else (like getting run over by a car)
        discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has `died`.'.._playerID..''.. _discordID..''.._steamID..''.._steamURL..'', Config.deathColor, 'deaths') -- sending to deaths channel
	end
end)

-- Send message when Player fires a weapon
RegisterServerEvent('playerShotWeapon')
AddEventHandler('playerShotWeapon', function(weapon)
	local ids = ExtractIdentifiers(source)
	if Config.discordID then _discordID ="\n**Discord ID:** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "" end
	if Config.steamID then _steamID ="\n**Steam ID:** " ..ids.steam.."" else _steamID = "" end
	if Config.steamURL then _steamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "" end
	if Config.playerID then _playerID ="\n**Playeer ID:** " ..source.."" else _playerID = "" end
	if Config.weaponLog then
		discordLog('**' .. sanitize(GetPlayerName(source))  .. '** fired a `' .. weapon .. '`'.._playerID..''.. _discordID..''.._steamID..''.._steamURL..'', Config.shootingColor, 'shooting')
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

RegisterServerEvent('JDlogs:GetIdentifiers')
AddEventHandler('JDlogs:GetIdentifiers', function(src)
	local ids = ExtractIdentifiers(src)
	return ids
end)

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end
