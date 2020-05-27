ESX              = nil
local PlayerData = {}

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

RegisterNetEvent('esx_armour:armour')
AddEventHandler('esx_armour:armour', function() 
	exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 3000,
        label = "Using Armour",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "oddjobs@basejump@ig_15",
            anim = "puton_parachute",
            flags = 49,
        },
    }, function(status)
        if not status then
            local playerPed = GetPlayerPed(-1)
			Citizen.CreateThread(function()
			SetPedArmour(playerPed, 100)
			end)
		end
	end)
end)