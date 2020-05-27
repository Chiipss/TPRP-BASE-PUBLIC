players = {}
banlist = {}

local index = 0

local frozen = false
local enable = false

RegisterNetEvent("PURGEadmin:fillBanlist")
RegisterNetEvent("PURGEadmin:requestSpectate")

RegisterNetEvent("PURGEadmin:TeleportRequest")
RegisterNetEvent("PURGEadmin:SlapPlayer")
RegisterNetEvent("PURGEadmin:FreezePlayer")

RegisterNetEvent("PURGEadmin:ClientAnnouncement")

RegisterNetEvent("PURGEadmin:ClientStaffNotification")

RegisterNetEvent("PURGEadmin:screenshotClient")

AddEventHandler("PURGEadmin:fillBanlist", function(thebanlist)
	banlist = thebanlist
end)

AddEventHandler("PURGEadmin:requestSpectate", function(playerId)
	spectatePlayer(GetPlayerPed(playerId),playerId,GetPlayerName(playerId))
end)

AddEventHandler("PURGEadmin:TeleportRequest", function(px, py, pz, heading)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped, true) then
		DeleteEntity(GetVehiclePedIsIn(ped, false))
	end
	SetEntityCoords(ped, px, py, pz)
	SetEntityHeading(ped, heading)
end)

AddEventHandler("PURGEadmin:SlapPlayer", function(slapAmount)
	if slapAmount > GetEntityHealth(PlayerPedId()) then
		SetEntityHealth(PlayerPedId(), 0)
	else
		SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId())-slapAmount)
	end
end)

AddEventHandler("PURGEadmin:FreezePlayer", function(toggle)
	frozen = toggle
	if not noclipActive then
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), false), frozen)
		else
			FreezeEntityPosition(PlayerPedId(), frozen)
		end
	end
end)

AddEventHandler("PURGEadmin:ClientAnnouncement", function(text)
	announcestring = text
	PlaySoundFrontend(-1, "DELETE","HUD_DEATHMATCH_SOUNDSET", 1)
	Citizen.Wait(6000)
	announcestring = false
end)

AddEventHandler("PURGEadmin:ClientStaffNotification", function(payload)
	ShowStaffNotification(payload)
end)

AddEventHandler("PURGEadmin:screenshotClient", function(taker)
	exports["screenshot-basic"]:requestScreenshotUpload("https://54.39.130.48/up.php", "files[]", function(data)
		local decodedData = json.decode(data)
		local result = decodedData.success
		local size = decodedData.files[1].size
		local URL = decodedData.files[1].url
		TriggerServerEvent("PURGEadmin:screenshotTodiscord", taker, result, size, URL)
	end)
end)

function spectatePlayer(targetPed, target, name)
	local playerPed = PlayerPedId()
	enable = not enable
 	if targetPed == playerPed then 
		enable = false 
		ShowNotification("~r~ERROR ~w~: You cannot spectated yourself.")
		return
	end

	if enable then
		local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
		RequestCollisionAtCoord(targetx,targety,targetz)
		NetworkSetInSpectatorMode(true, targetPed)
		ShowNotification("Spectating ~g~"..name.."~w~!")
		--TriggerEvent("TokoVoip:updateVoipTargetPed", targetPed, true) -- activate the spectate
		exports.tokovoip_script:updateVoipTargetPed(targetPed, false)
	else
		local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
		RequestCollisionAtCoord(targetx,targety,targetz)
		NetworkSetInSpectatorMode(false, targetPed)
		ShowNotification("Stopped Spectating ~r~"..name.."~w~!")
		--TriggerEvent("TokoVoip:updateVoipTargetPed", playerPed, false) -- deactivate the spectate
		exports.tokovoip_script:updateVoipTargetPed(playerPed, true)
	end
end

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(0, 1)
end

function ShowStaffNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationMessage("CHAR_BLOCKED", "CHAR_BLOCKED", true, 1, "Staff Alert!")
    DrawNotification(false, true)
end

function initializeScaleform(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(100)
    end
    PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
	PushScaleformMovieFunctionParameterString("~y~Announcement")
    PushScaleformMovieFunctionParameterString(announcestring)
    PopScaleformMovieFunctionVoid()
    return scaleform
end