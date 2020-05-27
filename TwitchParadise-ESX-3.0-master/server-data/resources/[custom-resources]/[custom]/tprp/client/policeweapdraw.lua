

--------------------------------------------------------------------------------------------- ESX SUPPORT ---------------------------------------------------------------------------------------------


ESX 			    			= nil
local PlayerData 				= {}

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

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

------------------------------------------------------------------------------------------ END ESX SUPPORT -----------------------------------------------------------------------------------------
local setWeapon 		 	= ""
local weaponCount			= 0
local disablePedWeaponDraw 	= false  --- Set this to true and non-police players will be set to unarmed when exiting a vehicle. If you use a custom unholstering animation enable this to prevent players bypassing it.

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			if IsPedInAnyVehicle(ped, false) or IsPedInAnyVehicle(ped, false) == 0 then
				DisableControlAction(0,157,true) -- disable '1' Key
				if IsDisabledControlJustReleased(0, 157) then
					TriggerEvent('weaponCounter')
					Citizen.Wait(800)
				end

			end
		end
	end
	
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped, false) or IsPedInAnyVehicle(ped, false) == 0 then
			if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
				if IsControlJustReleased(0, 75) then
					SetCurrentPedWeapon(ped, setWeapon, true)
					ClearPedSecondaryTask()
					Citizen.Wait(1000)
				end
			else
				if disablePedWeaponDraw then
					if IsControlJustReleased(0, 75) then
						SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"))
						Citizen.Wait(1000)
					end
				end

			end
		end
	end
	
end)

RegisterNetEvent('weaponCounter')
AddEventHandler('weaponCounter', function()
	weaponCount = weaponCount + 1
	if weaponCount == 1 then
		setWeapon = GetHashKey("WEAPON_STUNGUN")
		TriggerEvent('alertStunGun')
	elseif weaponCount == 2 then 
		setWeapon = GetHashKey("WEAPON_COMBATPISTOL")
		TriggerEvent('alertPistol')
	elseif weaponCount == 3 then
		setWeapon = GetHashKey("WEAPON_PUMPSHOTGUN_MK2")
		TriggerEvent('alertShotGun')
	elseif weaponCount == 4 then
		setWeapon = GetHashKey("WEAPON_CARBINERIFLE_MK2")
		TriggerEvent('alertCarbine')
	elseif weaponCount == 5 then
		setWeapon = GetHashKey("WEAPON_UNARMED")
		TriggerEvent('alertUnarmed')
	elseif weaponCount <= 6 then
		weaponCount = 0
	end
end)


------------------------------------------------------------------------------------------ PNOTIFY -----------------------------------------------------------------------------------------

RegisterNetEvent('alertUnarmed')
AddEventHandler('alertUnarmed', function()
	exports.pNotify:SetQueueMax("left", 1)
    exports.pNotify:SendNotification({
    text = "Unarmed",
    type = "info",
    timeout = 600,
    layout = "centerLeft",
    queue = "left",
    killer = true
      })
end)

RegisterNetEvent('alertStunGun')
AddEventHandler('alertStunGun', function()
	exports.pNotify:SetQueueMax("left", 1)
    exports.pNotify:SendNotification({
    text = "StunGun",
    type = "info",
    timeout = 600,
    layout = "centerLeft",
    queue = "left",
    killer = true
      })
end)

RegisterNetEvent('alertPistol')
AddEventHandler('alertPistol', function()
	exports.pNotify:SetQueueMax("left", 1)
    exports.pNotify:SendNotification({
    text = "Pistol",
    type = "info",
    timeout = 600,
    layout = "centerLeft",
    queue = "left",
    killer = true
      })
end)

RegisterNetEvent('alertShotGun')
AddEventHandler('alertShotGun', function()
	exports.pNotify:SetQueueMax("left", 1)
    exports.pNotify:SendNotification({
    text = "Shotgun",
    type = "info",
    timeout = 600,
    layout = "centerLeft",
    queue = "left",
    killer = true
      })
end)

RegisterNetEvent('alertCarbine')
AddEventHandler('alertCarbine', function()
	exports.pNotify:SetQueueMax("left", 1)
    exports.pNotify:SendNotification({
    text = "Carbine Rifle",
    type = "info",
    timeout = 600,
    layout = "centerLeft",
    queue = "left",
    killer = true
      })
end)