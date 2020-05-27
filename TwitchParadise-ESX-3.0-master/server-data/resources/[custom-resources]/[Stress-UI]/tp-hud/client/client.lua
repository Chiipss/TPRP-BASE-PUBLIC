ESX = nil

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
end)

local isTokovoip = true

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    ESX.TriggerServerCallback('disc-hud:getMoney', {}, function(data)
        SendNUIMessage({
            action = 'display',
            cash = data.cash,
            bank = data.bank
        })
    end)
end)

function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end


function ToggleUI()
    showUi = not showUi

    if showUi then
        SendNUIMessage({
            action = 'showui'
        })

        if IsPedInAnyVehicle(PlayerPedId()) then
            SendNUIMessage({
                action = 'showcar'
            })
        end
    else
        SendNUIMessage({
            action = 'hideui'
        })
        SendNUIMessage({
            action = 'hidecar'
        })
    end
end


--General UI Updates
Citizen.CreateThread(function()
    Citizen.Wait(0)
    SendNUIMessage({
        action = 'showui'
    })

    while true do
        local player = PlayerPedId()
        local pos = GetEntityCoords(player)
        local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
        local current_zone = GetLabelText(GetNameOfZone(pos.x, pos.y, pos.z))

        SendNUIMessage({
            action = 'tick',
            show = IsPauseMenuActive(),
            health = (GetEntityHealth(player) - 100),
            armor = GetPedArmour(player),
            stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),          
        })
        Citizen.Wait(200)
    end
end)

--Network Talking Updates
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if isTokovoip then
            SendNUIMessage({
                action = 'voice-color',
                isTalking = exports.tokovoip_script:getPlayerData(GetPlayerServerId(PlayerId()), 'voip:talking')
            })
        else
            SendNUIMessage({
                action = 'voice-color',
                isTalking = NetworkIsPlayerTalking(PlayerId())
            })
        end
    end
end)

Citizen.CreateThread(function()
    local currLevel = 1
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(1, 20) then
            if isTokovoip == true then
                currLevel =  exports.tokovoip_script:getPlayerData(GetPlayerServerId(PlayerId()), 'voip:mode')
                if currLevel == 1 then
                    SendNUIMessage({
                        action = 'set-voice',
                        value = 66
                    })
                elseif currLevel == 2 then
                    SendNUIMessage({
                        action = 'set-voice',
                        value = 33
                    })
                elseif currLevel == 3 then
                    SendNUIMessage({
                        action = 'set-voice',
                        value = 100
                    })
                end
            else
                currLevel = (currLevel + 1) % 3
                print(currLevel)
                if currLevel == 0 then
                    SendNUIMessage({
                        action = 'set-voice',
                        value = 33
                    })
                elseif currLevel == 1 then
                    SendNUIMessage({
                        action = 'set-voice',
                        value = 66
                    })
                elseif currLevel == 2 then
                    SendNUIMessage({
                        action = 'set-voice',
                        value = 100
                    })
                end
            end
        end
    end
end)

--Food Thirst
Citizen.CreateThread(function()
    while true do
        TriggerEvent('esx_status:getStatus', 'hunger', function(hunger)
            TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)
                TriggerEvent('esx_status:getStatus','stress',function(stress)
                    SendNUIMessage({
                        action = "updateStatus",
                        hunger = hunger.getPercent(),
                        thirst = thirst.getPercent(),
                        stress = stress.getPercent(),
                    })
                end)
            end)
        end)
        Citizen.Wait(5000)
    end
end)




Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        HideHudComponentThisFrame(7) -- Area Name
        HideHudComponentThisFrame(9) -- Street Name
        HideHudComponentThisFrame(3) -- SP Cash display
        HideHudComponentThisFrame(4)  -- MP Cash display
        HideHudComponentThisFrame(13) -- Cash changesSetPedHelmet(PlayerPedId(), false)

        -- WHY IS THIS EVEN A THING?! LEAVING IT JUST INCASE.
        --[[ if IsControlJustReleased(0, 344) then
            ToggleUI()
        end ]]
    end
end)

