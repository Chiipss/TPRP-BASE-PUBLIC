ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

ESX.RegisterServerCallback('disc-base:buy', function(source, cb, price)
    local player = ESX.GetPlayerFromId(source)
    if player.getMoney() >= price then
        player.removeMoney(price)
        cb(1)
    else
        cb(0)
    end
end)

RegisterServerEvent('disc-base:givePlayerItem')
AddEventHandler('disc-base:givePlayerItem', function(item, count)
    local player = ESX.GetPlayerFromId(source)
    player.addInventoryItem(item, count)
end)

ESX.RegisterServerCallback('disc-base:takePlayerItem', function(source, cb, item, count)
    local player = ESX.GetPlayerFromId(source)
    local invItem = player.getInventoryItem(item)
    if invItem.count - count < 0 then
        cb(false)
    else
        player.removeInventoryItem(item, count)
        cb(true)
    end
end)

RegisterServerEvent('disc-base:givePlayerDirtyMoney')
AddEventHandler('disc-base:givePlayerDirtyMoney', function(amount)
    local player = ESX.GetPlayerFromId(source)
    player.addAccountMoney('black_money', amount)
end)

RegisterServerEvent('disc-base:givePlayerMoney')
AddEventHandler('disc-base:givePlayerMoney', function(amount)
    local player = ESX.GetPlayerFromId(source)
    player.addMoney(amount)
end)

ESX.RegisterServerCallback('disc-base:takePlayerMoney', function(source, cb, amount)
    local player = ESX.GetPlayerFromId(source)
    local money = player.getMoney()
    if money - amount < 0 then
        cb(false)
    else
        player.removeMoney(amount)
        cb(true)
    end
end)

RegisterServerEvent('disc-base:checkLicence')
AddEventHandler("disc-base:checkLicence", function()
  local source = source
  local xPlayer = ESX.GetPlayerFromId(source)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if user then
        MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @owner AND type = @licence AND revoked = 0', {
        ['@owner'] = xPlayer.identifier,
        ['@licence'] = "weapon"
            }, function(result)
            --print(json.encode(result[1]))
                if(result[1] == nil) then
                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have a license!' })
                else
                     TriggerClientEvent('disc-base:openWeaponShop', source)
                end
            end)
        end
    end)
end)