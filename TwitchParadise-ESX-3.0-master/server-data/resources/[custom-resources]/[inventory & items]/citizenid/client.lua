ESX = nil
local Playerdata = nil
local localPlayer = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)



RegisterNetEvent('citizenid:showid')
AddEventHandler('citizenid:showid', function(source)
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			local xPlayer = ESX.GetPlayerData(source)
			
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
				--OpenCitizenCardMenu(closestPlayer)
				TriggerServerEvent("citizenid:showID",closestPlayer) -- TRIGGER SERVER EVENT TO PASS MY ID TO THE NEAREST PLAYER
				print(closestPlayer)
			else
				local serverid = GetPlayerServerId(PlayerId())
				--print(serverid)
				OpenCitizenCardMenu(serverid)
                exports['mythic_notify']:SendAlert('error', 'No Players Nearby, Viewing your own ID')
            end
            --print("Finished showing ID")
end)

RegisterNetEvent('citizenid:showID2') -- RECEIVE ORIGINAL PLAYERS ID FROM SERVER AND SHOW ON NEW PLAYERS SCREEN
AddEventHandler('citizenid:showID2', function(origPlayer)
				OpenCitizenCardMenu(origPlayer)
end)


function OpenCitizenCardMenu(player)
	ESX.TriggerServerCallback('citizenid:getOtherPlayerData', function(data)
		local elements = {}
		local nameLabel = _U('name', data.name)
		local jobLabel, sexLabel, dobLabel, heightLabel, idLabel

		if data.job.grade_label and  data.job.grade_label ~= '' then
			jobLabel = _U('job', data.job.label .. ' - ' .. data.job.grade_label)
		else
			jobLabel = _U('job', data.job.label)
		end

		
		nameLabel = _U('name', data.firstname .. ' ' .. data.lastname)

		if data.sex then
			if string.lower(data.sex) == 'm' then
				sexLabel = _U('sex', _U('male'))
			else
				sexLabel = _U('sex', _U('female'))
			end
		else
			sexLabel = _U('sex', _U('unknown'))
		end

		if data.dob then
			dobLabel = _U('dob', data.dob)
		else
			dobLabel = _U('dob', _U('unknown'))
		end

		if data.height then
			heightLabel = _U('height', data.height)
		else
			heightLabel = _U('height', _U('unknown'))
		end

		if data.name then
			idLabel = _U('id', data.name)
		else
			idLabel = _U('id', _U('unknown'))
		end
		

		local elements = {
			{label = nameLabel},
			{label = jobLabel}
		}

		
		table.insert(elements, {label = sexLabel})
		table.insert(elements, {label = dobLabel})
		table.insert(elements, {label = heightLabel})
		table.insert(elements, {label = idLabel})

		if data.licenses then
			table.insert(elements, {label = _U('license_label')})

			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
			title    = _U('citizen_interaction'),
			align    = 'bottom-right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

RegisterCommand('showid', function() 
	TriggerEvent('citizenid:showid')
end)