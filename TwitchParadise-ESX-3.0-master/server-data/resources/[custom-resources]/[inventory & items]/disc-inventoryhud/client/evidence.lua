local evidenceSecondaryInventory = {
    type = 'evidence',
    owner = ''
}

Citizen.CreateThread(function()
    while ESX == nil or ESX.PlayerData == nil or ESX.PlayerData.job == nil do
        Citizen.Wait(10)
    end
    print('Evidence Working')
    for k, v in pairs(Config.Evidence) do
        local marker = {
            name = k,
            type = v.markerType or 1,
            coords = v.coords,
            colour = v.markerColour or { r = 55, b = 255, g = 55 },
            size = v.size or vector3(0.5, 0.5, 0.0),
            action = function()
                evidenceSecondaryInventory.owner = k
                openInventory(evidenceSecondaryInventory)
            end,
            shouldDraw = function()
                return ESX.PlayerData.job.name == v.job or v.job == 'all'
            end,
            msg = v.msg or 'Press ~INPUT_CONTEXT~ to open Evidence',
        }
        TriggerEvent('disc-base:registerMarker', marker)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local player = GetPlayerPed(-1)
        local coords = GetEntityCoords(player)
        for k, v in pairs(Config.Evidence) do
            if GetDistanceBetweenCoords(coords, v.coords, true) < 1.0 then
                ESX.Game.Utils.DrawText3D(vector3(v.coords), "[E] - Open Evidence", 0.6)
            end
        end
    end

end)