ESX = nil 

TriggerEvent('esx:getSharedObject',function(obj) ESX = obj; end)


RegisterCommand("sellcoke", function(source, args, rawCommand)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local pol = policias ()
	
	local item = xPlayer.getInventoryItem("coke_pooch").count
	if item == 0 then
		TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'You have nothing to sell!', length = 4000})
	else
		if xPlayer.job.name ~= "police" then
			if pol > 2 then
				TriggerClientEvent('np-esquina:iniciar',src, pol)
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

ESX.RegisterServerCallback('np-esquina:porroscant', function(source, cb,cant,money)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	
	local item = xPlayer.getInventoryItem("coke_pooch").count
	
	if item >= cant then
		cb(true)
	elseif item == 0 then
		cb("vacio")
	else
		cb(false)
	end
end)

RegisterServerEvent('np-esquina:pagar')
AddEventHandler('np-esquina:pagar', function(cant,money)
local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
xPlayer.removeInventoryItem("coke_pooch", cant)
xPlayer.addMoney(cant*money)
end)