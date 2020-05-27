-- alerts police sometimes

-- can be scrapped without police online
-- can't sell scrap without police online

ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

items = {
    "prop_aircon_m_01",
    "prop_aircon_m_10",
    "prop_aircon_m_04",
    "prop_aircon_m_02",
    "prop_aircon_m_05"
}

Citizen.CreateThread(function()
    while true do
        sleepTime = 100
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed, 1)
        local nearest = 0

        for k, v in pairs(items) do
            nearest = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, 10.0, GetHashKey(v), false, false, false)
            if nearest ~= 0 then
                break
            end
        end
        local nearestCoords = GetEntityCoords(nearest, 0)

        local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, nearestCoords.x, nearestCoords.y, nearestCoords.z, true)

        if nearest ~= 0 and distance < 10 then
            DrawText3D(nearestCoords, "Press [~r~E~w~] to remove parts")
            sleepTime = 0
        end
        if nearest ~= 0 and distance < 2.0 then
            if IsControlJustPressed(0, 38) then
                disabledControls = true
                processScrap(nearest, nearestCoords)
            end
        end
        Citizen.Wait(sleepTime)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if disabledControls == true then
            DisableControlAction(0, 38, true)
        end
    end
end)

function processScrap(nearest, nearestCoords)
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, false)
    exports["t0sic_loadingbar"]:StartDelayedFunction("Removing parts...", 15000, function()
        ClearPedTasksImmediately(playerPed)
        disabledControls = false
        exports['mythic_notify']:SendAlert('success', 'You stole some parts', 10000)
        SetEntityAsMissionEntity(nearest)
        DeleteEntity(nearest)
        TriggerServerEvent('tp-scrap:giveItem')
        TriggerServerEvent('tp-scrap:notifyPolice', nearestCoords)
    end)
end

function DrawText3D(coords, text)
    if not Drawing then
        Drawing = true
        local onScreen,_x,_y = World3dToScreen2d(coords.x,coords.y,coords.z + 1.2)
        local px,py,pz = table.unpack(GetGameplayCamCoord())
        local dist = GetDistanceBetweenCoords(px,py,pz, coords.x,coords.y,coords.z + 1.2, 1)
        local color = { r = 220, g = 220, b = 220, alpha = 255 } -- Color of the text 
        local dropShadow = true
        local scale = ((1/dist)*2)*(1/GetGameplayCamFov())*200
        if onScreen then
          SetTextColour(color.r, color.g, color.b, color.alpha)
          SetTextScale(0.0*scale, 0.40*scale)
          SetTextFont(4)
          SetTextProportional(1)
          SetTextCentre(true)
          if dropShadow then
              SetTextDropshadow(10, 100, 100, 100, 255)
          end
          BeginTextCommandWidth("STRING")
          AddTextComponentString(text)
          local height = GetTextScaleHeight(0.45*scale, font)
          local width = EndTextCommandGetWidth(font)
          SetTextEntry("STRING")
          AddTextComponentString(text)
          EndTextCommandDisplayText(_x, _y)
        end
        Drawing = false
      end
end

RegisterNetEvent('tp-scrap:notifyCopsCL')
AddEventHandler('tp-scrap:notifyCopsCL', function(coords)
    if ESX.PlayerData.job.name == "police" then
        exports['mythic_notify']:SendAlert('error', 'Someone was spotted damaging property', 5000)
        Citizen.CreateThread(function()
            local BlipA = AddBlipForRadius(coords.x + math.random(-2, 2), coords.y + math.random(-2, 2), coords.z, 50.0)
            SetBlipHighDetail(BlipA, true)
            SetBlipColour(BlipA, 1)
            SetBlipAlpha(BlipA, 128)

            local BlipB = AddBlipForCoord(coords.x + math.random(-2, 2), coords.y + math.random(-2, 2), coords.z)
            SetBlipSprite(BlipB, 1)
            SetBlipDisplay(BlipB, 4)
            SetBlipScale(BlipB, 0.8)
            SetBlipColour(BlipB, 1)
            SetBlipAsShortRange(BlipB, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Vandalism In Progress")
            EndTextCommandSetBlipName(BlipB)

            local timer = GetGameTimer()
            while GetGameTimer() - timer < 30000 do
                Citizen.Wait(0)
            end

            RemoveBlip(BlipA)
            RemoveBlip(BlipB)
        end)
    end
end)