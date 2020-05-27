ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Make the kit usable!
ESX.RegisterUsableItem('repairkit', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if Config.AllowMecano then
		TriggerClientEvent('esx_repairkit:onUse', _source)
	else
		if xPlayer.job.name ~= 'mecano' then
			TriggerClientEvent('esx_repairkit:onUse', _source)
		end
	end
end)

RegisterNetEvent('esx_repairkit:removeKit')
AddEventHandler('esx_repairkit:removeKit', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if not Config.InfiniteRepairs then
		xPlayer.removeInventoryItem('repairkit', 1)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Removed 1 repair kit from your inventory', length = 7000})
	end
end)