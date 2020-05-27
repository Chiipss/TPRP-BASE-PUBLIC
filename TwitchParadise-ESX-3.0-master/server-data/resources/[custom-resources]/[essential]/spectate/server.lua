ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('tp-spectate:getOtherPlayerData', function(source, cb, target)
	
    local playerData = ESX.GetPlayerFromId(target)
    
    if playerData ~= nil then
        local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
            ['@identifier'] = playerData.identifier
        })

        local firstname = result[1].firstname
        local lastname  = result[1].lastname

        local data = {
            name      = GetPlayerName(target),
            job       = playerData.job,
            inventory = playerData.inventory,
            accounts  = playerData.accounts,
            weapons   = playerData.loadout,
            firstname = firstname,
            lastname  = lastname,
        }

        cb(data)
    end
end)