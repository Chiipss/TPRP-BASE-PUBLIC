local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }


local display = false
local v = 'n'
local lastplate = 1
ESX = nil

Citizen.CreateThread(function ()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
      PlayerData = ESX.GetPlayerData()
    end
  
    while PlayerData == nil do
      PlayerData = ESX.GetPlayerData()
      Citizen.Wait(0)
    end
end)

RegisterNetEvent('es:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        if v == 'n' and IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
            v = 's'
            checkluzes()
        elseif v == 's' and IsPedOnFoot(GetPlayerPed(-1)) then
            v = 'n'
        end
    end
end)

function checkluzes()
        Citizen.Wait(200)
        local plate = ESX.Math.Trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1),false)))
        if plate ~= nil then
                ESX.TriggerServerCallback('matif_headlights:check', function(result)
                        if result ~= nil and result ~= 'NOT' then
                            lastplate = plate
                            local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1),false)
                            ToggleVehicleMod(vehicle, 22, true)
                            SetVehicleHeadlightsColour(vehicle, tonumber(result))    
                        end
                end, plate)
        end
end

--[[ RegisterCommand("headlights", function(source, args)
    if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
        local plate = ESX.Math.Trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1),false)))

        if plate ~= lastplate then
            ESX.TriggerServerCallback('matif_headlights:check', function(result)
                if result ~= nil and result == 'NOT' then
                    print('doesnt have')
                    TriggerEvent('esx:showNotification', 'The vehicle you are in doesnt have the xenon headlight extra!')
                elseif result ~= nil and result ~= 'NOT' then
                    lastplate = plate
                    SetDisplay(not display)
                else
                    TriggerEvent('esx:showNotification', 'Something went wrong!')
                end
            end, plate)
        else
            SetDisplay(not display)
        end   
    else
        TriggerEvent('esx:showNotification', 'You are not in a vehicle!')
    end
end) ]]



RegisterNetEvent('tp:headlights')
AddEventHandler('tp:headlights', function()
    if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
        local plate = ESX.Math.Trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1),false)))

        if plate ~= lastplate then
            ESX.TriggerServerCallback('matif_headlights:check', function(result)
                if result ~= nil and result == 'NOT' then
                    print('doesnt have')
                    TriggerEvent('esx:showNotification', 'The vehicle you are in doesnt have the xenon headlight extra!')
                elseif result ~= nil and result ~= 'NOT' then
                    lastplate = plate
                    SetDisplay(not display)
                else
                    TriggerEvent('esx:showNotification', 'Something went wrong!')
                end
            end, plate)
        else
            SetDisplay(not display)
        end   
    else
        TriggerEvent('esx:showNotification', 'You are not in a vehicle!')
    end
end)

RegisterCommand("installheadlights", function(source, args)
    if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
        local plate = ESX.Math.Trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1),false)))
        TriggerServerEvent('matif_headlights:install', plate)
    else
        TriggerEvent('esx:showNotification', 'You are not in a vehicle!')
    end
end)

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("setcolor", function(data)
    print(data.color)
    local plate = ESX.Math.Trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1),false)))
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1)), 22, true)
    SetVehicleHeadlightsColour(GetVehiclePedIsIn(GetPlayerPed(-1)), tonumber(data.color))
	TriggerServerEvent('matif_headlights:set', plate, data.color)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        -- https://runtime.fivem.net/doc/natives/#_0xFE99B66D079CF6BC
        --[[ 
            inputGroup -- integer , 
	        control --integer , 
            disable -- boolean 
        ]]
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
        local canSleep = true

        if CanFitHeadlights() then
            

                for i=1, #Config.HeadlightLocations, 1 do
                    local carRepairLocations = Config.HeadlightLocations[i]
                    local distance = GetDistanceBetweenCoords(coords, carRepairLocations, true)

                    if distance < 5 then
                        ESX.Game.Utils.DrawText3D(vector3(910.98614501953,-965.14971923828,39.849), "~w~Press ~r~[E]~w~ to fit new headlights", 1.2)
                        --DrawMarker(1, carRepairLocations, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 2.0, 0, 115, 0, 20, false, false, 2, false, false, false, false)
                        canSleep = false
                    end

                    if distance < 5 then
                        canSleep = false

                        if IsControlJustReleased(0, Keys['E']) then
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            local plate = GetVehicleNumberPlateText(vehicle)
                            TriggerServerEvent('matif_headlights:install', plate)
                            Citizen.Wait(1000)
                            if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                                local plate = ESX.Math.Trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1),false)))
                        
                                if plate ~= lastplate then
                                    ESX.TriggerServerCallback('matif_headlights:check', function(result)
                                        if result ~= nil and result == 'NOT' then
                                            print('doesnt have')
                                            TriggerEvent('esx:showNotification', 'The vehicle you are in doesnt have the xenon headlight extra!')
                                        elseif result ~= nil and result ~= 'NOT' then
                                            lastplate = plate
                                            SetDisplay(not display)
                                        else
                                            TriggerEvent('esx:showNotification', 'This vehicle isnt owned or there is an issue!')
                                        end
                                    end, plate)
                                else
                                    SetDisplay(not display)
                                end   
                            else
                                TriggerEvent('esx:showNotification', 'You are not in a vehicle!')
                            end
                        end
                    end
                end

                if canSleep then
                    Citizen.Wait(500)
                end
            

		else
			Citizen.Wait(500)
		end
	end
end)

function CanFitHeadlights()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)

		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			return true
		end
	end

	return false
end