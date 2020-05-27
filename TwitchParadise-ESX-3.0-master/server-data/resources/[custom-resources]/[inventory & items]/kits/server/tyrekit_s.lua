ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Make the kit usable!
ESX.RegisterUsableItem('tyrekit', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if Config.AllowMecano then
		TriggerClientEvent('esx_tyrekit:onUse', _source)
	else
		if xPlayer.job.name ~= 'mecano' then
			TriggerClientEvent('esx_tyrekit:onUse', _source)
		end
	end
end)

RegisterNetEvent('esx_tyrekit:removeKit')
AddEventHandler('esx_tyrekit:removeKit', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if not Config.InfiniteRepairs then
		xPlayer.removeInventoryItem('tyrekit', 1)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Removed 1 tyre from your inventory', length = 7000})
	end
end)