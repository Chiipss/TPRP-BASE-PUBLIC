local secondarySearchInventory = {
    type = 'player',
    owner = '',
    seize = true
}
local secondaryStealInventory = {
    type = 'player',
    owner = '',
    steal = true
}

local cooldown = false
local counter
local cooldownEnd


RegisterNetEvent('disc-inventoryhud:search')
AddEventHandler('disc-inventoryhud:search', function()
    local player = ESX.GetPlayerData()
    if player.job.name == 'police' then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 3.0 then
            local searchPlayerPed = GetPlayerPed(closestPlayer)
            --if IsEntityPlayingAnim(searchPlayerPed, 'mp_arresting', 'idle', 3) or IsEntityDead(searchPlayerPed) or GetEntityHealth(searchPlayerPed) <= 0 then
                ESX.TriggerServerCallback('disc-inventoryhud:getIdentifier', function(identifier)
                    secondarySearchInventory.owner = identifier
                    openInventory(secondarySearchInventory)
                end, GetPlayerServerId(closestPlayer))
            --end
        end
    end
end)

RegisterNetEvent('disc-inventoryhud:steal')
AddEventHandler('disc-inventoryhud:steal', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local deadPlayer = false
    print(closestPlayer)

    if not cooldown then
        if closestPlayer ~= -1 and closestDistance <= 3.0 then
            local searchPlayerPed = GetPlayerPed(closestPlayer)
            if IsEntityPlayingAnim(searchPlayerPed, 'random@mugging3', 'handsup_standing_base', 3) or IsEntityPlayingAnim(searchPlayerPed, 'dead', 'dead_a', 3) then
                ESX.TriggerServerCallback('disc-inventoryhud:getIdentifier', function(identifier)
                    secondaryStealInventory.owner = identifier
                    openInventory(secondaryStealInventory)
                end, GetPlayerServerId(closestPlayer))
            end
        end
    else
        exports['mythic_notify']:SendAlert('error', 'You cannot steal from another player right now!', 15000)
    end
end)

RegisterNetEvent('disc-inventoryhud:stealCooldown')
AddEventHandler('disc-inventoryhud:stealCooldown', function()
    print("Steal cooldown activated")
    cooldown = true
    counter = 0
    cooldownEnd = 300
end)

Citizen.CreateThread(function()
    if cooldown then
        if counter == cooldownEnd then
            cooldown = false
        else
            counter = counter + 1
        end
        Citizen.Wait(1000)
    end
end)

RegisterNUICallback('StealCash', function(data)
    TriggerServerEvent('disc-inventoryhud:StealCash', data)
end)

RegisterNUICallback('SeizeCash', function(data)
    TriggerServerEvent('disc-inventoryhud:SeizeCash', data)
end)