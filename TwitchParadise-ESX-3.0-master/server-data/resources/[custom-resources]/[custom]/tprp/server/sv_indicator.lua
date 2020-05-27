RegisterServerEvent('asser:syncIndicator')
AddEventHandler('asser:syncIndicator', function(indicator)

	local playerid = source
	TriggerClientEvent('asser:syncIndicator', -1, playerid, indicator)
	
end)