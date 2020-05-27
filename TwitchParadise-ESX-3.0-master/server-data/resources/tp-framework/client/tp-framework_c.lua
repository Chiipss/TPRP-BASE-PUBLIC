
RegisterNetEvent('LRP-Armour:Client:SetPlayerArmour')
AddEventHandler('LRP-Armour:Client:SetPlayerArmour', function(armour)
    Citizen.Wait(6000)  -- Give ESX time to load their stuff. Because some how ESX remove the armour when load the ped.
                        -- If there is a better way to do this, make an pull request with 'Tu eres una papa' (you are a potato) as a subject
    SetPedArmour(PlayerPedId(), tonumber(armour))
end)

local TimeFreshCurrentArmour = 1000  -- 1s

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        TriggerServerEvent('LRP-Armour:Server:RefreshCurrentArmour', GetPedArmour(PlayerPedId()))
        Citizen.Wait(TimeFreshCurrentArmour)
    end
end)


AddEventHandler('onResourceStart', function(r)
	print('boobs')
end)


------------------- EBLIPS


-- by: minipunch
-- for: Initially made for USA Realism RP (https://usarrp.net)
-- purpose: Provide public servant with blips for all other active emergency personnel

local ACTIVE = false
local ACTIVE_EMERGENCY_PERSONNEL = {}

------------
-- events --
------------
RegisterNetEvent("eblips:toggle")
AddEventHandler("eblips:toggle", function(on)
	-- toggle blip display --
	ACTIVE = on
	-- remove all blips if turned off --
	if not ACTIVE then
		RemoveAnyExistingEmergencyBlips()
	end
end)

RegisterNetEvent("eblips:updateAll")
AddEventHandler("eblips:updateAll", function(personnel)
	ACTIVE_EMERGENCY_PERSONNEL = personnel
end)

RegisterNetEvent("eblips:update")
AddEventHandler("eblips:update", function(person)
	ACTIVE_EMERGENCY_PERSONNEL[person.src] = person
end)

RegisterNetEvent("eblips:remove")
AddEventHandler("eblips:remove", function(src)
	RemoveAnyExistingEmergencyBlipsById(src)
end)


---------------
-- functions --
---------------
function RemoveAnyExistingEmergencyBlips()
	for src, info in pairs(ACTIVE_EMERGENCY_PERSONNEL) do
		local possible_blip = GetBlipFromEntity(GetPlayerPed(GetPlayerFromServerId(src)))
		if possible_blip ~= 0 then
			RemoveBlip(possible_blip)
			ACTIVE_EMERGENCY_PERSONNEL[src] = nil
		end
	end
end

function RemoveAnyExistingEmergencyBlipsById(id)
		local possible_blip = GetBlipFromEntity(GetPlayerPed(GetPlayerFromServerId(id)))
		if possible_blip ~= 0 then
			RemoveBlip(possible_blip)
			ACTIVE_EMERGENCY_PERSONNEL[id] = nil
		end
end

-----------------------------------------------------
-- Watch for emergency personnel to show blips for --
-----------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if ACTIVE then
			for src, info in pairs(ACTIVE_EMERGENCY_PERSONNEL) do
				local player = GetPlayerFromServerId(src)
				local ped = GetPlayerPed(player)
				if GetPlayerPed(-1) ~= ped then
					if GetBlipFromEntity(ped) == 0 then
						local blip = AddBlipForEntity(ped)
						SetBlipSprite(blip, 1)
						SetBlipColour(blip, info.color)
						ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
						SetBlipAsShortRange(blip, true)
						SetBlipScale(blip, 0.8) -- set scale
						--SetBlipDisplay(blip, 4)
						--SetBlipShowCone(blip, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(info.name)
						EndTextCommandSetBlipName(blip)
					end
				end
			end
		end
		Wait(1)
	end
end)

--[[ Citizen.CreateThread(function()
	while true do
		
	end
end) ]]

--[[ RegisterCommand('veh1', function(source, args)
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	local modelHash = GetEntityModel(vehicle)
	local modelName = GetDisplayNameFromVehicleModel(modelHash)
	print(GetDisplayNameFromVehicleModel(modelHash))
	local fuelLevel = GetVehicleFuelLevel(vehicle)
	print(tonumber(fuelLevel))
end) ]]


RegisterNetEvent("tp:useOxy")
AddEventHandler("tp:useOxy", function(source)
	exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 3000,
        label = "Taking Oxy",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_suicide",
            anim = "pill",
            flags = 49,
        },
        prop = {
            model = "prop_cs_pills",
            bone = 58866,
            coords = { x = 0.1, y = 0.0, z = 0.001 },
            rotation = { x = -60.0, y = 0.0, z = 0.0 },
        },
    }, function(status)
        if not status then
            local count = 30
			while count > 0 do
				Citizen.Wait(1000)
				count = count - 1
				SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 1) 
				used = true
			end
			if math.random(100) > 80 then 
				TriggerEvent('mythic_hospital:client:RemoveBleed')
			end
		end
    end)
end)