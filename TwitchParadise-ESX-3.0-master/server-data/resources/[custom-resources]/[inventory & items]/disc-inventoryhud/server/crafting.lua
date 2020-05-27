local craft = false

Citizen.CreateThread(function()
    TriggerEvent('disc-inventoryhud:RegisterInventory', {
        name = "craft",
        label = "craft",
        slots = 25,
        getInventory = function(identifier, cb)
            getCraftInventory(identifier, cb)
        end,
        saveInventory = function(identifier, inventory)

        end,
        applyToInventory = function(identifier, f)
            getCraftInventory(identifier, f)
        end,
        getDisplayInventory = function(identifier, cb, source)
            getCraftDisplayInventory(identifier, cb, source)
        end
    })
end)

function getCraftInventory(identifier, cb)
    local craft = Config.Craft[identifier]
    local items = {}
    for k, v in pairs(craft.items) do
        v.usable = false
        items[tostring(k)] = v
    end
    cb(items)
end

function getCraftDisplayInventory(identifier, cb, source)
    local player = ESX.GetPlayerFromId(source)
    InvType["craft"].getInventory(identifier, function(inventory)
        local itemsObject = {}

        for k, v in pairs(inventory) do
            local esxItem = itemList[v.name]
            local item = createDisplayItem(v, esxItem, tonumber(k), v.price)
            table.insert(itemsObject, item)
        end

        local inv = {
            invId = identifier,
            invTier = InvType["craft"],
            inventory = itemsObject,
            cash = 0,
            black_money = 0
        }
        cb(inv)
    end)
end
--[[
RegisterServerEvent('disc-inventoryhud:craft')
AddEventHandler('disc-inventoryhud:craft', function(data)
    local player = ESX.GetPlayerFromId(source)
    local item = CraftList[data.originItem.id]
    local source = source
    --print()
        if item.id == data.originItem.id   then
            craft = true
        else
            craft = false
        end
        if craft and item.count == 1 then
     TriggerClientEvent("keen:craftRemove", player.source, item[1].item, item[1].qty) 
    TriggerClientEvent("keen:addItem", player.source, data.originItem.id, data.moveQty)
        else if craft and item.count == 2 then
            TriggerClientEvent("keen:itemremove", player.source, item[1].item, item[1].qty) 
            Wait(5)
            TriggerClientEvent("keen:itemremove", player.source, item[2].item, item[2].qty) 
            TriggerClientEvent("keen:addItem", player.source, data.originItem.id, data.moveQty)
        end
        end
    end)
]]

RegisterServerEvent('disc-inventoryhud:craft')
AddEventHandler('disc-inventoryhud:craft', function(data)
    local items = CraftList[data.originItem.id]
    local add =  false
    local player = ESX.GetPlayerFromId(source)
    local item1 = exports["disc-inventoryhud"]:itemCheck(items[1].item, items[1].qty, source) 
    Citizen.Wait(400)
    --local item2 = exports["disc-inventoryhud"]:itemCheck(items[2].item, items[2].qty) 
    local item3 = exports["disc-inventoryhud"]:itemCheck(items[3].item, items[3].qty, source) 
    Citizen.Wait(400)
    local item4 = exports["disc-inventoryhud"]:itemCheck(items[4].item, items[4].qty, source) 
    Citizen.Wait(400)

  if item1 and item3 and item4 then
    TriggerClientEvent("keen:itemremove", player.source, items[1].item, items[1].qty, source)
    Citizen.Wait(400)
    TriggerClientEvent("keen:itemremove", player.source, items[3].item, items[3].qty, source)
    Citizen.Wait(400)
    TriggerClientEvent("keen:itemremove", player.source, items[4].item, items[4].qty, source)
  else
    print("nope nope")
    --TriggerClientEvent('disc-inventoryhud:refreshInventory', source)
        
  

end
end)
    
