ESX = nil
local RegisteredSocieties = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local function getMoneyFromUser(id_user)
	local xPlayer = ESX.GetPlayerFromId(id_user)
	return xPlayer.getMoney()

end

local function getMoneyFromUser(id_user)
	local xPlayer = ESX.GetPlayerFromId(id_user)
	return xPlayer.getMoney()

end

	
TriggerEvent('es:addCommand', 'job', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.label
    local jobgrade = xPlayer.job.grade_label

TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You are working as: ' .. job .. ' - ' .. jobgrade, length = 10000})  
end, {help = "Check what job you have"})

TriggerEvent('es:addCommand', 'cash', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local wallet 		= getMoneyFromUser(_source)

TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You currently have $' .. wallet .. ' in your wallet', length = 10000})
end, {help = "Check how much is in your wallet"})




--[[ ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) ]]

--[[ TriggerEvent('es:addCommand', 'extra', function(source, args, user)
	local usource = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'police' then
	    local Veh = GetVehiclePedIsIn(GetPlayerPed(-1))
        local liveryID = tonumber(args[1])
        print("CHICKENS")

        --~TriggerClientEvent.....
		
        SetVehicleExtra(Veh, liveryID, 0)
    end
end)

TriggerEvent('es:addCommand', 'livery', function(source, args, user)
	local usource = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'police' then
	    local Veh = GetVehiclePedIsIn(GetPlayerPed(-1))
		local liveryID = tonumber(args[1])
	
		SetVehicleLivery(Veh, liveryID)
	end  	
end) ]]