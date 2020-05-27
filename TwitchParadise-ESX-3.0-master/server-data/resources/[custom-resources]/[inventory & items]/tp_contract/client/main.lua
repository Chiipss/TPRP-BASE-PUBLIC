ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('tp2_contract:getVehicle')
AddEventHandler('tp2_contract:getVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local closestPlayer, playerDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer ~= -1 and playerDistance <= 3.0 then
		local vehicle = ESX.Game.GetClosestVehicle(coords)
		local vehiclecoords = GetEntityCoords(vehicle)
		local vehDistance = GetDistanceBetweenCoords(coords, vehiclecoords, true)
		if DoesEntityExist(vehicle) and (vehDistance <= 3) then
			local plate = GetVehicleNumberPlateText(vehicle)
			exports['mythic_notify']:SendAlert('inform', 'Writing contract for the following license plate: ' .. plate, 10000)
			TriggerServerEvent('tp2_contract:sellVehicle', GetPlayerServerId(closestPlayer), plate)
		else
			exports['mythic_notify']:SendAlert('error', 'There is no vehicle nearby', 10000)
		end
	else
		exports['mythic_notify']:SendAlert('error', 'There is no buyer nearby', 10000)
	end
	
end)

RegisterNetEvent('tp2_contract:showAnim')
AddEventHandler('tp2_contract:showAnim', function(player)
	loadAnimDict('anim@amb@nightclub@peds@')
	TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CLIPBOARD', 0, false)
	Citizen.Wait(20000)
	ClearPedTasks(PlayerPedId())
end)


function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end

RegisterNetEvent('tp2_contract:showSoldNotification')
AddEventHandler('tp2_contract:showSoldNotification', function(plate)
	local plate = plate
	TriggerServerEvent('garage:removeKeys', plate)
	exports['mythic_notify']:SendAlert('success', 'You sold the vehicle with registration number: ' .. plate, 15000)
end)

RegisterNetEvent('tp2_contract:showBoughtNotification')
AddEventHandler('tp2_contract:showBoughtNotification', function(plate)
	local plate = plate
	TriggerServerEvent('garage:addKeys', plate)
	print("Added keys")
	print(plate)
	exports['mythic_notify']:SendAlert('success', 'You bought the vehicle with registration number: ' .. plate, 15000)
end)

RegisterNetEvent('tp2_contract:showNotOwnedNotification')
AddEventHandler('tp2_contract:showNotOwnedNotification', function(plate)
	local plate = plate
	exports['mythic_notify']:SendAlert('error', 'You do not own the vehicle with registration number: ' .. plate, 15000)
end)