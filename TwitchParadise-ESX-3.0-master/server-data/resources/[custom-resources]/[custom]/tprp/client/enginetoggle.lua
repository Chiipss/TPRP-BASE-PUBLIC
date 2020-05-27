-- Configuration

local commandEnabled = true -- (false by default) If you set this to true, typing "/engine" in chat will also toggle your engine.

-- You're all set now!


-- Code, no need to modify this, unless you know what you're doing or you want to fuck shit up.
-- No support will be provided if you modify this part below.

Citizen.CreateThread(function()
    if commandEnabled then
        RegisterCommand('engine', function() 
            toggleEngine()
        end, false)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
            if IsControlJustReleased(0, 246) then
                toggleEngine()
            end
        end
    end
end)

function toggleEngine()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
        if (GetIsVehicleEngineRunning(vehicle)) then
            exports['mythic_notify']:SendAlert('inform', 'You switched off the engine!', 5000)
        else
            exports['mythic_notify']:SendAlert('inform', 'You switched on the engine!', 5000)
        end
        SetVehicleEngineOn(vehicle, (not GetIsVehicleEngineRunning(vehicle)), false, true)
    end
end