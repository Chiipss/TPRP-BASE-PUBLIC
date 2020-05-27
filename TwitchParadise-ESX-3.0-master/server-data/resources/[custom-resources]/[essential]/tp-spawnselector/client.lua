local ESX, selectedspawnposition = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) 
			ESX = obj 
		end)

		Citizen.Wait(0)
	end
end)

RegisterNUICallback("SpawnPlayer", function()
	if selectedspawnposition ~= nil then
		SpawnPlayer(selectedspawnposition)
    else
        print("You need to select a spawn point!")
        exports['mythic_notify']:SendAlert('error', 'You need to first select a spawn location.', 7000)
		-- Send a message to client here that they need to select a spawnpoint to be able to spawn.
	end
end)

--[[ RegisterCommand('spawn', function(source, args, rawCommand)
    TriggerEvent('spawnselector:setNui')
end)
 ]]
RegisterNUICallback("SpawnLast", function()
    local pos = Location
	SetNuiFocus(false, false)
    SetCamActiveWithInterp(cam, cam2, 3700, true, true)
	Citizen.Wait(0)

	PlaySoundFrontend(-1, "Zoom_In", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
    RenderScriptCams(false, true, 500, true, true)
    PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
    Citizen.Wait(0)

	SetEntityVisible(PlayerPedId(), true, 0)
	FreezeEntityPosition(PlayerPedId(), false)
    SetPlayerInvisibleLocally(PlayerPedId(), false)
    SetPlayerInvincible(PlayerPedId(), false)

    DestroyCam(startcam, false)
    DestroyCam(cam, false)
    DestroyCam(cam2, false)
    Citizen.Wait(0)
    FreezeEntityPosition(GetPlayerPed(-1), false)
    Citizen.Wait(500)
    SetNuiFocus(false, false)
end)

RegisterNUICallback("SpawnPinkcage", function()
    selectedspawnposition = { x = 326.29, y = -212.31, z = 55.08, h = 282.91 }

    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false, 0)
    SetEntityCoords(playerPed, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z)
    FreezeEntityPosition(playerPed, true)

    startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(startcam, -505.09, -1224.11, 232.2)
    SetCamActive(startcam, true)
    PointCamAtCoord(startcam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)
    PointCamAtCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+2)
    SetCamActiveWithInterp(cam, startcam, 3700, true, true)
    Citizen.Wait(3700)

    cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam2, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+1)
    PointCamAtCoord(cam2, selectedspawnposition.x+10, selectedspawnposition.y, selectedspawnposition.z)
    SetCamActiveWithInterp(cam2, cam, 900, true, true)
end)

RegisterNUICallback("SpawnBus", function()
    selectedspawnposition = { x = 454.349, y = -661.036, z = 27.6534, h = 282.91 }

    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false, 0)
    SetEntityCoords(playerPed, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z)
    FreezeEntityPosition(playerPed, true)

    startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(startcam, -505.09, -1224.11, 232.2)
    SetCamActive(startcam, true)
    PointCamAtCoord(startcam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)
    PointCamAtCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+2)
    SetCamActiveWithInterp(cam, startcam, 3700, true, true)
    Citizen.Wait(3700)

    cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam2, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+1)
    PointCamAtCoord(cam2, selectedspawnposition.x+10, selectedspawnposition.y, selectedspawnposition.z)
    SetCamActiveWithInterp(cam2, cam, 900, true, true)
end)

RegisterNUICallback("SpawnTrain", function()
    selectedspawnposition = { x = -206.674, y = -1015.1, z = 30.1381, h = 282.91 }

    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false, 0)
    SetEntityCoords(playerPed, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z)
    FreezeEntityPosition(playerPed, true)

    startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(startcam, -505.09, -1224.11, 232.2)
    SetCamActive(startcam, true)
    PointCamAtCoord(startcam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)
    PointCamAtCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+2)
    SetCamActiveWithInterp(cam, startcam, 3700, true, true)
    Citizen.Wait(3700)

    cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam2, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+1)
    PointCamAtCoord(cam2, selectedspawnposition.x+10, selectedspawnposition.y, selectedspawnposition.z)
    SetCamActiveWithInterp(cam2, cam, 900, true, true)
end)

RegisterNUICallback("SpawnLegion", function()
    selectedspawnposition = { x = 202.331, y = -931.175, z = 30.692, h = 198.452 }

    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false, 0)
    SetEntityCoords(playerPed, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z)
    FreezeEntityPosition(playerPed, true)

    startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(startcam, -505.09, -1224.11, 232.2)
    SetCamActive(startcam, true)
    PointCamAtCoord(startcam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)
    PointCamAtCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+2)
    SetCamActiveWithInterp(cam, startcam, 3700, true, true)
    Citizen.Wait(3700)

    cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam2, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+1)
    PointCamAtCoord(cam2, selectedspawnposition.x+10, selectedspawnposition.y, selectedspawnposition.z)
    SetCamActiveWithInterp(cam2, cam, 900, true, true)
end)

--[[ RegisterNUICallback("SpawnSandy", function()
    selectedspawnposition = { x = 1955.54, y = 3843.48, z = 32.0165, h = 282.91 }

    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false, 0)
    SetEntityCoords(playerPed, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z)
    FreezeEntityPosition(playerPed, true)

    startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(startcam, -505.09, -1224.11, 232.2)
    SetCamActive(startcam, true)
    PointCamAtCoord(startcam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)
    PointCamAtCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+2)
    SetCamActiveWithInterp(cam, startcam, 3700, true, true)
    Citizen.Wait(3700)

    cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam2, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+1)
    PointCamAtCoord(cam2, selectedspawnposition.x+10, selectedspawnposition.y, selectedspawnposition.z)
    SetCamActiveWithInterp(cam2, cam, 900, true, true)
end) ]]

--[[ RegisterNUICallback("SpawnPier", function()
    selectedspawnposition = { x = -1686.61, y = -1068.16, z = 13.1522, h = 282.91 }

    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false, 0)
    SetEntityCoords(playerPed, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z)
    FreezeEntityPosition(playerPed, true)

    startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(startcam, -505.09, -1224.11, 232.2)
    SetCamActive(startcam, true)
    PointCamAtCoord(startcam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)
    PointCamAtCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+2)
    SetCamActiveWithInterp(cam, startcam, 3700, true, true)
    Citizen.Wait(3700)

    cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam2, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+1)
    PointCamAtCoord(cam2, selectedspawnposition.x+10, selectedspawnposition.y, selectedspawnposition.z)
    SetCamActiveWithInterp(cam2, cam, 900, true, true)
end) ]]

--[[ RegisterNUICallback("SpawnVinewood", function()
    selectedspawnposition = { x = 280.571, y = 182.679, z = 104.504, h = 282.91 }

    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false, 0)
    SetEntityCoords(playerPed, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z)
    FreezeEntityPosition(playerPed, true)

    startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(startcam, -505.09, -1224.11, 232.2)
    SetCamActive(startcam, true)
    PointCamAtCoord(startcam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)
    PointCamAtCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+2)
    SetCamActiveWithInterp(cam, startcam, 3700, true, true)
    Citizen.Wait(3700)

    cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam2, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+1)
    PointCamAtCoord(cam2, selectedspawnposition.x+10, selectedspawnposition.y, selectedspawnposition.z)
    SetCamActiveWithInterp(cam2, cam, 900, true, true)
end) ]]

SpawnPlayer = function(Location)
	local pos = Location
	SetNuiFocus(false, false)
    SetCamActiveWithInterp(cam, cam2, 3700, true, true)
	--callback("ok")
	Citizen.Wait(0)

	PlaySoundFrontend(-1, "Zoom_In", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
    RenderScriptCams(false, true, 500, true, true)
    PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
    Citizen.Wait(0)

	SetEntityVisible(PlayerPedId(), true, 0)
	FreezeEntityPosition(PlayerPedId(), false)
    SetPlayerInvisibleLocally(PlayerPedId(), false)
    SetPlayerInvincible(PlayerPedId(), false)

    DestroyCam(startcam, false)
    DestroyCam(cam, false)
    DestroyCam(cam2, false)
    Citizen.Wait(0)
    FreezeEntityPosition(GetPlayerPed(-1), false)
	SetEntityCoords(PlayerPedId(), pos.x, pos.y, pos.z)
end

RegisterNetEvent("spawnselector:setNui")
AddEventHandler("spawnselector:setNui", function()
	SetNuiFocus(true, true)

	SendNUIMessage({
		["Action"] = "OPEN_SPAWNMENU"
	})
end)
