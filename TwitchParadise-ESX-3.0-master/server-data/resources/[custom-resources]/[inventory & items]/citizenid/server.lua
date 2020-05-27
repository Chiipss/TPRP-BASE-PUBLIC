ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('citizenid', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('citizenid:showid', source)
end)

RegisterServerEvent("citizenid:showID") -- RECEIVE ID FROM PLAYER AND PASS TO NEW PLAYER
AddEventHandler("citizenid:showID", function(targetSrc)
    local origPlayer = source
    local targetSrc = tonumber(targetSrc)

    TriggerClientEvent("citizenid:showID2", targetSrc, origPlayer) -- PASS THE ID TO THE NEW PLAYER

end)

ESX.RegisterServerCallback('citizenid:getOtherPlayerData', function(source, cb, target)

    if target == 0 then
        target = source
    end
    print(source)
    print(target)
	
    local xPlayer = ESX.GetPlayerFromId(target)
    local result = MySQL.Sync.fetchAll('SELECT firstname, lastname, sex, dateofbirth, height FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    })

    local firstname = result[1].firstname
    local lastname  = result[1].lastname
    local sex       = result[1].sex
    local dob       = result[1].dateofbirth
    local height    = result[1].height

    local data = {
        name      = GetPlayerName(target),
        job       = xPlayer.job,
        inventory = xPlayer.inventory,
        accounts  = xPlayer.accounts,
        weapons   = xPlayer.loadout,
        firstname = firstname,
        lastname  = lastname,
        sex       = sex,
        dob       = dob,
        height    = height
    }

    
    TriggerEvent('esx_license:getLicenses', target, function(licenses)
        data.licenses = licenses
        cb(data)
    end)

    cb(data)
	
end)