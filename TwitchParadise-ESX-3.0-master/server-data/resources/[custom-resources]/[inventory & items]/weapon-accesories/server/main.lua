ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('silencer', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('eden_accesories:silencer', source)

end)

ESX.RegisterUsableItem('flashlight', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
	
    TriggerClientEvent('eden_accesories:flashlight', source)
	
end)

ESX.RegisterUsableItem('grip', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
		
    TriggerClientEvent('eden_accesories:grip', source)
	
end)


ESX.RegisterUsableItem('yusuf', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('eden_accesories:yusuf', source)

end)

ESX.RegisterUsableItem('pAmmo', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('pAmmo', 1)
    TriggerClientEvent('nfw_wep:pAmmo', source)
end)

ESX.RegisterUsableItem('mgAmmo', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('mgAmmo', 1)
    TriggerClientEvent('nfw_wep:mgAmmo', source)
end)

ESX.RegisterUsableItem('arAmmo', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('arAmmo', 1)
    TriggerClientEvent('nfw_wep:arAmmo', source)
end)

ESX.RegisterUsableItem('sgAmmo', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('sgAmmo', 1)
    TriggerClientEvent('nfw_wep:sgAmmo', source)
end)

ESX.RegisterUsableItem('rpe', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('rpe', 1)
    TriggerClientEvent('nfw_wep:rpe', source)
end)

RegisterNetEvent('returnItem')
AddEventHandler('returnItem', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem(item, 1)
end)

