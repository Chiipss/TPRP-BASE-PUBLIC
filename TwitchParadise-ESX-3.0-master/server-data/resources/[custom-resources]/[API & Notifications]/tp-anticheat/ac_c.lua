ESX = nil
local isDead          = false
local instancewait    = false
local newmoney, money, bank, newbank = 0, 0, 0, 0
local anticheat       = true

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('bansql:anticheat')
AddEventHandler('bansql:anticheat', function(data)
	anticheat = data
end)

RegisterNetEvent('bansql:legitmoney')
AddEventHandler('bansql:legitmoney', function(data)
	money = money+data
end)

RegisterNetEvent('bansql:legitbank')
AddEventHandler('bansql:legitbank', function(data)
	bank = bank+data
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	TriggerEvent('esx_policejob:unrestrain')
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

BlacklistedWeapons = { -- weapons that will get people banned
	"WEAPON_BALL",
	"WEAPON_RAILGUN",
	"WEAPON_GARBAGEBAG",
}

CageObjs = {
	"prop_gold_cont_01",
	"p_cablecar_s",
	"stt_prop_stunt_tube_l",
	"stt_prop_stunt_track_dwuturn",
	"prop_cs1_14b_traind",
    "prop_cs1_14b_traind_dam",
}


Citizen.CreateThread(function()
	while true do
		Wait(30000)
		TriggerServerEvent("anticheese:timer")
	end
end)

AddEventHandler('instance:enter', function()
	instancewait = true
end)

AddEventHandler('instance:leave', function()
	instancewait = true
end)

Citizen.CreateThread(function()  --Tp/NoClip check
	Citizen.Wait(60000)
	while anticheat do
		Citizen.Wait(0)
		if not isDead then --Check only if player if a live

			if instancewait then
				Citizen.Wait(10000)
				instancewait = false
			else
				local ped = PlayerPedId()
				local posx,posy,posz = table.unpack(GetEntityCoords(ped,true))
				local still = IsPedStill(ped)
				local vel = GetEntitySpeed(ped)
				local ped = PlayerPedId()
				local veh = IsPedInAnyVehicle(ped, true)
				local speed = GetEntitySpeed(ped)
				local para = GetPedParachuteState(ped)
				local flyveh = IsPedInFlyingVehicle(ped)
				local rag = IsPedRagdoll(ped)
				local fall = IsPedFalling(ped)
				local parafall = IsPedInParachuteFreeFall(ped)
				SetEntityVisible(PlayerPedId(), true) -- make sure player is visible
				Wait(3000) -- wait 3 seconds and check again

				local more = speed - 9.0 -- avarage running speed is 7.06 so just incase someone runs a bit faster it wont trigger

				local rounds = tonumber(string.format("%.2f", speed))
				local roundm = tonumber(string.format("%.2f", more))


				if not IsEntityVisible(PlayerPedId()) then
					SetEntityHealth(PlayerPedId(), -100) -- if player is invisible kill him!
				end

				newx,newy,newz = table.unpack(GetEntityCoords(ped,true))
				newPed = PlayerPedId() -- make sure the peds are still the same, otherwise the player probably respawned
				if GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz) > 300 and still == IsPedStill(ped) and vel == GetEntitySpeed(ped) and ped == newPed and not instancewait then
					TriggerServerEvent("AntiCheese:NoclipFlag", GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz))
				end

				if speed > 9.0 and not veh and (para == -1 or para == 0) and not flyveh and not fall and not parafall and not rag and not instancewait then
					--dont activate this, its broken!
					--TriggerServerEvent("AntiCheese:SpeedFlag", rounds, roundm) -- send alert along with the rounded speed and how much faster they are
				end
			end
		end
	end
end)

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(data)
	newmoney = data
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) 
	money = xPlayer.money
	bank  = xPlayer.accounts[1].money
end)

Citizen.CreateThread(function() --Money Cheat check
	Citizen.Wait(60000)
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		Citizen.Wait(60000) -- wait 60 seconds and check again
		newbank = ESX.PlayerData.accounts[1].money
		if newmoney+newbank > money+bank+99999 then
			TriggerServerEvent("AntiCheese:MoneyFlag", (newmoney-money))
		end
		money = newmoney
		bank  = newbank
	end
end)

-- prevent infinite ammo, godmode, invisibility and ped speed hacks
Citizen.CreateThread(function()
    while true do
	Citizen.Wait(1)
	SetPedInfiniteAmmoClip(PlayerPedId(), false)
	SetEntityInvincible(PlayerPedId(), false)
	SetEntityCanBeDamaged(PlayerPedId(), true)
	ResetEntityAlpha(PlayerPedId())
	local fallin = IsPedFalling(PlayerPedId())
	local ragg = IsPedRagdoll(PlayerPedId())
	local parac = GetPedParachuteState(PlayerPedId())
	if parac >= 0 or ragg or fallin then
		SetEntityMaxSpeed(PlayerPedId(), 80.0)
	else
		SetEntityMaxSpeed(PlayerPedId(), 7.1)
	end
    end
end)

function ReqAndDelete(object, detach)
	if DoesEntityExist(object) then
		NetworkRequestControlOfEntity(object)
		while not NetworkHasControlOfEntity(object) do
			Citizen.Wait(1)
		end
		if detach then
			DetachEntity(object, 0, false)
		end
		SetEntityCollision(object, false, false)
		SetEntityAlpha(object, 0.0, true)
		SetEntityAsMissionEntity(object, true, true)
		SetEntityAsNoLongerNeeded(object)
		DeleteEntity(object)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local ped = PlayerPedId()
		local handle, object = FindFirstObject()
		local finished = false
		repeat
			Wait(1)
			if IsEntityAttached(object) and DoesEntityExist(object) then
				if GetEntityModel(object) == GetHashKey("prop_acc_guitar_01") then
					ReqAndDelete(object, true)
				end
			end
			for i=1,#CageObjs do
				if GetEntityModel(object) == GetHashKey(CageObjs[i]) then
					ReqAndDelete(object, false)
				end
			end
			finished, object = FindNextObject(handle)
		until not finished
		EndFindObject(handle)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedJumping(PlayerPedId()) then
			local jumplength = 0
			repeat
				Wait(0)
				jumplength=jumplength+1
				local isStillJumping = IsPedJumping(PlayerPedId())
			until not isStillJumping
			if jumplength > 250 then
				TriggerServerEvent("AntiCheese:JumpFlag", jumplength )
			end
		end
	end
end)
