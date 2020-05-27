-- Created by @murfasa https://forum.cfx.re/u/murfasa

local dogtoggle = false
local allowed = false
local passAce = false
local onAim = GetConvar("dog.onAim", "true")
local useAce = GetConvar("dog.useAce", "false")

-- Functions --
Citizen.CreateThread(function()
    if useAce == "true" then
        TriggerServerEvent("dog:checkRole")
    end
end)

RegisterNetEvent("dog:returnCheck")
AddEventHandler("dog:returnCheck", function(check)
    passAce = check
end)

local function checkRole()
    if useAce == "false" then
        allowed = true
        return allowed
    end
    if passAce == true then
        allowed = true
        return allowed
    end
end

local function getEntity(player) -- function To Get Entity Player Is Aiming At
	local _, entity = GetEntityPlayerIsFreeAimingAt(player)
	return entity
end

local function aimCheck(player) -- function to check config value onAim. If it's off, then
    if onAim == "true" then
        return true
    else
        return IsPedShooting(player)
    end
end

local function drawNotification(text) -- draws a notification box
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end
-- Functions --


RegisterCommand("delgun", function()
        checkRole()
        if allowed == true then
            if dogtoggle == false then
                dogtoggle = true
                drawNotification("~g~Delete Object Gun Enabled!")
            else
                dogtoggle = false
                drawNotification("~b~Delete Object Gun Disabled!")
            end
        else
            drawNotification("~r~You have insufficient permissions to activate the Delete Object Gun.")
        end
end, false)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if dogtoggle then
            if IsPlayerFreeAiming(PlayerId()) then
                local entity = getEntity(PlayerId())
                if GetEntityType(entity) == 2 or 3 then
                    if aimCheck(GetPlayerPed(-1)) then
                        SetEntityAsMissionEntity(entity, true, true)
                        DeleteEntity(entity)
                    end
                end
            end
        end
    end
end)