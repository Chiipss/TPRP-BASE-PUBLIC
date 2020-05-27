Keys = {
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

local FirstSpawn, PlayerLoaded = true, false

thecount = 0
isCop = false
isEMS = false
ragdol = 1    
local IsDead = false
inwater = false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('nowCopDeathOff')
AddEventHandler('nowCopDeathOff', function()
    isCop = false
end)

RegisterNetEvent('nowCopDeath')
AddEventHandler('nowCopDeath', function()
    isCop = true
    mymodel = GetEntityModel(GetPlayerPed(-1))
end)

RegisterNetEvent('nowEMSDeathOff')
AddEventHandler('nowEMSDeathOff', function()
    isEMS = false
end)

RegisterNetEvent('hasSignedOnEms')
AddEventHandler('hasSignedOnEms', function()
    isEMS = true
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)



AddEventHandler('playerSpawned', function()
	IsDead = false

	if FirstSpawn then
		exports.spawnmanager:setAutoSpawn(false) -- disable respawn
		FirstSpawn = false

		ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(isDead)
			if isDead and Config.AntiCombatLog then
				while not PlayerLoaded do
					Citizen.Wait(1000)
				end

				RemoveItemsAfterRPDeath()
			end
		end)
	end
end) 


function GetDeath()
    if IsDead then
        return true
    elseif not IsDead then
        return false
    end
end

-- Create blips
--[[ Citizen.CreateThread(function()
	for k,v in pairs(Config.Hospitals) do
		local blip = AddBlipForCoord(v.Blip.coords)

		SetBlipSprite(blip, v.Blip.sprite)
		SetBlipScale(blip, 0.6)
		SetBlipColour(blip, v.Blip.color)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('hospital'))
		EndTextCommandSetBlipName(blip)
	end
end) ]]


function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(0.40, 0.40)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function OnPlayerDeath()
	IsDead = true
	ESX.UI.Menu.CloseAll()
	TriggerServerEvent('tp_ambulancejob:setDeathStatus', true)
    TriggerEvent('mythic_hospital:client:ResetLimbs')
    TriggerEvent('mythic_hospital:client:RemoveBleed')
	deathTimer()

end

Citizen.CreateThread(function()
    IsDead = false
    ragdol = 0
    while true do
        Wait(100)
        if IsEntityDead(GetPlayerPed(-1)) then 
            Citizen.Trace(GetPedCauseOfDeath(GetPlayerPed(-1)))
            

            SetEntityInvincible(GetPlayerPed(-1), true)
            SetEntityHealth(GetPlayerPed(-1), GetEntityMaxHealth(GetPlayerPed(-1)))

            plyPos = GetEntityCoords(GetPlayerPed(-1))

            if not IsDead then
                IsDead = true
                deathTimer()
            end
        end
    end
end)


RegisterNetEvent('doTimer')
AddEventHandler('doTimer', function()
    while IsDead do
        Citizen.Wait(0)
        if thecount > 0 then
            drawTxt(0.94, 1.44, 1.0,1.0,0.6, "Respawn: ~r~" .. math.ceil(thecount) .. "~w~ seconds remaining", 255, 255, 255, 255)
        else
            drawTxt(0.94, 1.44, 1.0,1.0,0.6, "~w~ PRESS ~r~E ~w~TO ~r~RESPAWN ~w~OR WAIT FOR A ~r~MEDIC", 255, 255, 255, 255)
        end
    end
end)

dragged = false
RegisterNetEvent('deathdrop')
AddEventHandler('deathdrop', function(beingDragged)
    dragged = beingDragged
    if beingDragged and IsDead then
        --TriggerEvent('resurrect:relationships')
    end
      if not beingDragged and IsDead then
        SetEntityHealth(GetPlayerPed(-1), 200.0)
        SetEntityCoords( GetPlayerPed(-1), GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 1.0, 1.0) )
    end 
end)


RegisterNetEvent('resurrect:relationships')
AddEventHandler('resurrect:relationships', function()
    local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
    NetworkResurrectLocalPlayer(plyPos, true, true, false)
    resetrelations()
end)


RegisterNetEvent('ressurection:relationships:norevive')
AddEventHandler('ressurection:relationships:norevive', function()
    resetrelations()
end)

deathanims = {
    [1] = "dead_a",
    [2] = "dead_b",
    [3] = "dead_c",
    [4] = "dead_d",
    [5] = "dead_e",
    [6] = "dead_f",
    [7] = "dead_g",
    [8] = "dead_h",

}

myanim = "dead_a"

function InVeh()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

function resetrelations()
    Citizen.Wait(1000)
    if isCop or isEMS then
        SetPedRelationshipGroupDefaultHash(GetPlayerPed(-1),GetHashKey('MISSION2'))
        SetPedRelationshipGroupHash(GetPlayerPed(-1),GetHashKey('MISSION2'))
    else
        SetPedRelationshipGroupDefaultHash(GetPlayerPed(-1),GetHashKey('PLAYER'))
        SetPedRelationshipGroupHash(GetPlayerPed(-1),GetHashKey('PLAYER'))
    end
end

local disablingloop = false
RegisterNetEvent('disableAllActions')
AddEventHandler('disableAllActions', function()
    if not disablingloop then
        myanim = "dead_a"
        disablingloop = true
        Citizen.Wait(100)
        while GetEntitySpeed(GetPlayerPed(-1)) > 0.5 do
            Citizen.Wait(1)
        end 
        Citizen.Wait(100)
        TriggerEvent("resurrect:relationships")
      --  SetPedCanRagdoll(GetPlayerPed(-1), false)
        
        TriggerEvent("deathAnim")
        TriggerEvent("disableAllActions2")
        local inveh = 0
        while IsDead do
            if IsEntityInWater(GetPlayerPed(-1)) then
                inwater = true
            else
                inwater = false
            end
            SetEntityInvincible(GetPlayerPed(-1), true)
            Citizen.Wait(1) 
            if InVeh() then
                if not inveh then
                    inveh = true
                end
            elseif not InVeh() and inveh and GetEntityHeightAboveGround(GetPlayerPed(-1)) < 2.0 or inveh == 0 and GetEntityHeightAboveGround(GetPlayerPed(-1)) < 2.0 then
                inveh = false
                Citizen.Trace("Not In Veh DA")
                TriggerEvent("deathAnim")
            elseif not InVeh() then
                if (GetEntitySpeed(GetPlayerPed(-1)) > 0.3  and not inwater) or (not IsEntityPlayingAnim(GetPlayerPed(-1), "dead", myanim, 1) and not inwater) then
                    TriggerEvent("deathAnim")
                elseif (not IsEntityPlayingAnim(GetPlayerPed(-1), "dam_ko", "drown", 1) and inwater) then
                    TriggerEvent("deathAnim")
                end 
            end

        end
        SetEntityInvincible(GetPlayerPed(-1), false)
      --  SetPedCanRagdoll(GetPlayerPed(-1), true)
        disablingloop = false
    end
end)


RegisterNetEvent('disableAllActions2')
AddEventHandler('disableAllActions2', function()

        while IsDead do

            Citizen.Wait(1) 

            DisableInputGroup(0)
            DisableInputGroup(1)
            DisableInputGroup(2)
            --DisableControlAction(1, 19, true)
            DisableControlAction(0, 34, true)
            DisableControlAction(0, 9, true)
            DisableControlAction(0, 301, true)
            DisableControlAction(0, 32, true)
            DisableControlAction(0, 8, true)
            DisableControlAction(0, 289, true) 
            DisableControlAction(2, 31, true)
            DisableControlAction(2, 32, true)
            DisableControlAction(1, 33, true)
            DisableControlAction(1, 34, true)
            DisableControlAction(1, 35, true)
            DisableControlAction(1, 21, true)  -- space
            DisableControlAction(1, 22, true)  -- space
            DisableControlAction(1, 23, true)  -- F
            DisableControlAction(1, 24, true)  -- F
            DisableControlAction(1, 25, true)  -- F
            DisableControlAction(1, 56, true)  -- F9
            DisableControlAction(1, 288, true)  -- F1
 
            DisableControlAction(1, 157, true) -- 1
            DisableControlAction(1, 158, true) -- 2
            DisableControlAction(1, 160, true) -- 3
            DisableControlAction(1, 164, true) -- 4
            DisableControlAction(1, 165, true) -- 5
            DisableControlAction(1, 159, true) -- 6

            


             
            if IsControlJustPressed(1,29) then
                SetPedToRagdoll(GetPlayerPed(-1), 26000, 26000, 3, 0, 0, 0) 
                 Citizen.Wait(22000)
                 TriggerEvent("deathAnim")
            end

            DisableControlAction(1, 106, true) -- VehicleMouseControlOverride
            DisableControlAction(1, 140, true) --Disables Melee Actions
            DisableControlAction(1, 141, true) --Disables Melee Actions
            DisableControlAction(1, 142, true) --Disables Melee Actions 
            DisableControlAction(1, 37, true) --Disables INPUT_SELECT_WEAPON (tab) Actions
            DisablePlayerFiring(GetPlayerPed(-1), true) -- Disable weapon firing

        end
        SetPedCanRagdoll(GetPlayerPed(-1), false)
end)

local tryingAnim = false
local enteringveh = false
RegisterNetEvent('respawn:sleepanims')
AddEventHandler('respawn:sleepanims', function()
    if not enteringveh then
        enteringveh = true
        ClearPedTasksImmediately(GetPlayerPed(-1))
        Citizen.Wait(1000)
        enteringveh = false   
    end
end)
function deadcaranim()
   loadAnimDict( "veh@low@front_ps@idle_duck" ) 
   TaskPlayAnim(GetPlayerPed(-1), "veh@low@front_ps@idle_duck", "sit", 8.0, -8, -1, 1, 0, 0, 0, 0)
end
myanim = "dead_a"
RegisterNetEvent('deathAnim')
AddEventHandler('deathAnim', function()
    if not dragged and not tryingAnim and not enteringveh and not InVeh() and IsDead then
        tryingAnim = true
        while GetEntitySpeed(GetPlayerPed(-1)) > 0.5 and not inwater do
            Citizen.Wait(1)
        end        
        Citizen.Trace("Death Anim")
        if inwater then
            SetEntityCoords(GetEntityCoords(GetPlayerPed(-1)))
            SetPedToRagdoll(GetPlayerPed(-1), 26000, 26000, 3, 0, 0, 0) 
        else
            
            loadAnimDict( "dead" ) 
            SetEntityCoords(GetPlayerPed(-1),GetEntityCoords(GetPlayerPed(-1)))
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TaskPlayAnim(GetPlayerPed(-1), "dead", myanim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
        end


        Citizen.Wait(3000)
        tryingAnim = false
    end
end)

function loadAnimDict( dict )
    RequestAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        
        Citizen.Wait( 1 )
    end
end

function deathTimer()
    thecount = 300
    TriggerEvent("doTimer")
    Citizen.Trace("timer")
    IsDead = true
	StartDistressSignal()



    TriggerEvent("disableAllActions")
    while IsDead do
        
        Citizen.Wait(100)
        thecount = thecount - 0.1

        if thecount == 60 or thecount == 120 or thecount == 180 or thecount == 240 then
            TriggerEvent("civilian:alertPolice",100.0,"death",0)
        end
        --SetEntityHealth(GetPlayerPed(-1), GetEntityMaxHealth(GetPlayerPed(-1)))
        while thecount < 0 do
            Citizen.Wait(1)
             
            if IsControlJustPressed(1,38) then
              thecount = 99999999
              releaseBody()
            end
        end      
    end
end

function StartDistressSignal()
	Citizen.CreateThread(function()
		local timer = Config.BleedoutTimer

		while timer > 0 and IsDead do
			Citizen.Wait(2)
			timer = timer - 30

			SetTextFont(4)
			SetTextScale(0.40, 0.40)
			SetTextColour(185, 185, 185, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName(_U('distress_send'))
			EndTextCommandDisplayText(0.442, 0.90)

			if IsControlPressed(0, Keys['G']) then
                SendDistressSignal()
             

				 --[[ Citizen.CreateThread(function()
					Citizen.Wait(1000 * 60 * 5)
					if IsDead then
						StartDistressSignal()
					end 
				end) ]]

				break 
			end
		end
	end)
end

function SendDistressSignal()
    local text = "Call | Somebody is in need of assistance, There are downed!."
    local coords = GetEntityCoords(GetPlayerPed(-1))
    TriggerServerEvent("tp:addChatCivdispatch", "EMS Have been called and are on route to your location. Sit tight and they will be with you as soon as possible.")
    --exports['mythic_notify']:SendAlert('error', 'EMS Have been called and are on route to your location. <br /><br /> Sit tight and they will be with you as soon as possible.<br />', 5000)
    TriggerServerEvent('MF_Trackables:NotifyAll',text,coords,"ambulance",true,GetPlayerServerId(PlayerId()))
end


function DrawGenericTextThisFrame()
	SetTextFont(4)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end

function releaseBody()
    thecount = 240
    IsDead = false   
    ragdol = 1
    ClearPedTasksImmediately(GetPlayerPed(-1))
    FreezeEntityPosition(GetPlayerPed(-1), false)

    ESX.TriggerServerCallback("esx-qalle-jail:retrieveJailTime", function(inJail, newJailTime)
		if inJail then
            SetEntityCoords(GetPlayerPed(-1), 1798.75, 2482.944, -122.69)
            exports['mythic_notify']:DoHudText('inform', 'You have been revived by medical staff in jail.')
        else
            if isCop then
                SetEntityCoords(GetPlayerPed(-1), 441.60, -982.37, 30.67)
            else
                SetEntityCoords(GetPlayerPed(-1), 355.0, -585.7, 43.3)
            end
            exports['mythic_notify']:DoHudText('inform', 'You have been revived by medical staff.')
        end

	end)


    
    SetEntityInvincible(GetPlayerPed(-1), false)
    ClearPedBloodDamage(GetPlayerPed(-1))
    local plyPos = GetEntityCoords(GetPlayerPed(-1),true)
    TriggerEvent("resurrect:relationships")
    SetCurrentPedWeapon(GetPlayerPed(-1),2725352035,true)
    Citizen.CreateThread(function()
        Citizen.Wait(4000)
    end)
end

function secondsToClock(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format("%02.f", math.floor(seconds / 3600))
		local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end

function StartDeathTimer()
	local canPayFine = false

	if Config.EarlyRespawnFine then
		ESX.TriggerServerCallback('esx_ambulancejob:checkBalance', function(canPay)
			canPayFine = canPay
		end)
	end

	local earlySpawnTimer = ESX.Math.Round(Config.EarlyRespawnTimer / 1000)
	local bleedoutTimer = ESX.Math.Round(Config.BleedoutTimer / 1000)

	Citizen.CreateThread(function()
		-- early respawn timer
		while earlySpawnTimer > 0 and IsDead do
			Citizen.Wait(1000)

			if earlySpawnTimer > 0 then
				earlySpawnTimer = earlySpawnTimer - 1
			end
		end

		-- bleedout timer
		while bleedoutTimer > 0 and IsDead do
			Citizen.Wait(1000)

			if bleedoutTimer > 0 then
				bleedoutTimer = bleedoutTimer - 1
			end
		end
	end)

	Citizen.CreateThread(function()
		local text, timeHeld

		-- early respawn timer
		while earlySpawnTimer > 0 and IsDead do
			Citizen.Wait(0)
			text = _U('respawn_available_in', secondsToClock(earlySpawnTimer))

			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.95)
		end

		-- bleedout timer
		while bleedoutTimer > 0 and IsDead do
			Citizen.Wait(0)
			text = _U('respawn_bleedout_in', secondsToClock(bleedoutTimer))

			if not Config.EarlyRespawnFine then
				text = text .. _U('respawn_bleedout_prompt')

				if IsControlPressed(0, Keys['E']) and timeHeld > 60 then
					RemoveItemsAfterRPDeath()
					break
				end
			elseif Config.EarlyRespawnFine and canPayFine then
				text = text .. _U('respawn_bleedout_fine', ESX.Math.GroupDigits(Config.EarlyRespawnFineAmount))

				if IsControlPressed(0, Keys['E']) and timeHeld > 60 then
					TriggerServerEvent('esx_ambulancejob:payFine')
					RemoveItemsAfterRPDeath()

					break
				end
			end

			if IsControlPressed(0, Keys['E']) then
				timeHeld = timeHeld + 1
			else
				timeHeld = 0
			end

			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end
			
		if bleedoutTimer < 1 and IsDead then
			RemoveItemsAfterRPDeath()
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedBeingStunned(GetPlayerPed(-1)) then
		ragdol = 1
		SetPedCanRagdoll(GetPlayerPed(-1), true)
		end
	end
end)

function RemoveItemsAfterRPDeath()
	TriggerServerEvent('tp_ambulancejob:setDeathStatus', false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end

		ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
			local playerpos = GetEntityCoords( GetPlayerPed(-1) )
				
			ESX.SetPlayerData('lastPosition', playerpos)
			ESX.SetPlayerData('loadout', {})
			RespawnPed(PlayerPedId(), playerpos, Config.RespawnPoint.heading)

			TriggerServerEvent('esx:updateLastPosition', playerpos)
			--TriggerServerEvent('mythic_hospital:server:RequestBed')
			
			DoScreenFadeIn(800)
		end)
	end)
end

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = 'Ambulance',
		number     = 'ambulance',
		base64Icon = 'data:image/png;base64,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'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)

	TriggerEvent('mythic_hospital:client:RemoveBleed', ped) 
	TriggerEvent('mythic_hospital:client:ResetLimbs', ped)

	ESX.UI.Menu.CloseAll()
end

AddEventHandler('esx:onPlayerDeath', function(data)
	OnPlayerDeath()
end)

RegisterNetEvent('reviveFunction')
AddEventHandler('reviveFunction', function()
    attemptRevive()
end)

function attemptRevive()
    if IsDead then
        ragdol = 1
        IsDead = false
        isDead = false
        thecount = 240
        TriggerEvent("Heal")
        SetEntityInvincible(GetPlayerPed(-1), false)
        ClearPedBloodDamage(GetPlayerPed(-1))        
        local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
        TriggerEvent("resurrect:relationships")
        ClearPedTasksImmediately(GetPlayerPed(-1))
        Citizen.Wait(500)
        getup()
    end
end

function getup()
    ClearPedSecondaryTask(GetPlayerPed(-1))
    SetPedCanRagdoll(GetPlayerPed(-1), true)
    loadAnimDict( "random@crash_rescue@help_victim_up" ) 
    TaskPlayAnim( GetPlayerPed(-1), "random@crash_rescue@help_victim_up", "helping_victim_to_feet_victim", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    SetCurrentPedWeapon(GetPlayerPed(-1),2725352035,true)
    Citizen.Wait(3000)
    endanimation()
end

function endanimation()
    ClearPedSecondaryTask(GetPlayerPed(-1))
end

RegisterNetEvent("heal")
AddEventHandler('heal', function()
	local ped = GetPlayerPed(-1)
	if DoesEntityExist(ped) and not IsEntityDead(ped) then
		SetEntityHealth(GetPlayerPed(-1), GetEntityMaxHealth(GetPlayerPed(-1)))
		ragdol = 0
	end
end)

RegisterNetEvent('tp_ambulancejob:revive')
AddEventHandler('tp_ambulancejob:revive', function()
	attemptRevive()
end)

-- Load unloaded IPLs
if Config.LoadIpl then
	Citizen.CreateThread(function()
		RequestIpl('Coroner_Int_on') -- Morgue
	end)
end


--curDist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), 0), 2438.3266601563,4960.3046875,47.27229309082,true)
