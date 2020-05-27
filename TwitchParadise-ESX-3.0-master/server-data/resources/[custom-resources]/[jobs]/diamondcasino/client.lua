local bossUI = {x=984.24780273438, y =60.386383056641, z =28.485998153687}

ESX                             = nil
local PlayerData 				= nil

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
  
      while ESX.GetPlayerData().job == nil do
          Citizen.Wait(10)
      end
  
      ESX.PlayerData = ESX.GetPlayerData()
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  ESX.PlayerData.job = job
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

Citizen.CreateThread(function()
	while true do
		sleepTime = 100
        local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),bossUI.x,bossUI.y,bossUI.z, true)
        
        if(distance<2.5 and ESX.PlayerData.job.grade_name == "boss" and ESX.PlayerData.job.name == "diamondcasino") then
            sleepTime = 0
			DrawM('[E] Open Casino Menu', 27, bossUI.x, bossUI.y, bossUI.z - 0.945, 255, 255, 255, 1.5, 15)
			if(IsControlJustPressed(1, 38)) then
                renderMenu(name, "Diamond Casino Boss Menu")
			end
        end
        
        Citizen.Wait(sleepTime)
	end
end)


function renderMenu(name, menuName)
	local _name = name
	local elements = {}
	
	table.insert(elements, {label = 'Boss actions', value = 'boss_menu'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'diamondcasinomenu',
		{
			title    = menuName,
			align    = 'bottom-right',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'boss_menu' then
				TriggerEvent('esx_society:openBossMenu', 'diamondcasino', function(data, menu)
					menu.close()
				end
			)
		end

		end,
		function(data, menu)

			menu.close()
		end
	)
end