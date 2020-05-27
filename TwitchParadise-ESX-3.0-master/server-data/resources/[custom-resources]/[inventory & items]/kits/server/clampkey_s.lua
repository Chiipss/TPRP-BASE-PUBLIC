ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Make the kit usable!
ESX.RegisterUsableItem('clamp_key', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
		TriggerClientEvent('tp_clampKey:onUse', _source)
end)