ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('armour', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	  xPlayer.removeInventoryItem('armour', 1)
	  TriggerClientEvent('esx_armour:armour', source)
end)