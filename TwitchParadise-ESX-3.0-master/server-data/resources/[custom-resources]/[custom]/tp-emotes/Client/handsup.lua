ESX 			    			= nil
local PlayerData 				= {}
local isHandsUp					= false

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

------------------------------------------------------------------------------------------ END ESX SUPPORT ------------------------------------------------------------------------------------------

local radioActive 				= false
local radioButton				= 137 --- U by default  -- use 57 for f10
local handsUpButton				= 73 --- H by default -- use 73 for X

--- Function for radio chatter function
Citizen.CreateThread( function()

	while true do
		Citizen.Wait(0)
		-- if you use ESX Framework and want this to be a cop only thing then replace the line below this with the following:
		-- if (PlayerData.job ~= nil and PlayerData.job.name == 'police') and (IsControlJustPressed(0,radioButton)) then
		if (PlayerData.job ~= nil and PlayerData.job.name == 'police') and (IsControlJustPressed(0,radioButton)) then
			local ped = PlayerPedId()
			--TriggerEvent('chatMessage', 'TESTING ANIMATION')
	
			if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
				radioActive = true
	
				if radioActive then
	
					RequestAnimDict( "random@arrests" )
	
					while ( not HasAnimDictLoaded( "random@arrests" ) ) do 
						Citizen.Wait( 100 )
					end
	
					if IsEntityPlayingAnim(ped, "random@arrests", "generic_radio_chatter", 3) then
						ClearPedSecondaryTask(ped)
					else
						TaskPlayAnim(ped, "random@arrests", "generic_radio_chatter", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
						local prop_name = prop_name
						local secondaryprop_name = secondaryprop_name
						DetachEntity(prop, 1, 1)
						DeleteObject(prop)
						DetachEntity(secondaryprop, 1, 1)
						DeleteObject(secondaryprop)
						--SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
					end
				end
			end
		end
	end
end)
	
--- Broke this into two functions because it was bugging out for some reason.
	
Citizen.CreateThread( function()
	
	while true do
		Citizen.Wait(0)
		-- if you use ESX Framework and want this to be a cop only thing then replace the line below this with the following:
		-- if (PlayerData.job ~= nil and PlayerData.job.name == 'police') and (IsControlJustReleased(0,57))  and (radioActive) then
		if (IsControlJustReleased(0,raisehandbutton))  and (radioActive) then
			local ped = PlayerPedId()
	
			if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
				radioActive = false
				ClearPedSecondaryTask(ped)
				--SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
			end
		end	
	end
end)

Citizen.CreateThread(function()
	TriggerEvent('chat:addSuggestion', '/e', '', {
		{ name="Emote Name", help="If your not sure what emotes are available press F3 and view them via the menu." }
	})
end)

Citizen.CreateThread( function()
	while true do
		Citizen.Wait(0)
		if (IsControlJustPressed(0,handsUpButton))  then
			local ped = PlayerPedId()
	
			if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then
				if IsPedInAnyVehicle(GetPlayerPed(-1), false) then 

					--Do nothing

				else
	
					RequestAnimDict( "random@mugging3" )
		
					while ( not HasAnimDictLoaded( "random@mugging3" ) ) do 
						Citizen.Wait( 100 )
					end
		
					if IsEntityPlayingAnim(ped, "random@mugging3", "handsup_standing_base", 3) then
						ClearPedSecondaryTask(ped)
						isHandsUp = false
					else
						TaskPlayAnim(ped, "random@mugging3", "handsup_standing_base", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
						local prop_name = prop_name
						local secondaryprop_name = secondaryprop_name
						DetachEntity(prop, 1, 1)
						DeleteObject(prop)
						DetachEntity(secondaryprop, 1, 1)
						DeleteObject(secondaryprop)
						isHandsUp = true
					end
				end
			end
		end
	end
end)

RegisterNetEvent("emotes:isHandsUp")
AddEventHandler("emotes:isHandsUp", function(passbacktarget)
	print("Step4: Client Side isHandsUp "..passbacktarget)
	local playerHandsUp = isHandsUp
	local passbacktarget = passbacktarget
	TriggerServerEvent("esx_thief:setHandsUp", passbacktarget, playerHandsUp)
	print("Step5: Client Side isHandsUp "..passbacktarget)
end)

--[[Cancel emotes
RegisterCommand("es",function(source, args)
	local player = PlayerPedId()
	if (DoesEntityExist(player) and not IsEntityDead(player)) then
		ClearPedTasks(player)
	end
end)
RegisterCommand("ec",function(source, args)
	local player = PlayerPedId()
	if (DoesEntityExist(player) and not IsEntityDead(player)) then
		ClearPedTasks(player)
	end
end)]]
local isSitting = false

RegisterCommand("chair",function(source)
	if isSitting == false then
		TriggerEvent("animation:Chair")
		isSitting = true
	else
		TriggerEvent("turnoffsitting")
		isSitting = false
	end
end)

--[[
RegisterCommand("e",function(source, args)
	local player = PlayerPedId()
	if tostring(args[1]) == nil then
		return
	else
		if tostring(args[1]) ~= nil then
            local argh = tostring(args[1])
			
			if argh == 'c' then
				TriggerEvent("turnoffsitting")
				if DoesEntityExist(obj) then
					DeleteObject(obj)
					obj = 0
				elseif DoesEntityExist(prop) then
					DeleteObject(prop)
					prop = 0
				elseif DoesEntityExist(secondaryprop) then
					DeleteObject(secondaryprop)
					secondaryprop = 0
				end
				if (DoesEntityExist(PlayerPedId()) and not IsEntityDead(PlayerPedId())) then
					ClearPedTasks(PlayerPedId())
				end

			elseif argh == 'surrender' then
				local surrendered = false
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( "random@arrests" )
					loadAnimDict( "random@arrests@busted" )
					if ( IsEntityPlayingAnim( player, "random@arrests@busted", "idle_a", 3 ) ) then 
						TaskPlayAnim( player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
						Wait (3000)
						TaskPlayAnim( player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
						surrendered = false
					else
						TaskPlayAnim( player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
						Wait (4000)
						TaskPlayAnim( player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
						Wait (500)
						TaskPlayAnim( player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
						Wait (1000)
						TaskPlayAnim( player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
						Wait(100)
						surrendered = true
					end     
				end

				Citizen.CreateThread(function() --disabling controls while surrendured
					while surrendered do
						Citizen.Wait(0)
						if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests@busted", "idle_a", 3) then
							DisableControlAction(1, 140, true)
							DisableControlAction(1, 141, true)
							DisableControlAction(1, 142, true)
							DisableControlAction(0,21,true)
						end
					end
				end)
			elseif argh == 'chair' then
				TriggerEvent("animation:Chair")
			elseif argh == 'suicidepill' then
				local pos = GetOffsetFromEntityInWorldCoords(player, 0.1, 0.1, 1.0)
				local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.1, 0.1, -1.0)

				RequestAnimDict("mp_suicide")
				while not HasAnimDictLoaded("mp_suicide") do
					Citizen.Wait(0)
				end

				if IsEntityPlayingAnim(player, "mp_suicide", "pill", 3) then
					ClearPedSecondaryTask(player)
				else
					TaskPlayAnim(player, "mp_suicide", "pill", 8.0, -8, -1, 9, 0, 0, 0, 0)
					Citizen.Wait(4500)      
					SetEntityHealth(GetPlayerPed(-1),0.0)   
				end
			end
		end
	end
end, false)
--]]
--[[Use /testanimation command, you can use this to easily test new animations---

RegisterCommand("testanimation",function(source, args)

	local ad = "amb@code_human_police_crowd_control@idle_b" --- insert the animation dic here
	local anim = "idle_d" --- insert the animation name here
	local player = PlayerPedId()
	

	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		TriggerEvent('chatMessage', '^2 Testing Animation')
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)]]

	
----------------------------------------------------------------------------------------------------------------------------
------------------------------------------------ functions -----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('umbrellaLoop')
AddEventHandler('umbrellaLoop', function()
    Citizen.Wait(3000)

    while obj ~= 0 do
        Citizen.Wait(1)

        local curw = GetSelectedPedWeapon(GetPlayerPed(-1))
        local noweapon = GetHashKey("WEAPON_UNARMED")
        if noweapon ~= curw then
            TriggerEvent("animation:PlayAnimation","umbrella")
        end
        if not IsEntityPlayingAnim(GetPlayerPed(-1), "amb@code_human_wander_drinking@male@base", "static", 3) then
            ClearPedTasks(GetPlayerPed(-1))
            loadAnimDict("amb@code_human_wander_drinking@male@base")
            TaskPlayAnim(GetPlayerPed(-1), "amb@code_human_wander_drinking@male@base", "static", 1.0, 1.0, -1, 49, 0, 0, 0, 0)

        end
        ClearPedWetness(GetPlayerPed(-1))
    end
    ClearPedTasks(GetPlayerPed(-1))
end)


Citizen.CreateThread(function(prop_name, secondaryprop_name)
	while true do
		Citizen.Wait(500)
		if IsPedRagdoll(PlayerPedId()) then 
			local playerPed = PlayerPedId()
			local prop_name = prop_name
			local secondaryprop_name = secondaryprop_name
			DetachEntity(prop, 1, 1)
			DeleteObject(prop)
			DetachEntity(secondaryprop, 1, 1)
			DeleteObject(secondaryprop)
		end
	end
end)	

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

