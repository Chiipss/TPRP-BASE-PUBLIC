-------------------------
--Written by Tościk#9715-
-------------------------
------------------CONFIG----------------------
local startX = 2190.445  --miejsce lapania pigow
local startY = 4981.941
local startZ = 41.517
---------------------------------------------
local slaughterX = 998.135   --punkt na slaughterhouse
local slaughterY = -2144.108
local slaughterZ = 29.529
---
local slaughterX2 = 996.870   --punkt na przetwarzanie 2
local slaughterY2 = -2143.121
local slaughterZ2 = 29.476
---
local packageX = 985.778    --punkt pakowania 1
local packageY = -2117.039
local packageZ = 30.757
---
local packageX2 = 985.498   --punkt pakowania 2
local packageY2 = -2121.712
local packageZ2 = 30.475
---
local sellX = 1194.148    --punkt sprzedazy
local sellY = 2722.781
local sellZ = 38.623


---------------------------------------------
--------tego lepiej nie ruszaj ponizej-------
---------------------------------------------
local pig1
local pig2
local pig3
local caught1 = 0
local caught2 = 0
local caught3 = 0
local numbercaught = 0
local share = false
local prop
local packeforacar = false
local cardboard
local meat
local packing = 0
--------------
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
end)
---
--[[ Citizen.CreateThread(function()
local blip1 = AddBlipForCoord(startX, startY, startZ)
    SetBlipSprite (blip1, 126)
    SetBlipDisplay(blip1, 4)
    SetBlipScale  (blip1, 0.6)
    SetBlipColour (blip1, 23)
    SetBlipAsShortRange(blip1, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Pig Farm')
    EndTextCommandSetBlipName(blip1)
local blip2 = AddBlipForCoord(slaughterX, slaughterY, slaughterZ)
    SetBlipSprite (blip2, 273)
    SetBlipDisplay(blip2, 4)
    SetBlipScale  (blip2, 0.7)
    SetBlipColour (blip2, 23)
    SetBlipAsShortRange(blip2, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Pig Slaughterhouse')
    EndTextCommandSetBlipName(blip2)
local blip3 = AddBlipForCoord(sellX, sellY, sellZ)
    SetBlipSprite (blip3, 478)
    SetBlipDisplay(blip3, 4)
    SetBlipScale  (blip3, 0.6)
    SetBlipColour (blip3, 23)
    SetBlipAsShortRange(blip3, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Pig Dealer')
    EndTextCommandSetBlipName(blip3)
end) ]]
---
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawText3D2(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
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
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end
----Chwytanie kruczaka
Citizen.CreateThread(function()
    while true do
	Citizen.Wait(0)
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, startX, startY, startZ)
---
		if dist <= 20.0 then
		DrawMarker(27, startX, startY, startZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
		else
		Citizen.Wait(1500)
		end
		
		if dist <= 2.5 then
		DrawText3D2(startX, startY, startZ, "~g~[E]~w~ To start catching pigs")
		end
--
		if dist <= 0.5 then
			if IsControlJustPressed(0, Keys['E']) then -- "E"
			catchchicken()
			end			
		end
	end
end)
-------Przerabianie

local Positions = {
	['Slaughter1'] = { ['hint'] = '~g~[E]~w~ To pack pig', ['x'] = 985.778, ['y'] = -2117.039, ['z'] = 30.757 },
	['Slaughter2'] = { ['hint'] = '~g~[E]~w~ To pack pig', ['x'] = 985.498, ['y'] = -2121.712, ['z'] = 30.475 }
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local plyCoords = GetEntityCoords(PlayerPedId())
        local distance1 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, slaughterX, slaughterY, slaughterZ)
        local distance2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, slaughterX2, slaughterY2, slaughterZ2)
        local distance3 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, packageX, packageY, packageZ)
        local distance4 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, packageX2, packageY2, packageZ2)

        --if distance1 <= 25.0 then
            DrawMarker(27, slaughterX, slaughterY, slaughterZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
            DrawMarker(27, slaughterX2, slaughterY2, slaughterZ2-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
            DrawMarker(27, packageX, packageY, packageZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
            DrawMarker(27, packageX2, packageY2, packageZ2-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
        --else
        --    Citizen.Wait(1500)
        --end

        if distance1 <= 2.5 then
            DrawText3D2(slaughterX, slaughterY, slaughterZ, "~g~[E]~w~ To portion the pig")
        end

        if distance1 <= 0.5 then
            if IsControlJustPressed(0, Keys['E']) then -- "E"
                portofchicken(1)
            end
        end

        if distance2 <= 2.5 then
            DrawText3D2(slaughterX2, slaughterY2, slaughterZ2, "~g~[E]~w~ To portion the pig")
        end

        if distance2 <= 0.5 then
            if IsControlJustPressed(0, Keys['E']) then -- "E"
                portofchicken(2)
            end
        end
        --
        if distance3 <= 2.5 and packing == 0 then
            DrawText3D2(packageX, packageY, packageZ, "~g~[E]~w~ To pack pig")
        elseif distance3 <= 2.5 and packing == 1 then
            DrawText3D2(packageX, packageY, packageZ, "~g~[G]~w~ To stop packing")
            DrawText3D2(packageX, packageY, packageZ+0.1, "~g~[E]~w~ To keep packing")
        end

		if distance3 <= 5.5 then
            if IsControlJustPressed(0, Keys['E']) then
                PackPigs(1)
            elseif IsControlJustPressed(0, Keys['G']) then
                stoppacking(1)
            end
        end

        if distance4 <= 2.5 and packing == 0 then
            DrawText3D2(packageX2, packageY2, packageZ2, "~g~[E]~w~ To pack pig")
        elseif distance4 <= 2.5 and packing == 1 then
            DrawText3D2(packageX2, packageY2, packageZ2, "~g~[G]~w~ To stop packing")
            DrawText3D2(packageX2, packageY2, packageZ2+0.1, "~g~[E]~w~ To keep packing")
        end

        if distance4 <= 0.5 then
            if IsControlJustPressed(0, Keys['E']) then -- "E"
                PackPigs(2)
            elseif IsControlJustPressed(0, Keys['G']) then
                stoppacking(2)
            end
        end
    end
end)

------

function stoppacking(position)
FreezeEntityPosition(GetPlayerPed(-1), false)
packeforacar = true
local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
proppig = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
packing = 0
while packeforacar do
Citizen.Wait(250)
local vehicle   = ESX.Game.GetVehicleInDirection()
local coords    = GetEntityCoords(GetPlayerPed(-1))
LoadDict('anim@heists@box_carry@')

	if not IsEntityPlayingAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 3 ) and packeforacar == true then
	TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	end
	
	if DoesEntityExist(vehicle) then
	packeforacar = false
	--ESX.ShowNotification("~y~Wkładasz pigi do samochodu.")
	exports['mythic_notify']:SendAlert('inform', 'You stored the pigs in the vehicle.')
	LoadDict('anim@heists@narcotics@trash')
	TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	Citizen.Wait(900)
	ClearPedTasks(GetPlayerPed(-1))
	DeleteEntity(proppig)
	end
end
end

function PackPigs(position)
local inventory = ESX.GetPlayerData().inventory
local count = 0
for i=1, #inventory, 1 do
	if inventory[i].name == 'slaughtered_pig' then
	count = inventory[i].count
	end
end
if(count > 0) then
	SetEntityHeading(GetPlayerPed(-1), 40.0)
	local PedCoords = GetEntityCoords(GetPlayerPed(-1))
	meat = CreateObject(GetHashKey('prop_cs_steak'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
	AttachEntityToEntity(meat, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0x49D9), 0.15, 0.0, 0.01, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
	cardboard = CreateObject(GetHashKey('prop_cs_clothes_box'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
	AttachEntityToEntity(cardboard, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.13, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
	packing = 1
	LoadDict("anim@heists@ornate_bank@grab_cash_heels")
	TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	Citizen.Wait(6500)
	TriggerServerEvent("tostpigi:przerob2",2)
	--ESX.ShowNotification("~y~Pakuj pigi dalej lub udaj się do pojazdu.")
	exports['mythic_notify']:SendAlert('inform', 'Keep packing the pig or go to the vehicle and store it.')
	ClearPedTasks(GetPlayerPed(-1))
	DeleteEntity(cardboard)
	DeleteEntity(meat)
else
--ESX.ShowNotification("~y~Nie masz nic do zapakowania.")
exports['mythic_notify']:SendAlert('error', 'You have nothing to pack!')
end
end
------
function portofchicken(position)
local inventory = ESX.GetPlayerData().inventory
local count = 0
for i=1, #inventory, 1 do
	if inventory[i].name == 'alive_pig' then
	count = inventory[i].count
	end
end
if(count > 0) then	
local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
LoadDict(dict)
FreezeEntityPosition(GetPlayerPed(-1),true)
TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
local PedCoords = GetEntityCoords(GetPlayerPed(-1))
something1 = CreateObject(GetHashKey('prop_knife'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
AttachEntityToEntity(something1, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xDEAD), 0.13, 0.14, 0.09, 40.0, 0.0, 0.0, false, false, false, false, 2, true)
if position == 1 then
SetEntityHeading(GetPlayerPed(-1), 311.0)
pig = CreateObject(GetHashKey('prop_int_cf_chick_01'),-94.87, 6207.008, 30.08, true, true, true)
SetEntityRotation(pig,90.0, 0.0, 45.0, 1,true)
elseif position == 2 then
SetEntityHeading(GetPlayerPed(-1), 222.0)
pig = CreateObject(GetHashKey('prop_int_cf_chick_01'),-100.39, 6201.56, 29.99, true, true, true)
SetEntityRotation(pig,90.0, 0.0, -45.0, 1,true)
end
Citizen.Wait(5000)
--ESX.ShowNotification("~g~Poćwiartowałeś piga.")
exports['mythic_notify']:SendAlert('inform', 'You slaughtered a pig!')
FreezeEntityPosition(GetPlayerPed(-1),false)
DeleteEntity(pig)
DeleteEntity(something1)
ClearPedTasks(GetPlayerPed(-1))
TriggerServerEvent("tostpigi:przerob2",1)
else
--ESX.ShowNotification("~y~Nie masz pigów.")
exports['mythic_notify']:SendAlert('error', 'You dont have any pigs!')
end
end


function pinexit()
DoScreenFadeOut(500)
Citizen.Wait(500)
SetEntityCoordsNoOffset(GetPlayerPed(-1), startX+2, startY+2, startZ, 0, 0, 1)
if DoesEntityExist(pig1) or DoesEntityExist(pig2) or DoesEntityExist(pig3) then
DeleteEntity(pig1)
DeleteEntity(pig2)
DeleteEntity(pig3)
end
Citizen.Wait(500)
DoScreenFadeIn(500)

local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
proppig = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
						
local givecars = true

while givecars do
Citizen.Wait(250)
local vehicle   = ESX.Game.GetVehicleInDirection()
local coords    = GetEntityCoords(GetPlayerPed(-1))
LoadDict('anim@heists@box_carry@')

	if not IsEntityPlayingAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 3 ) and givecars == true then
	TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	end
	
	if DoesEntityExist(vehicle) then
	givecars = false
	--ESX.ShowNotification("~y~Wkładasz pigi do samochodu.")
	exports['mythic_notify']:SendAlert('inform', 'You put the pig in the vehicle!')
	LoadDict('anim@heists@narcotics@trash')
	TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	Citizen.Wait(900)
	ClearPedTasks(GetPlayerPed(-1))
	DeleteEntity(proppig)
	TriggerServerEvent("tost:wkladajKurczki2")
	end
end



end

function catchchicken()
DoScreenFadeOut(500)
Citizen.Wait(500)
SetEntityCoordsNoOffset(GetPlayerPed(-1), 2187.673,4978.846,41.441, 0, 0, 1)
RequestModel(GetHashKey('a_c_pig'))
while not HasModelLoaded(GetHashKey('a_c_pig')) do
Wait(1)
end
pig1 = CreatePed(26, "a_c_pig", 2186.3889160156,4964.1103515625,41.287548065186, 49.939, true, false)

pig2 = CreatePed(26, "a_c_pig", 2166.9494628906,4971.1884765625,41.373683929443, 197.279, true, false)
pig3 = CreatePed(26, "a_c_pig", 2163.5041503906,4954.1103515625,41.416160583496, 302.730, true, false)
TaskReactAndFleePed(pig1, GetPlayerPed(-1))
TaskReactAndFleePed(pig2, GetPlayerPed(-1))
TaskReactAndFleePed(pig3, GetPlayerPed(-1))
Citizen.Wait(500)
DoScreenFadeIn(500)
share = true
end
-----
function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(5)
	
if share == true then
	local pig1Coords = GetEntityCoords(pig1)
	local pig2Coords = GetEntityCoords(pig2)
	local pig3Coords = GetEntityCoords(pig3)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pig1Coords.x, pig1Coords.y, pig1Coords.z)
	local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pig2Coords.x, pig2Coords.y, pig2Coords.z)
	local dist3 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pig3Coords.x, pig3Coords.y, pig3Coords.z)
	
	if numbercaught == 3 then
	caught1 = 0
	caught2 = 0
	caught3 = 0
	numbercaught = 0
	share = false
	--ESX.ShowNotification("~g~Udaj się z pigami do pojazdu.")
	exports['mythic_notify']:SendAlert('inform', 'Take the pigs to the vehicle!')
	pinexit()
	end
	
	if dist <= 1.0 then
	DrawText3D2(pig1Coords.x, pig1Coords.y, pig1Coords.z+0.5, "~o~[E]~b~ Catch the pig")
		if IsControlJustPressed(0, Keys['E']) then 
		caught1 = 1
		pigcaught()
		end	
	elseif dist2 <= 1.0 then
		DrawText3D2(pig2Coords.x, pig2Coords.y, pig2Coords.z+0.5, "~o~[E]~b~ Catch the pig")
		if IsControlJustPressed(0, Keys['E']) then 
		caught2 = 1
		pigcaught()
		end	
	elseif dist3 <= 1.0 then
		DrawText3D2(pig3Coords.x, pig3Coords.y, pig3Coords.z+0.5, "~o~[E]~b~ Catch the pig")
		if IsControlJustPressed(0, Keys['E']) then 
		caught3 = 1
		pigcaught()
		end	
	end
else
Citizen.Wait(500)
end	
end
end)

local ragdoll = false

function pigcaught()
	LoadDict('move_jump')
	TaskPlayAnim(GetPlayerPed(-1), 'move_jump', 'dive_start_run', 8.0, -8.0, -1, 0, 0.0, 0, 0, 0)
	Citizen.Wait(600)
	SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
	Citizen.Wait(1000)
	ragdoll = true
	local chanceofcatch = math.random(1,100)
	if chanceofcatch <= 60 then
			exports['mythic_notify']:SendAlert('success', 'You managed to catch 1 pig!')
			if caught1 == 1 then
				DeleteEntity(pig1)
				caught1 = 0
				numbercaught = numbercaught +1
			elseif caught2 == 1 then
				DeleteEntity(pig2)
				caught2 = 0
				numbercaught = numbercaught +1
			elseif caught3 == 1 then
				DeleteEntity(pig3)
				caught3 = 0
				numbercaught = numbercaught +1
			end
		else
		exports['mythic_notify']:SendAlert('error', 'The pig escaped your arms!')
	end
end


Citizen.CreateThread(function()
    while true do
	Citizen.Wait(0)
		if ragdoll then
			SetEntityHealth(PlayerPedId(), 200)
			TriggerEvent('mythic_hospital:client:ResetLimbs')
            TriggerEvent('mythic_hospital:client:RemoveBleed')
			ragdoll = false
		end
	end
end)

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(5)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, sellX, sellY, sellZ)
	
	if dist <= 20.0 then
	DrawMarker(27, sellX, sellY, sellZ-0.96, 0, 0, 0, 0, 0, 0, 2.20, 2.20, 2.20, 255, 255, 255, 200, 0, 0, 0, 0)
	else
	Citizen.Wait(1000)
	end
	
	if dist <= 2.0 then
	DrawText3D2(sellX, sellY, sellZ+0.1, "[E] Sell Packed Pig")
		if IsControlJustPressed(0, Keys['E']) then 
		Sellpigi()
		end	
	end
	
end
end)

function Sellpigi()
local inventory = ESX.GetPlayerData().inventory
local count = 0
for i=1, #inventory, 1 do
	if inventory[i].name == 'packaged_pig' then
	count = inventory[i].count
	end
end
if(count > 0) then
local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.9, -0.98))
proppig = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z,  true,  true, true)
SetEntityHeading(prop, GetEntityHeading(GetPlayerPed(-1)))
LoadDict('amb@medic@standing@tendtodead@idle_a')
TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
Citizen.Wait(6500)
LoadDict('amb@medic@standing@tendtodead@exit')
TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@exit', 'exit', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
Citizen.Wait(1900)
ClearPedTasks(GetPlayerPed(-1))
DeleteEntity(proppig)
TriggerServerEvent("tostpigi:przerob2",3)
else
--ESX.ShowNotification("~r~Nie masz nic na sprzedaż")
exports['mythic_notify']:SendAlert('error', 'You have nothing to sell!')
end
end
