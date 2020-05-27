ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function Draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

local coords = { x = 2437.96, y = 4960.65, z = 46.00, h = 43.69 }

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local plyCoords = GetEntityCoords(PlayerPedId(), 0)
        local distance = #(vector3(coords.x, coords.y, coords.z) - plyCoords)
        if distance < 10 then
            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                if distance < 3 then
			        Draw3DText(coords.x, coords.y, coords.z + 0.5, '[Q] - Check in for $450')
                        if IsControlJustReleased(0, 44) then --may need to disable key from being disabled while dead
                            if (GetEntityHealth(PlayerPedId()) <= 200) then
                                        exports['progressBars']:startUI(60000, "Treating, Do not move")
                                        Citizen.Wait(60000)
                                        --your revive script code goes here
                                        TriggerEvent('tp_ambulancejob:revive')
                                        --end revive code
                                        TriggerServerEvent('drp-grandmas:payBill')
                            else
                                exports['mythic_notify']:DoHudText('error', 'You do not need medical attention')
                            end
                        end
                    end
                end
            else
                Citizen.Wait(1000)
            end
    end
end)