ESX = nil
isRoll = false
amount = 100000

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_tpnrp_luckywheel:getLucky')
AddEventHandler('esx_tpnrp_luckywheel:getLucky', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not isRoll then
        if xPlayer ~= nil then
            if xPlayer.getMoney() >= amount then
                xPlayer.removeMoney(amount)

                local societyAccount
                TriggerEvent('esx_addonaccount:getSharedAccount', 'society_casino', function(account)
                    societyAccount = account
                end)
                societyAccount.addMoney(amount)

                isRoll = true
                -- local _priceIndex = math.random(1, 20)
                local _randomPrice = math.random(1, 100)
                if _randomPrice == 1 then
                    -- Win car
                    local _subRan = math.random(1,1000)
                    if _subRan <= 1 then
                        _priceIndex = 19
                    else
                        _priceIndex = 3
                    end
                elseif _randomPrice > 1 and _randomPrice <= 6 then
                    -- Win skin AK Gold
                    _priceIndex = 12
                    local _subRan = math.random(1,20)
                    if _subRan <= 2 then
                        _priceIndex = 12
                    else
                        _priceIndex = 7
                    end
                elseif _randomPrice > 6 and _randomPrice <= 15 then
                    -- Black money
                    -- 4, 8, 11, 16
                    local _sRan = math.random(1, 4)
                    if _sRan == 1 then
                        _priceIndex = 4
                    elseif _sRan == 2 then
                        _priceIndex = 8
                    elseif _sRan == 3 then
                        _priceIndex = 11
                    else
                        _priceIndex = 16
                    end
                elseif _randomPrice > 15 and _randomPrice <= 25 then
                    -- Win 300,000$
                    -- _priceIndex = 5
                    local _subRan = math.random(1,20)
                    if _subRan <= 2 then
                        _priceIndex = 5
                    else
                        _priceIndex = 20
                    end
                elseif _randomPrice > 25 and _randomPrice <= 40 then
                    -- 1, 9, 13, 17
                    local _sRan = math.random(1, 4)
                    if _sRan == 1 then
                        _priceIndex = 1
                    elseif _sRan == 2 then
                        _priceIndex = 9
                    elseif _sRan == 3 then
                        _priceIndex = 13
                    else
                        _priceIndex = 17
                    end
                elseif _randomPrice > 40 and _randomPrice <= 60 then
                    local _itemList = {}
                    _itemList[1] = 2
                    _itemList[2] = 6
                    _itemList[3] = 10
                    _itemList[4] = 14
                    _itemList[5] = 18
                    _priceIndex = _itemList[math.random(1, 5)]
                elseif _randomPrice > 60 and _randomPrice <= 100 then
                    local _itemList = {}
                    _itemList[1] = 3
                    _itemList[2] = 7
                    _itemList[3] = 15
                    _itemList[4] = 20
                    _priceIndex = _itemList[math.random(1, 4)]
                end
                -- print("Price " .. _priceIndex)
                SetTimeout(12000, function()
                    isRoll = false
                    -- Give Price
                    if _priceIndex == 1 or _priceIndex == 9 or _priceIndex == 13 or _priceIndex == 17 then
                        -- print("win mu~ 1, giap 3")
                        xPlayer.addInventoryItem("armour", 3)
                        xPlayer.addInventoryItem("champagne", 1)
                        xPlayer.addMoney(36000)
                        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = 'You won one body armour, champagne and $36000!', length = 12000})
                    elseif _priceIndex == 2 or _priceIndex == 6 or _priceIndex == 10 or _priceIndex == 14 or _priceIndex == 18 then
                        -- print("banh mi + nuoc")
                        xPlayer.addMoney(48000)
                        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = 'You won 10 bread, 24 bottles of water and $48000!', length = 12000})
                    elseif _priceIndex == 3 or _priceIndex == 7 or _priceIndex == 15 or _priceIndex == 20 then
                        -- print("Win money")
                        local _money = 0
                        if _priceIndex == 3 then
                            _money = 25000
                        elseif _priceIndex == 7 then
                            _money = 38000
                        elseif _priceIndex == 15 then
                            _money = 59000
                        elseif _priceIndex == 20 then
                            _money = 79000
                        end
                        xPlayer.addMoney(_money)
                        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = 'You won $' .. ESX.Math.GroupDigits(_money), length = 12000})
                    elseif _priceIndex == 4 or _priceIndex == 8 or _priceIndex == 11 or _priceIndex == 16 then
                        -- print("Black money x2")
                        local _blackMoney = 0
                        if _priceIndex == 4 then
                            _blackMoney = 10000
                        elseif _priceIndex == 8 then
                            _blackMoney = 15000
                        elseif _priceIndex == 11 then
                            _blackMoney = 20000
                        elseif _priceIndex == 16 then
                            _blackMoney = 25000
                        end
                        -- xPlayer.addAccountMoney("black_money", _blackMoney * 10)
                        xPlayer.addMoney(_blackMoney * 10)
                        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = 'You won $' .. ESX.Math.GroupDigits(_blackMoney * 10), length = 12000})
                    elseif _priceIndex == 5 then
                        -- print("Win 300,000$")
                        xPlayer.addMoney(300000)
                        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = 'You won $300,000 congratulations!!', length = 12000})
                    elseif _priceIndex == 12 then
                        -- print("Win ak gold")
                        xPlayer.addInventoryItem("lingot_gold", 10)
                        xPlayer.addMoney(100000)
                        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = 'You won GOLD and $100,000!', length = 12000})
                    elseif _priceIndex == 19 then
                        -- TriggerClientEvent("esx_tpnrp_luckywheel:winCar", _source)
                        -- DISCORD WEBHOOK
                        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = 'You won the jackpot! You just won a 918 Spyder!', length = 30000})
                    end
                    TriggerClientEvent("esx_tpnrp_luckywheel:rollFinished", -1)
                end)
                TriggerClientEvent("esx_tpnrp_luckywheel:doRoll", -1, _priceIndex)
            else
                TriggerClientEvent("esx_tpnrp_luckywheel:rollFinished", -1)    
                TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = 'You do not have enough money to spin the wheel :( ', length = 12000})
            end
        end
    end
end)

-- ADD FOR WIN CAR

--- LUCKYWHEEL
--[[ RegisterNetEvent("esx_tpnrp_luckywheel:winCar")
AddEventHandler("esx_tpnrp_luckywheel:winCar", function() 
    
    ESX.Game.SpawnVehicle("lp700r", { x = 933.29,y = -2.82, z = 78.76 }, 144.6, function (vehicle)
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

        local newPlate     = GeneratePlate()
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        vehicleProps.plate = newPlate
        SetVehicleNumberPlateText(vehicle, newPlate)

        TriggerServerEvent('esx_vehicleshop:setVehicleOwned', vehicleProps)

        ESX.ShowNotification("Bạn đã nhận được siêu xe Lambo 700R!")
    end)

    FreezeEntityPosition(playerPed, false)
    SetEntityVisible(playerPed, true)
end) ]]