--[[ 
local MiejsceMisji =  {x = 960.71197509766, y = -215.51979064941, z = 76.2552947998} --<< miejsce gdzie jest marker z misją
local dealerCoords =  {x = 960.78, y = -216.25, z = 76.25}  							--<< miejsce gdzie stoi dealer NPC
local pojazdCoords1 = {x = -1327.479736328, y = -86.045326232910, z = 49.31}  		--<< ponizej koordynaty do randomowego respienia się pojazdu
local pojazdCoords2 = {x = -2075.888183593, y = -233.73908996580, z = 21.10}
local pojazdCoords3 = {x = -972.1781616210, y = -1530.9045410150, z = 4.890}
local pojazdCoords4 = {x = 798.18426513672, y = -1799.8173828125, z = 29.33}
local pojazdCoords5 = {x = 1247.0718994141, y = -344.65634155273, z = 69.08}
local BronKierowca = "WEAPON_PISTOL50" 		--<< broń w jaką ma być wyposażony kierowca
local BronPasazer = "WEAPON_SMG"  			--<< broń w jaką ma być wyposażony strażnik
local CzasDetonacji = 90 * 1000 			--<< czas detonacji bomby po podłożeniu, domyślnie 20 sekund
local czasPakowania = 45 * 1000 			--<< czas pakowania gotówki do torby, domyślnie 30 sekund
----------------------tego nizej nie ruszaj------------------------------
local prop
local wyjebalo = 0
local wysadzony = 0
local oznaczenie
local transport
local zrespione = 0
local ZrespTuPojazd = nil
local dealer
local ostrzezenie = 0
--------------------------------------------------------
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

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.3, 0.3)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    --DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end

function PowiadomPsy()
	x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	playerX = tonumber(string.format("%.2f", x))
    playerY = tonumber(string.format("%.2f", y))
    playerZ = tonumber(string.format("%.2f", z))
	TriggerServerEvent('tp_gruppe:zawiadompsy', playerX, playerY, playerZ)
	Citizen.Wait(500)
end

RegisterNetEvent('tp_gruppe:infodlalspd')
AddEventHandler('tp_gruppe:infodlalspd', function(x, y, z)	
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		exports['mythic_notify']:SendAlert('error', 'Someone is attempting to take cash from a Gruppe van, All units please respond IMMEDIATELY! Do not ignore!', 30000)
        --ESX.ShowNotification('~y~Someone is trying to rob a gruppe truck!~n~~r~RESPOND IMMEDIATLEY')
        PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)


        local alpha = 250
		local alpha2 = 180
		local blip = AddBlipForCoord(x, y, z)
		local blip2 = AddBlipForCoord(x, y, z)


		SetBlipHighDetail(blip2, true)
		SetBlipColour(blip2, 1)
		SetBlipAlpha(blip2, alpha2)
		SetBlipAsShortRange(blip2, true)		

        SetBlipSprite(blip, 67)
		SetBlipHighDetail(blip, true)
		SetBlipColour(blip, 4)
		SetBlipAlpha(blip, alpha)
		SetBlipFlashes(blip, true)
		SetBlipRoute(blip, true)
		SetBlipRouteColour(blip, 1)
		SetBlipShowCone(blip, true)
		SetBlipDisplay(blip, 10)
		SetBlipBright(blip, true)
		BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Group6 ROB')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(90000)
        RemoveBlip(blip)
        RemoveBlip(blip2)
	end
end)

function NotyfikacjaMisja()
PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
local czas = 0.550
SetNotificationTextEntry("STRING")
AddTextComponentString("The clerk gave you the location of a gruppe van full of cash! Check your GPS.")
Citizen.InvokeNative(0x1E6611149DB3DB6B, "CHAR_DETONATEBOMB", "CHAR_DETONATEBOMB", true, 1, "Information", "~o~Misja", czas)
DrawNotification_4(false, true)
end
---
--
RegisterNetEvent('tp_gruppe:Pozwolwykonac')
AddEventHandler('tp_gruppe:Pozwolwykonac', function()
NotyfikacjaMisja()
ClearPedTasks(dealer)
TaskWanderStandard(dealer, 100,100)
local losujCoordy = math.random(1,5)
if losujCoordy == 1 then
ZrespTuPojazd = pojazdCoords1
elseif losujCoordy == 2 then
ZrespTuPojazd = pojazdCoords2
elseif losujCoordy == 3 then
ZrespTuPojazd = pojazdCoords3
elseif losujCoordy == 4 then
ZrespTuPojazd = pojazdCoords4
elseif losujCoordy == 5 then
ZrespTuPojazd = pojazdCoords5
end

RequestModel(GetHashKey('stockade'))
while not HasModelLoaded(GetHashKey('stockade')) do
Citizen.Wait(0)
end

SetNewWaypoint(ZrespTuPojazd.x, ZrespTuPojazd.y)
ClearAreaOfVehicles(ZrespTuPojazd.x, ZrespTuPojazd.y, ZrespTuPojazd.z, 15.0, false, false, false, false, false) 
				
transport = CreateVehicle(GetHashKey('stockade'), ZrespTuPojazd.x, ZrespTuPojazd.y, ZrespTuPojazd.z, -2.436,  996.786, 25.1887, true, true)
SetEntityAsMissionEntity(transport)
SetEntityHeading(transport, 52.00)
oznaczenie = AddBlipForEntity(transport)
SetBlipSprite(oznaczenie, 57)
SetBlipColour(oznaczenie, 1)
SetBlipFlashes(oznaczenie, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString('Gruppe van')
EndTextCommandSetBlipName(oznaczenie)
--
RequestModel("s_m_m_security_01")
while not HasModelLoaded("s_m_m_security_01") do
Wait(10)
end
local pilot = CreatePedInsideVehicle(transport, 1, "s_m_m_security_01", -1, true, true)
local nawigator = CreatePedInsideVehicle(transport, 1, "s_m_m_security_01", 0, true, true)
SetPedFleeAttributes(pilot, 0, 0)
SetPedCombatAttributes(pilot, 46, 1)
SetPedCombatAbility(pilot, 100)
SetPedCombatMovement(pilot, 2)
SetPedCombatRange(pilot, 2)
SetPedKeepTask(pilot, true)
GiveWeaponToPed(pilot, GetHashKey(BronKierowca),250,false,true)
SetPedAsCop(pilot, true)
--
SetPedFleeAttributes(nawigator, 0, 0)
SetPedCombatAttributes(nawigator, 46, 1)
SetPedCombatAbility(nawigator, 100)
SetPedCombatMovement(nawigator, 2)
SetPedCombatRange(nawigator, 2)
SetPedKeepTask(nawigator, true)
TaskEnterVehicle(nawigator,transport,-1,0,1.0,1)
GiveWeaponToPed(nawigator, GetHashKey(BronPasazer),250,false,true)
SetPedAsCop(nawigator, true)

TaskVehicleDriveWander(pilot, transport, 80.0, 443)
zrespione = 1
end)

local used = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
		
		if zrespione == 1 then
			local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local transCoords = GetEntityCoords(transport) 
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, transCoords.x, transCoords.y, transCoords.z)

			if dist <= 55.0  then
			DrawMarker(0, transCoords.x, transCoords.y, transCoords.z+4.5, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 135, 31, 35, 100, 1, 0, 0, 0)
				if ostrzezenie == 0 then
				ostrzezenie = 1
				exports['mythic_notify']:SendAlert('inform', 'Kill the driver and passenger.', 15000)
				end
			else
			Citizen.Wait(500)
			end
			
            if dist <= 4.5 and wysadzony == 0 then
				local inventory = ESX.GetPlayerData().inventory
				local c4 = 0
                for i=1, #inventory, 1 do
                    if inventory[i].name == 'c4' then
                    c4 = inventory[i].count
                    end
                end
                if c4 > 0 then 
                    hintToDisplay('Click ~INPUT_DETONATE~ to open the door')
                    if IsControlJustPressed(0, Keys['G']) then 
                        TriggerEvent("tp_gruppe:triggerBomb")
                        TriggerServerEvent("tp_gruppe:removeC4")
                        
                        Citizen.Wait(500)
                    end
                else
                    hintToDisplay('You do not have any C4!!')
			    end
            else
            Citizen.Wait(1500)
            end
        end
    end
end)


RegisterNetEvent('tp_gruppe:triggerBomb')
AddEventHandler('tp_gruppe:triggerBomb', function()
    SprawdzInformacjePojazdowe()
end)

function SprawdzInformacjePojazdowe()
    if IsVehicleStopped(transport) then
        if IsVehicleSeatFree(transport, -1) and IsVehicleSeatFree(transport, 0) and IsVehicleSeatFree(transport, 1) then
            wysadzony = 1
            RequestAnimDict('anim@heists@ornate_bank@thermal_charge_heels')
            while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge_heels') do
                Citizen.Wait(50)
            end
            PowiadomPsy()
            local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
            prop = CreateObject(GetHashKey('prop_c4_final_green'), x, y, z+0.2,  true,  true, true)
            AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.06, 0.0, 0.06, 90.0, 0.0, 0.0, true, true, false, true, 1, true)
            SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"),true)
            FreezeEntityPosition(GetPlayerPed(-1), true)
            TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@ornate_bank@thermal_charge_heels', "thermal_charge", 3.0, -8, -1, 63, 0, 0, 0, 0 )
            Citizen.Wait(5500)
            ClearPedTasks(GetPlayerPed(-1))
            DetachEntity(prop)
            AttachEntityToEntity(prop, transport, GetEntityBoneIndexByName(transport, 'door_pside_r'), -0.7, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
            exports['mythic_notify']:SendAlert('error', 'Move away from the truck! C4 will go off in 90 seconds.', 15000)
            FreezeEntityPosition(GetPlayerPed(-1), false)
            Citizen.Wait(CzasDetonacji)
            local transCoords = GetEntityCoords(transport)
            SetVehicleDoorBroken(transport, 2, false)
            SetVehicleDoorBroken(transport, 3, false)
            AddExplosion(transCoords.x,transCoords.y,transCoords.z, 'EXPLOSION_TANKER', 2.0, true, false, 2.0)
            ApplyForceToEntity(transport, 0, transCoords.x,transCoords.y,transCoords.z, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
            wyjebalo = 1
            exports['mythic_notify']:SendAlert('error', 'Take the money from the back and get outta there!', 15000)
            RemoveBlip(oznaczenie)
            PowiadomPsy()
        else
            exports['mythic_notify']:SendAlert('error', 'You need to take out the driver and passenger!', 10000)
        end
    else
        ESX.ShowNotification('~y~You cant rob while car is moving.')
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
		
		if wyjebalo == 1 then
			local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local transCoords = GetEntityCoords(transport) 
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, transCoords.x, transCoords.y, transCoords.z)

			if dist > 45.0 then
			Citizen.Wait(500)
			end
			
			if dist <= 4.5 then
				hintToDisplay('Press ~INPUT_PICKUP~ to take money')
				if IsControlJustPressed(0, Keys['E']) then 
				wyjebalo = 0
				ZabieranieSiana()
				Citizen.Wait(500)
				end
			end
		else
		Citizen.Wait(1500)
		end
end
end)

function ZabieranieSiana()
    RequestAnimDict('anim@heists@ornate_bank@grab_cash_heels')
    while not HasAnimDictLoaded('anim@heists@ornate_bank@grab_cash_heels') do
        Citizen.Wait(50)
    end
    local PedCoords = GetEntityCoords(GetPlayerPed(-1))
    torba = CreateObject(GetHashKey('prop_cs_heist_bag_02'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
    AttachEntityToEntity(torba, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.0, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
    TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
    FreezeEntityPosition(GetPlayerPed(-1), true)
    exports['mythic_notify']:SendAlert('success', 'You are filling the bag with money!', 30000)
    Citizen.Wait(czasPakowania)
    DeleteEntity(torba)
    ClearPedTasks(GetPlayerPed(-1))
    FreezeEntityPosition(GetPlayerPed(-1), false)
    SetPedComponentVariation(GetPlayerPed(-1), 5, 45, 0, 2)
    TriggerServerEvent("tp_gruppe:graczZrobilnapad")
    wyjebalo = 0
    wysadzony = 0
    zrespione = 0
    Citizen.Wait(2500)
end
 ]]

--Temp Code

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
    PlayerData = ESX.GetPlayerData()
    xPlayer = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    xPlayer = xPlayer
end)


local attempted = 0

RegisterNetEvent("tp:gruppeCard") 
AddEventHandler("tp:gruppeCard", function()
    local coordA = GetEntityCoords(GetPlayerPed(-1), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 100.0, 0.0)
    local targetVehicle = getVehicleInDirection(coordA, coordB)
    if targetVehicle ~= 0 and GetHashKey("stockade") == GetEntityModel(targetVehicle) then
        local entityCreatePoint = GetOffsetFromEntityInWorldCoords(targetVehicle, 0.0, -4.0, 0.0)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        local aDist = GetDistanceBetweenCoords(coords["x"], coords["y"],coords["z"], entityCreatePoint["x"], entityCreatePoint["y"],entityCreatePoint["z"])
        if aDist < 2.0 then
            AlertPD()
            TriggerEvent("sec:AttemptHeist", targetVehicle) 
        else
            TriggerEvent("DoLongHudText","You need to do this from behind the vehicle.")
        end
    end
end)


RegisterNetEvent('sec:AttemptHeist')
AddEventHandler('sec:AttemptHeist', function(veh)
    attempted = veh
    SetEntityAsMissionEntity(attempted,true,true)
    local plate = GetVehicleNumberPlateText(veh)
    ESX.TriggerServerCallback('tp:gruppe:checkPlate', function(canRob)
        if canRob then
            exports['mythic_progbar']:Progress({
                name = "unlockdoor_action",
                duration = 20000,
                label = "Unlocking vehicle",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false, 
                    disableCombat = false,
                },
                animation = {
                    animDict = "missheistdockssetup1clipboard@idle_a",
                    anim = "idle_a",
                    flags = 49,
                },
            }, function(status)
                if not status then
                    TriggerServerEvent('tp:gruppe:addPlate', plate)
                    TriggerEvent("sec:AllowHeist", veh)
                    TriggerServerEvent("tp:removeIDcard")
                end
            end)
        else
            exports['mythic_notify']:DoHudText('error', 'This truck is empty and the security system has been triggered.')
            AlertPD()
        end
    end, plate)
end)

RegisterNetEvent('sec:AllowHeist')
AddEventHandler('sec:AllowHeist', function(veh)
    TriggerEvent("sec:AddPeds",attempted)
    SetVehicleDoorOpen(attempted, 2, 0, 0)
    SetVehicleDoorOpen(attempted, 3, 0, 0)
    TriggerEvent("sec:PickupCash")

end)

RegisterNetEvent('sec:AddPeds')
AddEventHandler('sec:AddPeds', function(veh)
    local cType = 's_m_m_highsec_01'

    local pedmodel = GetHashKey(cType)
    RequestModel(pedmodel)
    while not HasModelLoaded(pedmodel) do
        RequestModel(pedmodel)
        Citizen.Wait(100)
    end

   ped2 = CreatePedInsideVehicle(veh, 4, pedmodel, 0, 1, 0.0)
   ped3 = CreatePedInsideVehicle(veh, 4, pedmodel, 1, 1, 0.0)
   ped4 = CreatePedInsideVehicle(veh, 4, pedmodel, 2, 1, 0.0)

   GiveWeaponToPed(ped2, GetHashKey('WEAPON_SpecialCarbine'), 420, 0, 1)
   GiveWeaponToPed(ped3, GetHashKey('WEAPON_SpecialCarbine'), 420, 0, 1)
   GiveWeaponToPed(ped4, GetHashKey('WEAPON_SpecialCarbine'), 420, 0, 1)

   SetPedMaxHealth(ped2, 350)
   SetPedMaxHealth(ped3, 350)
   SetPedMaxHealth(ped4, 350)

   SetPedDropsWeaponsWhenDead(ped2,false)
   SetPedRelationshipGroupDefaultHash(ped2,GetHashKey('COP'))
   SetPedRelationshipGroupHash(ped2,GetHashKey('COP'))
   SetPedAsCop(ped2,true)
   SetCanAttackFriendly(ped2,false,true)

   SetPedDropsWeaponsWhenDead(ped3,false)
   SetPedRelationshipGroupDefaultHash(ped3,GetHashKey('COP'))
   SetPedRelationshipGroupHash(ped3,GetHashKey('COP'))
   SetPedAsCop(ped3,true)
   SetCanAttackFriendly(ped3,false,true)
   

   SetPedDropsWeaponsWhenDead(ped4,false)
   SetPedRelationshipGroupDefaultHash(ped4,GetHashKey('COP'))
   SetPedRelationshipGroupHash(ped4,GetHashKey('COP'))
   SetPedAsCop(ped4,true)
   SetCanAttackFriendly(ped4,false,true)

   TaskCombatPed(ped2, GetPlayerPed(-1), 0, 16)
   TaskCombatPed(ped3, GetPlayerPed(-1), 0, 16)
   TaskCombatPed(ped4, GetPlayerPed(-1), 0, 16)
end)




local pickup = false
RegisterNetEvent('sec:PickupCash')
AddEventHandler('sec:PickupCash', function()
    pickup = true
    TriggerEvent("sec:PickupCashLoop")
    Wait(180000)
    pickup = false
end)

RegisterNetEvent('sec:PickupCashLoop')
AddEventHandler('sec:PickupCashLoop', function()
    local markerlocation = GetOffsetFromEntityInWorldCoords(attempted, 0.0, -3.7, 0.1)
    SetVehicleHandbrake(attempted,true)
    while pickup do
        Citizen.Wait(1)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        local aDist = GetDistanceBetweenCoords(coords["x"], coords["y"],coords["z"], markerlocation["x"],markerlocation["y"],markerlocation["z"])
        if aDist < 10.0 then
            DrawMarker(27,markerlocation["x"],markerlocation["y"],markerlocation["z"], 0, 0, 0, 0, 0, 0, 1.51, 1.51, 0.3, 212, 189, 0, 30, 0, 0, 2, 0, 0, 0, 0)
            
            if aDist < 2.0 then
                if IsDisabledControlJustReleased(0, 38) then
                    pickUpCash()
                end
                DrawText3Ds(markerlocation["x"],markerlocation["y"],markerlocation["z"], "Press [E] to pick up cash.")
            else
                DrawText3Ds(markerlocation["x"],markerlocation["y"],markerlocation["z"], "Get Closer to pick up the cash.")
            end
        end
    end
end)

function DrawText3Ds(x,y,z, text)
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

local gotem = false

local pickingup = false
function pickUpCash()

    if not pickingup then
        AlertPD()
        local coords = GetEntityCoords(GetPlayerPed(-1))
       -- Citizen.Trace("Doing Animation")
        pickingup = true
        RequestAnimDict("anim@mp_snowball")
        
        while not HasAnimDictLoaded("anim@mp_snowball") do
            Citizen.Wait(0)
        end

        while pickingup do

            local coords2 = GetEntityCoords(GetPlayerPed(-1))
            local aDist = GetDistanceBetweenCoords(coords["x"], coords["y"],coords["z"], coords2["x"],coords2["y"],coords2["z"])
            if aDist > 1.0 or not pickup then
                pickingup = false
            end

            if IsEntityPlayingAnim(GetPlayerPed(-1), "anim@mp_snowball", "pickup_snowball", 3) then
            else
                TaskPlayAnim(GetPlayerPed(-1), "anim@mp_snowball", "pickup_snowball", 8.0, -8, -1, 49, 0, 0, 0, 0)
            end 

            local chance = math.random(1,100)

            if chance > 96 then
                AlertPD()
                DropItemPedBankCard()
            end

            if math.random(200) > 195 and gotem == false then
                gotem = true
                TriggerServerEvent("tp:gruppeItem", "encryptedusbred", 1)
                TriggerServerEvent('tp_gruppe:giveDirtyCash', math.random(5000))
            end

            if chance < 10 then
                AlertPD()
                -- xPlayer.addAccountMoney('black_money', math.random(10))
                TriggerServerEvent('tp_gruppe:giveDirtyCash', math.random(1250))
            end

            TriggerServerEvent('tp_gruppe:giveDirtyCash', math.random(1250))
            
            Wait(math.random(5000,10000))

        end

        ClearPedTasks(GetPlayerPed(-1))
        
    end
end

function DropItemPedBankCard()

    local pos = GetEntityCoords(PlayerPedId())
    local myluck = math.random(20) 

    if myluck == 1 then
        TriggerServerEvent("tp:gruppeItem", "securityblack", 1)--gruppe
    --[[elseif myluck == 2 then
        TriggerServerEvent("tp:gruppeItem", "securityblue", 1) 
     elseif myluck == 3 then
        TriggerServerEvent("tp:gruppeItem", "securitygreen", 1)
    elseif myluck == 4 then
        TriggerServerEvent("tp:gruppeItem", "securitygold", 1)
    else
        TriggerServerEvent("tp:gruppeItem", "securityred", 1) ]]
    end
    
end

function FindEndPointCar(x,y)   
	local randomPool = 50.0
	while true do

		if (randomPool > 2900) then
			return
		end
	    local vehSpawnResult = {}
	    vehSpawnResult["x"] = 0.0
	    vehSpawnResult["y"] = 0.0
	    vehSpawnResult["z"] = 30.0
	    vehSpawnResult["x"] = x + math.random(randomPool - (randomPool * 2),randomPool) + 1.0  
	    vehSpawnResult["y"] = y + math.random(randomPool - (randomPool * 2),randomPool) + 1.0  
	    roadtest, vehSpawnResult, outHeading = GetClosestVehicleNode(vehSpawnResult["x"], vehSpawnResult["y"], vehSpawnResult["z"],  0, 55.0, 55.0)

        Citizen.Wait(1000)        
        if vehSpawnResult["z"] ~= 0.0 then
            local caisseo = GetClosestVehicle(vehSpawnResult["x"], vehSpawnResult["y"], vehSpawnResult["z"], 20.000, 0, 70)
            if not DoesEntityExist(caisseo) then

                return vehSpawnResult["x"], vehSpawnResult["y"], vehSpawnResult["z"], outHeading
            end
            
        end

        randomPool = randomPool + 50.0
	end
    --endResult["x"], endResult["y"], endResult["z"]
end


function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle

    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)   
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)
        
        offset = offset - 1

        if vehicle ~= 0 then break end
    end
    
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    
    if distance > 25 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

RegisterNetEvent('tp_gruppe:informPD')
AddEventHandler('tp_gruppe:informPD', function(x, y, z)	
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		exports['mythic_notify']:SendAlert('error', 'Someone is attempting to take cash from a Gruppe van, All units please respond IMMEDIATELY! Do not ignore!', 30000)
        --ESX.ShowNotification('~y~Someone is trying to rob a gruppe truck!~n~~r~RESPOND IMMEDIATLEY')
        
        PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
        Citizen.Wait(250)
        PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
        Citizen.Wait(250)
        PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)


        local alpha = 250
		local alpha2 = 180
		local blip = AddBlipForCoord(x, y, z)
		local blip2 = AddBlipForCoord(x, y, z)


		SetBlipHighDetail(blip2, true)
		SetBlipColour(blip2, 1)
		SetBlipAlpha(blip2, alpha2)
		SetBlipAsShortRange(blip2, true)		

        SetBlipSprite(blip, 67)
		SetBlipHighDetail(blip, true)
		SetBlipColour(blip, 4)
		SetBlipAlpha(blip, alpha)
		SetBlipFlashes(blip, true)
		SetBlipRoute(blip, true)
		SetBlipRouteColour(blip, 1)
		SetBlipShowCone(blip, true)
		SetBlipDisplay(blip, 10)
		SetBlipBright(blip, true)
		BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Gruppe 6 ROBBERY')
        EndTextCommandSetBlipName(blip)
        Citizen.Wait(90000)
        RemoveBlip(blip)
        RemoveBlip(blip2)
	end
end)

function AlertPD()
	x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	playerX = tonumber(string.format("%.2f", x))
    playerY = tonumber(string.format("%.2f", y))
    playerZ = tonumber(string.format("%.2f", z))
	TriggerServerEvent('tp_gruppe:SendPlayerToPd', playerX, playerY, playerZ)
	Citizen.Wait(500)
end


