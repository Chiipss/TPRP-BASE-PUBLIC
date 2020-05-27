RegisterNetEvent('JAM_Pillbox:CheckIn')
RegisterNetEvent('JAM_Pillbox:CheckOut')
RegisterNetEvent('JAM_Pillbox:NotifyEMS')
RegisterNetEvent('JAM_Pillbox:TreatPlayer')

local JPB = JAM_Pillbox
JPB.EMSCount = 0

JPB.Patients = {}

function JPB:GetNewId()
  for k=1,self.MaxCapacity,1 do
    if not JPB.Patients[k] then 
      return k
    end
  end
  return false
end

function JPB:GetPatientCount()
  local count = 0
  for k,v in pairs(self.Patients) do
    if v then count = count + 1; end
  end
  return count
end

AddEventHandler("playerDropped", function()
  local src = source
  for i = 1, #JPB.Patients do
      if src == JPB.Patients[i] then
          table.remove(JPB.Patients, i)
          print(JPB.Patients[i] .." Player crashed while using beds")
          break
      end
  end
end)

function JPB:GetEMSCount()

	TriggerEvent('tprp:GetJobCount', 'ambulance', function(count)
		JPB.EMSCount = count
	end)

	--[[
  if not ESX then 
    Citizen.Wait(0); 
  end
  while true do 
    local count = 0
    local players = ESX.GetPlayers()
    for k,v in pairs(players) do
      local xPlayer = ESX.GetPlayerFromId(v)
      while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(v) end
      local job = xPlayer.job.label
      if job == self.EMSJobLabel then
        count = count + 1
      end
    end
    self.EMSCount = count
    Wait(30 * 1000)
  end ]]
end

function JPB:NotifyEMS()
	TriggerEvent('tprp:GetJobPlayers', 'ambulance', function(players)
		for k, v in pairs(players) do
			TriggerClientEvent('JAM_Pillbox:DoNotify', k)
		end
	end)
  
	--[[
  local players = ESX.GetPlayers()
  for k,v in pairs(players) do
    local xPlayer = ESX.GetPlayerFromId(v)
    while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(v) end
    local job = xPlayer.job.label
    if job == self.EMSJobLabel then 
      TriggerClientEvent('JAM_Pillbox:DoNotify', v)
    end
  end]]
end

AddEventHandler('JAM_Pillbox:CheckIn', function(id) JPB.Patients[id] = source; end)
AddEventHandler('JAM_Pillbox:CheckOut', function(id) JPB.Patients[id] = false; end)
AddEventHandler('JAM_Pillbox:NotifyEMS', function(...) JPB:NotifyEMS(...); end)
AddEventHandler('JAM_Pillbox:TreatPlayer', function(id) TriggerClientEvent('JAM_Pillbox:GetTreated', id); end)
ESX.RegisterServerCallback('JAM_Pillbox:GetCapacity', function(source,cb) cb(JPB:GetPatientCount(),JPB:GetNewId()) end)
ESX.RegisterServerCallback('JAM_Pillbox:GetOnlineEMS', function(source,cb) cb(JPB.EMSCount) end)

Citizen.CreateThread(function(...) JPB:GetEMSCount(...); end)