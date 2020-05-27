ESX = nil

local built = false
local activeShops = {}
local saleItems = {}

Citizen.CreateThread(function()
    math.randomseed(GetGameTimer())
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    for i=1, Config.MaxShops, 1 do
        local mth = math.random(1,#Config.PawnShops)
        addActiveShop(Config.PawnShops[mth].x, Config.PawnShops[mth].y, Config.PawnShops[mth].z)
        Citizen.Wait(1)
    end
    for k,v in pairs(activeShops) do
        for i=1, Config.MaxItems, 1 do
            local mth = math.random(1, #Config.ShopItems)
            addShopItem(k, Config.ShopItems[mth])
            Citizen.Wait(1)
        end
    end
    built = true
end)

function addActiveShop(shopx, shopy, shopz)
    local doesExist = doesShopExist(shopx, shopy, shopz)
    if doesExist then
        Citizen.Wait(100)
        local mth = math.random(1,#Config.PawnShops)
        addActiveShop(Config.PawnShops[mth].x, Config.PawnShops[mth].y, Config.PawnShops[mth].z)
    else
        table.insert(activeShops, {x = shopx, y = shopy, z = shopz})
    end
end

function addShopItem(shopNumber, itemTable)
    local doesExist = doesItemExist(shopNumber, itemTable.itemName)
    if doesExist then
        Citizen.Wait(100)
        local mth = math.random(1,#Config.ShopItems)
        addShopItem(shopNumber, Config.ShopItems[mth])
    else
        table.insert(saleItems, {shop = shopNumber, itemName = itemTable.itemName, Label = itemTable.Label, SellPrice = itemTable.SellPrice})
    end
end

function doesShopExist(shopx, shopy, shopz)
    print(shopx .. " " .. shopy .. " " .. shopz)
    for k,v in pairs(activeShops) do
        if v.x == shopx and v.y == shopy and v.z == shopz then
            print("duplicate shop")
            return true
        else

        end
    end
    print("adding shop")
    return false
end

function doesItemExist(shop, item)
    for k,v in pairs(saleItems) do
        if v.itemName == item and v.shop == shop then
            print("duplicate item")
            return true
        else
            
        end
    end
    print("adding item " .. tostring(item))
    return false
end

RegisterServerEvent('tp-pawnshop:requestShops')
AddEventHandler('tp-pawnshop:requestShops', function()
    local source = source
    if built == false then
        Wait(1000)
        TriggerClientEvent('tp-pawnshop:sendShops', source, activeShops, saleItems)
    else
        TriggerClientEvent('tp-pawnshop:sendShops', source, activeShops, saleItems)
    end
end)

-- Server Event for Selling:
RegisterServerEvent("tp-pawnshop:SellItem")
AddEventHandler("tp-pawnshop:SellItem", function(amountToSell, totalSellPrice, itemName)
    local _source = source
    local _item = itemName
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        print("broke it")
        return
    else
        itemLabel = string.lower(xPlayer.getInventoryItem(_item).label)
        itemcount = xPlayer.getInventoryItem(_item).count
        if itemcount >= amountToSell then
            xPlayer.addMoney(totalSellPrice)
            xPlayer.removeInventoryItem(_item, amountToSell)
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You sold ' ..amountToSell.. " " ..itemLabel.. " for $" ..totalSellPrice.." ", length = 2500, style = { ['background-color'] = '#74ca74', ['color'] = '#FFFFFF' } })
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You don't have the required item(s)", length = 2500, style = { ['background-color'] = '#e43838', ['color'] = '#FFFFFF' } })
        end
    end
end)