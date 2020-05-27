-- Version 2.0

local AutoSaveEnabled = true
local TimerAutoSave = 60000
local TimerManualSave = 60000



function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, true)
end



function RequestToSave()
	LastPosX, LastPosY, LastPosZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
	local LastPosH = GetEntityHeading(GetPlayerPed(-1))
	TriggerServerEvent("projectEZ:savelastpos", LastPosX , LastPosY , LastPosZ, LastPosH)
	if not origin then
		--Notify("Player location saved to DB.")
	end
end



function Saver()
	Citizen.CreateThread(function ()
		while true do
			if AutoSaveEnabled then
				Citizen.Wait(TimerAutoSave)
				RequestToSave()
			else
				Citizen.Wait(0)
				if IsControlJustPressed(1, 97)  then
					RequestToSave()
					Citizen.Wait(TimerManualSave)
				end
			end	
		end
	end)
end



RegisterNetEvent('projectEZ:notify')
AddEventHandler('projectEZ:notify', function(alert)
    if not origin then
        Notify(alert)
    end
end)



RegisterNetEvent("projectEZ:spawnlaspos")
AddEventHandler("projectEZ:spawnlaspos", function(PosX, PosY, PosZ)
	SetEntityCoords(GetPlayerPed(-1), PosX, PosY, PosZ, 0, 0, 0, 1)
	if not origin then
		Notify("Position Loaded")
    end
	Saver()
end)



local firstspawn = false
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == false then
		TriggerServerEvent("projectEZ:SpawnPlayer")
		firstspawn = true
	end
end)