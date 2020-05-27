ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('tp-scrap:giveItem')
AddEventHandler('tp-scrap:giveItem', function()
    local source = source
    xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local mth = math.random(5,25)
        xPlayer.addInventoryItem("scrap_pieces", mth)
    end
end)

RegisterServerEvent('tp-scrap:notifyPolice')
AddEventHandler('tp-scrap:notifyPolice', function(coords)
    local chance = math.random(1,100)
    if chance <= 1 then
        TriggerClientEvent('tp-scrap:notifyCopsCL', -1, coords)
    end
end)