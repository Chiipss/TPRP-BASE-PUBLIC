--[[
	Developed by Damien, Frag and British <3

    NOTES:
    1: Licence System (Active Reloading of licences when getting new one + Licence checks for shops)
    2: 
    3: 

    --Todo's
    These are all spmamming to get the player:
    
    [x] Safebreach/ser/main - Line 44-72 = Seems to be spamming to get the player.
    [x] Mugging - Spamming grabbing the xPlayer/GetPlayer()
    [ ] EasyAdmin - When refreshing to check blacklist (remove this code not really needed)
]]



ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ActiveJobs = {
    ['unemployed'] = { Players = {}, Count=0 },
	['ambulance'] = { Players = {}, Count=0 },
	['police'] = { Players = {}, Count=0 },
    ['mechanic'] = { Players = {}, Count=0 },
    ['cardealer'] = { Players = {}, Count=0 },
    ['garbage'] = { Players = {}, Count=0 },
    ['lawyer'] = { Players = {}, Count=0 },
    ['offambulance'] = { Players = {}, Count=0 },
    ['offmechanic'] = { Players = {}, Count=0 },
    ['offpolice'] = { Players = {}, Count=0 },
    ['busdriver'] = { Players = {}, Count=0 },
	['taxi'] = { Players = {}, Count=0 },
    ['gopostal'] = { Players = {}, Count=0 },
    ['vagos'] = {Players = {}, Count=0},
    ['lswc'] = {Players = {}, Count=0},
    ['vanillaunicorn'] = {Players = {}, Count=0},
    ['diamondcasino'] = {Players = {}, Count=0},
    ['merryweather'] = {Players = {}, Count=0},
    ['hotelname'] = {Players = {}, Count=0},
}


AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
		local players = ESX.GetPlayers()
		for k, v in pairs(players) do
			local xPlayer = ESX.GetPlayerFromId(k)
			if (xPlayer ~= nil) then
				table.insert(ActiveJobs[xPlayer.job.name].Players, k)

				ActiveJobs[xPlayer.job.name].Count = ActiveJobs[xPlayer.job.name].Count + 1
			end
		end
	end
end) 

AddEventHandler('tprp:PlayerLoaded', function(xPlayer, source)
	table.insert(ActiveJobs[xPlayer.job.name].Players, source)
	ActiveJobs[xPlayer.job.name].Count = ActiveJobs[xPlayer.job.name].Count + 1
end)

AddEventHandler('tprp:PlayerDropped', function(xPlayer, source)
	ActiveJobs[xPlayer.job.name].Players[source] = nil
	ActiveJobs[xPlayer.job.name].Count = ActiveJobs[xPlayer.job.name].Count - 1
end)

ESX.RegisterServerCallback('tprp:GetJobCountCallBack', function(source, cb, jobId)
	cb(ActiveJobs[jobId].Count)
end)

AddEventHandler('tprp:GetJobCount', function(jobId, cb)
	cb(ActiveJobs[jobId].Count)
end)

AddEventHandler('tprp:GetJobPlayers', function(jobId, cb)
	cb(ActiveJobs[jobId].Players)
end)

AddEventHandler('tprp:DroppedRadio', function(playerIdentifier)
	print('dropped it like its hot ' .. tostring(playerIdentifier))

    local xPlayer = ESX.GetPlayerFromIdentifier(playerIdentifier)
    if xPlayer ~= nil then
		if xPlayer.getInventoryItem('radio').count == 0 then

			print('notified player he should remove radio, i think.')

			TriggerClientEvent('ls-radio:onRadioDrop', playerId)
		end
	end
end)

--[[ Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        local copsonline = tostring(ActiveJobs["police"].Count)
        print(copsonline)
    end
end) ]]

AddEventHandler('esx:setJob', function(playerId, job, lastJob)
    -- remove from last job
    for k, v in pairs(ActiveJobs) do
        if (v.Players[playerId] ~= nil) then
            v.Players[playerId] = nil
            v.Count = v.Count - 1
            break
        end
    end

    -- add to new job
    if (ActiveJobs[job.name].Players[playerId] == nil) then
        ActiveJobs[job.name].Players[playerId] = true
        ActiveJobs[job.name].Count = ActiveJobs[job.name].Count + 1
    end
end)


--[[ -- this is used elsewhere in other resources 
TriggerEvent('tprp:GetJobCount', 'police', function(count)
    PoliceCount = count
end) ]]

local currentArmour = nil

RegisterNetEvent('LRP-Armour:Server:RefreshCurrentArmour')
AddEventHandler('LRP-Armour:Server:RefreshCurrentArmour', function(updateArmour)
   currentArmour = updateArmour
end)

AddEventHandler('esx:playerLoaded', function(playerId)
	print("Player has joined")
    local xPlayer = ESX.GetPlayerFromId(playerId)
    MySQL.Async.fetchScalar("SELECT armour FROM users WHERE identifier = @identifier", { 
        ['@identifier'] = tostring(xPlayer.getIdentifier())
        }, function(data)
        if (data ~= nil) then
            TriggerClientEvent('LRP-Armour:Client:SetPlayerArmour', playerId, data)
		end
    end)
end)

AddEventHandler('esx:playerDropped', function(playerId)
    if currentArmour ~= nil then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        MySQL.Async.execute("UPDATE users SET armour = @armour WHERE identifier = @identifier", { 
            ['@identifier'] = tostring(xPlayer.getIdentifier()),
            ['@armour'] = tonumber(currentArmour)
		})
		print("Saved on leave")
    end
end)

------ EBLIPS

-- by: minipunch
-- for: Initially made for USA Realism RP (https://usarrp.net)
-- purpose: Provide public servants with blips for all other active emergency personnel

local ACTIVE_EMERGENCY_PERSONNEL = {}

--[[
person = {
 src = 123,
 color = 3,
 name = "Taylor Weitman"
}
]]

RegisterServerEvent("eblips:add")
AddEventHandler("eblips:add", function(person)
    ACTIVE_EMERGENCY_PERSONNEL[person.src] = person
    for k, v in pairs(ACTIVE_EMERGENCY_PERSONNEL) do
        TriggerClientEvent("eblips:updateAll", k, ACTIVE_EMERGENCY_PERSONNEL)
    end
    TriggerClientEvent("eblips:toggle", person.src, true)
end)

RegisterServerEvent("eblips:remove")
AddEventHandler("eblips:remove", function(src)
    -- remove from list --
    ACTIVE_EMERGENCY_PERSONNEL[src] = nil
    -- update client blips --
    for k, v in pairs(ACTIVE_EMERGENCY_PERSONNEL) do
        TriggerClientEvent("eblips:remove", tonumber(k), src)
    end
    -- deactive blips when off duty --
    TriggerClientEvent("eblips:toggle", src, false)
end)

-- Clean up blip entry for on duty player who leaves --
AddEventHandler("playerDropped", function()
    if ACTIVE_EMERGENCY_PERSONNEL[source] then
        ACTIVE_EMERGENCY_PERSONNEL[source] = nil
    end
end)



-- OXY

ESX.RegisterUsableItem('oxy', function(source)  
   TriggerClientEvent('tp:useOxy', source)
   local player = ESX.GetPlayerFromId(source)
   player.removeInventoryItem('oxy', 1)
end)


--[[ RegisterServerEvent('parachute:equip')
AddEventHandler('parachute:equip',function()
    local player = ESX.GetPlayerFromId(source)
    player.removeInventoryItem('parachute', 1)
end) ]]
