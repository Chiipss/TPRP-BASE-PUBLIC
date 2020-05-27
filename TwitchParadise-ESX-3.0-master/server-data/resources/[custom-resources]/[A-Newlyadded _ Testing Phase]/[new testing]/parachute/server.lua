ESX                       = nil

TriggerEvent('esx:getSharedObject', function(obj)
  ESX = obj
end)

ESX.RegisterUsableItem('parachute', function(source)  
   TriggerClientEvent('useparachute', source)
end)


RegisterServerEvent('parachute:equip')
AddEventHandler('parachute:equip',function()
    local player = ESX.GetPlayerFromId(source)
    player.removeInventoryItem('parachute', 1)
end)




