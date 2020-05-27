Citizen.CreateThread(function()
    TriggerEvent('disc-inventoryhud:RegisterInventory', {
        name = 'glovebox',
        label = 'Glove Box',
        slots = 5
    })
end)