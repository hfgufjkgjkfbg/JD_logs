local weapons = {
	[-1569615261] = 'Unarmed',
	[-72657034] = 'Parachute',
	[-1716189206] = 'Knife',
	[1737195953] = 'Nightstick',
	[1317494643] = 'Hammer',
	[-1786099057] = 'Baseball Bat',
	[-2067956739] = 'Crowbar',
	[1141786504] = 'Golf Club',
	[-102323637] = 'Bottle',
	[-1834847097] = 'Antique Cavalry Dagger',
	[-102973651] = 'Hatchet',
	[-656458692] = 'Knuckle Duster',
	[-581044007] = 'Machete',
	[-1951375401] = 'Flashlight',
	[-538741184] = 'SwitchBlade',
	[-853065399] = 'Battleaxe',
	[-1810795771] = 'Poolcue',
	[419712736] = 'Wrench',
	[940833800] = 'Stone Hatchet',

	[453432689] = 'Pistol',
	[-1075685676] = 'Pistol Mk2',
	[1593441988] = 'Combat Pistol',
	[-1716589765] = 'Pistol .50',
	[-1076751822] = 'SNS Pistol',
	[-2009644972] = 'SNS Pistol Mk2',
	[-771403250] = 'Heavy Pistol',
	[137902532] = 'Vintage Pistol',
	[-598887786] = 'Marksman Pistol',
	[-1045183535] = 'Heavy Revolver',
	[-879347409] = 'Heavy Revolver Mk2',
	[-1746263880] = 'Double-Action Revolver',
	[584646201] = 'AP Pistol',
	[911657153] = 'Stun Gun',
	[1198879012] = 'Flare Gun',
	[-1355376991] = 'Up-n-Atomizer',

	[324215364] = 'Micro SMG',
	[-619010992] = 'Machine Pistol',
	[-1121678507] = 'Mini SMG',
	[736523883] = 'SMG',
	[2024373456] = 'SMG Mk2',
	[-270015777] = 'Assault SMG',
	[171789620] = 'Combat PDW',
	[-1660422300] = 'MG',
	[2144741730] = 'Combat MG',
	[-608341376] = 'Combat MG Mk2',
	[1627465347] = 'Gusenberg Sweeper',
	[1198256469] = 'Unholy Deathbringer',

	[-1074790547] = 'Assault Rifle',
	[961495388] = 'Assault Rifle Mk2',
	[-208463392] = 'Carbine Rifle',
	[-86904375] = 'Carbine Rifle Mk2',
	[-1357824103] = 'Advanced Rifle',
	[-1063057011] = 'Special Carbine',
	[-1768145561] = 'Special Carbine Mk2',
	[2132975508] = 'Bullpup Rifle',
	[-2066285827] = 'Bullpup Rifle Mk2',
	[1649403952] = 'Compact Rifle',

	[100416529] = 'Sniper Rifle',
	[205991906] = 'Heavy Sniper',
	[177293209] = 'Heavy Sniper Mk2',
	[-952879014] = 'Marksman Rifle',
	[1785463520] = 'Marksman Rifle Mk2',

	[-1813897027] = 'Grenade',
	[741814745] = 'Sticky Bomb',
	[-1420407914] = 'Proximity Mine',
	[-1168923560] = 'Pipe Bomb',
	[-37975472] = 'Tear Gas',
	[-1600701090] = 'BZ Gas',
	[615608432] = 'Molotov',
	[101631238] = 'Fire Extinguisher',
	[883325847] = 'Jerry Can',
	[600439132] = 'Ball',
	[126349499] = 'Snowball',
	[1233104067] = 'Flare',

	[-1568386805] = 'Grenade Launcher',
	[-1312131151] = 'RPG',
	[1119849093] = 'Minigun',
	[2138347493] = 'Firework Launcher',
	[1834241177] = 'Railgun',
	[1672152130] = 'Homing Launcher',
	[125959754] = 'Compact Grenade Launcher',
	[-1238556825] = 'Widowmaker',

	[487013001] = 'Pump Shotgun',
	[1432025498] = 'Pump Shotgun Mk2',
	[2014895192] = 'Sawed-off Shotgun',
	[-1654528753] = 'Bullpup Shotgun',
	[-494615257] = 'Assault Shotgun',
	[-1466123874] = 'Musket',
	[984333226] = 'Heavy Shotgun',
	[-275439685] = 'Double Barrel Shotgun',
	[317205821] = 'Sweeper Shotgun',
}

Citizen.CreateThread(function()
    -- main loop thing
	alreadyDead = false
    while true do
        Citizen.Wait(50)
		local playerPed = GetPlayerPed(PlayerId())
		if IsEntityDead(playerPed) and not alreadyDead then
			Citizen.Wait(1)
			killer = GetPedSourceOfDeath(playerPed)
			Citizen.Wait(1)
			for _, player in ipairs(GetActivePlayers()) do
				if killer == GetPlayerPed(player) then
					killername = GetPlayerName(player)
				end
			end
			if GetPlayerServerId(PlayerId(playerPed)) == GetPlayerServerId(killer) then
				TriggerServerEvent('playerDied',0,0,nil,nil)
			elseif killername then
			for _, player in ipairs(GetActivePlayers()) do
				if killer == GetPlayerPed(player) then
				TriggerServerEvent('playerDied',killername,1,hashToWeapon(GetSelectedPedWeapon(killer)),GetPlayerServerId(player))
				end
			end
			else
				TriggerServerEvent('playerDied',0,2,nil,nil)
			end
			alreadyDead = true
		end
		if not IsEntityDead(playerPed) then
			alreadyDead = false
		end
	end
end)

Citizen.CreateThread(function()

	while true do
		Citizen.Wait(0)
		local playerped = GetPlayerPed(-1)

		if IsPedShooting(playerped) then
			TriggerServerEvent('playerShotWeapon', hashToWeapon(GetSelectedPedWeapon(playerped)))
		end

	end

end)

function hashToWeapon(hash)
	return weapons[hash]
end

exports('discord', function(message, color, channel)
	TriggerServerEvent('ClientDiscord', message, color, channel)
end)
