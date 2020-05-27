ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--base

	
RegisterServerEvent('gopostal:cash')
AddEventHandler('gopostal:cash', function(currentJobPay)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.addMoney(currentJobPay)
		
	TriggerClientEvent('esx:showNotification', _source, ' You earned $' .. currentJobPay)
end)	