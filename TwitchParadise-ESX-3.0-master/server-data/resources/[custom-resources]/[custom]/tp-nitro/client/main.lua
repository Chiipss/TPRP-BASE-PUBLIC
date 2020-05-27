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

ESX = nil

local hasNitroItem = false
local hasWrenchItem = false
local offset = nil
local vehicleCoord = nil
local IsInstallingNitro = false
local nitroUsed = false
local nitroveh = nil
local soundofnitro
local sound = false
local exhausts = {}
local installedCars = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    ESX.TriggerServerCallback('suku:getInstalledVehicles', function(vehicles)
        installedCars = vehicles
    end)
end)

RegisterNetEvent('suku:syncInstalledVehicles')
AddEventHandler('suku:syncInstalledVehicles', function(vehicles)
	  installedCars = vehicles
end)

AddEventHandler('suku:PassOnSequence', function(vehicle, plate, type)
    if IsPlateInList(plate) == true then
        if type == "uninstall" then
            TriggerEvent('suku:UninstallNitroFromVehicle', vehicle, plate)
        end
    else
        if type == "install" then
            TriggerEvent('suku:ImplementNitro', vehicle, plate)
        end
    end
end)

AddEventHandler('suku:ImplementNitro', function(vehicle, plate)
    IsInstallingNitro = true
    FreezeEntityPosition(vehicle, true)
    FreezeEntityPosition(GetPlayerPed(-1), true)
    SetVehicleDoorOpen(vehicle, 4, 0, 0)
    TriggerEvent("mythic_progbar:client:progress", {
					name = "repair_car",
					duration = 25000,
					label = "Installing nitro",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {
            animDict = "mini@repair",
            anim = "fixing_a_ped",
        },
}, function(status)
        if not status then
        end
    end)
    Wait(2000)
    PlaySoundFromEntity(-1, "Bar_Unlock_And_Raise", vehicle, "DLC_IND_ROLLERCOASTER_SOUNDS", 0, 0)
    Wait(2000)
    SetAudioFlag("LoadMPData", true)
    PlaySoundFrontend(-1, "Lowrider_Upgrade", "Lowrider_Super_Mod_Garage_Sounds", 1)
    Wait(8000)
    PlaySoundFromEntity(-1, "Bar_Unlock_And_Raise", vehicle, "DLC_IND_ROLLERCOASTER_SOUNDS", 0, 0)
    Wait(6000)
    PlaySoundFrontend(-1, "Lowrider_Upgrade", "Lowrider_Super_Mod_Garage_Sounds", 1)
    Wait(6000)
    PlaySoundFromEntity(-1, "Bar_Unlock_And_Raise", vehicle, "DLC_IND_ROLLERCOASTER_SOUNDS", 0, 0)

    local attempt = 0

	while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
		Citizen.Wait(100)
		NetworkRequestControlOfEntity(vehicle)
		attempt = attempt + 1
	end

    Wait(2000)
 
			
    SetVehicleDoorShut(vehicle, 4, 0)
    FreezeEntityPosition(vehicle, false)
    FreezeEntityPosition(GetPlayerPed(-1), false)
    TriggerServerEvent('suku:RemoveNitro', 1)
    local plate = GetVehicleNumberPlateText(vehicle)
    TriggerServerEvent('suku:InstallNitro', plate, 100)
    exports['mythic_notify']:DoHudText('inform', 'Nitro has been installed!')
    IsInstallingNitro = false
end)

AddEventHandler('suku:UninstallNitroFromVehicle', function(vehicle, plate)
    IsInstallingNitro = true
    FreezeEntityPosition(vehicle, true)
    FreezeEntityPosition(GetPlayerPed(-1), true)
    SetVehicleDoorOpen(vehicle, 4, 0, 0)
			TriggerEvent("mythic_progbar:client:progress", {
					name = "repair_car",
					duration = 25000,
					label = "Removing nitro",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {
            animDict = "mini@repair",
            anim = "fixing_a_ped",
        },
}, function(status)
        if not status then
        end
    end)
    Wait(5000)
    SetVehicleDoorShut(vehicle, 4, 0)
    FreezeEntityPosition(vehicle, false)
    FreezeEntityPosition(GetPlayerPed(-1), false)

    local breakchance = math.random(1, 25)
    if breakchance == 13 then
        SetVehicleEngineOn(vehicle, false, false )
        SetVehicleEngineHealth(vehicle, 0)
        SetVehicleUndriveable(vehicle, true)
        exports['mythic_notify']:DoHudText('inform', 'Nitro has been removed \n but the car broke down, \n you cut the wrong tube!')
    else
        exports['mythic_notify']:DoHudText('inform', 'Nitro has been removed!')
    end
    local plate = GetVehicleNumberPlateText(vehicle)
    TriggerServerEvent('suku:UninstallNitro', plate)
    IsInstallingNitro = false
end)

Citizen.CreateThread(function()
    while true do
        Wait(100)

        local ped = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(ped, false)
        local prop = GetVehicleNumberPlateText(veh)
        local isVehicleMarked = IsPlateInList(prop)

        if IsControlPressed(0, Keys["LEFTSHIFT"]) and GetPedInVehicleSeat(veh, -1) == ped then
            if isVehicleMarked then
                local nitroVehicle = GetPlateFromList(prop)
                if nitroVehicle.amount > 0 then
                    Citizen.InvokeNative(0xB59E4BD37AE292DB, veh, 5.0)
                    Citizen.InvokeNative(0x93A3996368C94158, veh, 25.0)
                    nitroUsed = true
                    StartScreenEffect("RaceTurbo", 750, false)

                    if sound == false then
                        soundofnitro = PlaySoundFromEntity(GetSoundId(), "Flare", veh, "DLC_HEISTS_BIOLAB_FINALE_SOUNDS", 0, 0)
                        sound = true
                    end
                end
            end
        else
            nitroUsed = false
            Citizen.InvokeNative(0xB59E4BD37AE292DB, veh, 1.0)
            Citizen.InvokeNative(0x93A3996368C94158, veh, 1.0)

            if sound == true then
                StopSound(soundofnitro)
                ReleaseSoundId(soundofnitro)
                sound = false
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(100)
        local ped = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(ped, false)
        local prop = GetVehicleNumberPlateText(veh)
        local hash = GetEntityModel(veh)

        if IsThisModelACar(hash) and IsPlateInList(prop) then
            exhausts = {}

            for i=1,12 do
                local exhaust = GetEntityBoneIndexByName(veh, "exhaust_" .. i)
                if i == 1 and GetEntityBoneIndexByName(veh, "exhaust") ~= -1 then
                    table.insert(exhausts, GetEntityBoneIndexByName(veh, "exhaust"))
                end
                if exhaust ~= -1 then
                    table.insert(exhausts, exhaust)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(100)

        local ped = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(ped, false)
        local prop = GetVehicleNumberPlateText(veh)
        local nitroVehicle = GetPlateFromList(prop)

        if nitroUsed and nitroVehicle.amount > 0 then
            Wait(Config.consumption)
            nitroVehicle.amount = nitroVehicle.amount - 1
            TriggerServerEvent('suku:UpdateNitroAmount', prop, 1)
            if exhausts ~= {} then
                flame(veh, #exhausts)
            end
        end
    end
end)

local uix = 0.01135
local uiy = 0.002

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if IsControlPressed(0, Keys["LEFTSHIFT"]) then
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                local prop = GetVehicleNumberPlateText(veh)
                if IsPlateInList(prop) then
                    local nitroVehicle = GetPlateFromList(prop)
                    drawRct(0.097 - uix, 0.95 - uiy, 0.046, 0.03, 0, 0, 0, 150)
                    DrawAdvancedText(0.171 - uix, 0.957 - uiy, 0.005, 0.0028, 0.3, "NOS~r~["..tostring(nitroVehicle.amount).."]~s~", 255, 255, 255, 255, 9, 1)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            RefreshList()
        end
    end
end)

function IsPlateInList(plate)
    for i = 1, #installedCars, 1 do
        if installedCars[i].plate == plate then
            return true
        end
    end
    return false
end

function GetPlateFromList(plate)
    for i = 1, #installedCars, 1 do
        if installedCars[i].plate == plate then
            return installedCars[i]
        end
    end
    return nil
end

function RefreshList()
    ESX.TriggerServerCallback('suku:getInstalledVehicles', function(vehicles)
        installedCars = {}
        installedCars = vehicles
    end)
end

function resetVisual()
    vehicleCoord = nil
    hasNitroItem = false
    offset = nil
end

function DisableInput(vehicle)
    SetVehicleEngineOn(vehicle, false, false )
    SetVehicleUndriveable(vehicle, true)

    DisableControlAction(0, 24, true) -- Attack
	DisableControlAction(0, 257, true) -- Attack 2
	DisableControlAction(0, 25, true) -- Aim
	DisableControlAction(0, 263, true) -- Melee Attack 1
	DisableControlAction(0, 32, true) -- W
	DisableControlAction(0, 34, true) -- A
	DisableControlAction(0, 31, true) -- S
	DisableControlAction(0, 30, true) -- D

	DisableControlAction(0, 45, true) -- Reload
	DisableControlAction(0, 22, true) -- Jump
	DisableControlAction(0, 44, true) -- Cover
	DisableControlAction(0, 37, true) -- Select Weapon
	DisableControlAction(0, 23, true) -- Also 'enter'?

	DisableControlAction(0, 288,  true) -- Disable phone
	DisableControlAction(0, 289, true) -- Inventory
	DisableControlAction(0, 170, true) -- Animations
	DisableControlAction(0, 167, true) -- Job

	DisableControlAction(0, 73, true) -- Disable clearing animation
	DisableControlAction(2, 199, true) -- Disable pause screen

	DisableControlAction(0, 59, true) -- Disable steering in vehicle
	DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
	DisableControlAction(0, 72, true) -- Disable reversing in vehicle

	DisableControlAction(2, 36, true) -- Disable going stealth

	DisableControlAction(0, 47, true)  -- Disable weapon
	DisableControlAction(0, 264, true) -- Disable melee
	DisableControlAction(0, 257, true) -- Disable melee
	DisableControlAction(0, 140, true) -- Disable melee
	DisableControlAction(0, 141, true) -- Disable melee
	DisableControlAction(0, 142, true) -- Disable melee
	DisableControlAction(0, 143, true) -- Disable melee
	DisableControlAction(0, 75, true)  -- Disable exit vehicle
	DisableControlAction(27, 75, true) -- Disable exit vehicle
end

function flame (veh, count)
    if exhausts then
        if not HasNamedPtfxAssetLoaded("core") then
            RequestNamedPtfxAsset("core")
            while not HasNamedPtfxAssetLoaded("core") do
                Wait(1)
            end
        end
        if count == 1 then
            UseParticleFxAssetNextCall("core")
            fire = StartParticleFxLoopedOnEntityBone_2("veh_backfire", veh, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, exhausts[1], 1.0, 0, 0, 0)
        elseif count == 2 then
            UseParticleFxAssetNextCall("core")
            fire = StartParticleFxLoopedOnEntityBone_2("veh_backfire", veh, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, exhausts[1], 1.0, 0, 0, 0)
            UseParticleFxAssetNextCall("core")
            fire2 = StartParticleFxLoopedOnEntityBone_2("veh_backfire", veh, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, exhausts[2], 1.0, 0, 0, 0)
        elseif count == 3 then
            UseParticleFxAssetNextCall("core")
            fire = StartParticleFxLoopedOnEntityBone_2("veh_backfire", veh, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, exhausts[1], 1.0, 0, 0, 0)
            UseParticleFxAssetNextCall("core")
            fire2 = StartParticleFxLoopedOnEntityBone_2("veh_backfire", veh, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, exhausts[2], 1.0, 0, 0, 0)
            UseParticleFxAssetNextCall("core")
            fire3 = StartParticleFxLoopedOnEntityBone_2("veh_backfire", veh, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, exhausts[3], 1.0, 0, 0, 0)
        elseif count == 4 then
            UseParticleFxAssetNextCall("core")
            fire = StartParticleFxLoopedOnEntityBone_2("veh_backfire", veh, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, exhausts[1], 1.0, 0, 0, 0)
            UseParticleFxAssetNextCall("core")
            fire2 = StartParticleFxLoopedOnEntityBone_2("veh_backfire", veh, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, exhausts[2], 1.0, 0, 0, 0)
            UseParticleFxAssetNextCall("core")
            fire3 = StartParticleFxLoopedOnEntityBone_2("veh_backfire", veh, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, exhausts[3], 1.0, 0, 0, 0)
            UseParticleFxAssetNextCall("core")
            fire4 = StartParticleFxLoopedOnEntityBone_2("veh_backfire", veh, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, exhausts[4], 1.0, 0, 0, 0)
        end
    end
end

function GetVehicleInDirection(coordFrom, coordTo)
    local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end

function drawRct(x, y, width, height, r, g, b, a)
	DrawRect(x, y, width, height, r, g, b, a)
end

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
    N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - 0.1+w, y - 0.02+h)
end

function startAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, 25000, 0, 0, false, false, false)
	end)
end


RegisterNetEvent('nitro:onUse')
AddEventHandler('nitro:onUse', function()
    local playerPed		= GetPlayerPed(-1)
	local coords		= GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

        if DoesEntityExist(vehicle) then
            local plate = GetVehicleNumberPlateText(vehicle)
            TriggerEvent('suku:ImplementNitro', vehicle, plate)
            Citizen.Wait(1000)
		end

		Citizen.CreateThread(function()
			Citizen.Wait(0)

			if CurrentAction ~= nil then
				exports['mythic_notify']:SendAlert('inform', 'Press X to cancel', 5000)
				if IsControlJustReleased(0, Keys["X"]) then
					TerminateThread(ThreadID)
					exports['mythic_notify']:SendAlert('inform', 'Repair canceled', 6000)
					CurrentAction = nil
				end
			end

		end)
	else
		exports['mythic_notify']:SendAlert('inform', 'No vehicle near-by', 6000)
	end
end)

RegisterNetEvent('wrench:onUse')
AddEventHandler('wrench:onUse', function()
    local playerPed		= GetPlayerPed(-1)
	local coords		= GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

        if DoesEntityExist(vehicle) then
            local plate = GetVehicleNumberPlateText(vehicle)
            TriggerEvent('suku:UninstallNitroFromVehicle', vehicle, plate)
            Citizen.Wait(1000)
		end

		Citizen.CreateThread(function()
			Citizen.Wait(0)

			if CurrentAction ~= nil then
				exports['mythic_notify']:SendAlert('inform', 'Press X to cancel', 5000)
				if IsControlJustReleased(0, Keys["X"]) then
					TerminateThread(ThreadID)
					exports['mythic_notify']:SendAlert('inform', 'Repair canceled', 6000)
					CurrentAction = nil
				end
			end

		end)
	else
		exports['mythic_notify']:SendAlert('inform', 'No vehicle near-by', 6000)
	end
end)