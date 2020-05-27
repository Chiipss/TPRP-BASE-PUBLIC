ESX = nil

local timing, isPlayerWhitelisted = math.ceil(Config.Timer * 60000), false
local streetName, playerGender

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	TriggerEvent('skinchanger:getSkin', function(skin)
		playerGender = skin.sex
	end)

	isPlayerWhitelisted = refreshPlayerWhitelisted()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job

	isPlayerWhitelisted = refreshPlayerWhitelisted()
end)

RegisterNetEvent('esx_outlawalert:outlawNotify')
AddEventHandler('esx_outlawalert:outlawNotify', function(alert)
	if isPlayerWhitelisted then
		ESX.ShowNotification(alert)
	end
end)

RegisterNetEvent('tp-outlawNotify')
AddEventHandler('tp-outlawNotify', function(notifyText, duration)
	local notifyText = notifyText
	if isPlayerWhitelisted then
		TriggerServerEvent("tp:addChatPolice", notifyText, duration)

		--exports['mythic_notify']:SendAlert('error', notifyText, duration)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)

		if NetworkIsSessionStarted() then
			DecorRegister('isOutlaw', 3)
			DecorSetInt(PlayerPedId(), 'isOutlaw', 1)

			return
		end
	end
end)

-- Gets the player's current street.
-- Aaalso get the current player gender
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)

		local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
		streetName = GetStreetNameFromHashKey(streetName)
	end
end)

AddEventHandler('skinchanger:loadSkin', function(character)
	playerGender = character.sex
end)

function refreshPlayerWhitelisted()
	if not ESX.PlayerData then
		return false
	end

	if not ESX.PlayerData.job then
		return false
	end

	for k,v in ipairs(Config.WhitelistedCops) do
		if v == ESX.PlayerData.job.name then
			return true
		end
	end

	return false
end

RegisterNetEvent('esx_outlawalert:carJackInProgress')
AddEventHandler('esx_outlawalert:carJackInProgress', function(targetCoords)
	if isPlayerWhitelisted then
		if Config.CarJackingAlert then
			local alpha = 350
			local alpha2 = 180
			local thiefBlip = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipJackingRadius)
			local thiefBlip2 = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipJackingRadius)


			SetBlipHighDetail(thiefBlip2, true)
			SetBlipColour(thiefBlip2, 3)
			SetBlipAlpha(thiefBlip2, alpha2)
			SetBlipAsShortRange(thiefBlip2, true)		

			SetBlipSprite(thiefBlip, 620)	
			SetBlipHighDetail(thiefBlip, true)
			SetBlipColour(thiefBlip, 4)
			SetBlipAlpha(thiefBlip, alpha)
			SetBlipFlashes(thiefBlip, true)
			SetBlipRoute(thiefBlip, true)
			SetBlipRouteColour(thiefBlip, 3)
			SetBlipShowCone(thiefBlip, true)
			SetBlipDisplay(thiefBlip, 10)
			SetBlipBright(thiefBlip, true)
			

			while alpha ~= 0 do
				Citizen.Wait(Config.BlipJackingTime * 4)
				alpha = alpha - 1
				SetBlipAlpha(thiefBlip, alpha)

				if alpha == 0 then
					RemoveBlip(thiefBlip)
					RemoveBlip(thiefBlip2)
					return
				end
			end

		end
	end
end)

RegisterNetEvent('esx_outlawalert:gunshotInProgress')
AddEventHandler('esx_outlawalert:gunshotInProgress', function(targetCoords)
	if isPlayerWhitelisted and Config.GunshotAlert then
		local alpha = 350
		local alpha2 = 180
		local gunshotBlip = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipGunRadius)
		local gunshotBlip2 = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipGunRadius)


		SetBlipHighDetail(gunshotBlip2, true)
		SetBlipColour(gunshotBlip2, 1)
		SetBlipAlpha(gunshotBlip2, alpha2)
		SetBlipAsShortRange(gunshotBlip2, true)		

        SetBlipSprite(gunshotBlip, 126)
		SetBlipHighDetail(gunshotBlip, true)
		SetBlipColour(gunshotBlip, 4)
		SetBlipAlpha(gunshotBlip, alpha)
		SetBlipFlashes(gunshotBlip, true)
		SetBlipRoute(gunshotBlip, true)
		SetBlipRouteColour(gunshotBlip, 1)
		SetBlipShowCone(gunshotBlip, true)
		SetBlipDisplay(gunshotBlip, 10)
		SetBlipBright(gunshotBlip, true)
        
		while alpha ~= 0 do
			Citizen.Wait(Config.BlipGunTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(gunshotBlip, alpha)

			if alpha == 0 then
				RemoveBlip(gunshotBlip)
				RemoveBlip(gunshotBlip2)
				return
			end
		end
	end
end)

RegisterNetEvent('esx_outlawalert:drugSaleInProgress')
AddEventHandler('esx_outlawalert:drugSaleInProgress', function(targetCoords)
	if isPlayerWhitelisted then
		local alpha = 350
		local alpha2 = 180
		local drugBlip = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipGunRadius)
		local drugBlip2 = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipGunRadius)


		SetBlipHighDetail(drugBlip2, true)
		SetBlipColour(drugBlip2, 21)
		SetBlipAlpha(drugBlip2, alpha2)
		SetBlipAsShortRange(drugBlip2, true)		

        SetBlipSprite(drugBlip, 501)
		SetBlipHighDetail(drugBlip, true)
		SetBlipColour(drugBlip, 4)
		SetBlipAlpha(drugBlip, alpha)
		SetBlipFlashes(drugBlip, true)
		SetBlipRoute(drugBlip, true)
		SetBlipRouteColour(drugBlip, 21)
		SetBlipShowCone(drugBlip, true)
		SetBlipDisplay(drugBlip, 10)
		SetBlipBright(drugBlip, true)
        
		while alpha ~= 0 do
			Citizen.Wait(Config.BlipGunTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(drugBlip, alpha)

			if alpha == 0 then
				RemoveBlip(drugBlip)
				RemoveBlip(drugBlip2)
				return
			end
		end
	end
end)

RegisterNetEvent('esx_outlawalert:combatInProgress')
AddEventHandler('esx_outlawalert:combatInProgress', function(targetCoords)
	if isPlayerWhitelisted and Config.MeleeAlert then
		local alpha = 350
		local meleeBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipMeleeRadius)

		SetBlipHighDetail(meleeBlip, true)
		SetBlipColour(meleeBlip, 17)
		SetBlipAlpha(meleeBlip, alpha)
		SetBlipAsShortRange(meleeBlip, true)
		SetBlipScale(meleeBlip, 0.8)

		while alpha ~= 0 do
			Citizen.Wait(Config.BlipMeleeTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(meleeBlip, alpha)

			if alpha == 0 then
				RemoveBlip(meleeBlip)
				return
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)

		if DecorGetInt(PlayerPedId(), 'isOutlaw') == 2 then
			Citizen.Wait(timing)
			DecorSetInt(PlayerPedId(), 'isOutlaw', 1)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)

		-- is jackin'
		if (IsPedTryingToEnterALockedVehicle(playerPed) or IsPedJacking(playerPed)) and Config.CarJackingAlert then

			Citizen.Wait(3000)
			
			local vehicle = GetVehiclePedIsIn(playerPed, true)
			--local vehicle = GetVehiclePedIsUsing(playerPed)

				if vehicle and ((isPlayerWhitelisted and Config.ShowCopsMisbehave) or not isPlayerWhitelisted) then
                local plate = GetVehicleNumberPlateText(vehicle)
                
                if plate == nil then
                    plate = "Unknown"
                end

				ESX.TriggerServerCallback('esx_outlawalert:isVehicleOwner', function(owner)
					if not owner then

						local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
						vehicleLabel = GetLabelText(vehicleLabel)

						DecorSetInt(playerPed, 'isOutlaw', 2)

						TriggerServerEvent('esx_outlawalert:carJackInProgress', {
							x = ESX.Math.Round(playerCoords.x, 1),
							y = ESX.Math.Round(playerCoords.y, 1),
							z = ESX.Math.Round(playerCoords.z, 1)
						}, streetName, vehicleLabel, playerGender, plate)
					end
				end, plate)
			end

		elseif IsPedInMeleeCombat(playerPed) and Config.MeleeAlert then

			Citizen.Wait(3000)

			if (isPlayerWhitelisted and Config.ShowCopsMisbehave) or not isPlayerWhitelisted then
				DecorSetInt(playerPed, 'isOutlaw', 2)

				TriggerServerEvent('esx_outlawalert:combatInProgress', {
					x = ESX.Math.Round(playerCoords.x, 1),
					y = ESX.Math.Round(playerCoords.y, 1),
					z = ESX.Math.Round(playerCoords.z, 1)
				}, streetName, playerGender)
			end

		elseif IsPedShooting(playerPed) and not IsPedCurrentWeaponSilenced(playerPed) and Config.GunshotAlert then

			Citizen.Wait(3000)

			if (isPlayerWhitelisted and Config.ShowCopsMisbehave) or not isPlayerWhitelisted then
				DecorSetInt(playerPed, 'isOutlaw', 2)

				TriggerServerEvent('esx_outlawalert:gunshotInProgress', {
					x = ESX.Math.Round(playerCoords.x, 1),
					y = ESX.Math.Round(playerCoords.y, 1),
					z = ESX.Math.Round(playerCoords.z, 1)
				}, streetName, playerGender)
			end
		end
	end
end)
