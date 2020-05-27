ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('matif_headlights:check', function(source, cb, plate)
    local _source = source

    MySQL.Async.fetchScalar('SELECT color FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
    }, function(result)
		cb(result)
	end)
end)

RegisterServerEvent('matif_headlights:set')
AddEventHandler('matif_headlights:set', function(plate, color)
    MySQL.Sync.execute("UPDATE owned_vehicles SET color =@color WHERE plate=@plate",{['@color'] = color, ['@plate'] = plate})
end)

RegisterServerEvent('matif_headlights:install')
AddEventHandler('matif_headlights:install', function(plate)
    local _src = source
    xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getJob().name == 'mechanic' then
        MySQL.Async.fetchScalar('SELECT color FROM owned_vehicles WHERE plate = @plate', {
            ['@plate'] = plate
        }, function(result)
            if result == 'NOT' then
                MySQL.Sync.execute("UPDATE owned_vehicles SET color =@color WHERE plate=@plate",{['@color'] = -1, ['@plate'] = plate})
                --notify(_src, 'Xenon headlight extra installed successfully!')

            elseif result ~= 'NOT' and result ~= nil then
                --notify(_src, 'This vehicle alredy has the xenon headlight extra!')

            else
                --otify(_src, 'You cannot install the extra on this vehicle!')
            end
        end)
    else
        TriggerClientEvent('esx:showNotification', source, 'You are not a mechanic!')
    end
end)


function notify(id, message)
    TriggerClientEvent('esx:showNotification', id, message)
end



