ESX = nil
local connectedPlayers = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_scoreboard:getConnectedPlayers', function(source, cb)
	cb(connectedPlayers)
end)

AddEventHandler('esx:setJob', function(playerId, job, lastJob)
	connectedPlayers[playerId].job = job.name

	TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
end)

AddEventHandler('esx:playerLoaded', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
		AddPlayerToScoreboard(xPlayer, true)
end)

AddEventHandler('esx:playerDropped', function(playerId)
	connectedPlayers[playerId] = nil

	TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		UpdatePing()
	end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.CreateThread(function()
			Citizen.Wait(1000) 
			AddPlayersToScoreboard()
		end)
	end
end)






function AddPlayerToScoreboard(xPlayer, update)
	local playerId = xPlayer.source

	local xPlayer = ESX.GetPlayerFromId(xPlayer.source)
    --local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
    --    ['@identifier'] = xPlayer.identifier
    --})

    --local firstname = result[1].firstname
	--local lastname  = result[1].lastname
	--local fullname = (firstname .. " " .. lastname)

	--if firstname == '' then
	--	Citizen.Wait(10000)
		--print("Player has no name, restarting process")
	--	AddPlayerToScoreboard(xPlayer, true)
	--	do return end
	--end

	local printString = ""
	identifiers = GetPlayerIdentifiers(playerId)
	for _, id in ipairs(identifiers) do
		-- CHECK FOR STEAM RUNNING
		if string.match(id, "steam:") then
			steamId = id
			--steamId = string.gsub(id, "steam:", " steam:")
			printString = (printString .. steamId)
			--print("Found steam id: "..steamId)
		end
	end

	fullname = (printString)

	connectedPlayers[playerId] = {}
	connectedPlayers[playerId].ping = GetPlayerPing(playerId)
	connectedPlayers[playerId].id = playerId
	--connectedPlayers[playerId].name = xPlayer.getName()
	connectedPlayers[playerId].name = fullname
	connectedPlayers[playerId].job = xPlayer.job.name

	if update then
		TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
	end

	if xPlayer.player.getGroup() == 'user' then
		Citizen.CreateThread(function()
			Citizen.Wait(3000)
			TriggerClientEvent('esx_scoreboard:toggleID', playerId, false)
		end)
	end

end

function AddPlayersToScoreboard()
	local players = ESX.GetPlayers()

	for i=1, #players, 1 do
		local xPlayer = ESX.GetPlayerFromId(players[i])
		AddPlayerToScoreboard(xPlayer, false)
	end

	TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
end

function UpdatePing()
	for k,v in pairs(connectedPlayers) do
		v.ping = GetPlayerPing(k)
	end

	TriggerClientEvent('esx_scoreboard:updatePing', -1, connectedPlayers)
end

TriggerEvent('es:addGroupCommand', 'screfresh', 'admin', function(source, args, user)
	AddPlayersToScoreboard()
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SISTEMA', 'You do not have permission to do so.' } })
end, {help = "Top up players list names!"})

TriggerEvent('es:addGroupCommand', 'sctoggle', 'admin', function(source, args, user)
	TriggerClientEvent('esx_scoreboard:toggleID', source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SISTEMA', 'Non hai i permessi per farlo.' } })
end, {help = "Togli colonna degli ID!"})
