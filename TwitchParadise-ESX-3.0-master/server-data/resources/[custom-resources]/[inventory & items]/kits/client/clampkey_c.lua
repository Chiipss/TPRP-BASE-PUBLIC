local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX						= nil
local CurrentAction		= nil
local PlayerData		= {}
local ClampedVehicles			= {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

--[[ RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	TriggerServerEvent('tp_clamp:syncAsk', source)
end) ]]

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('tp_clamp:onUse')
AddEventHandler('tp_clamp:onUse', function()
	local playerPed		= GetPlayerPed(-1)
	local coords		= GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		vehProps  = ESX.Game.GetVehicleProperties(vehicle)

		local loc = GetEntityCoords(vehicle)

		local attempt = 0

		while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
			Citizen.Wait(100)
			NetworkRequestControlOfEntity(vehicle)
			attempt = attempt + 1
		end

		if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
			if Config.IgnoreAbort then
				print("Checked")
			end
			TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
			Citizen.CreateThread(function()
				ThreadID = GetIdOfThisThread()
				CurrentAction = 'repair'

				exports["t0sic_loadingbar"]:StartDelayedFunction('Clamping vehicle', 10000, function() -- CHANGE BACK

				if CurrentAction ~= nil then

					local closestPos = GetEntityCoords(vehicle)
					--Draw3DText(closestPos.x, closestPos.y, closestPos.z + 2.0, "~r~CLAMPED")

                    SetEntityAsMissionEntity(vehicle)
					SetVehicleUndriveable(vehicle, true)
					SetVehicleDoorsLocked(vehicle, 2)
					FreezeEntityPosition(vehicle, true)
					
					
					ClearPedTasksImmediately(playerPed)

					exports['mythic_notify']:SendAlert('inform', 'You clamped the vehicle.', 7000)
					TriggerServerEvent('tp_clamp:removeKit')
					SetVehicleDoorShut(vehicle, 4)
			
				end

					TriggerServerEvent('tp_clamp:removeKit')


				CurrentAction = nil
					
					table.insert(ClampedVehicles, {vehicle = vehicle, vehProps = vehProps, loc = loc})
					for k,v in pairs(ClampedVehicles) do
						print(ClampedVehicles[k].vehProps.plate)
					end
					TriggerServerEvent('tp_clamp:sendVehicle', ClampedVehicles)

				TerminateThisThread()
			end)
		end)

	end

		Citizen.CreateThread(function()
			Citizen.Wait(0)

			if CurrentAction ~= nil then
				exports['mythic_notify']:SendAlert('inform', 'Press X to cancel', 5000)
				if IsControlJustReleased(0, Keys["X"]) then
					TerminateThread(ThreadID)
					exports['mythic_notify']:SendAlert('inform', 'Clamping canceled', 6000)
					CurrentAction = nil
				end
			end

		end)
	else
		exports['mythic_notify']:SendAlert('inform', 'No vehicle near-by', 6000)
	end
end)

RegisterNetEvent('tp_clampKey:onUse')
AddEventHandler('tp_clampKey:onUse', function()
	local playerPed		= GetPlayerPed(-1)
	local coords		= GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		vehProps = ESX.Game.GetVehicleProperties(vehicle)
		
		local attempt = 0

		while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
			Citizen.Wait(100)
			NetworkRequestControlOfEntity(vehicle)
			attempt = attempt + 1
		end

		if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
			if Config.IgnoreAbort then
				print("Checked")
			end
			TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
			Citizen.CreateThread(function()
				ThreadID = GetIdOfThisThread()
				CurrentAction = 'repair'

				exports["t0sic_loadingbar"]:StartDelayedFunction('Removing clamp', 10000, function()

				if CurrentAction ~= nil then

					local closestPos = GetEntityCoords(vehicle)
					--Draw3DText(closestPos.x, closestPos.y, closestPos.z + 2.0, "~r~Clamp removed")

                    SetEntityAsMissionEntity(vehicle)
					SetVehicleUndriveable(vehicle, false)
					FreezeEntityPosition(vehicle, false)
					SetVehicleDoorsLocked(vehicle, 1)


					ClearPedTasksImmediately(playerPed)

					
					

					exports['mythic_notify']:SendAlert('inform', 'Clamp removed.', 7000)
			
				end
				CurrentAction = nil
					for k,v in pairs(ClampedVehicles) do
						if v.vehProps.plate == vehProps.plate then
							ClampedVehicles[k] = nil
						end
					end
					
					print("Clamp Removed" .. vehProps.plate)
					TriggerServerEvent('tp_clamp:sendVehicle', ClampedVehicles)

					
				TerminateThisThread()
			end)
		end)

		end

		Citizen.CreateThread(function()
			Citizen.Wait(0)

			if CurrentAction ~= nil then
				exports['mythic_notify']:SendAlert('inform', 'Press X to cancel', 5000)
				if IsControlJustReleased(0, Keys["X"]) then
					TerminateThread(ThreadID)
					exports['mythic_notify']:SendAlert('inform', 'Removing canceled', 6000)
					CurrentAction = nil
				end
			end

		end)
	else
		exports['mythic_notify']:SendAlert('inform', 'No vehicle near-by', 6000)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local closest,closestDist
		local plyPos = GetEntityCoords(GetPlayerPed(-1))
		
		if ClampedVehicles then
			for k,v in pairs(ClampedVehicles) do
				local dist = GetVecDist(plyPos, v.loc)
				if not closestDist or dist < closestDist then
					closestDist = dist
					closest = v
				end
			end
		end

		if closestDist and closestDist < 5 then
			Draw3DText(closest.loc.x, closest.loc.y, closest.loc.z + 1.25, "~r~ VEHICLE CLAMPED")
		end

	end
end)

RegisterNetEvent('tp_clamp:syncReceive')
AddEventHandler('tp_clamp:syncReceive', function(NewClampedVehicles)
	print("Received new clamp data from server")
	for i=1, #ClampedVehicles do -- Clear current table out
		table.remove(ClampedVehicles, i)
	end
	ClampedVehicles = NewClampedVehicles
end)


function Draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function GetVecDist(v1, v2)
	if not v1 or not v2 or not v1.x or not v2.x then return 0; end
	return math.sqrt(  ( (v1.x or 0) - (v2.x or 0) )*(  (v1.x or 0) - (v2.x or 0) )+( (v1.y or 0) - (v2.y or 0) )*( (v1.y or 0) - (v2.y or 0) )+( (v1.z or 0) - (v2.z or 0) )*( (v1.z or 0) - (v2.z or 0) )  )
end