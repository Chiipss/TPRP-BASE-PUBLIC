ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Make the kit usable!
ESX.RegisterUsableItem('advrepairkit', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if Config.AllowMecano then
		TriggerClientEvent('esx_adv-repairkit:onUse', _source)
	else
		if xPlayer.job.name ~= 'mecano' then
			TriggerClientEvent('esx_adv-repairkit:onUse', _source)
		end
	end
end)

RegisterNetEvent('esx_adv-repairkit:removeKit')
AddEventHandler('esx_adv-repairkit:removeKit', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	print("Im deleting")

	if not Config.InfiniteRepairs then
		xPlayer.removeInventoryItem('advrepairkit', 1)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Removed 1 Advanced repair kit from your inventory', length = 7000})
	end
end)