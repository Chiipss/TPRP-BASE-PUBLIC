ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent('smerfikcraft:zlomiarzzbier2')
AddEventHandler('smerfikcraft:zlomiarzzbier2', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local jabka = xPlayer.getInventoryItem('milk').count
    if jabka < 50 then
        TriggerClientEvent('wiadro:postaw', _source)
        TriggerClientEvent('smerfik:zamrozcrft222', _source)


        TriggerClientEvent('zacznijtekst22', _source)

        TriggerClientEvent('smerfik:craftanimacja222', _source)
        TriggerClientEvent('smerfik:tekstjab22', _source)
        Citizen.Wait(10000)
        local ilosc = math.random(10,50)
        xPlayer.addInventoryItem('milk', ilosc)
        TriggerClientEvent('smerfik:odmrozcrft222', _source)

        TriggerClientEvent('esx:showNotification', _source, 'Collected ~y~'.. ilosc .. ' milk')
    else
        TriggerClientEvent('smerfik:zdejmijznaczek22', _source)
        TriggerClientEvent('esx:showNotification', _source, '~y~You dont have room for more milk!')
    end
end)



RegisterServerEvent('smerfik:pobierzjablka22') 
AddEventHandler('smerfik:pobierzjablka22', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
        xPlayer.removeMoney(3000)
end)

RegisterServerEvent('smerfik:pobierzjablka222') 
AddEventHandler('smerfik:pobierzjablka222', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addMoney(3000)
        TriggerClientEvent('esx:deleteVehicle', source)
end)

RegisterServerEvent('smerfikcraft:skup22')
AddEventHandler('smerfikcraft:skup22', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local jabka = xPlayer.getInventoryItem('milk').count
    if jabka >= 1 then

        local multiplier = math.random(4,8)
        local singleRemoveAmount = ESX.Math.Round(jabka / multiplier)
        local totalAmount = ESX.Math.Round((singleRemoveAmount) * 4)

        print(multiplier)
        print(singleRemoveAmount)
        print(totalAmount)

        TriggerClientEvent('tp:milking', _source)
        TriggerClientEvent('odlacz:propa3', _source)
        local cena = 2
        xPlayer.removeInventoryItem('milk', ESX.Math.Round(singleRemoveAmount))
        TriggerClientEvent('sprzedawanie:jablekanim22', _source)
        Citizen.Wait(4000)
        xPlayer.removeInventoryItem('milk', ESX.Math.Round(singleRemoveAmount))
        TriggerClientEvent('sprzedawanie:jablekanim22', _source)
        Citizen.Wait(4000)
        xPlayer.removeInventoryItem('milk', ESX.Math.Round(singleRemoveAmount))
        TriggerClientEvent('sprzedawanie:jablekanim22', _source)
        Citizen.Wait(4000)
        xPlayer.removeInventoryItem('milk', ESX.Math.Round(singleRemoveAmount))
        TriggerClientEvent('sprzedawanie:jablekanim22', _source)
        Citizen.Wait(4000)
        xPlayer.addMoney(totalAmount * cena)
        TriggerClientEvent('odlacz:propa2', _source)
        TriggerClientEvent('esx:showHelpNotification', _source, 'Milked cow of ~y~' .. ESX.Math.Round(totalAmount) ..' ~w~buckets: ~g~' .. totalAmount * cena .. '$')
        TriggerClientEvent('tp:misc-jobs:unlockControls', _source)
    else
        TriggerClientEvent('esx:showHelpNotification', _source, '~y~You dont have milk')
        TriggerClientEvent('tp:misc-jobs:unlockControls', _source)
    end
end)