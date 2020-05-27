ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-------------Light Diving suit
ESX.RegisterUsableItem('scubba', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
        TriggerClientEvent('police:woxy', _source)
end)

RegisterNetEvent('tp:subbaRemove')
AddEventHandler('tp:subbaRemove', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
		xPlayer.removeInventoryItem('scubba', 1)
end)