ESX          = nil
local IsDead = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer 
end)

local used = 0

local weapons = { 
	{name = "WEAPON_PISTOL", component = "component_at_pi_supp_02"},
	{name = "WEAPON_PISTOL50", component = "COMPONENT_AT_AR_SUPP_02"},
	{name = "WEAPON_COMBATPISTOL", component = "COMPONENT_AT_PI_SUPP"},
	{name = "WEAPON_APPISTOL", component = "COMPONENT_AT_PI_SUPP"},
	{name = "WEAPON_HEAVYPISTOL", component = "COMPONENT_AT_PI_SUPP"},
	{name = "WEAPON_VINTAGEPISTOL", component = "COMPONENT_AT_PI_SUPP"},
	{name = "WEAPON_SMG", component = "COMPONENT_AT_PI_SUPP"},
	{name = "WEAPON_MICROSMG", component = "COMPONENT_AT_AR_SUPP_02"},
	{name = "WEAPON_ASSAULTSMG", component = "COMPONENT_AT_AR_SUPP_02"},
	{name = "WEAPON_CARBINERIFLE", component = "COMPONENT_AT_AR_SUPP"},

	{name = "WEAPON_ADVANCEDRIFLE", component = "COMPONENT_AT_AR_SUPP"},
	{name = "WEAPON_SPECIALCARBINE", component = "COMPONENT_AT_PI_SUPP"},
	{name = "WEAPON_BULLPUPRIFLE", component = "COMPONENT_AT_AR_SUPP"},
	{name = "WEAPON_ASSAULTSHOTGUN", component = "COMPONENT_AT_AR_SUPP"},

	{name = "WEAPON_HEAVYSHOTGUN", component = "COMPONENT_AT_PI_SUPP"},
	{name = "WEAPON_BULLPUPSHOTGUN", component = "COMPONENT_AT_PI_SUPP"},
	{name = "WEAPON_PUMPSHOTGUN", component = "COMPONENT_AT_AR_SUPP"},
	{name = "WEAPON_MARKSMANRIFLE", component = "COMPONENT_AT_PI_SUPP"},
	{name = "WEAPON_SNIPERRIFLE", component = "COMPONENT_AT_PI_SUPP"},


	}



RegisterNetEvent('eden_accesories:silencer')
AddEventHandler('eden_accesories:silencer', function(duration)
	local inventory = ESX.GetPlayerData().inventory
	local silencer = 0
	for i=1, #inventory, 1 do
		if inventory[i].name == 'silencer' then
			silencer = inventory[i].count
		end
	end
	local ped = PlayerPedId()
	local currentWeaponHash = GetSelectedPedWeapon(ped)
	if used < silencer then

		if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
			GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_PISTOL"), GetHashKey("component_at_pi_supp_02"))

			
			used = used + 1

		elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
			GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
			
			used = used + 1


		elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
			GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
			
			used = used + 1

		elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
			GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
			
			used = used + 1

		elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
			GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
			
			used = used + 1

		elseif currentWeaponHash == GetHashKey("WEAPON_VINTAGEPISTOL") then
			GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_VINTAGEPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
			
			used = used + 1

		elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
			GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_PI_SUPP"))
			
			used = used + 1


		elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
			GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
			
			used = used + 1


		elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
			GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_ASSAULTSMG"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
			
			used = used + 1


		elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
			GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
			
			used = used + 1

		elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
			GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
			
			used = used + 1

		elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
			GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
			
			used = used + 1

		elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
			GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
			
			used = used + 1

		elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
			GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
			
			used = used + 1

		elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
			GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP"))
			
			used = used + 1

		elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
			GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
			
			used = used + 1

		elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
			GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
			
			used = used + 1

		elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
			GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_PUMPSHOTGUN"), GetHashKey("COMPONENT_AT_SR_SUPP"))
			
			used = used + 1

		elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
			GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
			
			used = used + 1

		elseif currentWeaponHash == GetHashKey("WEAPON_SNIPERRIFLE") then
			GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_SNIPERRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
			
			used = used + 1

		else
			ESX.ShowNotification(("You do not have a weapon in hand or your weapon can not have a silencer."))

		end
	else
		for k,v in ipairs(weapons) do
			if GetSelectedPedWeapon(ped) == GetHashKey(v.name) then
				print(v.name)
				print(v.component)
				RemoveWeaponComponentFromPed(ped, v.name, v.component)
				used = used - 1
			end
		end

	end
end)


Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1000)
		local ped = PlayerPedId()
		if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") then
			used = 0
		end
	end
end)
	



local used2 = 0

RegisterNetEvent('eden_accesories:flashlight')
AddEventHandler('eden_accesories:flashlight', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local flashlight = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'flashlight' then
						flashlight = inventory[i].count
					  end
					end
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used2 < flashlight then
						print('used2')

			if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
		  		 ESX.ShowNotification(("Flashlight Attacthed.")) 
		  		 	used2 = used2 + 1
		  	elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
		  		 ESX.ShowNotification(("Flashlight Attacthed.")) 
	used2 = used2 + 1
		  		

		  	elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
		  		 ESX.ShowNotification(("Flashlight Attacthed.")) 
	used2 = used2 + 1
				
		  	elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
		  		 ESX.ShowNotification(("Flashlight Attacthed.")) 
	used2 = used2 + 1
		  		 
		  	elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
		  		 ESX.ShowNotification(("Flashlight Attacthed.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Flashlight Attacthed.")) 
		  		 	used2 = used2 + 1


		  	elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
		  		 ESX.ShowNotification(("Flashlight Attacthed.")) 
	used2 = used2 + 1
				

		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_ASSAULTSMG"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Flashlight Attacthed.")) 
	used2 = used2 + 1
				 
		  	elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPDW") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_COMBATPDW"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Flashlight Attacthed.")) 
	used2 = used2 + 1
		  			

		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Flashlight Attacthed.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Flashlight Attacthed.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Flashlight Attacthed.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Flashlight Attacthed.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Flashlight Attacthed.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Flashlight Attacthed.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Flashlight Attacthed.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Flashlight Attacthed.")) 
	used2 = used2 + 1
		  		 
		  	elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_PUMPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Flashlight Attacthed.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Flashlight Attacthed.")) 
	used2 = used2 + 1
		  		
		  	else 
		  		  ESX.ShowNotification(("You do not have a weapon in hand or your weapon can not have a flashlight."))
		  		
			end
		else
				  		  ESX.ShowNotification(("You have use all your lamps."))

		end
end)
				local used3 = 0

RegisterNetEvent('eden_accesories:grip')
AddEventHandler('eden_accesories:grip', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local grip = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'grip' then
						grip = inventory[i].count
					  end
					end
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used3 < grip then

			
			if currentWeaponHash == GetHashKey("WEAPON_COMBATPDW") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_COMBATPDW"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Grip Attached")) 
		  				used3 = used3 + 1


		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Grip Attached.")) 
	used3 = used3 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Grip Attached.")) 
	used3 = used3 + 1
		  		
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Grip Attached.")) 
	used3 = used3 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Grip Attached.")) 
	used3 = used3 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Grip Attached.")) 
	used3 = used3 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Grip Attached.")) 
	used3 = used3 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Grip Attached.")) 
	used3 = used3 + 1
		  		 
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Grip Attached.")) 
	used3 = used3 + 1
		  		
		  	else 
		  		  ESX.ShowNotification(("You do not have a weapon in hand or your weapon cant have grip."))
		  		
			end
		else
				  		  ESX.ShowNotification(("Grips used"))
		end
end)

				local used4 = 0

RegisterNetEvent('eden_accesories:yusuf')
AddEventHandler('eden_accesories:yusuf', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local yusuf = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'yusuf' then
						yusuf = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used4 < yusuf then

			if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_PISTOL_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Skin installed.")) 
		  		 	used4 = used4 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_PISTOL50_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Skin installed.")) 
	used4 = used4 + 1
		  		
				
		  	elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_APPISTOL_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Skin installed.")) 
	used4 = used4 + 1
		  		 
		  	elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_HEAVYPISTOL_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Skin installed.")) 
	used4 = used4 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_SMG_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Skin installed.")) 
	used4 = used4 + 1
		  		 

		  	elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_MICROSMG_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Skin installed.")) 
	used4 = used4 + 1
				


		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_ASSAULTRIFLE_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Skin installed.")) 
	used4 = used4 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_CARBINERIFLE_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Skin installed.")) 
	used4 = used4 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
		  		 GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Skin installed.")) 
	used4 = used4 + 1
		  		
		  	
		  	else 
		  		  ESX.ShowNotification(("You do not have a weapon in hand or your weapon can not use a skin."))
		  		
			end
		else
				  		  ESX.ShowNotification(("You have to use all your skins."))

		end
end)

RegisterNetEvent('nfw_wep:pAmmo')
AddEventHandler('nfw_wep:pAmmo', function()
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
    local ammo = GetAmmoInPedWeapon(ped, currentWeaponHash)
    local item = "pAmmo"

    if(ammo >= 250 or ammo + 50 > 250) then
        exports['mythic_notify']:DoHudText('inform', 'Your weapon ammo is already maxed!')
        TriggerServerEvent('returnItem', item)
        return
    end

    if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 24)
        exports['mythic_notify']:DoHudText('inform', 'Added 24 more Pistol ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 24)
        exports['mythic_notify']:DoHudText('inform', 'Added 24 more Pistol ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL_MK2") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 24)
        exports['mythic_notify']:DoHudText('inform', 'Added 24 more Pistol ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 24)
        exports['mythic_notify']:DoHudText('inform', 'Added 24 more Pistol ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_SNSPISTOL") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 24)
        exports['mythic_notify']:DoHudText('inform', 'Added 24 more Pistol ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 24)
        exports['mythic_notify']:DoHudText('inform', 'Added 24 more Pistol ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_VINTAGEPISTOL") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 24)
        exports['mythic_notify']:DoHudText('inform', 'Added 24 more Pistol ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_REVOLVER") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 24)
		exports['mythic_notify']:DoHudText('inform', 'Added 24 more Pistol ammo')
	elseif currentWeaponHash == GetHashKey("WEAPON_DOUBLEACTION") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 24)
		exports['mythic_notify']:DoHudText('inform', 'Added 24 more Pistol ammo')
	elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANPISTOL") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 12)
		exports['mythic_notify']:DoHudText('inform', 'Added 24 more Pistol ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 24)
        exports['mythic_notify']:DoHudText('inform', 'Added 24 more Pistol ammo')
    else
        exports['mythic_notify']:DoHudText('inform', 'This weapon is not compatible with this ammo')
        TriggerServerEvent('returnItem', item)
    end
end)

RegisterNetEvent('nfw_wep:mgAmmo')
AddEventHandler('nfw_wep:mgAmmo', function()
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
    local ammo = GetAmmoInPedWeapon(ped, currentWeaponHash)
    local item = "mgAmmo"

    if(ammo >= 250 or ammo + 50 > 250) then
        exports['mythic_notify']:DoHudText('inform', 'Your weapon ammo is already maxed!')
        TriggerServerEvent('returnItem', item)
        return
    end

    if currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 45)
        exports['mythic_notify']:DoHudText('inform', 'Added 45 more Machine Gun ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_MACHINEPISTOL") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 45)
        exports['mythic_notify']:DoHudText('inform', 'Added 45 more Machine Gun ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 45)
        exports['mythic_notify']:DoHudText('inform', 'Added 45 more Machine Gun ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 45)
        exports['mythic_notify']:DoHudText('inform', 'Added 45 more Machine Gun ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPDW") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 45)
        exports['mythic_notify']:DoHudText('inform', 'Added 45 more Machine Gun ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_MG") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 45)
        exports['mythic_notify']:DoHudText('inform', 'Added 45 more Machine Gun ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_COMBATMG") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 45)
        exports['mythic_notify']:DoHudText('inform', 'Added 45 more Machine Gun ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_GUSENBERG") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 45)
        exports['mythic_notify']:DoHudText('inform', 'Added 45 more Machine Gun ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_MINISMG") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 45)
        exports['mythic_notify']:DoHudText('inform', 'Added 45 more Machine Gun ammo')
    else
        exports['mythic_notify']:DoHudText('inform', 'This weapon is not compatible with this ammo')
        TriggerServerEvent('returnItem', item)
    end
end)

RegisterNetEvent('nfw_wep:arAmmo')
AddEventHandler('nfw_wep:arAmmo', function()
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
    local ammo = GetAmmoInPedWeapon(ped, currentWeaponHash)
    local item = "arAmmo"

    if(ammo >= 250 or ammo + 50 > 250) then
        exports['mythic_notify']:DoHudText('inform', 'Your weapon ammo is already maxed!')
        TriggerServerEvent('returnItem', item)
        return
    end

    if currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 60)
        exports['mythic_notify']:DoHudText('inform', 'Added 60 more Assault Rifle ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 60)
        exports['mythic_notify']:DoHudText('inform', 'Added 60 more Assault Rifle ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 60)
        exports['mythic_notify']:DoHudText('inform', 'Added 60 more Assault Rifle ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 60)
        exports['mythic_notify']:DoHudText('inform', 'Added 60 more Assault Rifle ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 60)
        exports['mythic_notify']:DoHudText('inform', 'Added 60 more Assault Rifle ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_COMPACTRIFLE") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 60)
		exports['mythic_notify']:DoHudText('inform', 'Added 60 more Assault Rifle ammo')
	elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 60)
		exports['mythic_notify']:DoHudText('inform', 'Added 60 more Assault Rifle ammo')
	elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSNIPER") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 24)
		exports['mythic_notify']:DoHudText('inform', 'Added 24 more Assault Rifle ammo')
	elseif currentWeaponHash == GetHashKey("WEAPON_SNIPERRIFLE") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 24)
		exports['mythic_notify']:DoHudText('inform', 'Added 24 more Assault Rifle ammo')
    else
        exports['mythic_notify']:DoHudText('inform', 'This weapon is not compatible with this ammo')
        TriggerServerEvent('returnItem', item)
    end
end)

RegisterNetEvent('nfw_wep:sgAmmo')
AddEventHandler('nfw_wep:sgAmmo', function()
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
    local ammo = GetAmmoInPedWeapon(ped, currentWeaponHash)
    local item = "sgAmmo"

    if(ammo >= 250 or ammo + 50 > 250) then
        exports['mythic_notify']:DoHudText('inform', 'Your weapon ammo is already maxed!') 
        TriggerServerEvent('returnItem', item)
        return
    end

    if currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 12)
        exports['mythic_notify']:DoHudText('inform', 'Added 12 more Shotgun ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_SAWNOFFSHOTGUN") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 12)
        exports['mythic_notify']:DoHudText('inform', 'Added 12 more Shotgun ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_DBSHOTGUN") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 12)
        exports['mythic_notify']:DoHudText('inform', 'Added 12 more Shotgun ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 12)
        exports['mythic_notify']:DoHudText('inform', 'Added 12 more Shotgun ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 12)
        exports['mythic_notify']:DoHudText('inform', 'Added 12 more Shotgun ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_MUSKET") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 12)
        exports['mythic_notify']:DoHudText('inform', 'Added 12 more Shotgun ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 12)
        exports['mythic_notify']:DoHudText('inform', 'Added 12 more Shotgun ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_DOUBLEBARRELSHOTGUN") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 12)
        exports['mythic_notify']:DoHudText('inform', 'Added 12 more Shotgun ammo')
    elseif currentWeaponHash == GetHashKey("WEAPON_AUTOSHOTGUN") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 12)
        exports['mythic_notify']:DoHudText('inform', 'Added 12 more Shotgun ammo')
    else
        exports['mythic_notify']:DoHudText('inform', 'This weapon is not compatible with this ammo')
        TriggerServerEvent('returnItem', item)
    end
end)


RegisterNetEvent('nfw_wep:rpe')
AddEventHandler('nfw_wep:rpe', function()
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
    local ammo = GetAmmoInPedWeapon(ped, currentWeaponHash)
    local item = "rpe"

    if(ammo >= 250 or ammo + 50 > 250) then
        exports['mythic_notify']:DoHudText('inform', 'Your weapon ammo is already maxed!') 
        TriggerServerEvent('returnItem', item)
        return
    end

    if currentWeaponHash == GetHashKey("WEAPON_RPG") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 1)
        exports['mythic_notify']:DoHudText('inform', 'Added 1 RPE') 
    elseif currentWeaponHash == GetHashKey("WEAPON_FIREWORK") then
        exports['progressBars']:startUI(2000, "Reloading")
        Citizen.Wait(2000)
        AddAmmoToPed(ped, currentWeaponHash, 1)
        exports['mythic_notify']:DoHudText('inform', 'Added 1 RPE')
    else
        exports['mythic_notify']:DoHudText('inform', 'This weapon is not compatible with this ammo')
        TriggerServerEvent('returnItem', item)
    end
end)



AddEventHandler('playerSpawned', function()
  used = 0
  used2 = 0
  used3 = 0
  used4 = 0
end)












