ESX              = nil
local PlayerData = {}

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


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if NetworkIsSessionStarted() then
            Citizen.Wait(500)
           	TriggerServerEvent("st-scoreboard:AddPlayer")
			TriggerEvent("kashactersC:WelcomePage")
            TriggerEvent("kashactersC:SetupCharacters")
            return -- break the loop
        end
    end
end)

local IsChoosing = true
Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(0)
		if IsChoosing then
			TriggerScreenblurFadeIn(0)
		end

		for i=1, #Config.Logouts, 1 do
			local player = GetPlayerPed(-1)
			local playerloc = GetEntityCoords(player, 0)
			local logoutspot = Config.Logouts[i]
			local logoutdistance = GetDistanceBetweenCoords(logoutspot['x'], logoutspot['y'], logoutspot['z'], playerloc['x'], playerloc['y'], playerloc['z'], true)
			if logoutdistance <= 8 then
				DrawText3Ds(logoutspot.x,logoutspot.y,logoutspot.z + 0.10, "type /logout to swap characters.")
			end
		end
	end
end)

Citizen.CreateThread(function()

	for i=1, #Config.Logouts, 1 do
		local logoutspot = Config.Logouts[i]
		local blip = AddBlipForCoord(logoutspot)

		SetBlipSprite(blip, 480)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 4)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Switch Characters")
		EndTextCommandSetBlipName(blip)
	end
end)

local cam = nil
local cam2 = nil
RegisterNetEvent('kashactersC:SetupCharacters')
AddEventHandler('kashactersC:SetupCharacters', function()
    SetTimecycleModifier('hud_def_blur')
    FreezeEntityPosition(GetPlayerPed(-1), true)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 256.32,-1055.71,369.89, 300.00,0.00,0.00, 100.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
end)

RegisterNetEvent('kashactersC:WelcomePage')
AddEventHandler('kashactersC:WelcomePage', function()
    SetNuiFocus(true, true)
	SendNUIMessage({
        action = "openwelcome"
    })
end)

RegisterNetEvent('kashactersC:SetupUI')
AddEventHandler('kashactersC:SetupUI', function(Characters)
	IsChoosing = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openui",
        characters = Characters,
    })
end)

RegisterNetEvent('kashactersC:Logout')
AddEventHandler('kashactersC:Logout', function(plyr)
	for i=1, #Config.Logouts, 1 do
		local player = GetPlayerPed(-1)
		local playerloc = GetEntityCoords(player, 0)
		local logoutspot = Config.Logouts[i]
		local logoutdistance = GetDistanceBetweenCoords(logoutspot['x'], logoutspot['y'], logoutspot['z'], playerloc['x'], playerloc['y'], playerloc['z'], true)

		if logoutdistance <= 3 then
			TriggerEvent('kashactersC:ReloadCharacters')
		else
			exports['mythic_notify']:SendAlert('error', "You cannot logout here.")
		end
	end
end)

RegisterNetEvent('kashactersC:SpawnCharacter')
AddEventHandler('kashactersC:SpawnCharacter', function(spawn, isnew)
	TriggerServerEvent('es:firstJoinProper')
	TriggerEvent('es:allowedToSpawn')
	Citizen.Wait(3700)
	if isnew then
		IsChoosing = false
		TriggerScreenblurFadeOut(0)
		TriggerEvent('esx_identity:showRegisterIdentity')
		SendNUIMessage({
        action = "displayback"
		})
		SetTimecycleModifier('default')
		FreezeEntityPosition(GetPlayerPed(-1), true)
		cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 256.32,-1055.71,369.89, 300.00,0.00,0.00, 100.00, false, 0)
		SetCamActive(cam, true)
		RenderScriptCams(true, false, 1, true, true)
	else
		--TriggerServerEvent('es:firstJoinProper')
		--TriggerEvent('es:allowedToSpawn')
		SetTimecycleModifier('default')
		local pos = spawn
		SetEntityCoords(GetPlayerPed(-1), pos.x, pos.y, pos.z)
		DoScreenFadeIn(2250)
		--Citizen.Wait(500)
		--cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1355.93,-1487.78,520.75, 300.00,0.00,0.00, 100.00, false, 0)
		--PointCamAtCoord(cam2, pos.x,pos.y,pos.z+200)
		--SetCamActiveWithInterp(cam2, cam, 900, true, true)
		--Citizen.Wait(900)
	
		--cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x,pos.y,pos.z+200, 300.00,0.00,0.00, 100.00, false, 0)
		--PointCamAtCoord(cam, pos.x,pos.y,pos.z+2)
		--SetCamActiveWithInterp(cam, cam2, 3700, true, true)
		--Citizen.Wait(3700)
		PlaySoundFrontend(-1, "Zoom_Out", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
		RenderScriptCams(false, true, 0, true, true)
		PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
		FreezeEntityPosition(GetPlayerPed(-1), false)
		Citizen.Wait(500)
		SetCamActive(cam, false)
		DestroyCam(cam, true)
		IsChoosing = false
		DisplayHud(true)
		DisplayRadar(true)
		
		IsChoosing = false
		TriggerScreenblurFadeOut(0)
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
			if skin == nil then
				TriggerEvent('skinchanger:loadSkin', {sex = 0})
				TriggerServerEvent("clothing:checkIfNew")
			else
				TriggerEvent('skinchanger:loadSkin', skin)
			end
		end)
		--TriggerEvent('spawnselector:setNui')
	end
end)

RegisterNetEvent('kashactersC:ReloadCharacters')
AddEventHandler('kashactersC:ReloadCharacters', function()
    TriggerServerEvent("kashactersS:SetupCharacters")
    TriggerEvent("kashactersC:SetupCharacters")
end)

RegisterNUICallback("CharacterChosen", function(data, cb)
    SetNuiFocus(false,false)
    TriggerServerEvent('kashactersS:CharacterChosen', data.charid, data.ischar, data.spawnid or "1")
    cb("ok")
end)
RegisterNUICallback("DeleteCharacter", function(data, cb)
    SetNuiFocus(false,false)
    TriggerServerEvent('kashactersS:DeleteCharacter', data.charid)
    cb("ok")
end)
RegisterNUICallback("ShowSelection", function(data, cb)
	TriggerServerEvent("kashactersS:SetupCharacters")
end)

function DrawText3Ds(x,y,z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local p = GetGameplayCamCoords()
	local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
	local scale = (1 / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov
	if onScreen then
		SetTextScale(0.30, 0.30)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		local factor = (string.len(text)) / 370
		DrawRect(_x,_y+0.0120, factor, 0.026, 41, 11, 41, 68)
	end
end