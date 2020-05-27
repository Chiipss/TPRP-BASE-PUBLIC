-------------------------
--Written by Tościk#9715-
-------------------------
------------------CONFIG----------------------
local startX = 2388.725  --miejsce lapania kurczakow
local startY = 5044.985
local startZ = 46.304
---------------------------------------------
local przetworniaX = -96.007   --punkt na przetwarzanie 1
local przetworniaY = 6206.92
local przetworniaZ = 31.02
---
local przetworniaX2 = -100.64   --punkt na przetwarzanie 2
local przetworniaY2 = 6202.30
local przetworniaZ2 = 31.02
---
local pakowanieX = -106.44    --punkt pakowania 1
local pakowanieY = 6204.29
local pakowanieZ = 31.02
---
local pakowanieX2 = -104.20   --punkt pakowania 2
local pakowanieY2 = 6206.45
local pakowanieZ2 = 31.02
---
local sellX = -1177.17    --punkt sprzedazy
local sellY = -890.68
local sellZ = 13.79


---------------------------------------------
--------tego lepiej nie ruszaj ponizej-------
---------------------------------------------
local kurczak1
local kurczak2
local kurczak3
local Zlapany1 = 0
local Zlapany2 = 0
local Zlapany3 = 0
local Ilosczlapanych = 0
local akcja = false
local prop
local zapakowaneDoauta = false
local karton
local mieso
local pakuje = 0
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
local lapaniek = AddBlipForCoord(startX, startY, startZ)
    SetBlipSprite (lapaniek, 126)
    SetBlipDisplay(lapaniek, 4)
    SetBlipScale  (lapaniek, 0.6)
    SetBlipColour (lapaniek, 46)
    SetBlipAsShortRange(lapaniek, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Chicken Farm')
    EndTextCommandSetBlipName(lapaniek)
local rzeznia = AddBlipForCoord(przetworniaX, przetworniaY, przetworniaZ)
    SetBlipSprite (rzeznia, 273)
    SetBlipDisplay(rzeznia, 4)
    SetBlipScale  (rzeznia, 0.7)
    SetBlipColour (rzeznia, 46)
    SetBlipAsShortRange(rzeznia, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Slaughterhouse')
    EndTextCommandSetBlipName(rzeznia)
local skupk = AddBlipForCoord(sellX, sellY, sellZ)
    SetBlipSprite (skupk, 478)
    SetBlipDisplay(skupk, 4)
    SetBlipScale  (skupk, 0.6)
    SetBlipColour (skupk, 46)
    SetBlipAsShortRange(skupk, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Chicken Dealer')
    EndTextCommandSetBlipName(skupk)
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
		DrawText3D2(startX, startY, startZ, "~g~[E]~w~ To start catching chickens")
		end
--
		if dist <= 0.5 then
			if IsControlJustPressed(0, Keys['E']) then -- "E"
			LapKurczaka()
			end			
		end
	end
end)
-------Przerabianie
Citizen.CreateThread(function()
    while true do
	Citizen.Wait(0)
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, przetworniaX, przetworniaY, przetworniaZ)
		local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, przetworniaX2, przetworniaY2, przetworniaZ2)
		local distP = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pakowanieX, pakowanieY, pakowanieZ)
		local distP2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pakowanieX2, pakowanieY2, pakowanieZ2)

		if dist <= 25.0 then
		DrawMarker(27, przetworniaX, przetworniaY, przetworniaZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
		DrawMarker(27, przetworniaX2, przetworniaY2, przetworniaZ2-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
		DrawMarker(27, pakowanieX, pakowanieY, pakowanieZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
		DrawMarker(27, pakowanieX2, pakowanieY2, pakowanieZ2-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
		else
		Citizen.Wait(1500)
		end
		
		if dist <= 2.5 then
		DrawText3D2(przetworniaX, przetworniaY, przetworniaZ, "~g~[E]~w~ To portion the chicken")
		end

		if dist <= 0.5 then
			if IsControlJustPressed(0, Keys['E']) then -- "E"
			PorcjujKurczaka(1)
			end			
		end
		
		if dist2 <= 2.5 then
		DrawText3D2(przetworniaX2, przetworniaY2, przetworniaZ2, "~g~[E]~w~ To portion the chicken")
		end

		if dist2 <= 0.5 then
			if IsControlJustPressed(0, Keys['E']) then -- "E"
			PorcjujKurczaka(2)
			end			
		end
		--
		if distP <= 2.5 and pakuje == 0 then
		DrawText3D2(pakowanieX, pakowanieY, pakowanieZ, "~g~[E]~w~ To pack chicken")
		elseif distP <= 2.5 and pakuje == 1 then
		DrawText3D2(pakowanieX, pakowanieY, pakowanieZ, "~g~[G]~w~ To stop packing")
		DrawText3D2(pakowanieX, pakowanieY, pakowanieZ+0.1, "~g~[E]~w~ To keep packing")
		end

		if distP <= 0.5 then
			if IsControlJustPressed(0, Keys['E']) then 
			PakujKurczaka(1)
			elseif IsControlJustPressed(0, Keys['G']) then
			PrzestanPakowac(1)
			end			
		end
		
		if distP2 <= 2.5 and pakuje == 0 then
		DrawText3D2(pakowanieX2, pakowanieY2, pakowanieZ2, "~g~[E]~w~ To pack chicken")
		elseif distP2 <= 2.5 and pakuje == 1 then
		DrawText3D2(pakowanieX2, pakowanieY2, pakowanieZ2, "~g~[G]~w~ To stop packing")
		DrawText3D2(pakowanieX2, pakowanieY2, pakowanieZ2+0.1, "~g~[E]~w~ To keep packing")
		end

		if distP2 <= 0.5 then
			if IsControlJustPressed(0, Keys['E']) then -- "E"
			PakujKurczaka(2)
			elseif IsControlJustPressed(0, Keys['G']) then
			PrzestanPakowac(2)
			end		
		end	
	end
end)
------

function PrzestanPakowac(stanowisko)
FreezeEntityPosition(GetPlayerPed(-1), false)
zapakowaneDoauta = true
local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
pakuje = 0
while zapakowaneDoauta do
Citizen.Wait(250)
local vehicle   = ESX.Game.GetVehicleInDirection()
local coords    = GetEntityCoords(GetPlayerPed(-1))
LoadDict('anim@heists@box_carry@')

	if not IsEntityPlayingAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 3 ) and zapakowaneDoauta == true then
	TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	end
	
	if DoesEntityExist(vehicle) then
	zapakowaneDoauta = false
	--ESX.ShowNotification("~y~Wkładasz kurczaki do samochodu.")
	exports['mythic_notify']:SendAlert('inform', 'You stored the chickens in the vehicle.')
	LoadDict('anim@heists@narcotics@trash')
	TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	Citizen.Wait(900)
	ClearPedTasks(GetPlayerPed(-1))
	DeleteEntity(prop)
	end
end
end

function PakujKurczaka(stanowisko)
local inventory = ESX.GetPlayerData().inventory
local count = 0
for i=1, #inventory, 1 do
	if inventory[i].name == 'slaughtered_chicken' then
	count = inventory[i].count
	end
end
if(count > 0) then
	SetEntityHeading(GetPlayerPed(-1), 40.0)
	local PedCoords = GetEntityCoords(GetPlayerPed(-1))
	mieso = CreateObject(GetHashKey('prop_cs_steak'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
	AttachEntityToEntity(mieso, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0x49D9), 0.15, 0.0, 0.01, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
	karton = CreateObject(GetHashKey('prop_cs_clothes_box'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
	AttachEntityToEntity(karton, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.13, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
	pakuje = 1
	LoadDict("anim@heists@ornate_bank@grab_cash_heels")
	TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	Citizen.Wait(6500)
	TriggerServerEvent("tostKurczaki:przerob",2)
	--ESX.ShowNotification("~y~Pakuj kurczaki dalej lub udaj się do pojazdu.")
	exports['mythic_notify']:SendAlert('inform', 'Keep packing the chicken or go to the vehicle and store it.')
	ClearPedTasks(GetPlayerPed(-1))
	DeleteEntity(karton)
	DeleteEntity(mieso)
else
--ESX.ShowNotification("~y~Nie masz nic do zapakowania.")
exports['mythic_notify']:SendAlert('error', 'You have nothing to pack!')
end
end
------
function PorcjujKurczaka(stanowisko)
local inventory = ESX.GetPlayerData().inventory
local count = 0
for i=1, #inventory, 1 do
	if inventory[i].name == 'alive_chicken' then
	count = inventory[i].count
	end
end
if(count > 0) then	
local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
LoadDict(dict)
FreezeEntityPosition(GetPlayerPed(-1),true)
TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
local PedCoords = GetEntityCoords(GetPlayerPed(-1))
nozyk = CreateObject(GetHashKey('prop_knife'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
AttachEntityToEntity(nozyk, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xDEAD), 0.13, 0.14, 0.09, 40.0, 0.0, 0.0, false, false, false, false, 2, true)
if stanowisko == 1 then
SetEntityHeading(GetPlayerPed(-1), 311.0)
kurczak = CreateObject(GetHashKey('prop_int_cf_chick_01'),-94.87, 6207.008, 30.08, true, true, true)
SetEntityRotation(kurczak,90.0, 0.0, 45.0, 1,true)
elseif stanowisko == 2 then
SetEntityHeading(GetPlayerPed(-1), 222.0)
kurczak = CreateObject(GetHashKey('prop_int_cf_chick_01'),-100.39, 6201.56, 29.99, true, true, true)
SetEntityRotation(kurczak,90.0, 0.0, -45.0, 1,true)
end
Citizen.Wait(5000)
--ESX.ShowNotification("~g~Poćwiartowałeś kurczaka.")
exports['mythic_notify']:SendAlert('inform', 'You slaughtered a chicken!')
FreezeEntityPosition(GetPlayerPed(-1),false)
DeleteEntity(kurczak)
DeleteEntity(nozyk)
ClearPedTasks(GetPlayerPed(-1))
TriggerServerEvent("tostKurczaki:przerob",1)
else
--ESX.ShowNotification("~y~Nie masz kurczaków.")
exports['mythic_notify']:SendAlert('error', 'You dont have any chickens!')
end
end


function TepnijWyjscie()
DoScreenFadeOut(500)
Citizen.Wait(500)
SetEntityCoordsNoOffset(GetPlayerPed(-1), startX+2, startY+2, startZ, 0, 0, 1)
if DoesEntityExist(kurczak1) or DoesEntityExist(kurczak2) or DoesEntityExist(kurczak3) then
DeleteEntity(kurczak1)
DeleteEntity(kurczak2)
DeleteEntity(kurczak3)
end
Citizen.Wait(500)
DoScreenFadeIn(500)

local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
						
local dajdoAuta = true

while dajdoAuta do
Citizen.Wait(250)
local vehicle   = ESX.Game.GetVehicleInDirection()
local coords    = GetEntityCoords(GetPlayerPed(-1))
LoadDict('anim@heists@box_carry@')

	if not IsEntityPlayingAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 3 ) and dajdoAuta == true then
	TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	end
	
	if DoesEntityExist(vehicle) then
	dajdoAuta = false
	--ESX.ShowNotification("~y~Wkładasz kurczaki do samochodu.")
	exports['mythic_notify']:SendAlert('inform', 'You put the chicken in the vehicle!')
	LoadDict('anim@heists@narcotics@trash')
	TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	Citizen.Wait(900)
	ClearPedTasks(GetPlayerPed(-1))
	DeleteEntity(prop)
	TriggerServerEvent("tost:wkladajKurczki")
	end
end



end

function LapKurczaka()
DoScreenFadeOut(500)
Citizen.Wait(500)
SetEntityCoordsNoOffset(GetPlayerPed(-1), 2385.963, 5047.333, 46.400, 0, 0, 1)
RequestModel(GetHashKey('a_c_hen'))
while not HasModelLoaded(GetHashKey('a_c_hen')) do
Wait(1)
end
kurczak1 = CreatePed(26, "a_c_hen", 2370.262, 5052.913, 46.437, 276.351, true, false)

kurczak2 = CreatePed(26, "a_c_hen", 2372.040, 5059.604, 46.444, 223.595, true, false)
kurczak3 = CreatePed(26, "a_c_hen", 2379.192, 5062.992, 46.444, 195.477, true, false)
TaskReactAndFleePed(kurczak1, GetPlayerPed(-1))
TaskReactAndFleePed(kurczak2, GetPlayerPed(-1))
TaskReactAndFleePed(kurczak3, GetPlayerPed(-1))
Citizen.Wait(500)
DoScreenFadeIn(500)
akcja = true
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
	
if akcja == true then
	local kurczak1Coords = GetEntityCoords(kurczak1)
	local kurczak2Coords = GetEntityCoords(kurczak2)
	local kurczak3Coords = GetEntityCoords(kurczak3)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, kurczak1Coords.x, kurczak1Coords.y, kurczak1Coords.z)
	local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, kurczak2Coords.x, kurczak2Coords.y, kurczak2Coords.z)
	local dist3 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, kurczak3Coords.x, kurczak3Coords.y, kurczak3Coords.z)
	
	if Ilosczlapanych == 3 then
	Zlapany1 = 0
	Zlapany2 = 0
	Zlapany3 = 0
	Ilosczlapanych = 0
	akcja = false
	--ESX.ShowNotification("~g~Udaj się z kurczakami do pojazdu.")
	exports['mythic_notify']:SendAlert('inform', 'Take the chickens to the vehicle!')
	TepnijWyjscie()
	end
	
	if dist <= 1.0 then
	DrawText3D2(kurczak1Coords.x, kurczak1Coords.y, kurczak1Coords.z+0.5, "~o~[E]~b~ Catch the chicken")
		if IsControlJustPressed(0, Keys['E']) then 
		Zlapany1 = 1
		ZostalZlapany()
		end	
	elseif dist2 <= 1.0 then
		DrawText3D2(kurczak2Coords.x, kurczak2Coords.y, kurczak2Coords.z+0.5, "~o~[E]~b~ Catch the chicken")
		if IsControlJustPressed(0, Keys['E']) then 
		Zlapany2 = 1
		ZostalZlapany()
		end	
	elseif dist3 <= 1.0 then
		DrawText3D2(kurczak3Coords.x, kurczak3Coords.y, kurczak3Coords.z+0.5, "~o~[E]~b~ Catch the chicken")
		if IsControlJustPressed(0, Keys['E']) then 
		Zlapany3 = 1
		ZostalZlapany()
		end	
	end
else
Citizen.Wait(500)
end	
end
end)

local ragdoll = false

function ZostalZlapany()
	LoadDict('move_jump')
	TaskPlayAnim(GetPlayerPed(-1), 'move_jump', 'dive_start_run', 8.0, -8.0, -1, 0, 0.0, 0, 0, 0)
	Citizen.Wait(600)
	SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
	Citizen.Wait(1000)
	ragdoll = true
	local szansaZlapania = math.random(1,100)
	if szansaZlapania <= 60 then
			exports['mythic_notify']:SendAlert('success', 'You managed to catch 1 chicken!')
			if Zlapany1 == 1 then
				DeleteEntity(kurczak1)
				Zlapany1 = 0
				Ilosczlapanych = Ilosczlapanych +1
			elseif Zlapany2 == 1 then
				DeleteEntity(kurczak2)
				Zlapany2 = 0
				Ilosczlapanych = Ilosczlapanych +1
			elseif Zlapany3 == 1 then
				DeleteEntity(kurczak3)
				Zlapany3 = 0
				Ilosczlapanych = Ilosczlapanych +1
			end
		else
		exports['mythic_notify']:SendAlert('error', 'The chicken escaped your arms!')
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
	DrawText3D2(sellX, sellY, sellZ+0.1, "[E] Sell Packed Chickens")
		if IsControlJustPressed(0, Keys['E']) then 
		SellKurczaki()
		end	
	end
	
end
end)

function SellKurczaki()
local inventory = ESX.GetPlayerData().inventory
local count = 0
for i=1, #inventory, 1 do
	if inventory[i].name == 'packaged_chicken' then
	count = inventory[i].count
	end
end
if(count > 0) then
local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.9, -0.98))
prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z,  true,  true, true)
SetEntityHeading(prop, GetEntityHeading(GetPlayerPed(-1)))
LoadDict('amb@medic@standing@tendtodead@idle_a')
TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
Citizen.Wait(6500)
LoadDict('amb@medic@standing@tendtodead@exit')
TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@exit', 'exit', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
Citizen.Wait(1900)
ClearPedTasks(GetPlayerPed(-1))
DeleteEntity(prop)
TriggerServerEvent("tostKurczaki:przerob",3)
else
--ESX.ShowNotification("~r~Nie masz nic na sprzedaż")
exports['mythic_notify']:SendAlert('error', 'You have nothing to sell!')
end
end
