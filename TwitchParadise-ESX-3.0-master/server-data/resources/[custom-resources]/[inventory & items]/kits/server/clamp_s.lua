ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
ClampedVehicles = {}
ServerVehicles = {}

-- Make the kit usable!
ESX.RegisterUsableItem('clamp', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
		TriggerClientEvent('tp_clamp:onUse', _source)
end)

RegisterNetEvent('tp_clamp:removeKit')
AddEventHandler('tp_clamp-repairkit:removeKit', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if not Config.InfiniteRepairs then
		xPlayer.removeInventoryItem('clamp', 1)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Removed 1 clamp from your inventory', length = 7000})
	end
end)

RegisterServerEvent('tp_clamp:syncSend')
AddEventHandler('tp_clamp:syncSend', function(NewClampedVehicles)
	local _source = source
	print("Received New Data From ".. _source)
	ClampedVehicles = NewClampedVehicles
	TriggerClientEvent('tp_clamp:syncReceive', -1, ClampedVehicles) -- Send data to all clients
	for k,v in pairs(ClampedVehicles) do
		print(ClampedVehicles[k].vehProps.plate)
	end
end)

RegisterServerEvent('tp_clamp:syncAsk')
AddEventHandler('tp_clamp:syncAsk', function(source)
	local vehicles = ServerVehicles
	TriggerClientEvent('tp_clamp:syncReceive', -1, vehicles) -- Send data to all clients
end)

RegisterServerEvent('tp_clamp:sendVehicle')
AddEventHandler('tp_clamp:sendVehicle', function(vehicles)
	-- Add to server table
	ClampedVehicles = vehicles
	-- Send to all clients
	TriggerClientEvent('tp_clamp:syncReceive', -1, ClampedVehicles)
end)

AddEventHandler('es:playerLoaded',function(source)
	Citizen.Wait(5000)
	TriggerClientEvent('tp_clamp:syncReceive', source, ClampedVehicles)
end)