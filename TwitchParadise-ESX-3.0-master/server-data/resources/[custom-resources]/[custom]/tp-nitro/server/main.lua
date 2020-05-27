ESX = nil

local installedCars = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
	local vehicles = MySQL.Sync.fetchAll('SELECT * FROM nitro_vehicles')
	for i=1, #vehicles, 1 do
        local _vehicles = vehicles[i]
        if _vehicles ~= nil then
            table.insert(installedCars, _vehicles)
        end
	end
	TriggerClientEvent('suku:syncInstalledVehicles', -1, installedCars)
end)

RegisterServerEvent('suku:RemoveNitro')
AddEventHandler('suku:RemoveNitro', function(quantity)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('nitrocannister', quantity)
    TriggerClientEvent('suku:ActivateNitro', source)
end)

function DoesVehicleHaveAOwner(plate)
    MySQL.Async.fetchAll('SELECT * FROM `owned_vehicles` WHERE `plate` = @plate', {['@plate'] = plate}, function(result)
        return result[1]~=nil
    end)
end

ESX.RegisterServerCallback('suku:getInstalledVehicles', function (source, cb)
    cb(installedCars)
end)

ESX.RegisterServerCallback("suku:isInstalledVehicles", function(source, cb, plate)
    for i = 1, #installedCars, 1 do
        if installedCars[i] ~= nil then
            if installedCars[i].plate == plate then
                cb(true)
            end
        end
    end
end)

RegisterServerEvent('suku:InstallNitro')
AddEventHandler('suku:InstallNitro', function(plate, amount)
    if installedCars[1] ~= nil then
        for i = 1, #installedCars, 1 do
            if installedCars[i] ~= nil then
                if DoesVehicleHaveAOwner(plate) then
                    print("vehicle has owner")
                    table.insert(installedCars, {plate = plate, amount = amount})
                    MySQL.Async.execute('INSERT INTO nitro_vehicles (plate, amount) VALUES (@plate, @amount)', {
                        ['@plate'] = plate,
                        ['@amount'] = amount
                    })
                else
                    table.insert(installedCars, {plate = plate, amount = amount})
                end
            end
        end
    else
        if DoesVehicleHaveAOwner(plate) then
            print("vehicle has owner")
            table.insert(installedCars, {plate = plate, amount = amount})
            MySQL.Async.execute('INSERT INTO nitro_vehicles (plate, amount) VALUES (@plate, @amount)', {
                ['@plate'] = plate,
                ['@amount'] = amount
            })
        else
            table.insert(installedCars, {plate = plate, amount = amount})
        end
    end
end)

RegisterServerEvent('suku:UninstallNitro')
AddEventHandler('suku:UninstallNitro', function(plate)
    if installedCars[1] ~= nil then
        for i = 1, #installedCars, 1 do
            if installedCars[i] ~= nil then
                if DoesVehicleHaveAOwner(plate) then
                    MySQL.Async.execute('DELETE FROM nitro_vehicles WHERE plate = @plate', {
                        ['@plate'] = plate
                    })
                    table.remove(installedCars, i)
                else
                    table.remove(installedCars, i)
                end
            end
        end
    end
end)

RegisterServerEvent('suku:UpdateNitroAmount')
AddEventHandler('suku:UpdateNitroAmount', function(plate, amount)
    if DoesVehicleHaveAOwner(source, plate) then
        for i = 1, #installedCars, 1 do
            if installedCars[i].plate == plate then
                MySQL.Async.execute("UPDATE users SET amount = @amount WHERE plate = @plate",{
                    ['@plate'] = plate,
                    ['@amount'] = tonumber(installedCars[i].amount - amount)
                })
                installedCars[i].amount = (installedCars[i].amount - amount)
            end
        end
    else
        for i = 1, #installedCars, 1 do
            if installedCars[i].plate == plate then
                installedCars[i].amount = (installedCars[i].amount - amount)
            end
        end
    end
end)

ESX.RegisterServerCallback('suku:DoesPlayerHaveItem', function(source, cb, item)
    local xPlayer  = ESX.GetPlayerFromId(source)
    local amount = xPlayer.getInventoryItem(item).count
    if amount > 0 then
        cb(true)
    end
end)

ESX.RegisterUsableItem('nitrocannister', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('nitro:onUse', _source)
end)

ESX.RegisterUsableItem('wrench', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('wrench:onUse', _source)
end)