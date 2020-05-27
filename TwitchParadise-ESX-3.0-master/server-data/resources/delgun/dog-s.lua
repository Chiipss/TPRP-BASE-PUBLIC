-- Created by @murfasa https://forum.cfx.re/u/murfasa

RegisterServerEvent("dog:checkRole")
AddEventHandler("dog:checkRole", function()
    if IsPlayerAceAllowed(source, "dog.delgun") then
        TriggerClientEvent("dog:returnCheck", source, true)
    else
        TriggerClientEvent("dog:returnCheck", source, false)
    end
end)