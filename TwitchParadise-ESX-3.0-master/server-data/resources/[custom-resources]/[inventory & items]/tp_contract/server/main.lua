ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('tp2_contract:sellVehicle')
AddEventHandler('tp2_contract:sellVehicle', function(target, plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local _target = target
	local tPlayer = ESX.GetPlayerFromId(_target)
	local result = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier AND plate = @plate', {
			['@identifier'] = xPlayer.identifier,
			['@plate'] = plate
		})
	if result[1] ~= nil then
		MySQL.Async.execute('UPDATE owned_vehicles SET owner = @target WHERE owner = @owner AND plate = @plate', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@target'] = tPlayer.identifier
		}, function (rowsChanged)
			if rowsChanged ~= 0 then
				TriggerClientEvent('tp2_contract:showAnim', _source)
				Wait(22000)
				TriggerClientEvent('tp2_contract:showAnim', _target)
				Wait(22000)
				TriggerClientEvent('tp2_contract:showSoldNotification', _source, plate)
				TriggerClientEvent('tp2_contract:showBoughtNotification', _target, plate)
				Citizen.Wait(1000)
				xPlayer.removeInventoryItem('contract', 1)
				Citizen.Wait(1000)

				MySQL.Async.execute('INSERT INTO vehicle_log (seller, buyer, plate, date, time) VALUES (@seller, @buyer, @plate, @date, @time)', {
					['@seller'] = GetPlayerName(_source),
					['@buyer'] = GetPlayerName(_target),
					['@plate'] = plate,
					['@date'] = tostring(os.time("%x")),
					['@time'] = tostring(os.time("%X")),
				})



			end
		end)
	else
		TriggerClientEvent('tp2_contract:showNotOwnedNotification', _source)
	end
end)

ESX.RegisterUsableItem('contract', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('tp2_contract:getVehicle', _source)
end)