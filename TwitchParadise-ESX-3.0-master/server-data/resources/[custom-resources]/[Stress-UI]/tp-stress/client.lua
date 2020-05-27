ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx_status:loaded', function(status)
    TriggerEvent('esx_status:registerStatus', 'stress', 10, '#cadfff', function(status)
		return false
	end, function(status)
		status.add(1)
	end)

    Citizen.CreateThread(function()
		while true do
            Citizen.Wait(1)
            local ped = PlayerPedId()

            TriggerEvent('esx_status:getStatus', 'stress', function(status)
				StressVal = status.val
                
            end)

            -- print(StressVal) < DEBUG

            if StressVal == 1000000 then -- max StressVal
				SetTimecycleModifier("WATER_silty") -- a bit blur and vision distance reduce
				SetTimecycleModifierStrength(1)
			else
				ClearExtraTimecycleModifier()
			end

            if StressVal >= 900000 then
				local veh = GetVehiclePedIsUsing(ped)
			  	if IsPedInAnyVehicle(ped) and GetPedInVehicleSeat(veh, -1) == ped then -- if ped "driving" a vehicle
					Citizen.Wait(1000)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.1) -- kamera sallanmaları // cam shake
					--TaskVehicleTempAction(ped, veh, 7, 250) -- aracı hafif sola kırma // turn left a bit
					Citizen.Wait(500)
					--TaskVehicleTempAction(ped, veh, 8, 250) -- aracı hafif sağa kırma // turn right a bit
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.1)
					Citizen.Wait(500)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.1)
			  	else
					Citizen.Wait(1500)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.1)
			  	end
			elseif StressVal >= 800000 then
				local veh = GetVehiclePedIsUsing(ped)
			  	if IsPedInAnyVehicle(ped) and GetPedInVehicleSeat(veh, -1) == ped then
					Citizen.Wait(1000)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.07)
					--TaskVehicleTempAction(ped, veh, 7, 150)
					Citizen.Wait(500)
					--TaskVehicleTempAction(ped, veh, 8, 150)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.07)
					Citizen.Wait(500)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.07)
			  	else
					Citizen.Wait(1500)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.07)
			  	end
			elseif StressVal >= 700000 then
				local veh = GetVehiclePedIsUsing(ped)
			  	if IsPedInAnyVehicle(ped) and GetPedInVehicleSeat(veh, -1) == ped then
					Citizen.Wait(1000)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.06)
					--TaskVehicleTempAction(ped, veh, 7, 100)
					Citizen.Wait(500)
					--TaskVehicleTempAction(ped, veh, 8, 100)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.06)
					Citizen.Wait(500)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.06)
			  	else
					Citizen.Wait(2000)
					ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.06)
			  	end
			elseif StressVal >= 600000 then -- Below ½60 no effect to driving
				Citizen.Wait(2500) -- sıklık // frequency
				ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.04) -- efekt // effect
			elseif StressVal >= 500000 then
				Citizen.Wait(3500)
				ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.04)
			elseif StressVal >= 350000 then
				Citizen.Wait(5500)
				ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.03)
			elseif StressVal >= 250000 then
				Citizen.Wait(6500)
                ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.02)
            else
                Citizen.Wait(3000)
            end
        end
    end)
end)

Citizen.CreateThread(function() -- Aiming with a weapon
    while true do
        local ped = PlayerPedId()
        local status = GetPedConfigFlag(ped, 78, 1)

        if status then
            TriggerServerEvent("stress:add", 7000)
            Citizen.Wait(5000)
        else
            Citizen.Wait(1)
        end
    end
end)

--[[ Citizen.CreateThread(function() -- Holding a weapon (except melee and explosives category)
    while true do
        local ped = PlayerPedId()
        local status = IsPedArmed(ped, 4)

        if status then
            TriggerServerEvent("stress:add", 10000)
            Citizen.Wait(15000)
        else
            Citizen.Wait(1)
        end
    end
end) ]]

Citizen.CreateThread(function() -- While shooting
    while true do
        local ped = PlayerPedId()
        local status = IsPedShooting(ped)
        local silenced = IsPedCurrentWeaponSilenced(ped)

        if status and not silenced then
            TriggerServerEvent("stress:add", 50000)
            Citizen.Wait(2000)
        else
            Citizen.Wait(1)
        end
    end
end)

Citizen.CreateThread(function() -- Heard gunshot, melee hit etc., seems not to work, since player peds don't act like NPC's ?
    while true do
        local ped = PlayerPedId()
        local status = GetPedAlertness(ped)

        if status == 1 then
            TriggerServerEvent("stress:add", 10000)
            Citizen.Wait(10000)
        else
            Citizen.Wait(1)
        end
    end
end)

Citizen.CreateThread(function() -- Aiming with a melee, hitting with a melee or getting hit by a melee
    while true do
        local ped = PlayerPedId()
        local status = IsPedInMeleeCombat(ped)

        if status then
            TriggerServerEvent("stress:add", 5000)
            Citizen.Wait(5000)
        else
            Citizen.Wait(1)
        end
    end
end)


Citizen.CreateThread(function() -- While healt is below 100(half) TEST THIS BEFORE USE, CAN GET PROBLEMATIC
    while true do
        local ped = PlayerPedId()
        local amount = (GetEntityHealth(ped)-100)

        if amount <= 50 then
            TriggerServerEvent("stress:add", 35000)
            --exports['mythic_notify']:SendAlert("error", "METİN BURAYA // TEXT HERE") --Example mythic notify
            Citizen.Wait(60000)
        else
            Citizen.Wait(1)
        end
    end
end)

Citizen.CreateThread(function() -- Staying still or walking
    while true do
        local ped = PlayerPedId()
        local status = IsPedStill(ped)
        local status_w = IsPedArmed(ped, 4)
        local status2 = IsPedWalking(ped)
		local status_v = IsPedInAnyVehicle(ped, false)

        if status and not status_w and not status_v and not GetPedStealthMovement(ped) then -- durmak // still
            Citizen.Wait(15000)
            TriggerServerEvent("stress:remove", 26000)
            Citizen.Wait(15000)
        elseif status2 and not status_w and not GetPedStealthMovement(ped) then -- walking
            Citizen.Wait(15000)
            TriggerServerEvent("stress:remove", 10000)
            Citizen.Wait(15000)
        else
            Citizen.Wait(1)
        end
    end
end)

Citizen.CreateThread(function() -- Skydiving with parachute
    while true do
        local ped = PlayerPedId()
        local status = GetPedParachuteState(ped)

        if status == 0 then -- paraşütle dalış // freefall with chute (not falling without it)
            TriggerServerEvent("stress:add", 40000)
            Citizen.Wait(5000)
        elseif status == 1 or status == 2 then -- paraşüt açık // opened chute
            TriggerServerEvent("stress:add", 5000)
            Citizen.Wait(5000)
        else
            Citizen.Wait(5000) -- refresh rate is low on this one since it's not so common to skydive in RP servers
        end
    end
end)

Citizen.CreateThread(function() -- Stealth mode
    while true do
        local ped = PlayerPedId()
        local status = GetPedStealthMovement(ped)

        if status then
            TriggerServerEvent("stress:add", 10000)
            Citizen.Wait(8000)
        else
            Citizen.Wait(1) -- refresh rate
        end
    end
end)

Citizen.CreateThread(function() -- You can use this as a template if you want to make an animation stressful or stress reliever
    while true do
        local ped = PlayerPedId()
        local status = IsEntityPlayingAnim(ped, "timetable@tracy@sleep@", "idle_c", 3)

        if status then
            Citizen.Wait(20000)
            TriggerServerEvent("stress:remove", 40000)
        else
            Citizen.Wait(1) -- refresh rate
        end
    end
end)


function AddStress(method, value, seconds)
    if method:lower() == "instant" then
        TriggerServerEvent("stress:add", value)
    elseif method:lower() == "slow" then
        local count = 0
        repeat
            TriggerServerEvent("stress:add", value/seconds)
            count = count + 1
            Citizen.Wait(1000)
        until count == seconds
    end
end

function RemoveStress(method, value, seconds)
    if method:lower() == "instant" then
        TriggerServerEvent("stress:remove", value)
    elseif method:lower() == "slow" then
        local count = 0
        repeat
            TriggerServerEvent("stress:remove", value/seconds)
            count = count + 1
            Citizen.Wait(1000)
        until count == seconds
    end
end

--Citizen.CreateThread(function()
--    while true do -- döngü // loop
--        local test = IsPedShooting(ped) -- native you want to check (natives: https://runtime.fivem.net/doc/natives/)
--        if test then -- if the native returns true below action will happen
--            TriggerServerEvent("stress:add", 100000) -- adding stress
--        else -- while the native returns false do nothing and keep the loop
--            Citizen.Wait(1) -- how often you want to check the native in ms (should generally be smaller then 1000)
--        end
--    end
--end)


Citizen.CreateThread(function()
    while true do
   Citizen.Wait(1)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
    local speed = GetEntitySpeed(vehicle)
        if IsPedInAnyVehicle(ped) and speed > 57 and speed < 65 then --130MPH
            exports['tp-stress']:AddStress('slow', 8500, 5)
        end
        if IsPedInAnyVehicle(ped) and speed >= 66 then --150MPH
            exports['tp-stress']:AddStress('slow', 10000, 5)
        end
    end
end)
