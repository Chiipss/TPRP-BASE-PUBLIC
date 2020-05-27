local PlayerData = {}
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	xPlayer = ESX.GetPlayerData()
end)

RegisterCommand('mcard', function()
  Citizen.CreateThread(function()
    xPlayer = ESX.GetPlayerData() -- Refresh player data incase you switched job.
    Citizen.Wait(10)
    if xPlayer.job and xPlayer.job.name ~= 'police' then
        return
    else
      local display = true
      local startTime = GetGameTimer()
      local delay = 120000
      TriggerEvent('mcard:display', true)
      TriggerEvent('anima', true)
    
    
    while display do
      Citizen.Wait(1)
      ShowInfo('Press ~INPUT_CONTEXT~ to put card away.', 0)
      if (GetTimeDifference(GetGameTimer(), startTime) > delay) then
        display = false
        TriggerEvent('mcard:display', false)
      end
      if (IsControlJustPressed(1, 51)) then
        display = false
        TriggerEvent('mcard:display', false)
        StopAnimTask(GetPlayerPed(-1), 'amb@code_human_wander_clipboard@male@base', 'static', 1.0)
      end
    end
  end
  end)
end)

RegisterNetEvent('mcard:display')
AddEventHandler('mcard:display', function(value)
  SendNUIMessage({
    type = "mcard",
    display = value
  })
end)

RegisterNetEvent("anima")
AddEventHandler("anima", function(inputText) 
RequestAnimDict("amb@code_human_wander_clipboard@male@base")
TaskPlayAnim(GetPlayerPed(-1),"amb@code_human_wander_clipboard@male@base", "static", 1.0,-1.0, 120000, 1, 1, true, true, true)
end)

function ShowInfo(text, state)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)
  DisplayHelpTextFromStringLabel(0, state, 0, -1)
end