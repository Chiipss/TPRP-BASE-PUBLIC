ESX = nil
ESXLoaded = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
    ESXLoaded = true
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    TriggerEvent('disc-inventoryhud:refreshInventory')
end)



RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()

    for k,v in pairs(Config.Shops) do
        local blip = AddBlipForCoord(v.coords)
        if v.coords == vector3(-196.37, -1318.90, 31.08) or v.coords == vector3(310.119, -568.411, 43.31) or v.coords ==  vector3(-1393.409, -606.624, 29.319 + 1) or v.coords == vector3(1392.562, 3604.684, 33.980 + 1) or v.coords == vector3(1166.024, 2708.930, 37.157 + 1) or v.coords == vector3(-2968.243, 390.910, 14.043 + 1) or v.coords == vector3(-1487.553, -379.107, 39.163 + 1) or v.coords == vector3(-1222.915, -906.983, 11.326 + 1) or v.coords == vector3(1135.808, -982.281, 45.415 + 1) or v.coords == vector3(2748.0, 3473.0, 55.68) or v.coords == vector3(44.821, -1748.172, 29.23) or v.coords == vector3(342.863, -1298.74, 32.53) or v.coords == vector3(1728.41, 2584.31, 45.84) or v.coords == vector3(1677.65, 4881.955, 42.034) or v.coords == vector3(-51.419, 6360.17, 31.454) or v.coords == vector3(-580.878, -984.902, 22.454) or v.coords == vector3(-662.180, -934.961, 20.829 + 1) or v.coords == vector3(810.25, -2157.60, 28.62 + 1) or v.coords == vector3(1693.44, 3760.16, 33.71 + 1) or v.coords == vector3(-330.24, 6083.88, 30.45 + 1) or v.coords == vector3(252.63, -50.00, 68.94 + 1) or v.coords == vector3(22.09, -1107.28, 28.80 + 1) or v.coords == vector3(2567.69, 294.38, 107.73 + 1) or v.coords == vector3(-1117.58, 2698.61, 17.55 + 1) or v.coords == vector3(842.44, -1033.42, 27.19 + 1) or v.coords == vector3(452.36, -979.98, 29.68 + 1) or v.coords == vector3(952.64, -954.39, 39.75) or v.coords == vector3(-1194.1119384766,-891.71295166016,13.99515247345) or v.coords == vector3(-1074.228515625,-823.53033447266,11.035818099976) or v.coords == vector3(-1194.111,-891.712,13.995) or v.coords == vector3(1855.516,3699.118,34.267) or v.coords == vector3(1767.69, 3325.341, 41.438) or v.coords == vector3(1845.760,3692.538,34.267) or v.coords == vector3(1783.906, 2543.439, 44.798 + 1) or v.coords == vector3(-437.136,6001.071,31.716) or v.coords == vector3(1218.6063232422,-3235.1044921875,5.5287499427795) or v.coords == vector3(-1586.7843017578,-3012.75,-76.004959106445) or v.coords == vector3(-1878.1696777344,2062.9956054688,135.91505432129) or v.coords == vector3(13.157131195068,-1599.3381347656,29.376482009888) then --Add coords here of shops you want to hide.
            RemoveBlip(blip)
        elseif v.coords == vector3(567.29205322266, -3117.6762695313, 18.768548965454) or v.coords == vector3(1001.0770263672, 80.573554992676, 23.27642250061) or v.coords == vector3(135.37750244141, -1288.5422363281, 29.269525527954) then
            RemoveBlip(blip) -- VU, Casino & Merryweather
        else
        

        SetBlipSprite (blip, 52)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.6)
        SetBlipColour (blip, 2)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("General store")
        EndTextCommandSetBlipName(blip)
        end
    end

end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.Shops) do
        local blip = AddBlipForCoord(v.coords)
        if v.coords == vector3(-662.180, -934.961, 20.829 + 1) or v.coords == vector3(810.25, -2157.60, 28.62 + 1) or v.coords == vector3(1693.44, 3760.16, 33.71 + 1) or v.coords == vector3(-330.24, 6083.88, 30.45 + 1) or v.coords == vector3(252.63, -50.00, 68.94 + 1)or v.coords == vector3(22.09, -1107.28, 28.80 + 1) or v.coords == vector3(2567.69, 294.38, 107.73 + 1) or v.coords == vector3(-1117.58, 2698.61, 17.55+ 1) or v.coords == vector3(842.44, -1033.42, 27.19 + 1) then

            SetBlipSprite (blip, 110)
            SetBlipDisplay(blip, 4)
            SetBlipScale  (blip, 0.6)
            SetBlipColour (blip, 81)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName('Weapon Shop')
            EndTextCommandSetBlipName(blip)
        else
            RemoveBlip(blip)
        end
    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.Shops) do
        local blip = AddBlipForCoord(v.coords)
        if v.coords ==  vector3(-1393.409, -606.624, 29.319 + 1) or v.coords == vector3(1392.562, 3604.684, 33.980 + 1) or v.coords == vector3(1166.024, 2708.930, 37.157 + 1) or v.coords == vector3(-2968.243, 390.910, 14.043 + 1) or v.coords == vector3(-1487.553, -379.107, 39.163 + 1) or v.coords == vector3(-1222.915, -906.983, 11.326 + 1) or v.coords == vector3(1135.808, -982.281, 45.415 + 1) then

            SetBlipSprite (blip, 93)
            SetBlipDisplay(blip, 4)
            SetBlipScale  (blip, 0.6)
            SetBlipColour (blip, 2)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName('Liquor Shop')
            EndTextCommandSetBlipName(blip)
        else
            RemoveBlip(blip)
        end
    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.Shops) do
        local blip = AddBlipForCoord(v.coords)
        if v.coords == vector3(2748.0, 3473.0, 55.68) or v.coords == vector3(44.821, -1748.172, 29.23) or v.coords == vector3(342.863, -1298.74, 32.53) then

            SetBlipSprite (blip, 402)
            SetBlipDisplay(blip, 4)
            SetBlipScale  (blip, 0.8)
            SetBlipColour (blip, 2)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName('YouTool store')
            EndTextCommandSetBlipName(blip)
        else
            RemoveBlip(blip)
        end
    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.Shops) do
        local blip = AddBlipForCoord(v.coords)
        if v.coords == vector3(1728.41, 2584.31, 45.84) then

            SetBlipSprite (blip, 52)
            SetBlipDisplay(blip, 4)
            SetBlipScale  (blip, 0.6)
            SetBlipColour (blip, 2)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName('Prison store')
            EndTextCommandSetBlipName(blip)
        else
            RemoveBlip(blip)
        end
    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.Shops) do
        local blip = AddBlipForCoord(v.coords)
        if v.coords == vector3(1677.65, 4881.955, 42.034) or v.coords == vector3(-51.419, 6360.17, 31.454) or v.coords == vector3(-580.878, -984.902, 22.454) then

            SetBlipSprite (blip, 587)
            SetBlipDisplay(blip, 4)
            SetBlipScale  (blip, 0.6)
            SetBlipColour (blip, 2)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName('Garden Center')
            EndTextCommandSetBlipName(blip)
        else
            RemoveBlip(blip)
        end
    end
end)

local dropSecondaryInventory = {
    type = 'drop',
    owner = 'x123y123z123'
}

local isInInventory = false

RegisterNUICallback('NUIFocusOff', function(data)
    closeInventory()
end)

RegisterCommand('closeinv', function(source, args, raw)
    closeInventory()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, Config.OpenControl) and IsInputDisabled(0) then
            local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
            local _, floorZ = GetGroundZFor_3dCoord(x, y, z)
            dropSecondaryInventory.owner = getOwnerFromCoords(vector3(x, y, floorZ))
            openInventory(dropSecondaryInventory)
        end
        if IsControlJustReleased(0, 73) then
            SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_UNARMED'), true)
        end
    end
end
)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        closeInventory()
    end
end)




