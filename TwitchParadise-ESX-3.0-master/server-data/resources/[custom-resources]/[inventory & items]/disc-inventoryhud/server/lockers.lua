Citizen.CreateThread(function()
    for k,v in pairs(Config.storageLockers) do
        TriggerEvent('disc-inventoryhud:RegisterInventory', {
            name = k,
            label = v.businessname,
            slots = v.slots
        })
    end
end)

seeded = false
Citizen.CreateThread(function()
    while not seeded do
        math.randomseed(os.time())
        seeded = true
    end
end)

ESX.RegisterServerCallback('tp:storage:checkLocker', function(source, cb, lockerName)
    local player = ESX.GetPlayerFromId(source)

    if player then
        local sqlQuery = [[
            SELECT * FROM lockers WHERE identifier = @identifier AND lockername = @lockerName
        ]]

        MySQL.Async.fetchAll(sqlQuery, {
            ["@identifier"] = player["identifier"],
            ["@lockerName"] = lockerName
        }, function(result)
            if result[1] then
                if result[1].paid == 'true' then
                    
                    overdue = os.difftime(os.time(), result[1].lastpayment) / (24 * 60 * 60)
                    wholedays = math.floor(overdue)
                    if overdue >= 7 then
                        cb('unpaid')
                    else
                        cb('true')
                    end
                else
                    cb('unpaid')
                end
            else
                cb('false')
            end
        end)
    end
end)

ESX.RegisterServerCallback('tp:storage:checkRaidedLocker', function(source, cb, identifier, lockerName)
    local sqlQuery = [[
        SELECT * FROM lockers WHERE identifier = @identifier AND lockername = @lockerName
    ]]

    MySQL.Async.fetchAll(sqlQuery, {
        ["@identifier"] = identifier,
        ["@lockerName"] = lockerName
    }, function(result)
        if result[1] then
            cb('true')
        else
            cb('false')
        end
    end)
    
end)

ESX.RegisterServerCallback('tp:storage:checkAuthCode', function(source, cb, authCode)
    local sqlQuery = [[
        SELECT * FROM lockers_auth WHERE `code` = @code
    ]]

    MySQL.Async.fetchAll(sqlQuery, {
        ["@code"] = authCode,
    }, function(result)
        if result[1] then
            overdue = os.difftime(os.time(), result[1].generated) / (60 * 60)
            wholeHours = math.floor(overdue)
            print(overdue)
            if wholeHours >= 4 then
                cb('expired')
            else
                timeUsed = result[1].used
                incrementAuthUsage(authCode, timeUsed)
                cb('correct')
            end
        else
            cb('invalid')
        end
    end)
end)

ESX.RegisterServerCallback("tp:storage:getAuthCodes", function(source, callback)

		local sqlQuery = [[
			SELECT
				*
			FROM
				lockers_auth
		]]

		MySQL.Async.fetchAll(sqlQuery, {

		}, function(responses)
			local authcodes = {}

            for k, v in ipairs(responses) do
                overdue = os.difftime(os.time(), v["generated"]) / (60 * 60)
                wholeHours = math.floor(overdue)
                -- print(overdue)
                if wholeHours >= 24 then
                    active = "false"
                else
                    active = "true"
                end
				table.insert(authcodes, {
					["code"] = v["code"],
					["generated"] = v["generated"],
                    ["used"] = v["used"],
                    ["active"] = active
				})
			end
			callback(authcodes)
        end)    
end)

function incrementAuthUsage(code, timeUsed)
    MySQL.Async.execute("UPDATE lockers_auth SET used = @used WHERE code = @code", {
        ['@used'] = (timeUsed + 1),
        ['@code'] = code
    })
end

RegisterServerEvent('tp:storage:newLocker')
AddEventHandler('tp:storage:newLocker', function(identifier, lockername)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    local lockerPrice = Config.storageLockers[lockername].price

    if (lockerPrice > xPlayer.getAccount('bank').money) then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You cannot afford the locker rent! You\'re $' .. (lockerPrice - xPlayer.getAccount('bank').money) .. " short!"})
    else
        local newBalance = (xPlayer.getAccount('bank').money - lockerPrice)
        xPlayer.setAccountMoney('bank', newBalance)
        MySQL.Async.execute("INSERT INTO `lockers` (`identifier`, `paid`, `lastpayment`, `lockername`) VALUES (@identifier, @paid, @lastpayment, @lockername)", {
        ['@identifier'] = identifier,
        ['@paid'] = 'true',
        ['@lastpayment'] = os.time(),
        ['@lockername'] = lockername
        })
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You rented a new locker for $' .. lockerPrice .. ' was taken from your account!'})
    end
end)

RegisterServerEvent('tp:storage:payLockerRent')
AddEventHandler('tp:storage:payLockerRent', function(identifier, lockername)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    local lockerPrice = 0
    local bankBalance = 0

    lockerPrice = Config.storageLockers[lockername].price

    if (lockerPrice > xPlayer.getAccount('bank').money) then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You cannot afford the locker rent! You\'re $' .. (lockerPrice - xPlayer.getAccount('bank').money) .. " short!"})
    else
        local newBalance = (xPlayer.getAccount('bank').money - lockerPrice)
        xPlayer.setAccountMoney('bank', newBalance)
        MySQL.Async.execute("UPDATE lockers SET paid = @paid, lastpayment = @lastpayment WHERE identifier = @identifier AND lockername = @lockername", {
            ['@paid'] = 'true',
            ['@lastpayment'] = os.time(),
            ['@identifier'] = identifier,
            ['@lockername'] = lockername
        })
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You paid your locker rent! $' .. lockerPrice .. ' was taken from your account!'})
    end
end)

RegisterServerEvent('tp:storage:notifyRaid')
AddEventHandler('tp:storage:notifyRaid', function(lockerid)
    TriggerClientEvent('mythic_notify:client:SendAlert', lockerid, { type = 'success', text = 'Your storage locker has been accessed by a LEO', length = 30000})
end)

RegisterServerEvent('tp:storage:generateAuthCode')
AddEventHandler('tp:storage:generateAuthCode', function()
    local source = source
    local authcode = GenerateAuthCode()

    MySQL.Async.execute("INSERT INTO `lockers_auth` (`code`, `generated`, `used`) VALUES (@code, @generated, @used)", {
        ['@code'] = authcode,
        ['@generated'] = os.time(),
        ['@used'] = 0
    })

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Your auth code was generated: ' .. authcode, length = 60000})
end)

RegisterServerEvent('tp:storage:removeAuthCode')
AddEventHandler('tp:storage:removeAuthCode', function(authcode)
    local source = source

    MySQL.Async.execute('DELETE FROM lockers_auth WHERE code LIKE "%' .. authcode .. '%"', {})

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Auth code was generated: ' .. authcode .. ' was removed.', length = 30000})
end)

function GenerateAuthCode()
    local upperCase = "ABCDEFGHIJKLMNPQRSTUVWXYZ"
    local numbers = "0123456789"
    local characterSet = numbers .. upperCase
    local keyLength = 6
    local output = ""
    for	i = 1, keyLength do
        local rand = math.random(#characterSet)
        output = output .. string.sub(characterSet, rand, rand)
    end
    return output
end