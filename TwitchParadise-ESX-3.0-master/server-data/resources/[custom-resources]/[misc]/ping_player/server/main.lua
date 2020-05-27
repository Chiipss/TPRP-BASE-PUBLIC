RegisterCommand('ping', function(source, args, rawCommand)
	if args[1] ~= nil then
        if args[1]:lower() == 'accept' then
            TriggerClientEvent('mythic_ping:client:AcceptPing', source)
        elseif args[1]:lower() == 'reject' then
            TriggerClientEvent('mythic_ping:client:RejectPing', source)
        elseif args[1]:lower() == 'remove' then
            TriggerClientEvent('mythic_ping:client:RemovePing', source)
        else
            local tSrc = tonumber(args[1])
			if tSrc ~= nil then
				if source ~= tSrc then
					TriggerClientEvent('mythic_ping:client:SendPing', tSrc, GetPlayerName(source), source)
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Can\'t Ping Yourself' })
				end
			end
        end
    end
end, false)

RegisterServerEvent('mythic_ping:server:SendPingResult')
AddEventHandler('mythic_ping:server:SendPingResult', function(id, result)
	if result == 'accept' then
		TriggerClientEvent('mythic_notify:client:SendAlert', id, { type = 'inform', text = GetPlayerName(source) .. ' Accepted Your Ping' })
	elseif result == 'reject' then
		TriggerClientEvent('mythic_notify:client:SendAlert', id, { type = 'inform', text = GetPlayerName(source) .. ' Rejected Your Ping' })
	elseif result == 'timeout' then
		TriggerClientEvent('mythic_notify:client:SendAlert', id, { type = 'inform', text = GetPlayerName(source) .. ' Did Not Accept Your Ping' })
	elseif result == 'unable' then
		TriggerClientEvent('mythic_notify:client:SendAlert', id, { type = 'inform', text = GetPlayerName(source) .. ' Was Unable To Receive Your Ping' })
	elseif result == 'received' then
		TriggerClientEvent('mythic_notify:client:SendAlert', id, { type = 'inform', text = 'You Sent A Ping To ' .. GetPlayerName(source) })
	end
end)
