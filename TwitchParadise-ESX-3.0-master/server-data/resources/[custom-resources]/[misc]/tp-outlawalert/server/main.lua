ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_outlawalert:carJackInProgress')
AddEventHandler('esx_outlawalert:carJackInProgress', function(targetCoords, streetName, vehicleLabel, playerGender, plate)
	if playerGender == 0 then
		playerGender = _U('male')
	else
		playerGender = _U('female')
	end	

	local duration = 45000
 	local notifyText = ("Possible Car Jacking by " .. playerGender .. ", on " .. streetName .. ". Car: " .. vehicleLabel ..". Plate: " .. plate .. "")
	TriggerClientEvent('tp-outlawNotify', -1, notifyText, duration)
	TriggerClientEvent('esx_outlawalert:carJackInProgress', -1, targetCoords)
end)

RegisterServerEvent('esx_outlawalert:combatInProgress')
AddEventHandler('esx_outlawalert:combatInProgress', function(targetCoords, streetName, playerGender)
	if playerGender == 0 then
		playerGender = _U('male')
	else
		playerGender = _U('female')
	end

	TriggerClientEvent('esx_outlawalert:combatInProgress', -1, targetCoords)
end)

RegisterServerEvent('esx_outlawalert:gunshotInProgress')
AddEventHandler('esx_outlawalert:gunshotInProgress', function(targetCoords, streetName, playerGender)
	if playerGender == 0 then
		playerGender = _U('male')
	else
		playerGender = _U('female')
	end
	
	local duration = 20000
	local notifyText = ("Gunshots reported. " .. playerGender ..  " on " .. streetName .."!")
	TriggerClientEvent('tp-outlawNotify', -1, notifyText, duration)
	TriggerClientEvent('esx_outlawalert:gunshotInProgress', -1, targetCoords)
end)

RegisterServerEvent('esx_outlawalert:drugSaleInProgress')
AddEventHandler('esx_outlawalert:drugSaleInProgress', function(targetCoords, streetName, playerGender)
	if playerGender == 0 then
		playerGender = _U('male')
	else
		playerGender = _U('female')
	end
	
	local duration = 20000
	local notifyText = ("Drug sale reported. " .. playerGender ..  " on " .. streetName .."!")
	TriggerClientEvent('tp-outlawNotify', -1, notifyText, duration)
	TriggerClientEvent('esx_outlawalert:drugSaleInProgress', -1, targetCoords)
end)

ESX.RegisterServerCallback('esx_outlawalert:isVehicleOwner', function(source, cb, plate)
	local identifier = GetPlayerIdentifier(source, 0)

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			cb(result[1].owner == identifier)
		else
			cb(false)
		end
	end)
end)
