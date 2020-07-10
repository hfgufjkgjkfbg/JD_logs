local weapons = {
	[-1569615261] = 'Unarmed',
	[-1716189206] = 'Knife',
	[1737195953] = 'Nightstick',
	[1317494643] = 'Hammer',
	[-1786099057] = 'Bat',
	[-2067956739] = 'Crowbar',
	[1141786504] = 'Golfclub',
	[-102323637] = 'Bottle',
	[-1834847097] = 'Dagger',
	[-102973651] = 'Hatchet',
	[-656458692] = 'KnuckleDuster',
	[-581044007] = 'Machete',
	[-1951375401] = 'Flashlight',
	[-538741184] = 'SwitchBlade',
	[-1810795771] = 'Poolcue',
	[419712736] = 'Wrench',
	[-853065399] = 'Battleaxe',
	[453432689] = 'Pistol',
	[3219281620] = 'PistolMk2',
	[1593441988] = 'CombatPistol',
	[-1716589765] = 'Pistol50',
	[-1076751822] = 'SNSPistol',
	[-771403250] = 'HeavyPistol',
	[137902532] = 'VintagePistol',
	[-598887786] = 'MarksmanPistol',
	[-1045183535] = 'Revolver',
	[584646201] = 'APPistol',
	[911657153] = 'StunGun',
	[1198879012] = 'FlareGun',
	[324215364] = 'MicroSMG',
	[-619010992] = 'MachinePistol',
	[736523883] = 'SMG',
	[2024373456] = 'SMGMk2',
	[-270015777] = 'AssaultSMG',
	[171789620] = 'CombatPDW',
	[-1660422300] = 'MG',
	[2144741730] = 'CombatMG',
	[3686625920] = 'CombatMGMk2',
	[1627465347] = 'Gusenberg',
	[-1121678507] = 'MiniSMG',
	[-1074790547] = 'AssaultRifle',
	[961495388] = 'AssaultRifleMk2',
	[-2084633992] = 'CarbineRifle',
	[4208062921] = 'CarbineRifleMk2',
	[-1357824103] = 'AdvancedRifle',
	[-1063057011] = 'SpecialCarbine',
	[2132975508] = 'BullpupRifle',
	[1649403952] = 'CompactRifle',
	[100416529] = 'SniperRifle',
	[205991906] = 'HeavySniper',
	[177293209] = 'HeavySniperMk2',
	[-952879014] = 'MarksmanRifle',
	[487013001] = 'PumpShotgun',
	[2017895192] = 'SawnoffShotgun',
	[-1654528753] = 'BullpupShotgun',
	[-494615257] = 'AssaultShotgun',
	[-1466123874] = 'Musket',
	[984333226] = 'HeavyShotgun',
	[-275439685] = 'DoubleBarrelShotgun',
	[317205821] = 'Autoshotgun',
	[-1568386805] = 'GrenadeLauncher',
	[-1312131151] = 'RPG',
	[1119849093] = 'Minigun',
	[2138347493] = 'Firework',
	[1834241177] = 'Railgun',
	[1672152130] = 'HomingLauncher',
	[1305664598] = 'GrenadeLauncherSmoke',
	[125959754] = 'CompactLauncher',
	[-1813897027] = 'Grenade',
	[741814745] = 'StickyBomb',
	[-1420407917] = 'ProximityMine',
	[-1600701090] = 'BZGas',
	[615608432] = 'Molotov',
	[101631238] = 'FireExtinguisher',
	[883325847] = 'PetrolCan',
	[1233104067] = 'Flare',
	[600439132] = 'Ball',
	[126349499] = 'Snowball',
	[-37975472] = 'SmokeGrenade',
	[-1169823560] = 'Pipebomb',
	[-72657034] = 'Parachute',
	[-608341376] = 'CombatMG MK2',
	[1198256469] = 'UnholyHellbringer',
	[-1075685676] = 'Pistol MK2',
	[-2009644972] = 'SNSPistol MK2',
	[-598887786] = 'Revolver MK2',
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
