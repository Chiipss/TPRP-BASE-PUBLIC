-- Scripted by X. Cross && Jon P. --
local handsup = false

RegisterNetEvent("Handsup")
AddEventHandler("Handsup", function()
	local lPed = GetPlayerPed(-1)
	if DoesEntityExist(lPed) then
		Citizen.CreateThread(function()
			RequestAnimDict("random@mugging3")
			while not HasAnimDictLoaded("random@mugging3") do
				Citizen.Wait(100)
			end
			
			if IsEntityPlayingAnim(lPed, "random@mugging3", "handsup_standing_base", 3) then
				ClearPedSecondaryTask(lPed)
				SetEnableHandcuffs(lPed, false)
				handsup = false
			else
				TaskPlayAnim(lPed, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 49, 0, 0, 0, 0)
				SetEnableHandcuffs(lPed, true)
				handsup = true
				
			end		
		end)
	end
end)

RegisteNetEvent("tprp:isHandsUp")
AddEventHandler("tprp:isHandsUp", function()
	local isHandsUp = handsup
	if isHandsUp == true then
		return true
	else
		return false
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, 73) then -- X Button
			local lPed = GetPlayerPed(-1)
			if DoesEntityExist(lPed) then
				Citizen.CreateThread(function()
					RequestAnimDict("random@mugging3")
					while not HasAnimDictLoaded("random@mugging3") do
						Citizen.Wait(100)
					end
					
					if IsEntityPlayingAnim(lPed, "random@mugging3", "handsup_standing_base", 3) then
						ClearPedSecondaryTask(lPed)
						SetEnableHandcuffs(lPed, false)
						handsup = false
					else
						TaskPlayAnim(lPed, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 49, 0, 0, 0, 0)
						SetEnableHandcuffs(lPed, true)
						handsup = true
					end		
				end)
			end
		end	
	end
end)
