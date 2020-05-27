ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Make the kit usable!
ESX.RegisterUsableItem('dentpuller', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if Config.AllowMecano then
		TriggerClientEvent('esx_dentpuller:onUse', _source)
	else
		if xPlayer.job.name ~= 'mecano' then
			TriggerClientEvent('esx_dentpuller:onUse', _source)
		end
	end
end)

RegisterNetEvent('esx_dentpuller:removeKit')
AddEventHandler('esx_dentpuller:removeKit', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if not Config.InfiniteRepairs then
		--xPlayer.removeInventoryItem('dentpuller', 1)
		--exports['mythic_notify']:SendAlert('error', 'Removed 1 Dent puller from your inventory', 8000)
	end
end)