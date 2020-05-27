Citizen.CreateThread(function()
    TriggerEvent('disc-inventoryhud:RegisterInventory', {
        name = 'stash',
        label = 'Stash',
        slots = 50
    })
end)