--Function cmd /dropgun
RegisterServerEvent("chatCommandEntered")
RegisterServerEvent("chatMessageEntered")

RegisterCommand("dropgun", function(source, args, raw)
    TriggerClientEvent("dropweapon", source)
end)

--Function keybinding
RegisterServerEvent('drops')
AddEventHandler('drops', function()
  TriggerClientEvent('dropweapon', source)
end)
