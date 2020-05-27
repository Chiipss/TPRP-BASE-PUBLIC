ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('tp-scrapyard:success')
AddEventHandler('tp-scrapyard:success', function(pay, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addMoney(pay)

    if item then
        xPlayer.addInventoryItem(item, 1)
    end
end)

RegisterServerEvent('tp-scrapyard:exitVehicle')
AddEventHandler('tp-scrapyard:exitVehicle', function(plate)
    local plate = plate
    print(json.encode(plate))
    TriggerClientEvent('tp-scrapyard:clExitVehicle', -1, plate)
end)