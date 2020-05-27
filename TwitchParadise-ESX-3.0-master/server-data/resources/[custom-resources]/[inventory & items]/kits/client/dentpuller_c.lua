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

RegisterNetEvent('esx_dentpuller:onUse')
AddEventHandler('esx_dentpuller:onUse', function()
	local playerPed		= GetPlayerPed(-1)
	local coords		= GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

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
			TriggerEvent("mythic_progbar:client:progress", {
				name = "Pulling out dents",
				duration = 22000,
				label = "Using the dent puller",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
					anim = "machinic_loop_mechandplayer",
				},
			}, function(status)
				if not status then
					-- Do Something If Event Wasn't Cancelled
				end
			--TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
			Citizen.CreateThread(function()
				ThreadID = GetIdOfThisThread()
				CurrentAction = 'repair'

				--exports["t0sic_loadingbar"]:StartDelayedFunction('Pulling out dents', 20000, function()

				if CurrentAction ~= nil then				
					SetVehicleDeformationFixed(vehicle)
					ClearPedTasksImmediately(playerPed)

					exports['mythic_notify']:SendAlert('success', 'You removed all the dents, Nice work!', 7000)
					TriggerServerEvent('esx_dentpuller:removeKit')
				end

					TriggerServerEvent('esx_dentpuller:removeKit')


				CurrentAction = nil
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
					exports['mythic_notify']:SendAlert('inform', 'Repair canceled', 6000)
					CurrentAction = nil
				end
			end

		end)
	else
		exports['mythic_notify']:SendAlert('inform', 'No vehicle near-by', 6000)
	end
end)