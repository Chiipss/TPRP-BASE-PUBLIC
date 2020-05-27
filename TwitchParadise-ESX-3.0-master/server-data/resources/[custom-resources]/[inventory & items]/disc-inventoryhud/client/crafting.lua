local craftSecondaryInventory = {
    type = 'craft',
    owner = ''
}

Citizen.CreateThread(function()
    for k, v in pairs(Config.Craft) do
        if v.enableBlip then
            for val, coords in pairs(v.coords) do
                local blip = {
                    name = k,
                    coords = coords,
                    colour = v.blipColour or 2,
                    sprite = v.blipSprite or 52
                }
                TriggerEvent('disc-base:registerBlip', blip)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while not ESXLoaded do
        Citizen.Wait(10)
    end
    for k, v in pairs(Config.Craft) do
        for val, coords in pairs(v.coords) do
            local marker = {
                name = k .. val,
                coords = coords,
                type = v.markerType or 1,
                colour = v.markerColour or { r = 55, b = 255, g = 55 },
                size = v.size or vector3(1.0, 1.0, 1.0),
                action = function()
                    craftSecondaryInventory.owner = k
                    openInventory(craftSecondaryInventory)
                end,
                shouldDraw = function()
                    return ESX.PlayerData.job.name == v.job or v.job == 'all'
                end,
                msg = v.msg or _U('keycraft'),
            }
            TriggerEvent('disc-base:registerMarker', marker)
        end
    end
end)


RegisterNetEvent("keen:craftRemove")
    AddEventHandler("keen:craftRemove", function(item,count)
        TriggerServerEvent("keen:craftRemoval", item, count)
        end)
