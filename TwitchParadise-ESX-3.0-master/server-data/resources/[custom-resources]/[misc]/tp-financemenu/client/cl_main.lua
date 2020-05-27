ESX = nil
local menuOpen = false

cachedData = {}

Citizen.CreateThread(function()
	while not ESX do
		--Fetching esx library, due to new to esx using this.
		TriggerEvent("esx:getSharedObject", function(obj) 
			ESX = obj 
		end)

		Citizen.Wait(0)
	end

	if Config.FinanceMenu then
		while true do
			Citizen.Wait(5)

			if IsControlJustPressed(0, Config.FinanceMenuButton) then
				OpenFinanceMenu()
			end
		end
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(playerData)
	ESX.PlayerData = playerData
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(newJob)
	ESX.PlayerData["job"] = newJob
end)

local Positions = {
	['FinanceComputer'] = { ['hint'] = '[E] Use Finance Computer', ['x'] = -56.970, ['y'] = -1097.066, ['z'] = 26.422 }
}

Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		
		local plyCoords = GetEntityCoords(PlayerPedId())

		for index, value in pairs(Positions) do
			if value.hint ~= nil then
				local distance = GetDistanceBetweenCoords(plyCoords, value.x, value.y, value.z, true)
				if distance < 5.0 then
					sleep = 5
					DrawM(value.hint, 27, value.x, value.y, value.z - 0.945, 255, 255, 255, 1.5, 15)
					if distance < 0.7 and menuOpen == false then
						if IsControlJustReleased(0, 38) then
							OpenFinanceMenu()
							menuOpen = true
						end
					elseif distance > 1.5 and menuOpen == true then
						ESX.UI.Menu.CloseAll()
						menuOpen = false
					end
				end
			end			
		end
		Citizen.Wait(sleep)
	end
end)

function DrawM(hint, type, x, y, z)
	Draw3DText(x, y, z + 1.2, hint)
	DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
end

function Draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
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
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end