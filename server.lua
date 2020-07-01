local webhooks = {
    all = "https://discordapp.com/api/webhooks/727684801250984037/jOkljlvIRjZM-DasusORRfdXPBClPpyictP4EM3EK7i8ZMka-Fc1c8An9UqB4lRyLqn3",
	chat = "https://discordapp.com/api/webhooks/727684994398683207/a7RAuGG37gydROehu1-iGZ1KzPFT_guOEZ5mo6feut1WYtLrT7LOVbvegKI3jODgOAAb",
    joins = "https://discordapp.com/api/webhooks/727685095510769684/ED8cREYpN2se6Polc777IkMG3zjtVh8VCCWqmBiavcTMeVlZfBIbOnCBXeDHFCjvx_DY",
    leaving = "https://discordapp.com/api/webhooks/727685095510769684/ED8cREYpN2se6Polc777IkMG3zjtVh8VCCWqmBiavcTMeVlZfBIbOnCBXeDHFCjvx_DY",
    deaths = "https://discordapp.com/api/webhooks/727685380425515028/c44MKUrxoRccssAvLFdapceizZ9Nfn_3-qQ_TmZEYFQLWx1UGNpZLL5cJArcf93hpYf-",
    --shooting = "https://discordapp.com/api/webhooks/727685501083189259/zITFCFWYJCvlPv9lknOb3MjHruOK-wPgaQ09Ozi1pBwI4DHitv_DLpE0cC7Eujln5awT",
    me = "https://discordapp.com/api/webhooks/727685558947807293/E-qbOn8ohZdhazLc2OqG9fD8x8P_5I3OVdePoaFwOCHCN5PqnjYAbN1dA04O9S1kQ2NT",
	gme = "https://discordapp.com/api/webhooks/727685633962934324/BiaSibYA9zedzNGZf_iFq4dhcKHgLq34J0L2TTuSR8q83IiEx_c62WVP_x4OJq7xzJU7",
	twot = "https://discordapp.com/api/webhooks/727685730654093313/VIxBbSL9cCXnojc4V0XuBn6_GwAr5pB5R_92qpj8A8My7kQtt5Q1zfIV22Wdtiy_Rl-B",
	ooc = "https://discordapp.com/api/webhooks/727686025433972767/j648kcsyKr7L8fFvM9kszW0haiodP8bb7fzX7ero3BJxnZINZX06DHLPSqSUyiGg9pPq",
	darkweb = "https://discordapp.com/api/webhooks/727686136251547678/vNSw6h6pLafKdgkALLAMLhqS1DVf-_jeLgcVx-sJ8Uk9twUeSJYkspJxo5Y-zp0f-nS5",
    heal = "https://discordapp.com/api/webhooks/727685440542474302/-yhkdbBTSOf1Ktg9tquv7aN2T2ifC2dECtnRCKvuhjeLlyWphOvsXK2kxi66-MrzYcew",
    resources = "https://discordapp.com/api/webhooks/727685942738944070/cGLkk3OsMn9eBVuEH9Zjy9WglfEVYrKqz447UohamovPJKabZsgFylZBdkTEfnhU3V8m",
}

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

exports('discord', function(message, color, channel)
    discordLog(message, color, channel)
end)

function discordLog(message, color, channel)
	PerformHttpRequest(webhooks['all'], function(err, text, headers) end, 'POST', json.encode({username = "Server Logs", embeds = {{["color"] = color,["title"] = "Server Logs",["description"] = "".. message .."",["footer"] = {["text"] = os.date(),["icon_url"] = communtiylogo,},}}, avatar_url = "https://gyazo.com/3b6671e49b91493136d70f09795f5cfd.png"}), { ['Content-Type'] = 'application/json' })
	PerformHttpRequest(webhooks[channel], function(err, text, headers) end, 'POST', json.encode({username = "Server Logs", embeds = {{["color"] = color,["title"] = "Server Logs",["description"] = "".. message .."",["footer"] = {["text"] = os.date(),["icon_url"] = communtiylogo,},}}, avatar_url = "https://gyazo.com/3b6671e49b91493136d70f09795f5cfd.png"}), { ['Content-Type'] = 'application/json' })    
end

-- Event Handlers

AddEventHandler("playerConnecting", function(name, setReason, deferrals)
    discordLog('**' .. sanitize(GetPlayerName(source)) .. '** is connecting to the server.', '3066993', 'joins')
end)

AddEventHandler('playerDropped', function(reason)
    discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has left the server. (Reason: ' .. reason .. ')', '15158332', 'leaving')
end)

AddEventHandler('chatMessage', function(source, name, msg)
    discordLog('**' .. sanitize(GetPlayerName(source)) .. '**: ``' .. msg .. '``', '1146986', 'chat')
end)


RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(killer,reason,cause)
	if killer == "**Invalid**" then
		reason = 2
	end
	if reason == 0 then
        discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has commited suicide.', '10038562', 'deaths')
	elseif reason == 1 then
        discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has been killed by ' .. killer .. ' (' .. cause .. ')', '10038562', 'deaths')
	else
        discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has died.', '10038562', 'deaths')
	end
end)

--RegisterServerEvent('playerShotWeapon')
--AddEventHandler('playerShotWeapon', function(weapon)
--   discordLog('**' .. sanitize(GetPlayerName(source))  .. '** fired a ' .. weapon , '7419530', 'shooting')
--end)

RegisterServerEvent('ClientDiscord')
AddEventHandler('ClientDiscord', function(message, channel)
   discordLog(message, channel)
end)

AddEventHandler('onResourceStop', function (resourceName)
    discordLog('**' .. resourceName .. '** has been stopped.', '9936031', 'resources')
end)

AddEventHandler('onResourceStart', function (resourceName)
    Wait(100)
    discordLog('**' .. resourceName .. '** has been started.', '9936031', 'resources')
end)
