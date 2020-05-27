ESX = nil 

TriggerEvent('esx:getSharedObject',function(obj) ESX = obj; end)


RegisterCommand("sellweed", function(source, args, rawCommand)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local pol = policias ()
	
	local item = xPlayer.getInventoryItem("bagofdope").count
	if item == 0 then
		TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'You have nothing to sell!', length = 4000})
	else
		if xPlayer.job.name ~= "police" then
			if pol > 2 then
				TriggerClientEvent('tp-sellweed:start',src, pol)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'There are no authorities in the city to do this!', length = 4000})
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Youre a cop!', length = 4000})
		end
	end
end, false)

function policias ()
		local players = ESX.GetPlayers()
        local copCount = 0
        for k,src in pairs(players) do
            local xPlayer = ESX.GetPlayerFromId(src)
            while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(src); end
            if xPlayer.job.name == "police" then copCount = copCount + 1; end
        end
        return copCount
end

ESX.RegisterServerCallback('tp-sellweed:countItems', function(source, cb,cant,money)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	
	local item = xPlayer.getInventoryItem("bagofdope").count
	
	if item >= cant then
		cb(true)
	elseif item == 0 then
		cb("vacio")
	else
		cb(false)
	end
end)

RegisterServerEvent('tp-sellweed:payMe')
AddEventHandler('tp-sellweed:payMe', function(cant,money)
local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
xPlayer.removeInventoryItem("bagofdope", cant)
xPlayer.addMoney(cant*money)
end)