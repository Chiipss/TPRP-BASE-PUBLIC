ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem("tuning_laptop",function(source)
    local _source = source
    TriggerClientEvent("tuner:open", _source)
end)